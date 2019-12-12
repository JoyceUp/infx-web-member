
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}

    {# 引入css #}
{% endblock %}

{% block js_assets %}
    <script>
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.ib.register.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //资金类型
        var channelTypeMap = new Object();
        {% for at in Lang.select.ib.funds.out_channel_type %}
        channelTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}

        //订单状态
        var stateMap = new Object();
        {% for at in Lang.select.ib.funds.order_state %}
        stateMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //资金类型
        var fundsTypeMap = new Object();
        {% for at in Lang.select.ib.funds.withdraw_funds_type %}
        fundsTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}

        //详情
        function showDetail(id, channel_type, flag) {
            $.ajax({
                url: '/ib/funds/withdraw_record/info',
                async: true,
                type: 'post',
                dataType: 'json',
                data: {"id": id, 'channel_type': channel_type},
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    /* {value: 1, label: '入金-银行卡'},
                     {value: 2, label: '入金-微信支付'},
                     {value: 3, label: '入金-支付宝'},
                     {value: 4, label: '入金-电汇'},
                     {value: 5, label: '入金-线下充值'},
                      {value: 101, label: '出金-银行卡'},
                       {value: 102, label: '出金-电汇'},
                      {value: 103, label: '出金-转账'}
                     */

                    if (data.status == 200) {
                        var withdraw = JSON.parse(data.datas);
                        var content = 'detail_' + channel_type;
                        if (withdraw) {
                            //取消申请的必须参数
                            $("#" + content + " input[name=id]").val(withdraw.id);
                            $("#" + content + " input[name=channel_type]").val(withdraw.channel_type);

                            $("#" + content + " .order_no").html(withdraw.order_no);                        //订单编号
                            $("#" + content + " .gmt_create").html(withdraw.gmt_create);                    //创建时间
                            $("#" + content + " .channel_type").html(channelTypeMap[withdraw.channel_type]);//资金类型
                            $("#" + content + " .account_no").html(withdraw.account_no + "-" + accountTypeMap[withdraw.account_type]);                    //账号
                            $("#" + content + " .amount").html(withdraw.amount / 100 || 0);                 //申请金额
                            $("#" + content + " .fee").html(withdraw.fee / 100 || 0);                       //手续费
                            $("#" + content + " .pay_amount").html(withdraw.pay_amount / 100);              //支付金额USD
                            $("#" + content + " .card_no").html(withdraw.card_no);                          //银行账号
                            $("#" + content + " .card_user_name").html(withdraw.card_user_name);            //银行账户户名
                            if(channel_type == 102){
                                $("#" + content + " .bank_name").html(withdraw.branch_name);     //银行名称
                            }else{
                                $("#" + content + " .bank_name").html(withdraw.bank_name + " " + withdraw.city + " " + withdraw.branch_name + "<br/>" + withdraw.card_no);         //银行名称
                            }
                            $("#" + content + " .country").html(withdraw.country);                          //银行国家
                            $("#" + content + " .province").html(withdraw.province);                        //地区（省）
                            $("#" + content + " .city").html(withdraw.city);                                //地区（市）
                            $("#" + content + " .branch_name").html(withdraw.branch_name);                  //银行开户行
                            $("#" + content + " .branch_address").html(withdraw.branch_address);            //开户行地址
                            $("#" + content + " .branch_swift_code").html(withdraw.branch_swift_code);      //国际汇款代码
                            //留言
                            $("#" + content + " .remark").html(withdraw.remark);                            //处理备注
                            $("#" + content + " .status").html(stateMap[withdraw.status] || '处理中');      //订单状态
                            $("#" + content + " .gmt_create").html(withdraw.gmt_create);                    //创建时间
                            $("#" + content + " .gmt_modified").html(withdraw.gmt_modified);                //更新时间
                            if (withdraw.proof_photoId) {
                                $("#" + content + " .proof_photoId").html("<img src='/common/images/" + withdraw.proof_photoId + "'/>");//汇票凭证，图片
                            }
                            $("#" + content + " .rate").html(withdraw.rate / 10000 || 0);                   //汇率
                            if (withdraw.status == 2 && (withdraw.channel_type == 101 || withdraw.channel_type == 102)) {
                                $("#" + content + " .canceApply").show();                                   //取消申请  显示
                            } else {
                                $("#" + content + " .canceApply").hide();
                            }

                        }
                        var title = channelTypeMap[channel_type] + '{{ Lang.dialog_xx_details || "详情" }}';

                        if(flag){
                            layer.open({
                                type: 1,
                                title: title,
                                area: ['500px', 'auto'],
                                content: $("#" + content)
                            });
                        }
                    }
                }
            });
        }

        var tableIns;
        layui.use(['form','laydate','table'],function(){
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem: '#start_time', //初始日期
                type:'datetime',
                lang:laylang
            });
            laydate.render({
                elem: '#end_time', //结束日期
                type:'datetime',
                lang:laylang
            });

            //列表
            var table = layui.table;
            tableIns = table.render({
                elem:"#depositlist",
                url:'/ib/funds/withdraw_record/list',
                method: 'post',
                cols:[[
                    {field:'order_no',title:'{{ Lang.table_order_no || "订单编号"}}',width:300,align:'center',templet:function(d){
                            return '<a onclick="showDetail(\''+d.id+'\', '+d.channel_type+', true)" href="javascript:;">'+d.order_no+'</a>';
                        }},
                    {field:'account_no',title:'{{ Lang.table_source_account_no || "账号"}}',align:'center'},
                    {field:'channel_type',title:'{{ Lang.table_cause || "资金类型"}}',align:'center',templet:function(d){
                            return fundsTypeMap[d.channel_type];
                        }},
                    {field:'amount',title:'{{ Lang.table_amount_3 || "申请金额(USD)"}}',sort:true,align:'center', templet: function (d) {
                        var amount = d.amount / 100 || 0;
                            return amount <= 0 ? amount : "-"+amount;
                        }},
                    {field:'gmt_create',title:'{{ Lang.table_gmt_create_1 || "创建时间"}}',sort:true,align:'center'},
                    {field:'state',title:'{{ Lang.table_state || "订单状态"}}',align:'center',templet:function(d){
                            return "<span id='"+d.id+"_status'>"+(stateMap[d.status] || '{{ Lang.table_content_state || "处理中"}}')+"</spam>";
                        }},
                ]],
                page:true,
                response:{
                    statusName:'status',
                    statusCode :200,
                    msgName:'msg',
                    countName:'count',
                    dataName:'datas'
                }
            });
            table.on('sort(dataTable)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                //尽管我们的 table 自带排序功能，但并没有请求服务端。
                //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
                table.reload('depositlist', {
                    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                        field: obj.field    //当前排序的字段名
                        ,order: obj.type,    //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
                        account_no: $('input[name="account_no"]').val(),
                        type: $('input[name="type"]').val(),
                        channel_type: $('input[name="channel_type"]').val(),
                        state: $('input[name="state"]').val(),
                        start_time : $('input[name="start_time"]').val(),
                        end_time : $('input[name="end_time"]').val()
                    }
                });
            });

            //搜索表单
            var form = layui.form;
            form.on('submit(search_btn)',function(data){
                if(data.field.start_time && data.field.end_time){
                    if(new Date(data.field.start_time).getTime() > new Date(data.field.end_time).getTime()){
                        layer.alert("{{ Lang.alert_start_time_more_than_the_end_time || "开始时间 不能大于 结束时间" }}", {
                            title: '{{ Lang.page_msg_h3 || "提示：" }}'
                        });
                        return false;
                    }
                }
                search(data.field);
                return false;
            });

            //取消出金
            form.on('submit(cance)',function(data){
                layer.close(layer.index);
                var id = data.field.id;
                var channel_type = data.field.channel_type;
                if(id){
                    $.ajax({
                        url:'/ib/funds/withdraw/cancel_withdraw',
                        async: true,
                        data:{"id":id,"channel_type":channel_type},
                        type:'post',
                        dataType:'json',
                        contentType:"application/x-www-form-urlencoded;charset=UTF-8",
                        success:function(data){
                            if(data.status == 200){
                                layer.confirm('{{ Lang.open_cancel_success || "取消成功" }}', {
                                    btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                                }, function(){
                                    showDetail(id, channel_type, false);
                                    $("#"+id+"_status").html("{{ Lang.msg_cancel_success || "已取消" }}");
                                    layer.close(layer.index);
                                });
                            }else{
                                layer.alert(data.msg, {
                                    title: '{{ Lang.page_msg_h3 || "提示：" }}'
                                });
                            }
                        }

                    });
                }
                return false;
            })

            function search(search_form_data){
                tableIns.reload({
                    where:{
                        account_no:search_form_data.account_no,
                        type:search_form_data.type,
                        channel_type:search_form_data.channel_type,
                        state:search_form_data.state,
                        start_time :search_form_data.start_time,
                        end_time :search_form_data.end_time
                    },
                    page:{
                        curr:1
                    }
                });
            }
        });
    </script>
    {# 引入js #}
{% endblock %}

{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_funds_withdraw_record_title || "出金记录" }}
                    </div>
                    <div id="search_box">

                        <form class="layui-form"  action="">

                            {#<label class="input-title">代理账号：</label>#}
                            <div class="layui-input-inline">
                                <select name="account_no" id="from_account_id" lay-filter="from_account_id" class="layui-input">
                                    <option value="">{{ Lang.form_placeholder_account_no || "账号" }}</option>
                                    {% for ac in account %}
                                        <option value="{{ ac.account_no }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                            {#<label class="input-title">渠道类型：</label>#}
                            <div class="layui-input-inline">
                                <select name="channel_type">
                                    <option value="">{{ Lang.form_select_funds_type || "资金类型" }}</option>
                                    {% for at in Lang.select.ib.funds.withdraw_funds_type %}
                                        <option value="{{ at.value }}">{{ at.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                           {# <label class="input-title">状态：</label>#}
                            <div class="layui-input-inline">
                                <select name="state">
                                    <option value="">{{ Lang.form_select_order_state || "订单状态" }}</option>
                                    {% for at in Lang.select.ib.funds.order_state %}
                                        <option value="{{ at.value }}">{{ at.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                            <div class="layui-input-inline">
                                <input class="layui-input" id="start_time" name="start_time" placeholder="{{ Lang.form_text_gmt_create || "创建时间" }}" type="text" value="" >
                            </div>
                            <div class="layui-input-inline">
                                -
                            </div>
                            <div class="layui-input-inline">
                                <input class="layui-input" id="end_time" name="end_time" placeholder="{{ Lang.form_text_gmt_create || "创建时间" }}" type="text" value="">
                            </div>

                            <div class="layui-input-inline">
                                <button class="layui-btn" lay-submit="" lay-filter="search_btn" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                <button type="reset" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                            </div>

                        </form>

                    </div>

                </div>

                <div class="main_page_Info">
                    <table class="layui-hide" id="depositlist" lay-filter="dataTable"></table>
                    <div class="page"></div>
                </div>

            </div>
        </div>
    </div>

    {#银行卡入金 1#}
    <div id="detail_1" style="display:none">
        <form class="layui-form show-detail" action="">
            <div class="d-item">
                <label>{{ Lang.form_label_order_no || "订单编号" }}:</label>
                <input type="hidden" name="id" value=""/>
                <input type="hidden" name="channel_type" value=""/>
                <span class="order_no" name="id"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}:</label>
                <span class="gmt_create"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                <span class="account_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_funds_type || "资金类型" }}:</label>
                <span class="channel_type"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span class="amount"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount || "支付金额(CNY)" }}:</label>
                <span class="pay_amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_order_state || "订单状态" }}:</label>
                <span class="status"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}:</label>
                <span class="gmt_modified"></span>
            </div>

            <div class="canceApply" ><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>
    {#微信支付 2#}
    <div id="detail_2" style="display:none">
        <form class="layui-form show-detail" action="">
            <input type="hidden" name="id" value=""/>
            <input type="hidden" name="channel_type" value=""/>
            <div class="d-item">
                <label>{{ Lang.form_label_order_no || "订单编号" }}:</label>
                <span class="order_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}:</label>
                <span class="gmt_create"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                <span class="account_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_funds_type || "资金类型" }}:</label>
                <span class="channel_type"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span class="amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount || "支付金额(CNY)" }}:</label>
                <span class="pay_amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_order_state || "订单状态" }}:</label>
                <span class="status"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}:</label>
                <span class="gmt_modified"></span>
            </div>
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>

    {# 电汇入金 4#}
    <div id="detail_4" style="display:none">
        <form class="layui-form show-detail" action="">
            <input type="hidden" name="id" value=""/>
            <input type="hidden" name="channel_type" value=""/>
            <div class="d-item">
                <label>{{ Lang.form_label_order_no || "订单编号" }}:</label>
                <span class="order_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}:</label>
                <span class="gmt_create"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_account_no || "账户" }}:</label>
                <span class="account_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_funds_type || "资金类型" }}:</label>
                <span class="channel_type"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span class="amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount_usd || "支付金额(USD)" }}:</label>
                <span class="pay_amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_proof_photo || "汇票凭证" }}:</label>
                <span class="proof_photoId"><img src=""/></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_order_state || "订单状态" }}:</label>
                <span class="status"></span>
            </div>
            <!--处理备注 有内容则显示，没内容隐藏-->
            <div class="d-item">
                <label>{{ Lang.form_label_remark || "处理备注" }}:</label>
                <span class="remark"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}:</label>
                <span class="gmt_modified"></span>
            </div>
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>

    {# 出金-银行卡 101#}
    <div id="detail_101" style="display:none">
        <form class="layui-form show-detail" action="">
            <input type="hidden" name="id" value=""/>
            <input type="hidden" name="channel_type" value=""/>
            <div class="d-item">
                <label>{{ Lang.form_label_order_no || "订单编号" }}:</label>
                <span class="order_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}:</label>
                <span class="gmt_create"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_funds_type || "资金类型" }}:</label>
                <span class="channel_type"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                <span class="account_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_rate || "汇率" }}:</label>
                <span class="rate"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span class="amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_fee || "手续费(USD)" }}:</label>
                <span class="fee"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount || "支付金额(CNY)" }}:</label>
                <span class="pay_amount"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_bankcard || "收款银行" }}:</label>
                <span class="bank_name"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_select_order_state || "订单状态" }}:</label>
                <span class="status"></span>
            </div>
            <!--处理备注 有内容则显示，没内容隐藏-->
            <div class="d-item">
                <label>{{ Lang.form_label_remark || "处理备注" }}:</label>
                <span class="remark"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}:</label>
                <span class="gmt_modified"></span>
            </div>
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>

    {# 出金-电汇 102#}
    <div id="detail_102" style="display:none">
        <form class="layui-form show-detail" action="">
            <input type="hidden" name="id" value=""/>
            <input type="hidden" name="channel_type" value=""/>
            <div class="d-item">
                <label>{{ Lang.form_label_order_no || "订单编号" }}:</label>
                <span class="order_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}:</label>
                <span class="gmt_create"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_select_funds_type || "资金类型" }}:</label>
                <span class="channel_type"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                <span class="account_no"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span class="amount"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_fee || "手续费(USD)" }}:</label>
                <span class="fee"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount_usd || "支付金额(USD)" }}:</label>
                <span class="pay_amount"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_bank_account_no || "银行账号" }}:</label>
                <span class="card_no"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_card_user_name || "银行账户户名" }}:</label>
                <span class="card_user_name"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_bank_name || "银行名称" }}:</label>
                <span class="bank_name"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_bank_country || "银行国家" }}:</label>
                <span class="country"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_bank_province || "地区（省）" }}:</label>
                <span class="province"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_bank_city || "地区（市）" }}:</label>
                <span class="city"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_branch_name || "银行开户行" }}:</label>
                <span class="branch_name"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_branch_address || "开户行地址" }}:</label>
                <span class="branch_address"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_branch_swift_code || "国际汇款代码" }}:</label>
                <span class="branch_swift_code"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_select_order_state || "订单状态" }}:</label>
                <span class="status"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_remark || "处理备注" }}:</label>
                <span class="remark"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}:</label>
                <span class="gmt_modified"></span>
            </div>
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>
{% endblock %}
