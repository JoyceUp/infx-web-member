
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}

    {# 引入css #}
{% endblock %}

{% block js_assets %}
    <script>
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.register.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //账户类型
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}


        //出入金渠道类型
        var channelTypeMap = new Object();
        {% for at in Lang.select.member.funds.channel_type %}
        channelTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}

        //订单状态
        var stateMap = new Object();
        {% for at in Lang.select.member.funds.order_state %}
        stateMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //查看详情
        function showDetail(id, channel_type, is_show) {
            $.ajax({
                url: '/member/funds/deposit/info',
                async: true,
                data: {"id": id, "type": channel_type},
                type: 'post',
                dataType: 'json',
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success: function (data) {
                    if (data.status == 200) {
                        var deposit = JSON.parse(data.datas);
                        var content = 'detail_' + channel_type;
                        if (deposit) {
                            //取消申请的必须参数
                            $("#" + content + " input[name=id]").val(deposit.id);
                            $("#" + content + " input[name=channel_type]").val(deposit.channel_type);

                            $("#" + content + " .order_no").html(deposit.order_no);                             //订单编号
                            $("#" + content + " .channel_type").html(channelTypeMap[deposit.channel_type]);     //资金类型
                            $("#" + content + " .account_no").html(deposit.account_no + "-" + accountTypeMap[deposit.account_type]);       //账号
                            $("#" + content + " .amount").html(fmoney((deposit.amount / 100).toFixed(2),2));           //申请金额
                            $("#" + content + " .fee").html(deposit.fee / 100 || 0);            //手续费
                            $("#" + content + " .pay_amount").html(fmoney((deposit.pay_amount / 100).toFixed(2),2));   //支付金额USD
                            $("#" + content + " .card_no").html(deposit.card_no);               //银行账号
                            $("#" + content + " .card_user_name").html(deposit.card_user_name); //银行账户户名
                            $("#" + content + " .bank_name").html(deposit.branch_name);         //银行名称

                            $("#" + content + " .country").html(deposit.country);               //银行国家
                            $("#" + content + " .province").html(deposit.province);             //地区（省）
                            $("#" + content + " .city").html(deposit.city);                     //地区（市）
                            $("#" + content + " .branch_name").html(deposit.branch_name);       //银行开户行
                            $("#" + content + " .branch_address").html(deposit.branch_address);       //开户行地址
                            $("#" + content + " .branch_swift_code").html(deposit.branch_swift_code); //国际汇款代码
                            //留言
                            $("#" + content + " .remark").html(deposit.remark);                 //处理备注
                            $("#" + content + " .status").html(stateMap[deposit.status] || '{{ Lang.table_content_state || "处理中"}}');    //订单状态
                            $("#" + content + " .gmt_create").html(deposit.gmt_create);         //创建时间
                            $("#" + content + " .gmt_modified").html(deposit.gmt_modified);     //更新时间
                            if (deposit.proof_photoId) {
                              //  $("#" + content + " .proof_photoId").html("<img src='/common/images/" + deposit.proof_photoId + "'/>");   //汇票凭证，图片
                                $.post("/common/images/",{id:deposit.proof_photoId},function(result){
                                    if(result){
                                        $("#" + content + " .proof_photoId img").attr("src",result)
                                    }
                                });
                            }
                            $("#" + content + " .rate").html(deposit.rate / 10000);             //汇率
                            if (deposit.status == 2 && (deposit.channel_type == 1021 || deposit.channel_type == 1020)) {
                                    $("#" + content + " .canceApply").show();                   //取消申请  显示
                            } else {
                                $("#" + content + " .canceApply").hide();                       //取消申请  隐藏
                            }
                        }
                        var title = channelTypeMap[channel_type] + '{{ Lang.dialog_xx_details || "详情" }}';
                        if(is_show){
                            layer.open({
                                type: 1,
                                title: title,
                                area: ['600px', '80%'],
                                content: $("#" + content)
                            });
                        }
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {

                }

            });
        };


        var tableIns;
        layui.use(['form','laydate','table'],function(){
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem:'#start_time',
                type:'datetime',
                lang:laylang
            });

            laydate.render({
                elem:'#end_time',
                type:'datetime',
                lang:laylang
            });

            //列表
            var table = layui.table;
            tableIns = table.render({
                elem:"#depositlist",
                url:'/member/funds/deposit/list',
                method: 'post',
                cols:[[
                    {field:'order_no',title:'{{ Lang.table_order_no || "订单编号"}}',width:300,align:'center',templet:function(d){
                        return '<a onclick="showDetail(\''+d.id+'\','+d.channel_type+', true)" href="javascript:;">'+d.order_no+'</a>';
                        }},
                    {field:'account_no',title:'{{ Lang.table_source_account_no || "账号"}}',align:'center'},
                    {field:'channel_type',title:'{{ Lang.table_cause || "资金类型"}}',align:'center',templet:function(d){
                            return channelTypeMap[d.channel_type];
                        }},
                    {
                        field: 'amount', title: '{{ Lang.table_amount_3 || "申请金额(USD)"}}', sort: true, align: 'center', templet: function (d) {
                            if (d.channel_type == 101 || d.channel_type == 102) {
                                var amount = d.amount / 100 || 0;
                                return amount == 0 ? 0 : "-" +  fmoney(amount.toFixed(2),2);
                            }
                            return   fmoney((d.amount / 100).toFixed(2),2);
                        }
                    },
                    {field:'gmt_create',title:'{{Lang.table_gmt_create_1 || "创建时间" }}',sort:true,align:'center'},
                    {field:'status',title:'{{ Lang.table_state || "订单状态"}}',align:'center',templet:function(d){
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
                        status: $('input[name="status"]').val(),
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

            function search(search_form_data){
                tableIns.reload({
                    where:{
                        account_type:search_form_data.account_type,
                        account_no:search_form_data.account_no,
                        type:search_form_data.type,
                        channel_type:search_form_data.channel_type,
                        status:search_form_data.status,
                        start_time :search_form_data.start_time,
                        end_time :search_form_data.end_time
                    },
                    page:{
                        curr:1
                    }
                });
            };

            //取消出金
            form.on('submit(cance)', function (data) {
                layer.close(layer.index);
                var id = data.field.id;
                var channel_type = data.field.channel_type;
                if (id) {
                    $.ajax({
                        url: '/member/funds/deposit/cancel',
                        async: true,
                        data: {"id": id, "channel_type": channel_type},
                        type: 'post',
                        dataType: 'json',
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        success: function (data) {
                            if (data.status == 200) {
                                layer.confirm('{{ Lang.open_cancel_success || "取消成功" }}', {
                                    btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                                }, function () {
                                    showDetail(id, channel_type, false);
                                    $("#" + id + "_status").html("{{ Lang.msg_cancel_success || "已取消" }}");
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
        });
        function reload(){
            tableIns.reload({
                where:{
                },
                page:{
                    curr:1
                }
            });
        }
    </script>
    {# 引入js #}
{% endblock %}

{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_funds_deposit_title || "出入金记录" }}
                    </div>
                    <div id="search_box">

                        <form class="layui-form"  action="">

                            {#<label class="input-title">查询：</label>#}

                            <div class="layui-input-inline">
                                <select name="account_type">
                                    <option value="">{{ Lang.table_source_account_type || "账户类型" }}</option>
                                    {% for at in Lang.select.member.account.account_type %}
                                    {% if at.value == 1 || at.value == 2 || at.value == 9  %}
                                    <option value="{{ at.value }}">{{ at.label }}</option>
                                    {% endif %}
                                    {% endfor %}
                                </select>
                            </div>

                            <div class="layui-input-inline">
                                <select name="channel_type" id="channel_type" lay-filter="channel_type">
                                    <option value="">{{ Lang.form_select_funds_type || "资金类型" }}</option>
                                    {% for at in Lang.select.member.funds.channel_type %}
                                        <option value="{{ at.value }}">{{ at.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                           {# <label class="input-title">状态：</label>#}
                            <div class="layui-input-inline">
                                <select name="status" id="state" lay-filter="state">
                                    <option value="">{{ Lang.table_state || "订单状态" }}</option>
                                    {% for at in Lang.select.member.funds.order_state %}
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
                                <button class="layui-btn" lay-submit="" lay-filter="search_btn" onclick="javascript:return false;">{{ Lang.btn_search || "查询" }}</button>
                                <button type="reset" class="layui-btn layui-btn-primary" onclick="reload()">{{ Lang.btn_reset || "清空" }}</button>
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

    {#电汇入金-IDR 41#}
    <div id="detail_41" style="display:none">
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
                <label>{{ Lang.form_label_rate || "汇率" }}:</label>
                <span class="rate"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount || "支付金额(IDR)" }}:</label>
                <span class="pay_amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_proof_photo || "汇票凭证" }}:</label>
                <span class="proof_photoId"><img src=""/></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.table_state || "订单状态" }}:</label>
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

            <div class="canceApply" ><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="javascript:return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>

   {# 电汇入金-USD 40#}
    <div id="detail_40" style="display:none">
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
                <span class="proof_photoId"><img src="" style="width:200px"/></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.table_state || "订单状态" }}:</label>
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
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="javascript:return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>

    {# 出金-电汇-IDR 1021#}
    <div id="detail_1021" style="display:none">
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
                <label>{{ Lang.form_label_rate || "汇率" }}:</label>
                <span class="rate"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_label_pay_amount || "支付金额(IDR)" }}:</label>
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
                <label>{{ Lang.table_state || "订单状态" }}:</label>
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
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="javascript:return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>
    {# 出金-电汇-USD 1020#}
    <div id="detail_1020" style="display:none">
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
                <label>{{ Lang.table_state || "订单状态" }}:</label>
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
            <div class="canceApply" style="display:none"><button class="layui-btn" lay-submit="" lay-filter="cance" onclick="javascript:return false;">{{ Lang.btn_cancel_apply || "取消申请" }}</button></div>
        </form>
    </div>
    <style>
        img {
            border: 0;
            display:inline-block!important;
        }
    </style>
{% endblock %}
