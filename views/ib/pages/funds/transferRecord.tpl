
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}

    {# 引入css #}
{% endblock %}



{% block js_assets %}
    <script>
        //订单状态
        var stateMap = new Object();
        {% for at in Lang.select.ib.funds.order_state %}
        stateMap[{{ at.value }}] = "{{ at.label }}"
        {% endfor %}

        //出金渠道类型
        var channelTypeMap = new Object();
        {% for at in Lang.select.ib.funds.funds_type %}
        channelTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //详情
        function showDetail(id){
            $.ajax({
                url: "/ib/funds/transfer_record/info",
                async: true,
                data: {"id": id},
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success:function(data){
                    if(data.status==200){
                        var transfer = JSON.parse(data.datas);
                        if(transfer){
                            //处理中，增加取消按钮
                            if(transfer.status == 2){
                                $("#cancel_btn_div").show();
                            }else{
                                $("#cancel_btn_div").hide();
                            }

                            //已忽略显示处理备注
                            if(transfer.remark){
                                $("#remark").html(transfer.remark);
                                $("#remark_div").show();
                            }
                            $("#id").val(transfer.id);
                            $("#order_no").html(transfer.order_no);
                            $("#gmt_create").html(transfer.gmt_create);
                            // $("#channel_type").html(channelTypeMap[transfer.channel_type]);
                            $("#account_no").html(transfer.account_no);
                            $("#target_account_no").html(transfer.target_account_no);
                            $("#amount").html(transfer.amount / 100);
                            $("#status").html(stateMap[transfer.status] || '{{ Lang.msg_ing || "{{ Lang.table_content_state || \"处理中\"}}" }}');
                            $("#gmt_modified").html(transfer.gmt_modified);
                        }
                        layer.open({
                            type:1,
                            title:'{{ Lang.dialog_transfer_details || "转账记录详情" }}',
                            area:['500px','auto'],
                            content:$('#detail')
                        });
                    }
                }
            });
        }
        //取消转账
        function cancelTransfer(){
            layer.close(layer.index);
            var id = $("#id").val();
            $.ajax({
                url:'/ib/funds/transfer/cancel_transfer',
                async: true,
                type:'post',
                dataType:'json',
                data: {"id": id, "type":$("#channel_type").html()},
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success:function(data){
                    if(data.status == 200){
                        layer.confirm('{{ Lang.open_cancel_success || "取消成功" }}', {
                            btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                        }, function(){
                            $("#cancel_btn_div").hide();
                            $("#status").html("{{ Lang.msg_cancel_success || "已取消" }}");
                            $("#"+id+"_status").html("{{ Lang.msg_cancel_success || "已取消" }}");
                            layer.close(layer.index);
                        });
                    }else{
                        layer.alert(data.msg, {
                            title: '{{ Lang.alert_title_info || "信息" }}'
                        });
                    }
                }
            });
        }

        //列表
        var tableIns;
        layui.use(['table','form','laydate'],function(){
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
            var table = layui.table;
            tableIns = table.render({
                elem:'#dataTable',
                url:'/ib/funds/transfer_record/list',
                page:true,
                method:'post',
                cols:[[
                    {field:'order_no',title:'{{Lang.table_order_no || "订单编号" }}',width:300,align:'center',templet:function(d){
                            return '<a onclick="showDetail(\''+d.id+'\','+d.channel_type+')" href="javascript:;">'+d.order_no+'</a>';
                        }},
                    {field:'account_no',title:'{{ Lang.table_account_no || "转出账号"}}',align:'center'},
                    {field:'target_account_no',title:'{{Lang.table_target_account_no || "转入账号" }}',align:'center'},
                    {field:'amount',title:'{{ Lang.table_amount_2 || "转账金额(USD)"}}',sort:true,align:'center',templet:function(d){
                            return d.amount / 100;
                        }},
                    {field:'gmt_create',title:'{{ Lang.table_gmt_create_1 || "创建时间"}}',sort:true,align:'center'},
                    {field:'state',title:'{{ Lang.table_state || "订单状态"}}',align:'center',templet:function(d){
                            return "<span id='"+d.id+"_status'>"+(stateMap[d.status] || '{{ Lang.table_content_state || "处理中"}}')+"</spam>";
                        }}
                ]],
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
                table.reload('dataTable', {
                    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                        field: obj.field    //当前排序的字段名
                        ,order: obj.type,    //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
                        account_no_to: $('input[name="account_no_to"]').val(),
                        account_no_from: $('input[name="account_no_from"]').val(),
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

            function search(search_form_data){
                tableIns.reload({
                    where:{
                        account_no_to:search_form_data.account_no_to,
                        account_no_from:search_form_data.account_no_from,
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
                        {{ Lang.page_funds_transfer_title || "转账记录" }}
                    </div>
                    <div id="search_box">

                        <form class="layui-form"  action="">

                            <div class="layui-input-inline">
                                <select name="account_no_from" class="layui-input">
                                    <option value="">{{ Lang.form_placeholder_account_no_from || "转出账号" }}</option>
                                    {% for ac in account %}
                                        <option value="{{ ac.account_no }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                            <div class="layui-input-inline">
                                <select name="account_no_to" class="layui-input">
                                    <option value="">{{ Lang.form_placeholder_account_no_to || "转入账号" }}</option>
                                    {% for ac in account %}
                                        <option value="{{ ac.account_no }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                            <div class="layui-input-inline">
                                <select name="state">
                                    <option value="">{{ Lang.form_select_order_state || "订单状态" }}</option>
                                    {% for at in Lang.select.ib.funds.transfer_order_state %}
                                        <option value="{{ at.value }}">{{ at.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                            <div class="layui-input-inline">
                                <input class="layui-input" id="start_time" name="start_time" placeholder="{{ Lang.form_placeholder_start_time || "开始时间" }}" type="text" value="" >
                            </div>
                            <div class="layui-input-inline">
                                -
                            </div>
                            <div class="layui-input-inline">
                                <input class="layui-input" id="end_time" name="end_time" placeholder="{{ Lang.form_placeholder_end_time || "结束时间" }}" type="text" value="">
                            </div>

                            <div class="layui-input-inline">
                                <button class="layui-btn" lay-submit="" lay-filter="search_btn" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                <button type="reset" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                            </div>

                        </form>

                    </div>

                </div>

                <div class="main_page_Info">
                    <table class="layui-hide" id="dataTable" lay-filter="dataTable" ></table>
                    <div class="page"></div>
                </div>
            </div>
        </div>
    </div>
    <div id="detail" style="display:none">
        <form class="layui-form show-detail" action="">
            <div class="d-item">
                <label>{{ Lang.form_label_order_no || "订单编号" }}:</label>
                <span id="order_no"></span>
                <input type="hidden" id="id"/>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}:</label>
                <span id="gmt_create"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_select_funds_type || "资金类型" }}:</label>
                <span id="channel_type">{{ Lang.form_text_transfer || "转账" }}</span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no_from || "转出账号" }}:</label>
                <span id="account_no"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no_to || "转入账号" }}:</label>
                <span id="target_account_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span id="amount"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_state || "状态" }}:</label>
                <span id="status"></span>
            </div>

            <div class="d-item" style="display:none" id="remark_div">
                <label>{{ Lang.form_label_remark || "处理备注" }}:</label>
                <span id="remark"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}:</label>
                <span id="gmt_modified"></span>
            </div>

            <div class="canceApply" id="cancel_btn_div" style="display:none">
                <input type="button" onclick="cancelTransfer()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
            </div>
        </form>
    </div>
{% endblock %}
