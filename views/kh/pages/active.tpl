{% extends '../common/layouts/layout.tpl' %}
{% set title= Lang.page_open_an_account || "开立账户"  %}
{% block css_assets %}
    <style type="text/css">
        #live2,#live3,#live4 {
            display: none;
        }
    </style>
{% endblock %}

{% block content %}

<div id="theRealAccForm">
    <div id="live1" class="form1">

        <div class="register" {% if res.status != 200 %} style="display:none" {% endif %}>
            <div class="succ succ_page">
                <div class="succ-icon">
                    <img src="/assets/kh/images/succ-icon.png">
                </div>
                <h4>   {#这里的文字要改#}
                    <span>{{ Lang.page_register_active_succ_msg || "恭喜！账户激活成功,请登录账户" }}</span><br/>
                </h4>
                <p><em id="jumpToA"></em>{{Lang.page_register_active_succ_goto ||  "秒后跳转登录" }}</p>
                <p></p>
            </div>

        </div>

        <div class="register" {% if res.status == 200 %} style="display:none" {% endif %}>
            <div class="succ succ_page">
                <div class="succ-icon">
                    <img src="/assets/kh/images/err-icon.png">
                </div>
                <h4>   {#这里的文字要改#}
                    <span>{{ Lang.page_register_active_err_msg || "出错了，激活失败" }}</span><br/>
                </h4>
                <p><em id="jumpToB"></em>{{Lang.page_register_active_succ_goto ||  "秒后跳转登录" }}</p>
                <p></p>
            </div>

        </div>

    </div>

</div>

{% endblock %}

{% block js_assets %}
    <script>
        $(function () {
            countDown(5,"/member")
        })
        function countDown(secs, surl) {
            var jumpToA = document.getElementById('jumpToA');
            var jumpToB = document.getElementById('jumpToB');
            jumpToA.innerHTML = secs;
            jumpToB.innerHTML = secs;
            if (--secs > 0) {
                setTimeout("countDown(" + secs + ",'" + surl + "')", 1000);
            } else {
             location.href = surl;
            }
        }

    </script>
{% endblock %}