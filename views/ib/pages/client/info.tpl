{% extends '../../common/layouts/layout.tpl' %}
{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">{{ Lang.page_customer_info_title || "客户详情" }}<button class="layui-btn" lay-submit onclick="window.history.go(-1)">{{ Lang.btn_back || "返回" }}</button></div>
                    <div id="search_box">
                        <span>{{ Lang.form_text_personal_info || "个人信息" }}</span>
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-md-offset2" style="line-height: 25px">
                                <input type="hidden" id="user_id" value="{{ datas.id }}"/>
                                <div class="layui-word-aux">{{ Lang.form_placeholder_name || "姓名" }}：{{ datas.full_name }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_email || "电子邮箱" }}： {{ datas.email }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_identity_type || "证件类型" }}：{{ datas.identity_type | identityType }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_country || "国家" }}：{{ datas.country }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_address || "居住地址" }}：{{ datas.address }}</div>
                            </div>
                            <div class="layui-col-md4 layui-col-md-offset1" style="line-height: 25px">
                                <div class="layui-word-aux">{{ Lang.form_text_gender || "称呼" }}：{{ datas.title }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_mobile || "手机号码" }}： {{ datas.mobile }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_identity_no || "证件号码" }}：{{ datas.identity_no | hideIdentityNo }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_city || "城市" }}：{{ datas.city }}</div>
                                <div class="layui-word-aux">{{ Lang.form_text_zip_code || "邮政编码" }}：{{ datas.zipcode }}</div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="main_page_Info">
                    <label for="">{{ Lang.form_text_account_info_other || "其他信息" }}</label>
                    <div class="layui-tab layui-tab-card">
                        <ul class="layui-tab-title">
                            <li class="layui-this">{{ Lang.form_text_account_info_ || "账户信息" }}</li>
                            <li>{{ Lang.form_text_deposit_info || "出入金信息" }}</li>
                            <li>{{ Lang.form_text_transfer_info_two || "转账信息" }}</li>
                            {#<li>{{ Lang.form_text_account_info_trading || "交易信息" }}</li>#}
                        </ul>
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show"><table class="layui-hide" id="account_t" ></table><div class="page"></div></div>
                            <div class="layui-tab-item"><table class="layui-hide" id="dep_draw_t" ></table><div class="page"></div></div>
                            <div class="layui-tab-item"><table class="layui-hide" id="transfer_t" ></table><div class="page"></div></div>


                            <div class="layui-tab-item" id="trade-ata-table-h">
                                <table id="trade_t" class="layui-hide"></table>
                                <div class="page"></div>
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
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        //用户账户状态 id-value
        var accountStateMap = new Object();
        {% for st in Lang.select.member.account.state %}
        accountStateMap[{{ st.value }}] = "{{ st.label }}";
        {% endfor %}

        //出入金渠道类型
        var channelTypeMap = new Object();
        {% for at in Lang.select.member.funds.channel_type %}
        channelTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}

        //交易类型
        var fundTypeMap = new Object();
        {% for at in Lang.select.ib.transaction.type %}
        fundTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}

        //订单状态
        var orderStateMap = new Object();
        {% for at in Lang.select.sale.order_state %}
        orderStateMap[{{ at.value }}] = "{{ at.label }}"
        {% endfor %}

        var fundsOrderStateMap = new Object();
        {% for at in Lang.select.sale.funds_order_status_map %}
        fundsOrderStateMap[{{ at.value }}] = " {{ at.label}}";
        {% endfor %}

        layui.use(['form', 'table', 'element'], function(){
            var form = layui.form;
            var table = layui.table;
            var laydate = layui.laydate;
            var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

            //账号信息
            tableIns_account = table.render({
                elem: '#account_t'
                , url: '/ib/client/account' //数据接口
                , cellMinWidth: 80
                , page: true //开启分页
                , where: {
                    user_id: $("#user_id").val()
                }
                , cols: [[ //表头
                    {field: 'gmt_create', title: '{{ Lang.table_gmt_create_2 || "创建日期" }}', align: 'center', fixed: 'left',},
                    {field: 'account_no', title: '{{ Lang.table_mt4_account || "MT4账号" }}', align: 'center'}
                    , {field: 'account_type', title: '{{ Lang.table_source_account_type || "账户类型" }}', align: 'center', templet: function (d) {
                            return accountTypeMap[d.account_type];
                        }
                    }
                    , {field: 'leverage', title: '{{ Lang.table_leverage_1 || "杠杆" }}', align: 'center', templet: function (d) {
                            return d.leverage ? "1:"+d.leverage : "1:1";
                        }
                    }
                    , {
                        field: 'balance', title: '{{ Lang.table_balance_2 || "余额" }}', align: 'center', templet: function (d) {
                            return d.balance / 100 || 0;
                        }
                    }
                    , {field: 'state', title: '{{ Lang.table_account_state_1 || "状态" }}', align: 'center', templet: function (d) {
                            return accountStateMap[d.state];
                        }
                    }
                    , {field: 'parent_account_no', title: '{{ Lang.table_belong_IB || "所属IB" }}', align: 'center'}
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
            tableIns_dep_draw= table.render({
                elem: '#dep_draw_t'
                ,url: '/ib/client/dep_draw' //数据接口
                ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,page: true //开启分页
                ,where:{
                    user_id: $("#user_id").val()
                }
                ,cols: [[ //表头
                    {field: 'gmt_create', title: '{{ Lang.table_gmt_create_1 || "创建时间" }}', align:'center'}
                    ,{field: 'order_no', title: '{{ Lang.table_order_no || "订单编号" }}', align:'center'}
                    ,{field: 'account_no', title: '{{ Lang.table_mt4_account || "MT4账号" }}', align:'center'}
                    ,{field: 'amount', title: '{{ Lang.table_amount_3 || "申请金额(USD)" }}', align:'center', templet: function (d) {
                            return d.amount / 100 || 0;
                        }
                    }
                    ,{field: 'channel_type', title: '{{ Lang.table_cause || "资金类型" }}', align:'center', templet: function (d) {
                            // return d.cause;
                            return channelTypeMap[d.cause];
                        }
                    }
                    ,{field: 'order_status', title: '{{ Lang.table_state || "订单状态" }}', align:'center', templet: function (d) {
                            // return d.order_status;
                            return orderStateMap[d.order_status];
                        }
                    }
                    ,{field: 'remark', title: '{{ Lang.table_remark || "处理备注" }}', align:'center'}
                ]],
                response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });
            //转账信息
            tableIns_transfer= table.render({
                elem: '#transfer_t'
                ,url: '/ib/client/transfer' //数据接口
                ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,page: true //开启分页
                ,where:{
                    user_id: $("#user_id").val()
                }
                ,cols: [[ //表头
                    {field: 'gmt_create', title: '{{ Lang.table_gmt_create_1 || "创建时间" }}', align:'center'},
                    {field: 'order_no', title: '{{ Lang.table_order_no || "订单编号" }}', align:'center'}
                    ,{field: 'account_no', title: '{{ Lang.table_account_no || "转出账号" }}', align:'center'}
                    ,{field: 'target_account_no', title: '{{ Lang.table_target_account_no || "转入账号" }}',align:'center'}
                    ,{field: 'amount', title: '{{ Lang.table_amount_2 || "转账金额(USD)" }}', align:'center', templet: function (d) {
                            return d.amount / 100 || 0;
                        }
                    }
                    ,{field: 'status', title: '{{ Lang.table_account_state_1 || "状态" }}', align:'center', templet: function (d) {
                            return orderStateMap[d.status];
                        }
                    }
                    ,{field: 'remark', title: '{{ Lang.table_remark || "处理备注" }}', align:'center'}
                ]],
                response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    , statusCode: 200 //成功的状态码，默认：0
                    , msgName: 'msg' //状态信息的字段名称，默认：msg
                    , countName: 'count' //数据总数的字段名称，默认：count
                    , dataName: 'datas' //数据列表的字段名称，默认：data
                }
            });
            //交易信息
            tableIns_trade= table.render({
                elem: '#trade_t'
                ,url: '/ib/client/trade' //数据接口
                ,cellMinWidth: 120 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,page: true //开启分页
                ,where:{
                    user_id: $("#user_id").val()
                }
                ,cols: [[ //表头
                    {field: 'order_no', title: '{{ Lang.table_order_no || "订单编号" }}', align:'center'},
                    {field: 'account_no', title: '{{ Lang.table_mt4_account || "MT4账号" }}', align:'center'}
                    ,{field: 'open_time', title: '{{ Lang.form_label_open_time_gmt || "开仓时间（GMT）" }}', align:'center'}
                    ,{field: 'type', title: '{{ Lang.table_type || "交易类型" }}',align:'center', templet: function (d) {
                            return fundTypeMap[d.type];
                        }
                    }
                    ,{field: 'symbol', title: '{{ Lang.table_trading_symbol || "交易品种" }}', align:'center'}
                    ,{field: 'volume', title: '{{ Lang.table_trading_volume || "交易量" }}', align:'center'}
                    ,{field: 'open_price', title: '{{ Lang.table_open_price || "开仓价格" }}', align:'center'}
                    ,{field: 'close_price', title: '{{ Lang.table_close_price || "平仓价格" }}', align:'center'}
                    ,{field: 'close_time', title: '{{ Lang.table_close_time || "平仓时间" }}', align:'center'}
                    ,{field: 'sl', title: 'S/L', align:'center'}
                    ,{field: 'tp', title: 'T/P', align:'center'}
                    ,{field: 'fee', title: '{{ Lang.table_fee || "手续费(USD)" }}', align:'center', templet: function (d) {
                            return d.fee / 100 || 0;
                        }
                    }
                    ,{field: 'swaps', title: '{{ Lang.table_swaps || "隔夜利息" }}', align:'center'}
                    ,{field: 'profit', title: '{{ Lang.table_profit || "交易盈亏" }}', align:'center'}
                    ,{field: 'order_status', title: '{{ Lang.form_label_state || "状态" }}', align:'center', templet: function (d) {
                            return fundsOrderStateMap[d.order_status];
                        }
                    }
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
    </script>
{% endblock %}