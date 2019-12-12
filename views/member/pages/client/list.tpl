{% extends '../../common/layouts/layout.tpl' %}
{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.title_my_lower_level || "我的下级" }}
                    </div>
                    <div id="search_box">
                        <form class="layui-form"  action="">
                            <div class="layui-inline">
                                <input type="hidden" name="account_no"  placeholder="{{ Lang.form_placeholder_account_no || "账号" }}" autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-inline">
                                <input type="text" name="full_name"  placeholder="{{ Lang.form_placeholder_name || "姓名" }}" autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-inline">
                                <input type="text" name="email"  placeholder="{{ Lang.form_placeholder_login_email || "邮箱" }}" autocomplete="off" class="layui-input">
                            </div>

                            <div class="layui-input-inline">
                                <input class="layui-input" id="start_time" name="start_time" placeholder="{{ Lang.form_placeholder_start_time || "创建时间" }}" type="text" value="" >
                            </div>
                            <div class="layui-input-inline">
                                -
                            </div>
                            <div class="layui-input-inline">
                                <input class="layui-input" id="end_time" name="end_time" placeholder="{{ Lang.form_placeholder_end_time || "创建时间" }}" type="text" value="">
                            </div>

                            <div class="layui-inline">
                                <button class="layui-btn" lay-submit lay-filter="search_btn" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                <button type="reset" class="layui-btn layui-btn-primary" onclick="reload()">{{ Lang.btn_reset || "清空" }}</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="main_page_Info">
                    <table class="layui-hide" id="tra" lay-filter="dataTable"></table>
                    <div class="page"></div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}

{% block js_assets %}
    <script>
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
                elem: '#tra'
                , url: '/member/client/list_datas'
                , method: 'post'
                , cellMinWidth: 80
                , page: true
                , cols: [[
                   /* {field: 'account_no', title: '{{ Lang.table_source_account_no || "账号" }}', align: 'center', fixed: 'left', templet: function (d) {
                            return d.account_no;
                        }
                    }
                    ,*/
                    {field: 'full_name', title: '{{ Lang.table_customer_name || "姓名" }}', align: 'center', fixed: 'left', templet: function (d) {
                            return d.full_name;
                        }
                    }
                    , {field: 'email', title: '{{ Lang.table_email || "邮箱" }}', align: 'center'}
                    , {field: 'gmt_create', title: '{{ Lang.table_gmt_create || "注册时间" }}', sort: true, align: 'center'}
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
                        full_name: $('input[name="full_name"]').val(),
                        email: $('input[name="email"]').val(),
                        start_time : $('input[name="start_time"]').val(),
                        end_time : $('input[name="end_time"]').val()
                    }
                });
            });

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
                        full_name:search_form_data.full_name,
                        email:search_form_data.email,
                        start_time :search_form_data.start_time,
                        end_time :search_form_data.end_time
                    },
                    page:{
                        curr:1
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