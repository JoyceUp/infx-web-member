<div id="sidebar">
    <ul class="side_nav">

        <li class="side_nav_itmes {% if active == 'account_list' || active == 'account_append' || active == 'account_info' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
                <a class="n1" href="/ib/account/mt"><i class="left_nav_icon iconfont icon-acc"></i>{{ Lang.menu_ib_account || "我的账户" }}</a>
            <ul>
                <li  {% if active == "account_list" %} class="active" {% endif %}>
                    <a href="/ib/account/mt">{{ Lang.menu_ib_account_list || "账户列表" }}</a>
                </li>
                <li {% if active == "account_append" %} class="active" {% endif %}>
                    <a href="/ib/account/append">{{ Lang.menu_ib_account_append || "创建新账户" }}</a>
                </li>
                <li {% if active == "account_info" %} class="active" {% endif %}>
                    <a href="/ib/account/info">{{ Lang.menu_ib_account_info || "个人资料" }}</a>
                </li>
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'withdraw' || active == 'transfer' || active == 'return_to_balance' || active == 'funds_record' || active == 'withdraw_record' || active == 'transfer_record' || active == 'return_to_balance_record'  %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n2" href="/ib/funds/withdraw"><i class="left_nav_icon iconfont icon-trading"></i>{{ Lang.menu_ib_funds || "我的资金" }}</a>
            <ul>
                <li {% if active == "withdraw" %} class="active" {% endif %}>
                    <a href="/ib/funds/withdraw">{{ Lang.menu_ib_funds_withdraw || "出金" }}</a>
                </li>
                <li {% if active == "transfer" %} class="active" {% endif %}>
                    <a href="/ib/funds/transfer">{{ Lang.menu_ib_funds_transfer || "账户转账" }}</a>
                </li>
                <li {% if active == "return_to_balance" %} class="active" {% endif %}>
                    <a href="/ib/funds/return_to_balance">{{ Lang.menu_ib_funds_balance || "返利转余额" }}</a>
                </li>
                <li {% if active == "funds_record" %} class="active" {% endif %}>
                    <a href="/ib/funds/fundsrecord">{{ Lang.menu_ib_funds_fundsrecord || "资金记录" }}</a>
                </li>
                <li {% if active == "withdraw_record" %} class="active" {% endif %}>
                    <a href="/ib/funds/withdraw_record">{{ Lang.menu_ib_funds_withdraw_record || "出金记录" }}</a>
                </li>
                <li {% if active == "transfer_record" %} class="active" {% endif %}>
                    <a href="/ib/funds/transfer_record">{{ Lang.menu_ib_funds_transfer_record || "转账记录" }}</a>
                </li>
                <li {% if active == "return_to_balance_record" %} class="active" {% endif %}>
                    <a href="/ib/funds/return_to_balance_record">{{ Lang.menu_ib_funds_balance_record || "返利转余额记录" }}</a>
                </li>
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'client_list' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n3" href="/ib/client/list"><i class="left_nav_icon iconfont icon-profile"></i>{{ Lang.menu_ib_client || "我的客户" }}</a>
            <ul>
                <li {% if active == "client_list" %} class="active" {% endif %}>
                    <a href="/ib/client/list">{{ Lang.menu_ib_client_list || "客户信息"}}</a>
                </li>
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'trade' || active == 'rebate' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n4" href="/ib/rebates/trade"><i class="left_nav_icon iconfont icon-deposit"></i>{{ Lang.menu_ib_rebates || "我的佣金" }}</a>
            <ul>
                <li {% if active == "trade" %} class="active" {% endif %}>
                    <a href="/ib/rebates/trade">{{ Lang.menu_ib_rebates_trade || "交易返佣记录" }}</a>
                </li>
                <li {% if active == "rebate" %} class="active" {% endif %}>
                    <a href="/ib/rebates/balance">{{ Lang.menu_ib_rebates_balance || "余额返利记录" }}</a>
                </li>
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'createInviteUrl' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <a class="n4" href="/ib/invite/page"><i class="left_nav_icon iconfont icon-lianjie"></i>{{ Lang.menu_ib_invite || "开户链接" }}</a>
        </li>

    </ul>
</div>

<script>

    $(function () {

        $(".active a").click(function () {
            $(this).next("ul").slideToggle();
            $(this).parent().toggleClass("on");
        });


    });


</script>