<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {% block meta_data %}
    {% endblock %}

    {% set role = "member" %}

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=11;IE=10;IE=9; IE=8;">
    <meta charset="utf-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
    <meta http-equiv="expires" content="0">
    <title>{{ Lang.page_member_title || "外汇2.0-客户中心" }}</title>
    <link rel="Bookmark" href="resources/img/1.ico">
    <link rel="shortcut icon" href="resources/img/1.ico">
    {% set lang = "cn" %}
    {% include "./head.tpl" %}

    {% block css_assets %}
    {% endblock %}
</head>

<script>

    window.token = getCookie("token")
    login = function(){
        window.location.href = "/member/login"
    }
    window.login= login

    if(window.token == "" || window.token == null || getCookie("user") == null || !getCookie("user")){
        login()
    }else{
        if(getCookie("user")){
            window.user = JSON.parse(getCookie("user"))

        }
    }
    //ajax返回结果拦截器
    $.ajaxSetup({
        dataFilter: function () {
            if(arguments[0].indexOf("status")>-1){
                var result = JSON.parse(arguments[0]);
                if (result.status && result.status == 401) {
                    window.location.href = "/member/login";
                }
            }
            return arguments[0];
        }
    });

</script>
<body>

<div id="wrapper">

    {% include "../partials/header.tpl" %}

    <div id="main">

    {#    {% if accounts_status != -1 %}
        {% include "../partials/left.tpl" %}
        {% endif %}#}

        {% include "../partials/left.tpl" %}

        {% block content %}{% endblock %}
        <br style="clear:both;" />
    </div>

    {% include "../partials/footer.tpl" %}

    {% block js_assets %}

    {% endblock %}

</div>

<div id="errDiv" style="display: none;z-index: 3">
    <div style="padding:60px 0 60px 0;">
        <span class="required">{{ common.no_mt }}</span>
    </div>
</div>
</body>
</html>


