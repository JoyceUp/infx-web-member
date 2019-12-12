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
        {% for at in Lang.select.member.register.account_type %}
        account_type[{{ at.value }}] = '{{ at.label }}';
        {% endfor %}

        //查看详情
        var detailIns;
        var isOpen = false;

        //销售提成明细
        function showDetail(date){
            var table = layui.table;
            var table_trade_detail = table.render({
                elem:"#bonusDetail"
                ,url:'/sale/bonus/info'
                ,method:'post'
                ,where:{"start_time":date}
               /* ,page:true*/
                ,cols:[[
                    {field:'email',title:'{{ Lang.table_email || "电子邮箱" }}',align:'center',width:'150'},
                    {field:'full_name',title:'{{ Lang.table_customer_name_1 || "客户姓名"}}',align:'center',width:120},
                    {field:'commission',title:'{{ Lang.table_amount_04 || "返佣(USD)"}}',align:'center',width:120,templet:function(d){
                            if(d.commission){
                                return fmoney(d.commission/100,2) ;
                            }else{
                                return 0;
                            }
                        }},
                    {field:'rebate',title:'{{ Lang.table_amount_01 || "返利(USD)"}}',align:'center',width:120,templet:function(d){
                            if(d.rebate){
                                return  fmoney(d.rebate/100,2) ;
                            }else{
                                return 0;
                            }
                        }},
                    {field:'reward_rate',title:'{{ Lang.table_earning_rate || "提成比例"}}',align:'center',width:120,templet:function(d){
                            if(d.reward_rate){
                                return d.reward_rate/10000 +"%";
                            }else{
                                return 0;
                            }
                        }},
                    {field:'reward',title:'{{ Lang.table_amount_5 || "提成金额(USD)"}}',width:120,align:'center',templet:function(d){
                            if(d.reward){
                                return  fmoney(d.reward/100,2)  ;
                            }else{
                                var rewardNumber =  (d.rebate / 100 ) * ( d.reward_rate / 1000000);
                                return toFixed(rewardNumber,2)
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
                title: "{{ Lang.dialog_bonus_details_2 || "提成明细" }}",
                area: ['auto', '500px'], //宽高
                content: $("#detail"),
                cancel: function(index, layero){
                    isOpen = false;
                    layer.close(index)
                    return false;
                }
            });
        }

        //提成列表
        var tableIns;
        layui.use(['form', 'laydate', 'table','element'], function () {
            var element = layui.element;
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem: '#start_time'
                , type: 'date'
                , format: 'yyyy-MM-dd',
                lang:laylang
            });
            laydate.render({
                elem: '#end_time'
                , type: 'date'
                , format: 'yyyy-MM-dd',
                lang:laylang
            });

            //填充表单数据
            var table = layui.table;
                tableIns = table.render({
                    elem: '#test'
                    , url: '/sale/bonus/list'
                    , cols: [[
                        {
                            field: 'change_time', title: '{{ Lang.table_change_time || "提成日期" }}', align: 'center', templet: function (d) {
                                if (d.statistics) {
                                    return "{{ Lang.table_total_text || "合计" }}";
                                }
                                if (d.change_time) {
                                    return d.change_time.substring(0, 10);
                                }
                            }
                        }
                        , {
                            field: 'amount', title: '{{ Lang.table_amount_5 || "提成金额(USD)" }}', align: 'center', templet: function (d) {
                                if (d.statistics) {
                                    return d.sum_reward_amount / 100;
                                } else {

                                    if (d.amount) {
                                     return '<a onclick="showDetail(\'' + d.change_time.substring(0, 10) + '\')"  href="javascript:;">' + d.amount / 100 + '</a>'
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
                if (data.field.start_time && data.field.end_time) {
                    if (new Date(data.field.start_time).getTime() > new Date(data.field.end_time).getTime()) {
                        layer.alert("{{ Lang.alert_start_time_more_than_the_end_time || "开始时间 不能大于 结束时间" }}", {
                            title: '{{ Lang.page_msg_h3 || "提示：" }}'
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
            if (start) {
                start = start + " 00:00:00";
            } else {
                start = '';
            }

            if (end) {
                end = end + " 23:59:59"
            } else {
                end = '';
            }
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    start_time: start
                    , end_time: end
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
                        {{ Lang.page_rebate_bonus_title || "提成列表" }}
                    </div>
                    <div id="search_box">
                        <form class="layui-form" action="">

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
                                <button type="reset" class="layui-btn layui-btn-primary" onclick="reload()">{{ Lang.btn_reset || "清空" }}</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="main_page_Info">
                    <table class="layui-hide " id="test"></table>
                    <div class="page">
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="detail" style="display:none">
        <div class="main_page_Info">
            <table class="layui-hide layui-table-cell" id="bonusDetail"></table>
            <div class="page">
            </div>
            </div>
        </div>
    </div>

{% endblock %}
