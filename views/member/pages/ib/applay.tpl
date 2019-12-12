{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
{% endblock %}



{% block js_assets %}
    {# 引入js #}


    <script>
        //Demo
        layui.use('form', function(){
            var form = layui.form;

            form.verify({
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
                url: "/member/ib/submit_applay",
                async: true,
                data: data,
                type: "get",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        layer.alert("{{ Lang.alert_submit_success || "提交成功" }}", {
                            title: '{{ Lang.page_msg_h3 || "提示：" }}'
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        function getVerifyCode(val) {
            if(!emailReg.test($("#email").val())){
                layer.alert("{{ Lang.alert_email_format_error || "邮箱格式不正确" }}", {
                    title: '{{ Lang.page_msg_h3 || "提示：" }}'
                });
                return false;
            }

            $.ajax({
                url: "/member/ib/get_verify_code",
                async: true,
                data: {email: ''},
                type: "get",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        layer.alert("{{ Lang.alert_view_email || "请查看邮箱" }}", {
                            title: '{{ Lang.page_msg_h3 || "提示：" }}'
                        });
                        settime(val)
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        var countdown = 60;
        function settime(val) {
            if (countdown == 0) {
                val.removeAttribute("disabled");
                val.value="{{ Lang.btn_getCode || "获取验证码" }}";
                countdown = 60;
            } else {
                val.setAttribute("disabled", true);
                val.value="{{ Lang.btn_reset_email_retry || "重新发送" }}(" + countdown + ")";
                countdown--;
                setTimeout(function() {
                    settime(val)
                },1000)
            }
        }
    </script>

{% endblock %}



{% block content %}
    {# 内容 #}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_ib_apply || "申请代理" }}
                    </div>
                    <div class="main_head_text required">

                    </div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">

                            <div class="form">

                                {#注意要把name改成相关的字段名#}
                                <form class="layui-form form w500" action="">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_text_family_name || "姓" }}：</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="family_name" lay-verify="NotBlank" msg="{{ Lang.validate_family_name_not_null || "请输入您的姓" }}" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_text_given_name || "名" }}：</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="given_name" lay-verify="NotBlank" msg="{{ Lang.validate_given_name_not_null || "请输入您的名" }}" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_text_gender || "称呼" }}：</label>
                                        <div class="layui-input-block">
                                            <input type="radio" name="gender" value="{{ Lang.form_text_gender_boy || "男" }}" title="{{ Lang.form_text_gender_boy }}">
                                            <input type="radio" name="gender" value="{{ Lang.form_text_gender_girl || "女" }}" title="{{ Lang.form_text_gender_girl }}" checked>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_text_identity_type || "证件类型" }}：</label>
                                        <div class="layui-input-block">
                                            <select name="identity_type" lay-verify="NotBlank" msg="{{ Lang.validate_identity_type_not_chose || "请选择您的证件类型" }}">
                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                {% for item in Lang.select.ib.register.identity_type %}
                                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                                {% endfor %}
                                            </select>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_text_identity_no || "证件号码" }}：</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="identity_no" lay-verify="NotBlank" msg="{{ Lang.validate_identity_no_not_null || "证件号码不能为空" }}" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_text_email || "电子邮箱" }}：</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="email" id="email" lay-verify="email" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">{{ Lang.form_placeholder_login_code || "验证码" }}：</label>
                                        <div class="layui-input-inline">
                                            <input type="text" name="verify_code" lay-verify="NotBlank" msg="{{ Lang.validate_email_captcha_not_null || "请输入邮箱验证码" }}" placeholder="{{ Lang.validate_email_captcha_not_null }}" autocomplete="off" class="layui-input">
                                        </div>
                                        <div class="layui-form-mid btn">
                                            <input type="button" class="layui-btn layui-btn-sm" onclick="getVerifyCode(this)" value="{{ Lang.btn_getCode || "获取验证码" }}"/>
                                        </div>
                                    </div>

                                    <div class="layui-form-item mt50">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit lay-filter="formSubmit">{{ Lang.btn_sub || "提交" }}</button>
                                        </div>
                                    </div>
                                </form>


                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}

