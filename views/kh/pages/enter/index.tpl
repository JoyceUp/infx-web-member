{% extends '../../common/layouts/layout.tpl' %}

{% set title=Lang.page_reg_signup_dl_title || "代理登记 " %}
{% block css_assets %}
	<style>
		.layui-form-mid.btn {
			padding: 4px 0!important;
		}

		.layadmin-user-login-main {width:500px;margin:4% auto}
		.layadmin-user-login-body .ib_form .layui-form-item .layui-input{padding:6px}

	</style>
{% endblock %}
{% block content %}


	<div class="container w800" id="resulBox" style="display: none" >
		<div class="register" >
			<div class="succ succ_page" id="succMsg">
				<div class="succ-icon">
					<img src="/assets/kh/images/succ-icon.png">
				</div>
				<h4><span>{{ Lang.page_reg_signup_dl_tips1 || "恭喜，登记成功！ " }}</span><br/></h4>
				<p>{{ Lang.page_reg_signup_dl_tips2 || "请等待审核，注意查收邮件 " }}</p>
			</div>
			<div class="succ fail_page none" id="errMsg" style="display: none">
				<div class="succ-icon">
					<img src="/assets/kh/images/err-icon.png">
				</div>
				<h4>{{ Lang.page_reg_signup_dl_tips3 || "抱歉,登记失败！ " }}</h4>
				<p>{{ Lang.page_reg_signup_dl_tips4 || "失败原因： " }}<em id="res_err_acc"></em></p>
			</div>
		</div>
	</div>


	<div class="layadmin-user-login-main" id="regBox">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<h2>{{ Lang.page_reg_signup_dl_title || "代理登记 " }}</h2>
			<p></p>
		</div>
		<div class="layadmin-user-login-box layadmin-user-login-body layui-form">

			<div class="ib_form">



				<form class="layui-form " action="">
					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_text_family_name || "姓" }}：</label>
						<div class="layui-input-block">
							<input type="text" name="family_name" lay-verify="NotBlank" msg="{{ Lang.validate_family_name_not_null || "请输入您的姓" }}" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_text_given_name || "名" }}：</label>
						<div class="layui-input-block">
							<input type="text" name="given_name" lay-verify="NotBlank" msg="{{ Lang.validate_given_name_not_null || "请输入您的名" }}" autocomplete="off" class="layui-input">
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_text_gender || "称呼" }}：</label>
						<div class="layui-input-block">
                            {% for item in Lang.select.ib.register.gender %}
								<input type="radio" name="gender" value="{{ item.value }}" title="{{ item.label }}" {% if loop.index == 1 %}checked{% endif %}/>
                            {% endfor %}
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity_type || "证件类型" }}：</label>
						<div class="layui-input-block">
                            <select name="identity_type" lay-verify="NotBlank" msg="{{ Lang.validate_identity_type_not_chose || "请选择您的证件类型" }}">
								<option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.ib.register.identity_type %}
									<option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
							</select>
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity_no || "证件号码" }}：</label>
						<div class="layui-input-block">
							<input type="text" name="identity_no" lay-verify="identity_no" autocomplete="off" class="layui-input">
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_text_email || "电子邮箱" }}：</label>
						<div class="layui-input-block">
							<input type="text" name="email" id="email" lay-verify="NotBlank|email" msg="{{ Lang.msg_email_not_null || "请输入电子邮箱" }}" autocomplete="off" class="layui-input">
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_login_code || "验证码" }}：</label>
						<div class="layui-input-inline">
							<input type="text" name="verify_code" lay-verify="NotBlank" msg="{{ Lang.validate_email_captcha_not_null || "请输入邮箱验证码" }}" placeholder="{{ Lang.validate_email_captcha_not_null }}" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-form-mid btn">
							<input type="button" class="layui-btn layui-btn-sm" id="getVerifyCodeBtn" onclick="getVerifyCode(this)" value="{{ Lang.btn_getCode || "获取验证码" }}"/>
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label">{{ Lang.form_label_invite_code || "邀请码" }}：</label>
						<div class="layui-input-block">
							<input type="text" name="invite_code" value="{{ no }}" lay-verify="invite_code" autocomplete="off" class="layui-input">
						</div>
					</div>

					<div class="layui-form-item mt50 submit-item">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit lay-filter="formSubmit" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
						</div>
					</div>
				</form>


			</div>
		</div>
	</div>
{% endblock %}


{% block js_assets %}

	<script>
        //Demo
        layui.use('form', function(){
            var form = layui.form;
            form.verify({
                identity_no:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_identity_no_not_null || "证件号码不能为空" }}";
                    }else{
                        var type = $('select[name="identity_type"]').val()
                        var result = isIdentity(type,value);
                        if(result != true){
                            return result;
                        }
                    }
                },
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });
            //监听提交
            form.on('submit(formSubmit)', function(data){
                submit(data.field);
                return false;
            });
        });

        function submit(data) {
            $.ajax({
                url: "/ib/reg/signup",
                async: true,
                data: data,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {

                    if (data.status == 200) {
                        $("#resulBox").show();
                        $("#regBox").hide();
                        $("#succMsg").show();
                        $("#errMsg").hide();
                    }else{
                        if(data.msg && data.msg.indexOf("验证码") >= 0){
                            layer.msg(data.msg, {
                                icon:2
                            });
                        }else{
                            $("#resulBox").show();
                            $("#regBox").hide();
                            $("#succMsg").hide();
                            $("#errMsg").show();
                            $("#res_err_acc").text("");
                            $("#res_err_acc").text(data.msg);
                        }
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        //验证电子邮箱
        function checkEmail(email, cb) {
            $.ajax({
                url: '/common/unique_mail',
                async: true,
                data: {'email': email},
                type: 'post',
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        cb(true);
                    } else {
                        cb(false);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    cb(false);
                }
            });
        }

        /*获取验证码*/
        function getVerifyCode(val){
            var email = $('input[name="email"]').val();
            if(email == '') {
                layer.msg('{{ Lang.msg_email_not_null || "请输入电子邮箱" }}', {icon: 5, time: 2000});
                return false;
            }
            if(!emailReg.test(email)){
                layer.msg('{{ Lang.alert_email_format_error || "邮箱格式不正确" }}', {icon: 5, time: 2000});
                return false;
            }
            //验证电子邮箱
            checkEmail(email, function (flag) {
                if(!flag){
                    layer.msg("{{ Lang.msg_email_already_existed || "电子邮箱已存在" }}", {icon: 5, time: 2000});
                    return false;
                }
                $.ajax({
                    url: "/common/send_mail",
                    async: true,
                    data:{'email':email},
                    type: 'post',
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=utf-8",
                    success:function(data){
                        if (data.status == 200) {
                            layer.msg('{{ Lang.msg_verify_code_send_success || "验证码已发送，请及时查收！" }}', {icon: 1, time: 2000});
                            setTime(val)
                        }else{
                            layer.msg(data.msg, {icon: 5, time: 2000});
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){}
                });
            });
        }

        var countdown = 60;
        function setTime(val) {
            if (countdown == 0) {
                val.removeAttribute("disabled");
                $(val).removeClass("layui-btn-disabled");
                val.value="{{ Lang.btn_getCode || "获取验证码" }}";
                countdown = 60;
            } else {
                $(val).addClass("layui-btn-disabled");
                val.setAttribute("disabled", true);
                val.value="{{ Lang.btn_reset_email_retry || "重新发送" }}(" + countdown + ")";
                countdown--;
                setTimeout(function() {
                    setTime(val)
                },1000)
            }
        }
	</script>
{% endblock %}

