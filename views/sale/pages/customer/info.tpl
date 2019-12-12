{% extends '../../common/layouts/layout.tpl' %}
{% set sale_setting = Lang.select.sale %}
{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_customer_info_title || "客户详情" }}<div style="float:right;margin-bottom:10px"><button class="layui-btn layui-btn-normal" onclick="javascript:history.go(-1)">{{ Lang.btn_back || "返回" }}</button></div>
                    </div>
                    <div id="search_box">
                        <span>{{ Lang.form_text_personal_info || "个人信息" }}</span>
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-md-offset2" style="line-height: 25px">
                                <input type="hidden" id="cid" value="{{ datas.info.id }}"/>
                                <p>{{ Lang.form_placeholder_name || "姓名" }}：{{ datas.info.full_name }}</p>
                                <p>{{ Lang.form_text_email || "电子邮箱" }}：{{ datas.info.email }}</p>
                                <p>{{ Lang.form_text_identity_type || "证件类型" }}：{{ sale_setting.identity_type[datas.identity.identity_type] || "" }}</p>
                                <p>{{ Lang.form_text_country || "国家" }}：{{ datas.address.country }}</p>
                                <p>{{ Lang.form_text_address || "居住地址" }}：{{ datas.address.address }}</p>
                            </div>
                            <div class="layui-col-md4 layui-col-md-offset1" style="line-height: 25px">
                                <p>{{ Lang.form_text_gender || "称呼" }}：{{sale_setting.gender[datas.info.gender] }}</p>
                                <p>{{ Lang.form_text_mobile || "手机号码" }}：+{{ datas.info.country_code || "62" }}-{{ datas.info.mobile }}</p>
                                <p>{{ Lang.form_text_identity_no || "证件号码" }}：{{ datas.identity.identity_no| hideIdentityNo }}</p>
                                <p>{{ Lang.form_text_city || "城市" }}：{{ datas.address.city }}</p>
                                <p>{{ Lang.form_text_zip_code || "邮政编码" }}：{{ datas.address.zip_code }}</p>
                            </div>

                        </div>
                    </div>
                    <div class="layui-tab layui-tab-card">
                        <ul class="layui-tab-title">
                            <li class="layui-this">{{ Lang.form_text_account_info || "账号信息" }}</li>
                            <li>{{ Lang.form_text_deposit_info || "出入金信息" }}</li>
                            <li>{{ Lang.form_text_rebate_info || "返利信息" }}</li>
                           <li>{{ Lang.form_text_commission_info || "返佣信息" }}</li>
                        </ul>
                        <div class="layui-tab-content" >
                            <div class="layui-tab-item layui-show">
                                <table id="account_table" class="layui-hide"></table>
                                <div class="page"></div>
                            </div>
                            <div class="layui-tab-item ">
                                <table id="deposit_table" class="layui-hide"></table>
                                <div class="page"></div>
                            </div>
                            <div class="layui-tab-item">
                                <table id="transfer_table" class="layui-hide"></table>
                                <div class="page"></div>
                            </div>
                            <div class="layui-tab-item">
                                <table id="deal_table" class="layui-hide"></table>
                                <div class="page"></div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div id="detail" style="display:none">
        <div class="main_page_Info">
            <table class="layui-hide" id="detail_table">
            </table>
        </div>
    </div>
{% endblock %}

