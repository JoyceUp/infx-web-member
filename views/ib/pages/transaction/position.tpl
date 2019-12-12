{% extends '../../common/layouts/layout.tpl' %}
{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">{{ Lang.page_rebate_trade_title || "交易返佣记录" }}</div>
                    <div id="search_box">
                        <form class="layui-form"  action="">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <input type="text" name="source_account_user_name"  placeholder="{{ Lang.form_placeholder_customer_name || "客户姓名" }}" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-inline">
                                    <input type="text" name="account_no"  placeholder="{{ Lang.table_mt4_account || "MT4账号" }}" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">{{ Lang.form_label_open_time_gmt || "开仓时间（GMT）" }}</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="start_time" id="test1" autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid">-</div>
                                    <div class="layui-input-inline">
                                        <input type="text" name="end_time" id="test2" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button class="layui-btn" lay-submit lay-filter="search_btn" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                    <button type="reset" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="main_page_Info">
                    <table class="layui-hide" id="tra" ></table>
                    <div class="page"></div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}

{% block js_assets %}
    <script>
        //交易类型  交易品种
        var typeOptions = new Object();
        {% for at in Lang.select.ib.transaction.type %}
        typeOptions[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}
        var symbolOptions = new Object();
        {% for at in Lang.select.ib.transaction.symbol %}
        symbolOptions[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}

        layui.use(['form','laydate','table'], function(){
            var form = layui.form;
            var table = layui.table;
            var laydate = layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#test1',
                lang:laylang //指定元素
            });
            laydate.render({
                elem: '#test2',
                lang:laylang //指定元素
            });

            tableIns = table.render({
                elem : '#tra'
                ,url : '/ib/transaction/position_datas'
                ,cellMinWidth : 80
                ,page:true
                ,cols : [[
                    {field:'order_no', title:'{{ Lang.table_order_no || "订单编号"}}', align: 'center',fixed:'left'}
                    ,{field:'account_no', title:'{{Lang.table_source_account_no || "账号" }}', align: 'center'}
                    ,{field:'open_time', title:'{{ Lang.table_open_time || "开仓时间"}}', align: 'center'}
                    ,{field:'type', title:'{{ Lang.table_type || "交易类型"}}', align: 'center', templet: function (d) {
                            return typeOptions[d.type];
                        }}
                    ,{field:'symbol', title:'{{ Lang.table_trading_symbol || "交易品种"}}', align: 'center', templet: function (d) {
                            return symbolOptions[d.symbol];
                        }}
                    ,{field:'volume', title:'{{ Lang.table_trading_volume || "交易量" }}', align: 'center'}
                    ,{field:'open_price', title:'{{ Lang.table_open_price || "开仓价格" }}', align: 'center'}
                    ,{field:'sl', title:'S / L', align: 'center'}
                    ,{field:'tp', title:'T / P', align: 'center'}
                    ,{field:'fee', title:'{{ Lang.table_fee || "手续费(USD)" }}', align: 'center'}
                    ,{field:'swaps', title:'{{ Lang.table_swaps || "隔夜利息" }}', align: 'center'}
                    ,{field:'profit', title:'{{ Lang.table_profit || "交易盈亏" }}', align: 'center'}
                ]]
                , response: {
                statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
            }
            })

            //搜索表单
            var form = layui.form;
            form.on('submit(search_btn)',function(data){
                search(data.field);
                return false;
            });

            function search(search_form_data){
                tableIns.reload({
                    where:{
                        account_no:search_form_data.account_no,
                        state:search_form_data.state,
                        ib_no:search_form_data.ib_no,
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
{% endblock %}