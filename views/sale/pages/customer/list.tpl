{% extends '../../common/layouts/layout.tpl' %}
{% block content %}
     <div class="main_content">
        <div class="main_content_holder">
            <div class="layui-tab layui-tab-card">
                <ul class="layui-tab-title">
                    <li class="layui-this">{{ Lang.form_text_cutomer_type || "直客" }}</li>
                    <li>{{ Lang.form_text_cutomer_type_no || "非直客" }}</li>

                </ul>
                <div class="layui-tab-content" >
                    <div class="layui-tab-item layui-show">
                        <div id="fund">
                            <div class="main_head">
                                <div class="main_head_unit">
                                    {{ Lang.page_customer_title || "客户列表" }}
                                </div>
                                <div id="search_box">
                                    <form class="layui-form" action="">
                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <input type="text" name="full_name"  placeholder="{{ Lang.form_placeholder_name || "姓名" }}" autocomplete="off" class="layui-input">
                                            </div>

                                            <div class="layui-inline">
                                                <input type="text" name="email" placeholder="{{ Lang.form_placeholder_login_email || "邮箱" }}" autocomplete="off" class="layui-input">
                                            </div>

                                            <div class="layui-inline">
                                                <input type="text" name="account_no"  placeholder="{{ Lang.form_placeholder_account_no || "账号" }}" autocomplete="off" class="layui-input">
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
                                <table id="customer_list" class="layui-hide" lay-filter="dataTable"></table>
                                <div class="page">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-tab-item ">
                        <div id="fund">
                            <div class="main_head">
                                <div class="main_head_unit">
                                    {{ Lang.page_customer_title || "客户列表" }}
                                </div>
                                <div id="search_box">
                                    <form class="layui-form" action="">
                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <input type="text" name="full_name"  placeholder="{{ Lang.form_placeholder_name || '姓名' }}" autocomplete="off" class="layui-input">
                                            </div>

                                            <div class="layui-inline">
                                                <input type="text" name="email" placeholder="{{ Lang.form_placeholder_login_email || '邮箱' }}" autocomplete="off" class="layui-input">
                                            </div>

                                            <div class="layui-inline">
                                                <input type="text" name="account_no"  placeholder="{{ Lang.form_placeholder_account_no || '账号' }}" autocomplete="off" class="layui-input">
                                            </div>
                                            <div class="layui-inline">
                                                <input type="text" name="parent_full_name"  placeholder="{{ Lang.form_referral || '推荐人姓名' }}" autocomplete="off" class="layui-input">
                                            </div>
                                            <div class="layui-inline">
                                                <button class="layui-btn" lay-submit lay-filter="search_btn_2" onclick="return false;">{{ Lang.btn_search || "查询" }}</button>
                                                <button type="reset" class="layui-btn layui-btn-primary" onclick="reload2()">{{ Lang.btn_reset || "清空" }}</button>
                                            </div>

                                        </div>
                                    </form>

                                </div>
                            </div>
                            <div class="main_page_Info">
                                <table id="customer_list_2" class="layui-hide" lay-filter="dataTable2"></table>
                                <div class="page">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </div>
    </div>
{% endblock %}
{% block js_assets %}
        <script>

            //详情
            function showDetail(customer_id) {
                // 页面跳转到页面传参方式
                //在服务端 通过req.query.cid 获取
                window.location.href ="/sale/customer/info/?cid="+ customer_id;
            }

            //列表展示
            var tableIns;//直客
            var tableIns_2;//非直客
            layui.use(['laydate','table','element'], function(){
                var $ = layui.jquery
                    ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

                var laydate = layui.laydate;
             laydate.render({
                elem: '#start_time',
                 lang:laylang //指定元素
            });
             laydate.render({
                elem: '#end_time' ,
                 lang:laylang//指定元素
            });

             var table = layui.table;
                tableIns= table.render({
                elem: '#customer_list'
                ,url: '/sale/customer/list' //数据接口
                ,where:{direct:1}
                ,page: true //开启分页
                ,method: 'post'
                ,cols: [[ //表头
                   {field: 'gmt_create', title: '{{ Lang.table_gmt_create || "注册时间"}}', align:'center',templet:function(d){
                           if(d.gmt_create){
                               return d.gmt_create.substr(0,10);
                           }else{
                               return "";
                           }
                       }},
                    {field: 'customer_name', title: '{{ Lang.table_customer_name || "姓名" }}', align:'center',templet:function (row) {
                        return '<a onclick="showDetail(\''+row.id+'\')"  href="javascript:;">' + row.customer_name + '</a>'
//                        return row.customer_name
                    } }
                  ,{field: 'mobile', title: '{{ Lang.table_mobile || "手机号码" }}', align:'center'}
                  ,{field: 'email', title: '{{ Lang.table_email || "电子邮箱" }}',width:140,align:'center'}
                  ,{field: 'total_balance', title: '{{ Lang.table_total_balance || "账户总余额"}}',align:'center', templet: function (d) {
                      if(d.total_balance) {
                          return  fmoney(d.total_balance / 100,2);
                      }else{
                          return 0;
                      }
                            }}
                  ,{field: 'sum_deposit', title: '{{ Lang.table_sum_deposit || "总入金"}}', align:'center',templet: function (d) {
                                if(d.sum_deposit) {
                                    return  fmoney(d.sum_deposit / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                  ,{field: 'sum_withdraw', title: '{{Lang.table_sum_withdraw || "总出金" }}',align:'center',templet: function (d) {
                                if(d.sum_withdraw) {
                                    return fmoney(d.sum_withdraw / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                  ,{field: 'net_deposit', title: '{{ Lang.table_net_deposit || "总净入金"}}', align:'center',templet: function (d) {
                                if(d.net_deposit) {
                                    return fmoney(d.net_deposit / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                  ,{field: 'sum_hold_volume', title: '{{ Lang.table_buy_amount || "总持仓总数"}}', align:'center',templet:function(d){
                      if(d.sum_hold_volume){
                          return fmoney(d.sum_hold_volume / 100,2);
                      }else{
                          return 0;
                      }
                            }}
                  ,{field: 'sum_close_volume', title: '{{ Lang.table_sell_amount || "总平仓总数"}}', align:'center',templet:function(d){
                      if(d.sum_close_volume){
                          return fmoney(d.sum_close_volume / 100,2);
                      }else{
                          return 0;
                      }
                            }}
                ]],
                  response: {
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

                form.on('submit(search_btn_2)', function (data) {
                    search2(data.field);
                    return false;
                });

                table.on('sort(dataTable)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                    //尽管我们的 table 自带排序功能，但并没有请求服务端。
                    //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
                    table.reload('customer_list', {
                        initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                        ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                            field: obj.field    //当前排序的字段名
                            ,order: obj.type,    //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
                            full_name:  $('input[name="full_name"]').val(),
                            email:  $('input[name="email"]').val(),
                            account_no:  $('input[name="account_no"]').val()
                        }
                    });
                });

                table.on('sort(dataTable2)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                    //尽管我们的 table 自带排序功能，但并没有请求服务端。
                    //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
                    table.reload('customer_list_2', {
                        initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                        ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                            field: obj.field    //当前排序的字段名
                            ,order: obj.type,    //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
                            full_name:  $('input[name="full_name"]').val(),
                            email:  $('input[name="email"]').val(),
                            account_no:  $('input[name="account_no"]').val(),

                        }
                    });
                });

            function search(search_form_data) {
                tableIns.reload({
                    where: { //设定异步数据接口的额外参数，任意设
                        full_name: search_form_data.full_name,
                        email: search_form_data.email,
                        account_no: search_form_data.account_no,
                        direct:1
                    }
                    , page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            }


               //非直客列表
                tableIns_2= table.render({
                    elem: '#customer_list_2'
                    ,url: '/sale/customer/list' //数据接口
                    ,page: true //开启分页
                    ,where:{direct:0}
                    ,method: 'post'
                    ,cols: [[ //表头
                        {field: 'gmt_create', title: '{{ Lang.table_gmt_create || "注册时间"}}',align:'center',width:90,templet:function(d){
                            if(d.gmt_create){
                                return d.gmt_create.substr(0,10);
                            }else{
                                return "";
                            }
                            }}
                        ,{field: 'customer_name', title: '{{ Lang.table_customer_name || "姓名" }}', align:'center',width:100}
                        ,{field: 'mobile', title: '{{ Lang.table_mobile || "手机号码" }}', align:'center',width:120}
                        ,{field: 'email', title: '{{ Lang.table_email || "电子邮箱" }}',align:'center',width:140}
                        ,{field: 'total_balance', title: '{{ Lang.table_total_balance || "账户总余额"}}',align:'center', templet: function (d) {
                                if(d.total_balance) {
                                    return  fmoney( d.total_balance / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                        ,{field: 'sum_deposit', title: '{{ Lang.table_sum_deposit || "总入金"}}', width:80, align:'center',templet: function (d) {
                                if(d.sum_deposit) {
                                    return  fmoney(d.sum_deposit / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                        ,{field: 'sum_withdraw', title: '{{Lang.table_sum_withdraw || "总出金" }}',width:100,align:'center',templet: function (d) {
                                if(d.sum_withdraw) {
                                    return    fmoney(d.sum_withdraw / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                        ,{field: 'net_deposit', title: '{{ Lang.table_net_deposit || "总净入金"}}', align:'center',width:120,templet: function (d) {
                                if(d.net_deposit) {
                                    return  fmoney(d.net_deposit / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                        ,{field: 'sum_hold_volume', title: '{{ Lang.table_buy_amount || "总持仓总数"}}', align:'center', width:120,templet:function(d){
                                if(d.sum_hold_volume){
                                    return fmoney(d.sum_hold_volume / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                        ,{field: 'sum_close_volume', title: '{{ Lang.table_sell_amount || "总平仓总数"}}', width:120, align:'center',templet:function(d){
                                if(d.sum_close_volume){
                                    return  fmoney(d.sum_close_volume / 100,2);
                                }else{
                                    return 0;
                                }
                            }}
                        ,{field: 'parent_full_name', title: '{{ Lang.table_referral || "推荐人姓名" }}', align:'center',width:100}
                    ]],
                    response: {
                        statusName: 'status' //数据状态的字段名称，默认：code
                        , statusCode: 200 //成功的状态码，默认：0
                        , msgName: 'msg' //状态信息的字段名称，默认：msg
                        , countName: 'count' //数据总数的字段名称，默认：count
                        , dataName: 'datas' //数据列表的字段名称，默认：data
                    }
                });

                function search2(search_form_data) {
                    tableIns_2.reload({
                        where: { //设定异步数据接口的额外参数，任意设
                            full_name: search_form_data.full_name,
                            email: search_form_data.email,
                            account_no: search_form_data.account_no,
                            parent_full_name:$('input[name="parent_full_name"]').val(),
                            direct:0
                        }
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    });
                }
            });

            function reload(){
                tableIns.reload({
                    where:{
                        full_name: "",
                        email:"",
                        account_no:"",
                        direct:1
                    },
                    page:{
                        curr:1
                    }
                });
            }
            function reload2(){
                tableIns_2.reload({
                    where:{
                        full_name:"",
                        email: "",
                        account_no: "",
                        parent_full_name:"",
                        direct:0
                    },
                    page:{
                        curr:1
                    }
                });
            }
</script>
{% endblock %}