{% block js_assets %}
    <script>
        var orderStateMap = new Object();
        {% for at in Lang.select.sale.order_state %}
        orderStateMap[{{ at.value }}] = " {{ at.label}}";
        {% endfor %}

        var fundsOrderStateMap = new Object();
        {% for at in Lang.select.sale.funds_order_status_map %}
        fundsOrderStateMap[{{ at.value }}] = " {{ at.label}}";
        {% endfor %}

        var fundsTypeMap = new Object();
        {% for at in Lang.select.sale.funds_type %}
        fundsTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value}}] = "{{at.label }}";
        {% endfor %}

        var accountStateMap = new Object();
        {% for at in Lang.select.sale.account_state %}
        accountStateMap[{{ at.value}}] = "{{at.label }}";
        {% endfor %}

        var transactionTypeMap = new Object();
        {% for at in Lang.select.ib.transaction.type %}
        transactionTypeMap[{{ at.value}}] = "{{at.label }}";
        {% endfor %}

        var tableIns_account;
        var tableIns_Money;
        var tableIns_transform;
        var tableIns_trade;

       var customer_id = $("#cid").val();
        layui.use(['element','table'], function(){
            var $ = layui.jquery
                ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

            var table = layui.table;
            //账号信息
            tableIns_account=table.render({
                elem: '#account_table'
                ,url: '/sale/customer/account/list' //数据接口
                ,page: true //开启分页
                ,where:{
                    cid:customer_id
                }
                ,method:'post'
                ,cols: [[ //表头

                    {field: 'gmt_create', title: '{{ Lang.table_gmt_create_2 || "创建日期"}}', align:'center',templet:function(d){
                        if(d.gmt_create){
                            return d.gmt_create.substr(0,10);
                        }else{
                            return "";
                        }
                    }},
                    {field: 'account_no', title: '{{ Lang.table_source_account_no || "账号"}}', align:'center'}
                    ,{field: 'account_type', title: '{{ Lang.table_source_account_type || "账户类型"}}', align:'center',templet:function(d){
                            return accountTypeMap[d.account_type];
                        }}
                    ,{field: 'leverage', title: '{{ Lang.table_leverage_1 || "杠杆"}}',align:'center',templet:function(d){
                        if(d.leverage){
                            return "1:"+d.leverage;
                        }else{
                            return "";
                        }
                        }}
                    ,{field: 'balance', title: '{{ Lang.table_balance_2 || "余额"}}', align:'center', templet: function (d) {
                        if(d.balance) {
                            return  fmoney(d.balance / 100,2);
                        }else{
                            return 0;
                        }
                        }}
                    ,{field: 'state', title: '{{ Lang.table_account_state_1 || "状态"}}', align:'center',templet:function(d){
                        return accountStateMap[d.state];
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
            //出入金信息
            tableIns_Money= table.render({
                elem: '#deposit_table'
                ,url: '/sale/customer/deposit/list?cid=' + customer_id  //数据接口
                ,page: true //开启分页
                ,where:{
                    cid:customer_id
                }
                ,method:'post'
                ,cols: [[ //表头

                    {field: 'gmt_create', title: '{{ Lang.table_gmt_create_1 || "创建时间"}}', align:'center',templet:function(d){
                            if(d.gmt_create){
                                return d.gmt_create.substr(0,10);
                            }else{
                                return "";
                            }
                        }},
                    {field: 'order_no', title: '{{ Lang.table_order_no || "订单编号"}}', align:'center'}
                    ,{field: 'account_no', title: '{{ Lang.table_source_account_no || "账号"}}', align:'center'}
                    ,{field: 'channel_type', title: '{{ Lang.table_cause || "资金类型"}}',align:'center',templet:function(d){
                        return fundsTypeMap[d.channel_type];
                        }}
                    ,{field: 'amount', title: '{{ Lang.table_amount_3 || "申请金额(USD)"}}', align:'center', templet: function (d) {
                            if(d.amount) {
                                return  fmoney(d.amount / 100,2);
                            }else{
                                return 0;
                            }
                        }}
                    ,{field: 'status', title: '{{ Lang.table_state || "订单状态"}}', align:'center',templet:function(d){
                            return orderStateMap[d.status];
                        }}
                    ,{field: 'remark', title: '{{ Lang.table_remark || "处理备注"}}', align:'center'}
                ]],
                response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });
            //返利信息
            tableIns_transform= table.render({
                elem: '#transfer_table'
                ,url: '/sale/customer/rebate/list'
                ,page: true //开启分页
                ,where:{
                    cid:customer_id
                }
                ,method:'post'
                ,cols: [[ //表头
                    {field: 'gmt_create', title: '{{ Lang.table_rebate_date || "返利日期"}}', align:'center'},
                    {field: 'amount', title: '{{ Lang.table_amount_1 || "返利金额(USD)"}}', align:'center',templet:function(d){

                            if (d.amount) {
                                return '<a onclick="showDetail(\'' + d.gmt_create + '\')"  href="javascript:;">' + fmoney(d.amount / 100,2); + '</a>';
                            } else {
                                return 0;
                            }
                        }}
                ]],
                response: {
                    statusName: 'status'
                    , statusCode: 200
                    , msgName: 'msg'
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });


            //返佣信息
            tableIns_trade= table.render({
                elem: '#deal_table'
                ,url: '/sale/customer/commission/list?cid=' + customer_id //数据接口
                ,page: true //开启分页
                ,where:{
                    cid:customer_id
                }
                ,method:'post'
                ,cols: [[ //表头
                    {field: 'gmt_create', title: '{{ Lang.table_balance_date || "返佣日期" }}', align:'center'},
                    {field: 'account_no', title: '{{ Lang.table_account_no_next || "下级账号" }}', align:'center'}
                    ,{field: 'account_type', title: '{{ Lang.table_source_account_type || "账户类型" }}', align:'center',templet:function(d){
                                if(d.account_type){
                                    return accountTypeMap[d.account_type];
                                }else{
                                    return "";
                                }
                        }}
                    ,{field: 'volume', title: '{{ Lang.table_trade_number || "交易手数" }}',align:'center',templet:function(d){
                        if(d.volume){
                            return d.volume/100 ;
                        }else{
                            return 0;
                        }
                    }}
                    ,{field: 'commission_rate', title: '{{ Lang.table_rate_rebate || "返佣比例" }}', align:'center',templet:function(d){
                        if(d.commission_rate){
                            return d.commission_rate/100;
                        }else{
                            return "";
                        }
                    }}
                    ,{field: 'amount', title: '{{ Lang.table_commission_amount || "返佣金额(USD)" }}', align:'center',templet:function(d){
                        if(d.amount){
                            return  fmoney(d.amount / 100,2);
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
        });
        //返利信息详情
        function showDetail(start_time) {
            //填充表单数据
            var table = layui.table;
            table.render({
                elem: '#detail_table'
                , url: "/sale/customer/rebate/detail"
                , method: 'post'
                , where: {
                    start_time: start_time + " 00:00:00",
                    end_time: start_time + " 23:59:59",
                    cid:customer_id
                }
                , cols: [[
                    {field: 'account_no', title: '{{ Lang.table_lower_level_account || "下级账号" }}',width: 140, align: 'center'}
                    , {field: 'source_account_full_name', title: '{{ Lang.table_lower_level_name || "下级姓名" }}',width: 100, align: 'center'}
                    , {field: 'account_type', title: '{{ Lang.table_source_account_type || "账户类型" }}',width: 120, align: 'center', templet: function (d) {
                            return accountTypeMap[d.account_type] || '';
                        }
                    }
                    , {field: 'balance', title: '{{ Lang.form_placeholder_account_balance || "账户余额(USD)" }}',width: 100, align: 'center', templet: function (d) {
                            return fmoney((d.balance / 100).toFixed(2),2);
                        }
                    }
                    , {field: 'rebate_rate', title: '{{ Lang.table_rate || "年化返利率" }}',width: 180, align: 'center', templet: function (d) {
                            return d.rebate_rate / 10000 + "%";
                        }
                    }
                    , {
                        field: 'amount', title: '{{ Lang.table_amount_1 || "返利金额(USD)" }}',width: 150, align: 'center', templet: function (d) {
                            return fmoney(d.amount / 100,2);
                        }
                    }
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

            layer.open({
                type: 1,
                title: "{{ Lang.dialog_rebate_details || "余额返利明细" }}",
                area: ['85%', '400px'], //宽高
                content: $("#detail")
            });
        }
    </script>

{% endblock %}