<script type="text/javascript" src="/assets/vendors/jquery-ui/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/assets/vendors/layui/layui.js"></script>
<script type="text/javascript" src="/assets/member/scripts/utils/validate.js"></script>
<script type="text/javascript" src="/assets/vendors/resizeImage/lrz.bundle.js" ></script>
<script type="text/javascript" src="/assets/member/scripts/utils/utils.js" ></script>
<script type="text/javascript" src="/assets/member/scripts/utils/commonUtils.js" ></script>
<script type="text/javascript" src="/assets/member/scripts/utils/cookieUtils.js"></script>
<link rel="stylesheet" href="/assets/vendors/layui/css/layui.css" >
<!--[i18n]>
<script type="text/javascript" src="/i18n/zh.json"></script>

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