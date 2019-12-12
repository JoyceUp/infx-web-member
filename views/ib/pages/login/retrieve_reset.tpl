<!DOCTYPE html>
<html>
<head>

{#<%
	String  langstr = TypeUtils.stringVal(request.getAttribute("lang"));
%>#}
	<title>{{ Lang.page_restpassword_title || "重置密码" }}</title>
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
			<h2>{{ Lang.page_restpassword_title || "重置密码" }}</h2>
			<p>{{ msg }}</p>
			<p style="display: none">{{ msgt }}</p>
		</div>
		<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
			<form class="layui-form" action="">
				<div class="layui-form-item">
					<label class="layadmin-user-login-icon iconfont icon-unlock" for="user-login-username"></label>
					<input type="password" name="password"  lay-verify="password" placeholder="{{ Lang.form_placeholder_new_password || "新密码" }}" class="layui-input">
				</div>
				<div class="layui-form-item">
					<label class="layadmin-user-login-icon iconfont icon-queren" for="user-login-username"></label>
					<input type="password" name="password2"  lay-verify="password2" placeholder="{{ Lang.form_placeholder_confirm_password || "确认密码" }}" class="layui-input">
				</div>
				<input type="hidden" name="code" value="{{ reset_code }}"/>

				<div class="layui-form-item mt30">
					<button class="layui-btn layui-btn-fluid" lay-submit=""  lay-filter="user-login-submit">{{ Lang.btn_sub || "提交" }}</button>
				</div>
			</form>
		</div>
	</div>

	<div class="dialog_text_holder">


            {% autoescape %}
			<span style="font-size: 16px;">
				{{ common.attention }}
			</span>
			{{common.attentioncontent}}
			{% endautoescape %}
		</p>				
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
            ,layer = layui.layer

   form.verify({
       password : function (value) {

           if(!passwordReg.test(value)){
               return value.trim().length == 0 ? '{{ Lang.validate_new_password_not_null || "请输入新密码" }}' : passwordErrorMsg;
           }
       },
       password2 : function (value) {
           if(value.trim() == ""){
               $('input[name="password2"]').val('');
               return '{{ Lang.validate_confirm_password_not_null || "请输入确认新密码" }}';
           }
           if(value.trim() != $('input[name="password"]').val()){
               $('input[name="password2"]').val('');
               return '{{ Lang.validate_twice_password_error || "两次密码输入不一致" }}';
           }
       }
        });

        //监听提交
        form.on('submit(user-login-submit)', function(data){

            submit(data.field)
            return false;
        });


    });

    function submit(data){
		var params = {
		    password: data.password,
            reset_code: data.code
		}

        $.post("/ib/password/retrieve/reset",params,function(result){
            if(result.status !=200){
				layer.msg(result.msg,{icon:2})
				return false
			}

            layer.msg("{{ Lang.msg_reset_login_password_re_login || "重置密码成功，请重新登录" }}",{icon:1},function(){
                window.location.href = "/ib/login"
			})
        });
	}
</script>