
<!DOCTYPE html>
<html lang="en">
<head>

    <link rel="Bookmark" href="resources/img/1.ico">
    <link rel="shortcut icon" href="resources/img/1.ico">
    <meta charset="utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>{{ title }}</title>
    <meta name="keywords" content="外汇真实账户开立">
    <meta name="description" content="填写以下内容以便成为一个真实的外汇交易账户。如果您已经拥有一个有效的交易账户，请点击此处登录到账户管理中心。如果您需要开立一个全新的交易账户，请使用账户管理中心中的开立新账户功能，毋须重复注册.">

    <link rel="stylesheet" href="/assets/kh/css/reset.css?v=2" type="text/css" />
    <link rel="stylesheet" href="/assets/kh/css/style.css" type="text/css" />

    <style type="text/css">
        #live2,#live3,#live4 {
            display: none;
        }
    </style>
    <script type="text/javascript">
      /*  var basePath='<%=basePath%>';
        (function(){
            redirect("http://wechat.mdffx.com/auth/register.html");
        })();*/
    </script>
    {% include "./head.tpl" %}
</head>
<body>
{% include "../partials/header.tpl" %}
<div class="header">
    <div class="header-bg"></div>
    <div class="header-menu">
        <h1 id="lg"><a class="jp" href="http://www.rtfgroups.com/">慢点富</a></h1>
        <div class="header-right"></div>
    </div>
    <!-- 二级菜单 -->
    <div id="menu" class="menu-01">
        <div class="menu-con">
            <p><em class="menu-icon-09"></em></p>
        </div>
    </div>
</div>
<!-- 内容部分 -->
<!-- /*第一块内容*/ -->
<div class="warp notice-banner">
    <img src="/assets/kh/images/notice-banner.jpg" alt=""/>
</div>
<!-- /*第二块内容*/ -->
<div class="warp">

    {% block content %}
    {% endblock %}

</div>
<!-- footer -->
{% include "../partials/footer.tpl" %}


{% block js_assets %}
{% endblock %}

{% block css_assets %}

{% endblock %}
</body>
</html>


