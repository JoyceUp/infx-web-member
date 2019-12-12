<div id="sidebar">
    <ul class="side_nav">

        <li class="side_nav_itmes {% if active == 'realAccounts' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <a class="n4" href="/member/real_accounts/list"><i class="left_nav_icon iconfont icon-acc"></i>{{ Lang.menu_real_accounts || "开设账户" }}</a>
        </li>

        <li class="side_nav_itmes {% if active == 'mtlst' || active == 'append' || active == 'modify_lev' || active == 'balance_flush' %}itmes_active on{% endif %}"><!--当前子级选中状态class="active"-->

            <a class="n1" href="/member/account/mt"><i class="left_nav_icon iconfont icon-acc"></i>{{ Lang.menu_member_account || "我的账户" }}</a>
            {# <ul>
                <li  {% if active == "mtlst" %} class="active" {% endif %}>
                    <a href="/member/account/mt">{{ Lang.menu_member_account_list || "账户列表" }}</a>
                </li>
                 <li  {% if active == "modify_lev" %} class="active" {% endif %}>
                    <a href="/member/account/modify_lev">{{ Lang.menu_member_account_modify_lev || "修改杠杆" }}</a>
                </li>
                <li {% if active == "balance_flush" %} class="active" {% endif %}>
                    <a href="/member/account/balance_flush">{{ Lang.menu_member_account_balance_flush || "余额清零" }}</a>
                </li>
            </ul>#}
        </li>

        <li class="side_nav_itmes {% if active == 'deposit' || active == 'withdraw' || active == 'return_to_balance' %}itmes_active on{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n2" href="javascript:;"><i class="left_nav_icon iconfont icon-trading"></i>{{ Lang.menu_member_transaction || "资金交易" }}</a>
            <ul>
                <li  {% if active == "deposit" %} class="active" {% endif %}>
                    <a href="/member/transaction/deposit">{{ Lang.menu_member_transaction_deposit || "账户入金" }}</a>
                </li>
                <li  {% if active == "withdraw" %} class="active" {% endif %}>
                    <a href="/member/transaction/withdraw">{{ Lang.menu_member_transaction_withdraw || "账户出金" }}</a>
                </li>
                {#<!-- <li {% if active == "return_to_balance" %} class="active" {% endif %}>
                    <a href="/member/funds/return_to_balance">{{ Lang.menu_ib_funds_balance || "返利转余额" }}</a>
                </li>-->#}
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'funds_record' || active == 'funds_deposit' || active == 'funds_transfer' || active == 'funds_balance_flush' || active=='return_to_balance_record' %}itmes_active on{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n3" href="javascript:;"><i class="left_nav_icon iconfont icon-deposit"></i>{{ Lang.menu_member_funds || "资金信息" }}</a>
            <ul>
                <li  {% if active == "funds_record" %} class="active" {% endif %}>
                    <a href="/member/funds/fundsrecord">{{ Lang.menu_member_funds_fundsrecord || "资金记录" }}</a>
                </li>
                <li  {% if active == "funds_deposit" %} class="active" {% endif %}>
                    <a href="/member/funds/deposit">{{ Lang.menu_member_funds_deposit || "出入金记录" }}</a>
                </li>

                    {#<li {% if active == "return_to_balance_record" %} class="active" {% endif %}>
                        <a href="/member/funds/return_to_balance_record">{{ Lang.menu_ib_funds_balance_record || "返利转余额记录" }}</a>
                    </li>#}

           {#     <li  {% if active == "funds_balance_flush" %} class="active" {% endif %}>
                    <a href="/member/funds/blanceflush">{{ Lang.menu_member_funds_blanceflush || "余额清零记录" }}</a>
                </li>#}
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'userinfo' || active == 'bankinfo' || active == 'telinfo' || active == 'workinfo' %}itmes_active on{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n4" href="javascript:;"><i class="left_nav_icon iconfont icon-customer"></i>{{ Lang.menu_member_user || "客户信息" }}</a>
            <ul>
                <li  {% if active == "userinfo" %} class="active" {% endif %}>
                    <a href="/member/user/info">{{ Lang.menu_member_user_userinfo || "个人信息" }}</a>
                </li>
              {# <!--

                    <li  {% if active == "workinfo" %} class="active" {% endif %}>
                        <a href="/member/user/workinfo">{{ Lang.menu_member_user_workinfo || "投资者信息" }}</a>
                    </li>
                -->#}
            <li  {% if active == "telinfo" %} class="active" {% endif %}>
                    <a href="/member/user/telinfo">{{ Lang.menu_member_user_telinfo || "电汇信息" }}</a>
                </li>
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'client_list' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <a class="n4" href="/member/client/list"><i class="left_nav_icon iconfont icon-lianjie"></i>{{ Lang.menu_member_lower_level_management || "下级管理" }}</a>
        </li>

        <li class="side_nav_itmes {% if active == 'trade' || active == 'rebate' %}itmes_active on{% endif %}"><!--当前子级选中状态class="active"-->
            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n4" href="javascript:;"><i class="left_nav_icon iconfont icon-deposit"></i>{{ Lang.menu_member_rebate || "我的返佣返利" }}</a>
            <ul>
                <li {% if active == "trade" %} class="active" {% endif %}>
                    <a href="/member/rebates/trade">{{ Lang.menu_member_rebate_trade || "返佣记录" }}</a>
                </li>
                <li {% if active == "rebate" %} class="active" {% endif %}>
                    <a href="/member/rebates/balance">{{ Lang.menu_member_rebate_balance || "返利记录" }}</a>
                </li>
            </ul>
        </li>

        <li class="side_nav_itmes {% if active == 'createInviteUrl' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <a class="n4" href="/member/invite/page"><i class="left_nav_icon iconfont icon-lianjie"></i>{{ Lang.menu_ib_invite || "开户链接" }}</a>
        </li>

    </ul>
    <br style="clear:both;" />
</div>

<style>
    .side_nav_itmes ul {display:none}
    .side_nav_itmes.itmes_active ul {display:block}
</style>

<script>

    $(function () {

        $(".side_nav_itmes  a").click(function () {
           // $(this).parent().siblings().find("ul").hide("slow");
            $(this).next("ul").slideToggle();

          //  $(this).parent().toggleClass("itmes_active");
            $(this).parent().toggleClass("on");
        });

     /*   $(".side_nav_itmes a").next("ul").slideToggle();
        $(".side_nav_itmes a").parent().toggleClass("on");*/
    });


</script>