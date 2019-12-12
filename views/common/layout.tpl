<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>{% block title %} {{ Lang.page_title }} {% endblock %}</title>

  {% block head %}
  {% endblock %}
    {#{% include "./common/lang.tpl" %}#}
</head>
<body>
  {% block content %}{% endblock %}
</body>

</html>