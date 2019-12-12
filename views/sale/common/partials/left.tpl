<div id="sidebar">
    <ul class="side_nav">

        <li class="side_nav_itmes {% if active == 'customer' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->
            <a class="n1" href="/sale/customer"><i class="left_nav_icon iconfont icon-customer"></i>{{ Lang.menu_sale_customer || "客户信息" }}</a>
            <!--<ul>

                <li {% if active == "customer" %} class="active" {% endif %}>
                    <a href="/sale/customer">{{ Lang.menu_sale_customer_list || "客户列表" }}</a>
                </li>

            </ul>-->

        </li>

        <li class="side_nav_itmes {% if active == 'trade' || active == 'balance' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->

            <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
            <a class="n3" href="/sale/rebate/trade"><i class="left_nav_icon iconfont icon-deposit"></i>{{ Lang.menu_sale_rebate || "返佣返利信息" }}</a>
            <ul>

                <li {% if active == "trade" %} class="active" {% endif %}>
                    <a href="/sale/rebate/trade">{{ Lang.menu_sale_rebate_trade || "交易返佣记录" }}</a>
                </li>

                <li {% if active == "balance" %} class="active" {% endif %}>
                    <a href="/sale/rebate/balance">{{ Lang.menu_sale_rebate_balance || "余额返利记录" }}</a>
                </li>

            </ul>

        </li>

        <li class="side_nav_itmes {% if active == 'bonus' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->

            <a class="n4" href="/sale/bonus"><i class="left_nav_icon iconfont icon-tubiao207"></i>{{ Lang.menu_sale_bonus || "提成信息" }}</a>
          {#  <ul>

                <li {% if active == "bonus" %} class="active" {% endif %} >
                    <a href="/sale/bonus">{{ Lang.menu_sale_bonus_list || "提成列表" }}</a>
                </li>

            </ul>#}

        </li>

        <li class="side_nav_itmes {% if active == 'userinfo' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->

            <a class="n4" href="/sale/userinfo"><i class="left_nav_icon iconfont icon-acc"></i>{{ Lang.menu_sale_userinfo || "用户信息" }}</a>

        </li>

        <li class="side_nav_itmes {% if active == 'benefit' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->

            <a class="n4" href="/sale/benefit"><i class="left_nav_icon iconfont icon-acc"></i>{{ Lang.page_rebate_benefit_title || "津贴管理" }}</a>

        </li>

        <li class="side_nav_itmes {% if active == 'invitation' %}itmes_active{% endif %}"><!--当前子级选中状态class="active"-->

            <a class="n4" href="/sale/invite/page"><i class="left_nav_icon iconfont icon-friendadd"></i>{{ Lang.menu_sale_invitation || "邀请管理" }}</a>

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