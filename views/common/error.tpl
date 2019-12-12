{% extends 'layout.tpl' %}

{% block title %}index {{title}} {%endblock%}

{% block head %}
{{title}}
{% endblock %}

{% block content %}
<h1>{{error.status}}</h1>
<p>{{message}}</p>
{% endblock %}