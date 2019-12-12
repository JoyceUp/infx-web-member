<meta name="renderer" content="webkit|ie-comp|ie-stand">
<script type="text/javascript" src="/assets/vendors/jquery-ui/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/assets/vendors/layui/layui.js"></script>

<link rel="stylesheet" href="/assets/member/styles/personal.css?v=1" >
<link rel="stylesheet" href="/assets/vendors/layui/css/layui.css" >

<link rel="stylesheet" href="/assets/member/styles/zh/css/index.css" >
<link rel="stylesheet" href="/assets/member/styles/rewrite.css" >

<script type="text/javascript" src="/assets/member/scripts/utils/cookieUtils.js"></script>

<link href="http://at.alicdn.com/t/font_540585_82m8sv0e1uxtuik9.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/assets/member/scripts/utils/validate.js"></script>
<script type="text/javascript" src="/assets/member/scripts/utils/utils.js"></script>
<script type="text/javascript" src="/assets/member/scripts/utils/commonUtils.js"></script>

<script type="text/javascript" src="/assets/member/scripts/plugins/jquery.step.min.js"></script>
<script type="text/javascript" src="/assets/vendors/layui/country_code.js"></script>

<!--[if (gte IE 8)&(lte IE 9)]>
<link href="/assets/member/styles/ie/personal_ie9.css" rel="stylesheet">
<link href="/assets/member/styles/ie/modifyPwd_ie9.css" rel="stylesheet">
<![endif]-->
<!--[if IE 9]>
<script type="text/javascript" src="/assets/member/scripts/ie/jqplaceHolder.js"></script>
<![endif]-->
<!--[if IE 8]>
<script type="text/javascript" src="/assets/member/scripts/ie/nwmatcher.js"></script>
<script type="text/javascript" src="/assets/member/scripts/ie/selectivizr-min.js"></script>
<script type="text/javascript" src="/assets/member/scripts/ie/jqplaceHolder.js"></script>
<![endif]-->

<!--[if lt IE 9]>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<script>
    var ua = navigator.userAgent.toLowerCase();
    if (ua.match(/msie/) != null || ua.match(/trident/) != null) {
        var browserVersion = ua.match(/msie ([\d.]+)/) != null ? ua.match(/msie ([\d.]+)/)[1] : ua.match(/rv:([\d.]+)/)[1];
        if (browserVersion < 9 ) {
            location.href = "/browser/update"
        }
    }



</script>

{#<script type="text/javascript" src="/assets/vendors/jquery-ui-1.9.2/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="/assets/vendors/jquery-ui-1.9.2/ui/jquery.ui.dialog.js"></script>#}
{#<link rel="stylesheet" href="/assets/vendors/jquery-ui-1.9.2/themes/base/jquery.ui.all.css">#}
    {% include "./lang.tpl" %}
{%  set version = "v0.5.3" %}