{% extends '../../common/layouts/layout.tpl' %}
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
                                    <select name="account_no" placeholder="{{ Lang.form_label_ib_account_no || "代理账号" }}">
                                        <option value="">{{ Lang.form_label_ib_account_no || "代理账号" }}</option>
                                        {% for ac in account %}
                                            <option value="{{ ac.account_no }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                                <div class="layui-inline">
                                    <input type="text" name="source_account_full_name"  placeholder="{{ Lang.form_placeholder_customer_name || "客户姓名" }}" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-inline">
                                    <input type="text" name="source_account_no"  placeholder="{{ Lang.form_placeholder_customer_account_no || "客户账号" }}" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">{{ Lang.form_label_trade_time || "返佣时间" }}</label>
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
                                    <button type="reset" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="main_page_Info">
                    <table class="layui-hide" lay-filter="dataTable" id="tra" ></table>
                    <div class="page"></div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}

{% block js_assets %}
    <script>
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.ib.register.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        layui.use(['form','laydate','table'], function(){
            var form = layui.form;
            var table = layui.table;
            var laydate = layui.laydate;
            //执行一个laydate实例
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

            tableIns = table.render({
                elem : '#tra'
                ,url : '/ib/rebates/trade/list'
                ,method: 'post'
                ,cellMinWidth : 80
                ,page:true
                ,cols : [[
                    {field:'account_no', title:'{{Lang.table_account_no_1 || "代理账号" }}', align: 'center', templet: function (d) {
                            if(d.statistics){
                                return "{{ Lang.table_total_text || "合计" }}";
                            }
                            return d.account_no;
                        }
                    }
                    ,{field:'source_account_type', title:'{{ Lang.table_source_account_type_1 || "客户账户类型"}}', align: 'center', templet: function (d) {
                            return accountTypeMap[d.source_account_type] || '';
                        }}
                    ,{field:'source_account_no', title:'{{ Lang.table_source_account_no_1 || "客户账号"}}', align: 'center'}
                    ,{field:'source_account_full_name', title:'{{ Lang.table_customer_name_1 || "客户姓名"}}', align: 'center'}
                    ,{field:'trading_symbol', title:'{{ Lang.table_trading_symbol || "交易品种"}}', align: 'center'}
                    ,{field:'trading_volume', title:'{{ Lang.table_trading_volume || "交易量"}}',sort:true, align: 'center', templet: function (d) {
                            return d.trading_volume / 100 ||  0;
                        }}
                    , {
                        field: 'rateRebate', title: '{{Lang.table_rate_rebate || "返佣比率" }}', align: 'center', templet: function (d) {
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
                    ,{field:'commission_amount', title:'{{ Lang.table_commission_amount || "返佣金额(USD)"}}', align: 'center', templet: function (d) {
                            return d.commission_amount / 100 ||  0;
                        }}
                    ,{field:'change_time', title:'{{ Lang.table_change_time_1 || "返佣时间" }}', align: 'center'}
                ]]
                , response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });
            table.on('sort(dataTable)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                //尽管我们的 table 自带排序功能，但并没有请求服务端。
                //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
                table.reload('tra', {
                    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                        field: obj.field    //当前排序的字段名
                        ,order: obj.type,    //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
                        account_no: $('input[name="account_no"]').val(),
                        source_account_full_name: $('input[name="source_account_full_name"]').val(),
                        source_account_no: $('input[name="source_account_no"]').val(),
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
                        source_account_full_name:search_form_data.source_account_full_name,
                        source_account_no:search_form_data.source_account_no,
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