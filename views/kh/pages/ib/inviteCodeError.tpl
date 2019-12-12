{% extends '../../common/layouts/layout.tpl' %}
{% block css_assets %}
    <style>
        .reg-title-2 span {
            font-size: 14px;
            color: #999;
        }
    </style>
{% endblock %}
{% block js_assets %}

{% endblock %}
{% block content %}
    {#完成#}
    <div class="register" id="third">
        <h3 style="color: red;">{{ datas.msg }}</h3>
    </div>
{% endblock %}
