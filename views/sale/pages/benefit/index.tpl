{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    <style>
    .layui-table-cell{
        text-overflow: inherit;
    }

    </style>
{% endblock %}

{% block js_assets %}
    <script>
        var position = new Object();
        {% for at in Lang.select.sale.position %}
        position[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        var account_type = new Object();
        {% for at in Lang.select.sale.account_type %}
        account_type[{{ at.value }}] = '{{ at.label }}';
        {% endfor %}


        //津贴列表
        var tableIns;
        layui.use(['form', 'laydate', 'table','element'], function () {
            var element = layui.element;
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem: '#start_time'
                ,type: 'month'
                ,lang:laylang
            });
            laydate.render({
                elem: '#end_time'
                , type: 'month'
                ,lang:laylang
            });

            //填充表单数据
            var table = layui.table;
                tableIns = table.render({
                    elem: '#test'
                    , url: '/sale/benefit/list'
                    , cols: [[
                        {
                            field: 'month', title: '{{ Lang.table_year_month || "年/月" }}', align: 'center', templet: function (d) {
                                if (d.statistics) {
                                    return "{{ Lang.table_total_text || "合计" }}";
                                }else{
                                    return d.month;
                                }
                            }
                        }
                        , {
                            field: 'amount', title: '{{ Lang.table_amount_6 || "津贴金额(USD)" }}', align: 'center', templet: function (d) {
                                if (d.statistics) {
                                    return d.sum_reward_amount / 100;
                                } else {

                                    if (d.amount) {
                                     return '<a onclick="showDetail(\'' + d.month+ '\')"  href="javascript:;">' + d.amount / 100 + '</a>'
                                    } else {
                                        return '0';
                                    }
                                }
                            }
                        }
                    ]]
                    , page: true
                    , method: 'post'
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
                search(data.field);
                return false;
            });

        });

        function search(search_form_data) {
            var start_time = search_form_data.date;
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    date: start_time
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,done:function(res,curr,count){u
                    if(window.user.department_sales !== 1) {
                        $("[data-field='department_leader_amount']").hide();
                        $("[data-field='amount']").hide();
                    }
                }
            });
        }


        //查看详情
        var detailIns2;
        var isOpen = false;

        //销售津贴明细
        function showDetail(date){
            var table = layui.table;
            detailIns2 = table.render({
                elem:"#bonusDetail"
                ,url:'/sale/benefit/info'
                ,method:'post'
                ,where:{"start_time":date}
                ,page:true
                ,cols:[[
                    {field:'day',title:'{{ Lang.table_date || "日期" }}',align:'center',width:100},
                    {field:'sale_account_no',title:'{{ Lang.table_sales_account_no || "销售账号" }}',width:100,align:'center'},
                    {field:'sale_name',title:'{{ Lang.table_sales_name || "销售姓名"}}',align:'center',width:100},
                    {field:'sale_type',title:'{{ Lang.table_sales_type || "销售类别"}}',align:'center',width:70,templet:function(d){
                            if(d.sale_type){
                                return position[d.sale_type];
                            }else{
                                return "";
                            }
                        }},
                    {field:'sale_reward',title:'{{ Lang.table_sales_amount || "销售收益"}}',width:70,align:'center',templet:function(d){
                            if(d.sale_reward){
                                return d.sale_reward/100;
                            }else{
                                return "";
                            }
                        }},
                    {field:'rate',title:'{{ Lang.table_earning_rate || "提成比例"}}',width:100,align:'center',templet:function(d){
                        if(d.rate){
                            return d.rate/10000 + "%";
                        }else{
                            return "";
                        }
                        }},
                    {field:'amount',title:'{{ Lang.table_sales_benefit || "津贴金额(USD)"}}',align:'center',width:100,templet:function(d){
                            if(d.amount){
                                return d.amount/100;
                            }else{
                                return 0;
                            }
                        }},
                ]]
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
                title: "{{ Lang.dialog_benefit_detail || "津贴明细" }}",
                area: ['860px', '500px'], //宽高
                content: $("#detail"),
                cancel: function(index, layero){
                    isOpen = false;
                    layer.close(index)
                    return false;
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
                        {{ Lang.page_rebate_benefit_title || "津贴管理" }}
                    </div>
                    <div id="search_box">
                        <form class="layui-form" action="">

                            <div class="layui-input-inline">
                                <input class="layui-input" id="start_time" name="date" placeholder="{{ Lang.form_text_year_month || "年月" }}" type="text" value="" >
                            </div>
                            <div class="layui-input-inline">
                                <button class="layui-btn" lay-submit="" lay-filter="search_btn" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                <button type="reset" class="layui-btn layui-btn-primary" onclick="reload()">{{ Lang.btn_reset || "清空" }}</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="main_page_Info">
                    <table class="layui-hide" id="test"></table>
                    <div class="page">
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="detail" style="display:none">
        <div class="main_page_Info">
            <table class="layui-hide" id="bonusDetail"></table>
            <div class="page">
            </div>
            </div>
        </div>
    </div>

{% endblock %}
