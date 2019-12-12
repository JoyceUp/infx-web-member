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
    <title>{{ Lang.page_dl_title || "外汇2.0-代理中心" }}</title>
    <link rel="Bookmark" href="resources/img/1.ico">
    <link rel="shortcut icon" href="resources/img/1.ico">
    {% set lang = "cn" %}
    {% include "./head.tpl" %}

    {% block css_assets %}
    {% endblock %}
</head>
<script type="text/javascript" src="/assets/member/scripts/utils/validate.js"></script>
<script>
    window.token = getCookie("ibtoken")
    login = function(){
        window.location.href = "/ib/login"
    }
    window.login= login

    if(window.token == "" || window.token == null || getCookie("user") == null){
        login()
    }else{
        window.user = JSON.parse(getCookie("user"))
    }

</script>
<body>

<div id="wrapper">

    {% include "../partials/header.tpl" %}

    <div id="main">
        {% include "../partials/left.tpl" %}

        {% block content %}
        {% endblock %}

    </div>
    {% include "../partials/footer.tpl" %}

    {% block js_assets %}

    {% endblock %}

</div>


</body>
</html>


