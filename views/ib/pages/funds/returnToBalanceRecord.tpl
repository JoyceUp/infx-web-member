
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}

    {# 引入css #}
{% endblock %}

{% block js_assets %}
    <script>
        var stateMap = new Object();
        {% for at in Lang.select.ib.funds.state %}
        stateMap[{{ at.value }}] = "{{ at.label }}"
        {% endfor %}

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
                url:'/ib/funds/return_to_balance_record/list',
                page:true,
                method:'post',
                cols:[[
                    {field:'order_no',title:'{{ Lang.table_order_no || "订单编号"}}',width:300,align:'center'},
                    {field:'account_no',title:'{{ Lang.table_source_account_no || "账号"}}',align:'center'},
                    {field:'amount',title:'{{ Lang.table_amount_3 || "申请金额(USD)"}}',sort:true,align:'center', templet: function (d) {
                            return d.amount / 100;
                        }},
                    {field:'account_balance',title:'{{ Lang.table_account_balance || "转前余额(USD)"}}',align:'center', templet: function (d) {
                            return d.account_balance / 100;
                        }},
                    {field:'gmt_create',title:'{{ Lang.table_account_balance_1 || "转后余额(USD)"}}',align:'center', templet: function (d) {
                            return (d.amount + d.account_balance) / 100;
                        }},
                    {field:'gmt_create',title:'{{ Lang.table_gmt_create_1 || "创建时间" }}',sort:true,align:'center'}
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
                        account_no: $('input[name="account_no"]').val(),
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
                        account_no:search_form_data.account_no,
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
                        {{ Lang.page_funds_return_to_balancelist_title || "返利转余额记录" }}
                    </div>
                    <div id="search_box">

                        <form class="layui-form"  action="">

                            <div class="layui-input-inline">
                                <select name="account_no" class="layui-input">
                                    <option value="">{{ Lang.form_placeholder_account_no || "账号" }}</option>
                                    {% for ac in account %}
                                        <option value="{{ ac.account_no }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
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
                    <table class="layui-hide" id="dataTable" lay-filter="dataTable"></table>
                </div>
            </div>
        </div>
    </div>
{% endblock %}
