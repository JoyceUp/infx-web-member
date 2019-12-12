{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
{% endblock %}

{% block js_assets %}
    <script>

        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.ib.register.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //状态 id-value
        var stateMap = new Object();
        {% for st in Lang.select.ib.register.state %}
        stateMap[{{ st.value }}] = "{{ st.label }}";
        {% endfor %}

        //查看详情
        function showDetail(id) {
            $.ajax({
                url: "/ib/account/mt/info",
                async: true,
                data: {"id": id},
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (data) {
                    if (data.status == 200) {
                        var account = JSON.parse(data.datas);
                        if(account){
                            $("#account_no").html(account.account_no);
                            $("#account_type").html(accountTypeMap[account.account_type]);
                            $("#balance").html(account.balance / 100);
                            $("#sales_no").html(account.sales_no);
                            $("#sales_name").html(account.sales_name);
                            $("#state").html(stateMap[account.state]);
                            $("#gmt_create").html(account.gmt_create);
                            $("#change_time").html(account.change_time);
                            layer.open({
                                type: 1,
                                title: '{{ Lang.dialog_account_details || "账户详情" }}',
                                area: ['400px', '440px'], //宽高
                                content: $("#detail")
                            });
                        }
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        var tableIns;
        layui.use(['form', 'table'], function () {
            //填充表单数据
            var table = layui.table;

            tableIns = table.render({
                elem: '#test'
                , url: '/ib/account/mt/list'
                , method: 'post'
                , cols: [[
                    {
                        field: 'account_no', title: '{{ Lang.table_source_account_no || "账号"}}', align: 'center', templet: function (d) {
                            return '<a onclick="showDetail(\'' + d.id + '\')"  href="javascript:;">' + d.account_no + '</a>'
                        }
                    }
                    , {
                        field: 'account_type', title: '{{ Lang.table_source_account_type || "账户类型"}}', align: 'center', templet: function (d) {
                            return accountTypeMap[d.account_type];
                        }
                    }
                    , {field: 'balance', title: '{{ Lang.form_placeholder_account_balance || "账户余额(USD)"}}', align: 'center', templet: function (d) {
                            return d.balance / 100;
                        }}
                    , {field: 'rebate', title: '{{Lang.table_rebate || "可转返利(USD)" }}', align: 'center', templet: function (d) {
                            return d.rebate / 100;
                        }}
                    , {
                        field: 'state', title: '{{ Lang.table_account_state || "账户状态" }}', align: 'center', templet: function (d) {
                            return stateMap[d.state];
                        }
                    }
                    , {field: 'gmt_create', title: '{{ Lang.table_gmt_create_1 || "创建时间" }}', align: 'center',}
                ]]
                // , page: true
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
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    account_no: search_form_data.account_no
                    , account_type: search_form_data.account_type
                    , state: search_form_data.state
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
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
                        {{ Lang.page_account_list_title || "账户列表" }}
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
        <form class="layui-form show-detail" action="">
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no || "账号" }}：</label>
                <span id="account_no"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_type || "账户类型" }}：</label>
                <span id="account_type"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_balance || "账户余额(USD)" }}：</label>
                <span id="balance"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_state || "账户状态" }}：</label>
                <span id="state"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_sales_account_no || "销售账号" }}：</label>
                <span id="sales_no"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_placeholder_sales_name || "销售姓名" }}：</label>
                <span id="sales_name"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_create || "创建时间" }}：</label>
                <span id="gmt_create"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_gmt_modified || "更新时间" }}：</label>
                <span id="change_time"></span>
            </div>
        </form>
    </div>

{% endblock %}
