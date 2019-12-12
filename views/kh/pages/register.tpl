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
        {% include "./live/live1.tpl" %}

    </div>
  {#  <div id="live2" class="form2">
        {% include "./live/live2.tpl" %}

    </div>
    <div id="live3" class="form3">
        {% include "./live/live3.tpl" %}

    </div>#}
    <div id="live4" class="form4">
        {% include "./live/live4.tpl" %}

    </div>
</div>

{% endblock %}

{% block js_assets %}
    <script>

        function loading(){
            var loadingIndex = layer.load(2, {
                shade: [0.6,'#fff'] //0.1透明度的白色背景
            });
        }

        function closeLoading(){
            layer.closeAll('loading');
        }


    </script>
{% endblock %}