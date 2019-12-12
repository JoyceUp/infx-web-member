{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
{% endblock %}

{% block js_assets %}
    <script>
        //资金类型
        var fundsTypeMap = new Object();
        {% for at in Lang.select.member.funds.funds_type %}
         fundsTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}
        //账户类型
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        {% if at.account_type == 1  and at.account_type == 4 and at.account_type == 9  %}
                accountTypeMap[{{ at.value }}] = "{{ at.label }}";
            {% endif %}
        {% endfor %}

        var tableIns;
        layui.use(['form','laydate','table'], function() {
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem: '#start_time'
                , type: 'datetime',
                lang:laylang
            });
            laydate.render({
                elem: '#end_time'
                , type: 'datetime',
                lang:laylang
            });

            //列表
            var table = layui.table;
            tableIns = table.render({
                elem:'#fundslist',
                url:'/member/funds/fundsrecord/list',
                method:'post',
                cols:[[
                    // {field:'order_no',title:'订单编号',width:300,align:'center'},
                    {field:'account_no',title:'{{ Lang.table_source_account_no || "账号" }}',align:'center'},
                    {field:'cause',title:'{{ Lang.table_cause || "资金类型"}}',align:'center',templet:function(d){
                            return fundsTypeMap[d.cause];
                        }},
                    {field:'difference',title:'{{ Lang.table_difference || "金额(USD)"}}',sort:true,align:'center', templet: function (d) {
                            return fmoney( (d.difference / 100).toFixed(2),2);
                        }},
                    {field:'gmt_create',title:'{{ Lang.table_gmt_create_1 || "创建时间" }}',sort:true,align:'center'}
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
                table.reload('fundslist', {
                    initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                        field: obj.field    //当前排序的字段名
                        ,order: obj.type,    //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
                        account_no: $('input[name="account_no"]').val(),
                        type: $('input[name="type"]').val(),
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
                        layer.alert("{{ Lang.alert_start_time_more_than_the_end_time || '开始时间 不能大于 结束时间' }}", {
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
                        start_time :search_form_data.start_time,
                        end_time :search_form_data.end_time
                    },
                    page:{
                        curr:1
                    }
                });
            }
        })

        function reload(){
            tableIns.reload({
                where:{
                    account_type:"",
                    account_no:"",
                    type:"",
                    start_time :"",
                    end_time :""
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
                        {{ Lang.page_funds_fundsrecord_title || "资金记录" }}
                    </div>
                    <div id="search_box">

                        <form class="layui-form"  action="">

                        {#<label class="input-title">{{ Lang.table_source_account_type || "账户类型" }}：</label>#}
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
                                <select name="type">
                                    <option value="">{{ Lang.form_select_funds_type || "资金类型" }}</option>
                                   {% for at in Lang.select.member.funds.funds_type %}
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

                    <table class="layui-hide" id="fundslist" lay-filter="dataTable"></table>

                    <div class="page">

                    </div>
                </div>
            </div>
        </div>
    </div>



{% endblock %}
