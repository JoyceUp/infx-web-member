<!DOCTYPE html>
<html>
<head>

    {#<%
        String  langstr = TypeUtils.stringVal(request.getAttribute("lang"));
    %>#}
    {% include "../../common/layouts/head.tpl" %}
	{% include "../../../common/language.tpl" %}
	<link href="/assets/member/styles/auth/login.css?v=4" rel="stylesheet" type="text/css">
	<link href="//at.alicdn.com/t/font_540585_a26shfobzp9fi529.css" rel="stylesheet" type="text/css">
	<style>

	</style>
</head>
<body>
<div class="container">
<div id="header">
	<div class="header_holder">
        {% if langstr === "cn" || langstr === "" %}
			<a class="logo" href="http://www.rtfgroups.com/"></a>
        {% else %}
			<a class="enlogo" href="http://en.rtfgroups.com/"></a>
        {% endif %}
	</div>
</div>
{

<div class="layadmin-user-login-main">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2>{{ Lang.page_msg_login || "登录" }}<i style="font-style: normal;color:#999;font-size:10px;margin-left: 5px;">{{ version }}</i></h2>
		<p></p>
	</div>
	<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layadmin-user-login-icon iconfont icon-profile" for="user-login-username"></label>
				<input type="text" name="username"  lay-verify="username" placeholder="{{ Lang.form_placeholder_login_email || "邮箱" }}" class="layui-input"/>
			</div>
			<div class="layui-form-item">
				<label class="layadmin-user-login-icon iconfont icon-unlock" for="user-login-password"></label>
				<input type="password" name="password" lay-verify="password" placeholder="{{ Lang.form_placeholder_login_password || "密码" }}" class="layui-input"/>
			</div>
			<div class="layui-form-item" id="captcha-item" style="display: none">
				<input type="text" name="captcha" lay-verify="captcha" placeholder="{{ Lang.btn_login_placeholder_code }}" class="layui-input" >
				<img src="/common/captcha/get" onclick="this.src='/common/captcha/get?r='+Math.random();"/>
			</div>
			<div class="layui-form-item">
				<a href="/ib/password/retrieve">{{ Lang.page_login_backpassword || "忘记密码" }}</a>
			</div>
			<div class="layui-form-item">
				<button class="layui-btn layui-btn-fluid" lay-submit=""  lay-filter="user-login-submit" onclick="return false;">{{ Lang.btn_login || "登 录" }}</button>
			</div>
		</form>
	</div>
</div>

<div class="ui-pd-bottom"></div>
<div id="footer">
	<div class="footer_container">
		<span class="en">Copyright © 2018 Real Time Futures. All rights reserved.</span>
	</div>
</div>

</div>
</body></html>


<script>

    $(function () {
        var isShow = getCookie("captcha_show");
        if (isShow == 1) {
            $("#captcha-item img").click();
            $("#captcha-item").show();
        } else {
            $("#captcha-item").hide();
        }
    });

    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer

        form.verify({
            username: function (value) {
                if (value.length == 0) {
                    return '{{ Lang.validate_login_email_not_null || "请输入登录账号" }}';
                }
                if (!emailReg.test(value) && !mtReg.test(value)) {
                    return '{{ Lang.validate_login_email_format_error || "请输入正确的账号" }}';
                }
            },
            captcha: function (value) {
                if (!$("#captcha-item").is(":hidden")) {
                    if (value.trim().length == 0) {
                        return '{{ Lang.validate_captcha_not_null || "请输入验证码" }}'
                    }
                }
            },
            password: function (value) {
                if (value.length == 0) {
                    return '{{ Lang.validate_password_not_null || "请输入密码" }}';
                }
            }
            /* ,password: [passwordReg, '请输入正确的密码']*/
        });

        //监听提交
        form.on('submit(user-login-submit)', function (data) {
                if (!$("#captcha-item").is(":hidden")) {
                checkCaptcha(data.field)
            } else {
                signup(data.field)
            }
            return false;
        });


    });

    function signup(data) {
        $.post("/ib/signup", data, function (result) {
            var path = "/ib";
            if (result.status != 200) {
                setCaptcha(path)
                layer.msg(result.msg, {icon: 2})
                return false
            }

            var datas = JSON.parse(result.datas)
            var user = {
                role_type: datas.role_type,
                user_id: datas.user_id,
                email: datas.user.email
            }
            addCookie("captcha_show", 0, 0, path);
            addCookie("ibtoken", datas.token, 0, path);
            addCookie("user", JSON.stringify(user), 0, path);
            layer.msg("{{ Lang.msg_login_success || "登录成功" }}", {icon: 1, time: 1000,}, function () {
                window.location.href = "./account/mt"
            }, 100)


        });
    }
</script>