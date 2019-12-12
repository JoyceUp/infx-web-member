<!DOCTYPE html>
<html>
<head>

{#<%
	String  langstr = TypeUtils.stringVal(request.getAttribute("lang"));
%>#}
	<title>{{ Lang.page_backpassword_title || "找回密码" }}</title>
	{% include "../../common/layouts/head.tpl" %}
<link href="/assets/member/styles/auth/login.css?v=4" rel="stylesheet" type="text/css">

	<style>

	</style>
<script type="text/javascript">

</script>
</head>
<body>
	<div id="header">
		<div class="header_holder">
			{% if langstr === "cn" || langstr === "" %}
				<a class="logo" href="http://www.rtfgroups.com/"></a>
			{% else %}
				<a class="enlogo" href="http://en.rtfgroups.com/"></a>
			{% endif %}
		{#	<div style="position:absolute;top:5px;right:50px; ">
				<select  id="langSel" class="langCSS" >
				    <option value="cn" >中文</option>
				    <option value="en">English</option>
				    <option value="kor">한글</option>
				</select>
			</div>#}
		</div>
	</div>


	<div class="layadmin-user-login-main">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<h2>
				{{ Lang.page_backpassword_title || "找回密码" }}
			</h2>
			<p></p>
		</div>
		<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
			<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layadmin-user-login-icon iconfont icon-youxiang" for="user-login-username"></label>
				<input type="text" name="email"  lay-verify="email" placeholder="{{ Lang.form_placeholder_login_retrieve_email || "请输入注册的邮箱" }}" class="layui-input">
			</div>

			<div class="layui-form-item mt30">
				<button class="layui-btn layui-btn-fluid" lay-submit="" id="sendEmailBut" lay-filter="user-login-submit" onclick="return false;">{{ Lang.btn_login_send_reset_password || "发送邮件, 重置密码" }}</button>
			</div>
		</form>
		</div>
	</div>

	<div id="footer">
		<div class="footer_container">
			<span class="en">Copyright © 2018 Real Time Futures. All rights reserved.</span>
		</div>
	</div>
<div class="cm-popover" id="cm-popover" style="display: none;">
<div class="cm-popover__arrow">
 <span class="cm-popover__arrow-bg"></span>
 </div>
 <div class="cm-popover__raw-open">null</div>
 </div></body><div></div></html>


<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer;

        form.verify({
            email: function(value){
                if(!emailReg.test(value)){
                    return value.trim().length == 0 ? '{{ Lang.msg_email_not_null || "请输入电子邮箱" }}' : '{{ Lang.alert_email_format_error || "邮箱格式不正确" }}';
                }
            }
        });

        //监听提交
        form.on('submit(user-login-submit)', function(data){
            submit(data.field);
            return false;
        });


    });

    var sending = false;
    function submit(data){
        if(!sending){
            sending = true;
        }else{
            return false;
        }
        $.post("/member/password/retrieve",data,function(result){
            sending = false;
            if(result.status !=200){
            	layer.msg(result.msg,{icon:2});
				return false
			}
            setTime();
            layer.msg("{{ Lang.msg_reset_email_send_success || "重置密码邮件发送成功，请查收邮件" }}",{icon:1})
        });
	}
    var countdown = 60;
    function setTime() {
        var val = $("#sendEmailBut");
        if (countdown == 0) {
            val.removeClass("layui-btn-disabled");
            val.removeAttr("disabled");
            val.html("{{ Lang.btn_login_send_reset_password || "发送邮件, 重置密码" }}");
            countdown = 60;
        } else {
            val.addClass("layui-btn-disabled");
            val.attr("disabled", true);
            val.html("{{ Lang.btn_reset_email_retry || "重新发送" }}(" + countdown + ")");
            countdown--;
            setTimeout(function() {
                setTime();
            },1000)
        }
    }
</script>