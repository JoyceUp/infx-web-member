{% extends '../../common/layouts/layout.tpl' %}
{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_rebate_balance_title || "余额返利记录" }}
                    </div>
                    <div id="search_box">
                        <form class="layui-form" action="">
                            <div class="layui-form-item" style="margin-bottom: 0">
                                <div class="layui-inline">
                                    <label class="layui-form-label"style="width: 160px; padding: 9px 5px;" >{{ Lang.form_label_balance_time || "返利日期" }}</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="start_time" id="start_time" autocomplete="off"
                                               class="layui-input">
                                    </div>
                                    <div class="layui-form-mid">-</div>
                                    <div class="layui-input-inline">
                                        <input type="text" name="end_time" id="end_time" autocomplete="off"
                                               class="layui-input">
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
                    <table class="layui-hide" id="tra"></table>
                    <div class="page"></div>
                </div>
            </div>
        </div>
    </div>

    <div id="detail" style="display:none">
        <div class="main_page_Info">
            <table class="layui-hide" id="detail_table">
            </table>
        </div>
    </div>
{% endblock %}

{% block js_assets %}
    <script>



        var accountTypeMaps = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMaps[{{ at.value}}] = "{{at.label }}";
        {% endfor %}


        //查看详情
        function showDetail(start_time) {
            console.log(accountTypeMaps)
            //填充表单数据
            var table = layui.table;
            table.render({
                elem: '#detail_table'
                , url: "/member/rebates/balance/list"
                , method: 'post'
                , where: {
                    start_time: start_time + " 00:00:00",
                    end_time: start_time + " 23:59:59",
                }
                , cols: [[
                    {field: 'source_account_no', title: '{{ Lang.table_lower_level_account || "下级账号" }}',width: 140, align: 'center'}
                    , {field: 'source_account_full_name', title: '{{ Lang.table_lower_level_name || "下级姓名" }}',width: 100, align: 'center'}
                    , {field: 'source_account_type', title: '{{ Lang.table_source_account_type || "账户类型" }}',width: 120, align: 'center', templet: function (d) {
                            return accountTypeMaps[d.source_account_type] || '';
                        }
                    }
                    , {field: 'source_account_balance', title: '{{ Lang.form_placeholder_account_balance || "账户余额(USD)" }}',width: 100, align: 'center', templet: function (d) {
                            return fmoney((d.source_account_balance / 100).toFixed(2),2);
                        }
                    }
                    , {field: 'rate', title: '{{ Lang.table_rate || "年化返利率" }}',width: 180, align: 'center', templet: function (d) {
                            return d.rate / 10000 + "%";
                        }
                    }
                    , {
                        field: 'amount', title: '{{ Lang.table_amount_1 || "返利金额(USD)" }}',width: 150, align: 'center', templet: function (d) {
                            return fmoney(d.amount / 100,2);
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

            layer.open({
                type: 1,
                title: "{{ Lang.dialog_rebate_details || "余额返利明细" }}",
                area: ['85%', '400px'], //宽高
                content: $("#detail")
            });
        }

        var tableIns;
        layui.use(['form', 'laydate', 'table'], function () {
            var form = layui.form;
            var table = layui.table;
            var laydate = layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#start_time'
                , type: 'date',
                lang:laylang
            });
            laydate.render({
                elem: '#end_time'
                , type: 'date',
                lang:laylang
            });

            tableIns = table.render({
                elem: '#tra'
                , url: '/member/rebates/balance/oneday'
                , method: 'post'
                , cellMinWidth: 80
                , page: true
                , cols: [[
                    {
                        field: 'gmt_create', title: '{{ Lang.table_rebate_date || "返利日期" }}', align: 'center', templet: function (d) {
                            if(d.statistics){
                                return "{{ Lang.table_total_text || "合计" }}";
                            }
                            return d.gmt_create.substr(0, 10)
                        }
                    }
                    , {
                        field: 'daily_amount', title: '{{ Lang.table_amount_1 || "返利金额(USD)" }}', align: 'center', templet: function (d) {
                            if(d.statistics){
                                return d.amount / 100;
                            }
                            if (d.amount) {
                                return '<a onclick="showDetail(\'' + d.gmt_create + '\')"  href="javascript:;">' + (d.amount / 100) + '</a>';
                            } else {
                                return 0;
                            }

                        }
                    }
                ]]
                , response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });

            //搜索表单
            var form = layui.form;
            form.on('submit(search_btn)', function (data) {
                search(data.field);
                return false;
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
                    where: {
                        account_no: search_form_data.account_no,
                        state: search_form_data.state,
                        ib_no: search_form_data.ib_no,
                        start_time: start,
                        end_time: end
                    },
                    page: {
                        curr: 1
                    }
                });
            }
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
{% endblock %}