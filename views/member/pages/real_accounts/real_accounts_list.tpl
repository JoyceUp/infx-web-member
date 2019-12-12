{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
{% endblock %}

{% block js_assets %}
    <script>

        //账户状态 id-value
        var accountStateMap = new Object();
        {% for at in Lang.select.member.real_account.state %}
        accountStateMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}
        //账户汇率类型 id-value
        var accountRateTypeMap = new Object();
        {% for at in Lang.select.member.register.open_rate %}
        accountRateTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}
        //账户汇率类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.register.demo_account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //账户类型 id-value
        var accountDemoTypeMap = new Object();
        {% for at in Lang.select.member.register.demo_account_type %}
        accountDemoTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //账户类型 id-value
        var accountDemoStateMap = new Object();
        {% for at in Lang.select.member.register.demo_account_state %}
        accountDemoStateMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}




        var tableIns ,tableDemo;
        layui.use(['form', 'table'], function () {
            //填充表单数据
            var table = layui.table;
            tableIns = table.render({
                elem: '#test'
                , url: '/member/real_accounts/list'
                , method: 'post'
                , cols: [[
                    {field: 'gmt_create', title: '{{ Lang.table_source_real_account_date || "申请时间"}}', align: 'center', templet: function (d) {
                            var dom;
                            if(d.state == 1) {
                                dom = '<a href="/member/real_accounts/profile?id=' + d.id + '">' + d.gmt_create + '</a>'
                            }else {
                                dom = '<a href="/member/real_accounts/step?no=' + d.id + '">' + d.gmt_create + '</a>'
                            }
                            return dom
                        }
                    }
                    ,{field:'order_no',title:'{{ Lang.form_text_order_no||"订单号" }}',align:'center'}
                    ,{field:'account_type',title:'{{ Lang.form_user_bank_account_type||"账户类型" }}',align:'center',templet:function(d){
                        if(d.account_type){
                            return accountTypeMap[d.account_type]
                        }else{
                            return "";
                        }
                        }}
                    ,{field:'account_rate_type',title:'{{ Lang.form_label_rate||"汇率" }}',align:'center',templet:function(d){
                        if(d.account_rate_type) {
                            return accountRateTypeMap[d.account_rate_type];
                        }else{
                            return "";
                        }
                        }}

                    , {
                       /* field: 'state', title: '{{ Lang.table_source_real_account_state || "申请状态"}}', align: 'center', templet: function (d) {
                            console.log(d.attachment_info)
                            var filePath;
                            if(d.state <= 3){
                                $("#openBtn").attr("disabled",true);
                                $("#openBtn").css({"pointer-events":"none","background":"#bbb"});
                            }
                            var id=Math.ceil(Math.random()*1000)
                            if(d.state >= 4 && d.attachment_info != ''){
                                $.post("/common/images/",{id:d.attachment_info[0].file_path},function(result){
                                    if(result){
                                       filePath = result
                                        $("a[data-id=" + id + "]").attr("href",filePath)
                                    }
                                });
                                return accountStateMap[d.state] + "<a data-id=" + id + ">下载</a>"
                            }else {
                                return accountStateMap[d.state]
                            }
                        }*/
                        field: 'state', title: '{{ Lang.table_source_real_account_state || "申请状态"}}', align: 'center', templet: function (d) {

                            if(d.state <= 3){
                                $("#openBtn").attr("disabled",true);
                                $("#openBtn").css({"pointer-events":"none","background":"#bbb"});
                            }
                            if(d.state >= 4 && d.attachment_info != ''){
                                return accountStateMap[d.state] + "<a href=" + d.attachment_info[0].file_path + " target='_new' >下载</a>"
                            }else {
                                return accountStateMap[d.state]
                            }
                        }
                    },{field: 'id', title: '{{ Lang.real_account_info||"Info" }}', toolbar: '#barDemo'}


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
            table.on('tool(test)', function(obj){
                var data = obj.data;
                if(obj.event === 'edit'){
                    showHistory(data.open_state_log)
                }
            });
            tableDemo = table.render({
                elem: '#demo'
                , url: '/member/demo_accounts/list'
                , method: 'post'
                , cols: [[
                    {
                        field: 'accountNo', title: '{{ Lang.form_placeholder_account_no || "账号"}}', align: 'center'
                    }
                    ,{
                        field: 'accountRateType', title: '{{ Lang.form_label_rate || "汇率"}}', align: 'center',templet:function(d){
                            if(d.accountRateType) {
                                return accountRateTypeMap[d.accountRateType];
                            }else{
                                return "";
                            }
                        }}
                    , {
                        field: 'accountState', title: '{{ Lang.form_label_state || "状态"}}', align: 'center', templet: function (d) {
                            return accountDemoStateMap[d.accountState];
                        }},
                    { field: 'accountType', title: '{{ Lang.real_accounts_type || "类型"}}', align: 'center', templet: function (d) {
                            return accountDemoTypeMap[d.accountType];
                        }
                    }
                ]]
                , page: false
                , response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });



            //展示已知数据
          tableHistory =  table.render({
                elem: '#history'
                ,cols: [[ //标题栏
                    {field: 'id', title: 'No', width: 80, templet: function (d) {
                        return d.LAY_INDEX
                    } }
                    ,{field: 'gmt_create', title: 'Date Start',width: 150}
                    ,{field: 'gmt_modified', title: 'Date End',width: 150}
                    ,{field: 'state', title: 'state',width: 150, templet: function (d) {
                      return accountStateMap[d.state];
                  }}
                ]]
                ,data: []
                //,skin: 'line' //表格风格
                ,even: true
                //,page: true //是否显示分页
                //,limits: [5, 7, 10]
                //,limit: 5 //每页默认显示的数量
            });



        });

        var  tableHistory
        function showHistory(data) {

            tableHistory.reload({
                data:data
            })

            layer.open({
                type: 1,
                title: '{{ Lang.dialog_account_history || "账户历史" }}',
                area: ["60%", "auto"], //宽高
                content: $(".accountHistory")
            });
        }



    </script>

    <script type="text/html" id="barDemo">

        <a class="layui-btn layui-btn-xs" lay-event="edit">{{ Lang.dialog_account_history || "账户历史" }}</a>

    </script>
{% endblock %}

{% block content %}

    <div class="accountHistory" style="display: none;width:100%">
        <table  id="history" style="width:100%"></table>
    </div>

    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_real_account_list_title || "账户列表" }}
                    </div>

                </div>
                <div class="main_page_Info" style="margin-top:20px;">


                    <h3 style="font-size:16px;text-align: left">{{  Lang.real_accounts_title|| "真实账户" }}</h3>
                    <table class="layui-hide" id="test"  lay-filter="test"></table>


                    <div class="page">

                    </div>
                </div>
                <div style="margin-top:30px;text-align: center">
                    <a class="layui-btn" href="/member/real_accounts/profile"  id="openBtn">{{ Lang.real_account_apply_btn || "申请开设账户" }}</a>
                </div>


                <br/>           <br/>           <br/>
                <h3 style="font-size:16px;text-align: left">{{  Lang.demo_accounts_title|| "模拟账户" }}</h3>
                <table class="layui-hide" id="demo" lay-filter="demo"></table>
            </div>
        </div>
    </div>





{% endblock %}
