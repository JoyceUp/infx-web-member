{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
{% endblock %}

{% block js_assets %}
    <script>

        var account_type = new Object();
        {% for at in Lang.select.sale.account_type %}
        account_type[{{ at.value }}] = '{{ at.label }}';
        {% endfor %}

        var tableIns;
        layui.use(['form', 'laydate', 'table'], function () {
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem: '#start_time', //初始日期
                type:'date',
                lang:laylang
            });
            laydate.render({
                elem: '#end_time', //结束日期
                type:'date',
                lang:laylang
            });

            //填充表单数据
            var table = layui.table;
            tableIns = table.render({
                elem: '#test'
                , url: '/sale/rebate/trade/list'
                , method: 'post'
                , cols: [[
                    {
                        field: 'change_time', title: '{{ Lang.table_change_time_1 || "返佣时间" }}', width: 210, align: 'center', templet: function (d) {
                            if (d.statistics) {
                                return "{{ Lang.table_total_text || "合计" }}";
                            }
                            return d.change_time;
                        }
                    }
                    , {field: 'source_account_no', title: '{{ Lang.table_source_account_no || "账号" }}', align: 'center'}
                    , {field: 'source_account_full_name', title: '{{ Lang.table_customer_name || "姓名" }}', align: 'center'}
                    , {
                        field: 'source_account_type', title: '{{ Lang.table_source_account_type || "账户类型" }}', align: 'center', templet: function (d) {
                            if (d.statistics) {
                                return "";
                            }
                            if (d.source_account_type) {
                                return account_type[d.source_account_type];
                            } else {
                                return "{{ Lang.table_unknown || "未知" }}";
                            }
                        }
                    }

                    , {field: 'trading_symbol', title: '{{ Lang.table_trading_symbol || "交易品种" }}', align: 'center'}
                    , {
                        field: 'trading_volume', title: '{{ Lang.table_trading_volume || "交易量" }}',  align: 'center', templet: function (d) {
                            if (d.trading_volume) {
                                return d.trading_volume / 100;
                            } else {
                                return 0;
                            }
                        }
                    }
                    , {
                        field: 'rateRebate', title: '{{ Lang.table_rate_rebate || "返佣比率" }}', align: 'center', templet: function (d) {
                            if (d.statistics) {
                                return "";
                            }
                            var rate = d.commission_amount / d.trading_volume;
                            var rateStr = rate.toString();
                            if (rateStr.indexOf('.') > -1) {
                                rate = toFixed(rate, 2);
                            }
                            return rate + "USD/{{ Lang.form_hand || "手" }}";
                        }
                    }
                    , {
                        field: 'commission_amount',
                        title: '{{ Lang.table_commission_amount || "返佣金额(USD)" }}',
                        align: 'center',
                        templet: function (d) {
                            return   fmoney(d.commission_amount / 100 / 100,2);
                        }
                    }

                ]]
                , page: true
                , response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });

            //监听搜索按钮
            var form = layui.form;
            form.on('submit(search_btn)', function (data) {
                if (data.field.start_time && data.field.end_time) {
                    if (new Date(data.field.start_time).getTime() > new Date(data.field.end_time).getTime()) {
                        layer.alert("{{ Lang.alert_start_time_more_than_the_end_time || "开始时间 不能大于 结束时间" }}", {
                            title: '{{ Lang.page_text_info || "信息：" }}'
                        });
                        return false;
                    }
                }
                search(data.field);
                return false;
            });
        });

        function search(search_form_data) {
            var start = search_form_data.start_time;
            var end = search_form_data.end_time;

            if(start){
                start = start + " 00:00:00";
            }else {
                start = '';
            }

            if(end){
                end = end + " 23:59:59";
            }else {
                end ='';
            }
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    start_time: start
                    , end_time: end
                    , source_account_full_name: search_form_data.source_account_full_name
                    , source_account_no: search_form_data.source_account_no
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        }

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
{% endblock %}


{% block content %}

    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_rebate_trade_title || "交易返佣记录" }}
                    </div>
                    <div id="search_box">
                        <form class="layui-form"  action="">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <input type="text" name="source_account_full_name"  placeholder="{{ Lang.form_placeholder_customer_name || "客户姓名" }}" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-inline">
                                    <input type="text" name="source_account_no"  placeholder="{{ Lang.form_placeholder_customer_account_no || "客户账号" }}" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label zm-w190">{{ Lang.form_label_trade_time || "返佣时间" }}</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="start_time" id="start_time" autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid">-</div>
                                    <div class="layui-input-inline">
                                        <input type="text" name="end_time" id="end_time" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button class="layui-btn" lay-submit lay-filter="search_btn" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                    <button type="reset" class="layui-btn layui-btn-primary" onclick="reload()">{{ Lang.btn_reset || "清空" }}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="main_page_Info">
                    <table class="layui-hide" id="test"></table>
                </div>
            </div>
        </div>
    </div>
{% endblock %}
