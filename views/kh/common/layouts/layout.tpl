<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    {#<%
        String  langstr = TypeUtils.stringVal(request.getAttribute("lang"));
    %>#}
    <title>{{ title }}</title>
    {% include "../../common/layouts/head.tpl" %}
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <link href="/assets/member/styles/auth/login.css?v=4" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="/assets/kh/css/reset.css?v=2" type="text/css" />
    <link rel="stylesheet" href="/assets/kh/css/style.css" type="text/css" />

    {% block css_assets %}

    {% endblock %}
    {% include "../../../common/lang.tpl" %}
    {% include "../../../common/language.tpl" %}
</head>
<body>
<div class="container">

{% include "../partials/header.tpl" %}

{% block content %}
{% endblock %}

{% include "../partials/footer.tpl" %}

{% block js_assets %}
{% endblock %}

</div>
</body>
</html>

