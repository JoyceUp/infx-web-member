{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
{% endblock %}

{% block js_assets %}
    <script>

        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}
        //汇率类型 id-value
        var accountRateTypeMap = new Object();
        {% for at in Lang.select.member.register.open_rate %}
        accountRateTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        // 账户下拉框
        var accountHtml = '<option value="" selected>{{ Lang.form_select_invite_type || "请选择" }}</option>';
        {% for ac in account %}
        accountHtml += '<option value="{{ ac.account_no }}" >{{ ac.account_no }}-'+accountTypeMap[{{ ac.account_type }}]+'</option>';
        {% endfor %}
        $('select[name="account_no"]').html(accountHtml);

        //状态 id-value
        var stateMap = new Object();
        {% for st in Lang.select.member.account.state %}
        stateMap[{{ st.value }}] = "{{ st.label }}";
        {% endfor %}

        //查看详情
        function showDetail(id) {
            $.ajax({
                url: "/member/account/mt/info",
                async: true,
                data: {"id": id},
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success: function (data) {
                    if (data.status == 200) {
                        var account = JSON.parse(data.datas);
                        if(account){
                            $("#account_no").html(account.account_no);
                            $("#account_type").html(accountTypeMap[account.account_type]);
                            $("#balance").html( fmoney(account.balance / 100,2));
                            $("#exchange_rate").html(accountRateTypeMap[account.account_rate_type]);
                            $("#leverage").html("1:" + account.leverage);
                            $("#ib_no").html(account.ib_no);
                            $("#ib_name").html(account.ib_name);
                            $("#sales_no").html(account.sales_no);
                            if(account.sales_no =="60000000"){
                                $("#sales_name").html('{{ Lang.sales_demo||"虚拟销售" }}');
                            }else {
                                $("#sales_name").html(account.sales_name);
                            }
                            $("#state").html(stateMap[account.state]);
                            $("#gmt_create").html(account.gmt_create);
                            $("#change_time").html(account.change_time);
                            layer.open({
                                type: 1,
                                title: "{{ Lang.page_account_list_info_title || "账户详情" }}",
                                area: ['500px', 'auto'], //宽高
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
                , url: '/member/account/mt/list'

                , method: 'post'
                , cols: [[
                    {
                        field: 'account_no', title: '{{ Lang.table_source_account_no || "账号"}}', align: 'center', templet: function (d) {
                            if (d.account_type != 9){
                                return '<a onclick="showDetail(\'' + d.id + '\')"  href="javascript:;">' + d.account_no + '</a>'
                            }else{
                                return d.account_no;
                            }

                        }
                    }
                    , {
                        field: 'account_type', title: '{{ Lang.table_source_account_type || "账户类型"}}', align: 'center', templet: function (d) {
                            return accountTypeMap[d.account_type];
                        }
                    }
                    , {field: 'balance', title: '{{Lang.form_placeholder_account_balance || "账户余额(USD)" }}', align: 'center', templet: function (d) {
                            return  fmoney(d.balance / 100,2);
                        }}
                    , {field: 'leverage', title: '{{ Lang.table_leverage || "杠杆比例" }}', align: 'center', templet: function (d) {
                            if (d.account_type != 9){
                                return "1:" + d.leverage;
                            }else{
                                return "";
                            }
                        }
                    }
                    , {
                        field: 'state', title: '{{ Lang.table_account_state || "账户状态" }}', align: 'center', templet: function (d) {
                            return stateMap[d.state];
                        }
                    }
                    , {field: 'gmt_create', title: '{{ Lang.table_gmt_create_1 || "创建时间" }}', align: 'center',}
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
                        {{ Lang.page_account_list_title || "账户列表" }}
                    </div>
                    <div id="search_box">

                        <form class="layui-form" action="">

                            {#<label class="input-title">{{ Lang.form_placeholder_account_no || "账号" }}：</label>#}
                            <div class="layui-input-inline">
                                <select name="account_no" class="layui-input">
                                </select>
                            </div>

                            {#<label class="input-title">{{ Lang.form_placeholder_account_state || "账户状态" }}：</label>#}
                            <div class="layui-input-inline">
                                <select name="state" lay-filter="status">
                                    <option value="">{{ Lang.form_placeholder_account_state || "账户状态" }}</option>
                                    {% for st in Lang.select.member.account.state %}
                                        <option value="{{ st.value }}">{{ st.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>

                            <div class="layui-input-inline">
                                <button class="layui-btn" lay-submit="" lay-filter="search_btn" onclick="javascript:return false;">{{ Lang.btn_search || "查询" }}</button>
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
                <label>{{ Lang.form_label_rate || "汇率" }}：</label>
                <span id="exchange_rate"></span>
            </div>

            <div class="d-item">
                <label>{{ Lang.table_leverage || "杠杆比例" }}：</label>
                <span id="leverage"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_state || "账户状态" }}：</label>
                <span id="state"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_superior_account || "上级账号" }}：</label>
                <span id="ib_no"></span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_superior_name || "上级姓名" }}：</label>
                <span id="ib_name"></span>
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
