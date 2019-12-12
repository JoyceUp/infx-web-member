<!DOCTYPE html>
<html>
<head>

{#<%
	String  langstr = TypeUtils.stringVal(request.getAttribute("lang"));
%>#}
	{% include "../common/layouts/head.tpl" %}
<link href="/assets/member/styles/auth/login.css?v=4" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/assets/member/scripts/biz/auth/login.js?v=1"></script>
<script type="text/javascript">
$(function() {
	var errMsg = "{{loginerr}}";
	if (null != errMsg) {
		$("#err").empty().append(errMsg);
	}
	
	(function($) {
		$.getUrlParam = function(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if (r != null)
				return unescape(r[2]);
			return null;
		}
	})(jQuery);

	var urlLang = $.getUrlParam('lang');
	var language = (urlLang == "" || urlLang == null) ? "<%=langstr %>" : urlLang;
	
	if(language == "cn"){
		$("#langSel").find("option[value='cn']").attr("selected",true);
	}else if(language == "en"){
		$("#langSel").find("option[value='en']").attr("selected",true);
	}else if(language == "kor"){
		$("#langSel").find("option[value='kor']").attr("selected",true);
	}else{
		$("#langSel").find("option[value='cn']").attr("selected",true);
	}
	
	$("#langSel").change(function() {
		var language = $("#langSel").val();
		if (language == "cn") {
			window.location.href = basePath + "?lang=" + "cn";
		} else if (language == "en") {
			window.location.href = basePath + "?lang=" + "en";
		} else if (language == "kor") {
			window.location.href = basePath + "?lang=" + "kor";
		} else {
			window.location.href = basePath;
		}
	});
});
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
			<div style="position:absolute;top:5px;right:50px; ">
				<select  id="langSel" class="langCSS" >
				    <option value="cn" >中文</option>
				    <option value="en">English</option>
				    <option value="kor">한글</option>
				</select>
			</div>
		</div>
	</div>
	<div id="dialog">
		<div class="dialog_content">
			<div class="dialog_title">
				<h2>{{common.dialogtitle || "{{ Lang.page_msg_login || "登录" }}"}}</h2>
				<hr/>
			</div>
			<form  action="//signup" method="post" id="form">
				<ul class="from" style="width: 378px;">
					<li>							
						<input id="id_username" class="input_index" name="userName" type="text" title="{{ common.email_mt || '{{ Lang.form_placeholder_login_email_or_mt || "邮箱或mt账号" }}'}}" value=""  vali="require"  valiformat="email_mt" placeholder="{{ common.email_mt || Lang.form_placeholder_login_email_or_mt}}">
					</li>
					<li>
						<input id="id_password" class="input_index " name="password" type="password" title="{{ common.password || '{{ Lang.form_placeholder_login_password || "密码" }}'}}" value=""  vali="require" placeholder="{{ common.password || Lang.form_placeholder_login_password}}" >
					</li>
					<li>
						<div class="accountType">
						   <span id="err" class="required"></span>
						</div>
					</li>
					<li>
						<div class="forgetpwd" style="float: right;padding-top: 0px;">
							<a href="{{basePath }}auth/initResetPwd.html">{{ common.forgetpwd || '{{ Lang.page_login_backpassword || "忘记密码" }}'}}？</a>
						</div>
					</li>
				</ul>
			</form>
			<div class="btn_bottom">
				<button id="btn-login" type="button" class="btn-primary btn-icon" onclick="return false;">{{common.login || '{{ Lang.page_msg_login || "登录" }}'}}</button>
			</div>
		</div>
	</div>
	<div class="dialog_text_holder">
		<hr/>

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