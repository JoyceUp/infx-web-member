{% extends './layout.tpl' %}

{% block title %}404{%endblock%}

{% block head %}
    {{title}}
{% endblock %}

{% block content %}
    <div style="height:300px">

        <div style="text-align: center;margin-top:10%">
            <h1 style="font-size:100px;color:#999">404</h1>
            <p>{{ page_404 }}</p>
        </div>

    </div>


{% endblock %}