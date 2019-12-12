{% extends '../../common/layouts/layout.tpl' %}
{% set title= Lang.page_reg_signup_dl_registered_title || "代理登记 "  %}
{% block css_assets %}
    <style>
        .reg-title-2 span {
            font-size: 14px;
            color: #999;
        }

        .statement a {
            color: #2681e2;
        }
    </style>
{% endblock %}
{% block js_assets %}
    <script type="text/javascript" src="/assets/kh/js/country.js"></script>
    {#引入js#}
    <script>
        $(function () {
            initCountry();
        });

        //初始化 国家
        function initCountry() {
            var proHtml = '';
            for (var i = 0; i < country.length; i++) {
                if (country[i][0].toLowerCase() == 'cn') {
                    proHtml += '<option value="' + country[i][1] + '" selected>' + country[i][1] + '</option>';
                } else {
                    proHtml += '<option value="' + country[i][1] + '">' + country[i][1] + '</option>';
                }
            }
            $('select[name=country]').append(proHtml);
        }

        renderUpload();
        //渲染上传组件
        function renderUpload(user_id) {
            layui.use(['upload', 'laydate'], function () {

                var laydate = layui.laydate;
                laydate.render({
                    elem: '#birthday' //指定元素
                    ,lang:laylang
                });

                var identity1_path = $('#identity1_path')
                var identity2_path = $('#identity2_path')
                var upload = layui.upload;
                //注册第二步页面拖拽上传
                var uploadInstA= upload.render({
                    elem: '#identity1_upload'
                    , url: '/common/upload/'
                    , data: {role_type: 2, role_id: $("userId").val()}
                    , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                    , accept: 'images' //允许上传的文件类型
                    , size: IsPC()? 2048:0 //最大允许上传的文件大小
                    ,auto:false
                    ,choose:function(obj){
                        layer.load(2); //上传loading
                        if(!IsPC()){
                            obj.preview(function(index, file, result){
                                var data = {role_type: 2, role_id: user_id}
                                resizeImageUpload(file,data,identity1_path)
                            })

                        }else{
                            uploadInstA.upload()
                        }
                        obj.preview(function (index, file, result) {
                            $('#identity1_upload').html('<img style="width:100%" class="layui-upload-img" src="' + result + '">'); //图片链接（base64）
                        });

                    }
                    , done: function (res) {
                        uploadSucc(res, identity1_path)
                    }
                });
                var uploadInstB=upload.render({
                    elem: '#identity2_upload'
                    , url: '/common/upload/'
                    , data: {role_type: 2, role_id: user_id}
                    , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                    , accept: 'images' //允许上传的文件类型
                    , size: IsPC()? 2048:0 //最大允许上传的文件大小
                    ,auto:false
                    ,choose:function(obj){
                        layer.load(2); //上传loading
                        if(!IsPC()){
                            obj.preview(function(index, file, result){
                                var data = {role_type: 2, role_id: user_id}
                                resizeImageUpload(file,data,identity2_path)
                            })

                        }else{
                        uploadInstB.upload()
                        }
                        obj.preview(function (index, file, result) {
                            $('#identity2_upload').html('<img style="width:100%" class="layui-upload-img" src="' + result + '">'); //图片链接（base64）
                        });


                    }
                    , before: function (obj) {
                        //预读本地文件示例，不支持ie8
                    }

                    , done: function (res) {
                        uploadSucc(res, identity2_path)
                    }
                });
            });
            return false;
        }


        //var datas = JSON.parse(jQuery.parseHTML("{{ datas }}")[0].data);
        //渲染表单
        layui.use(['form'], function () {
            var form = layui.form;
            //代理注册 下一步
            form.on("submit(next)", function (data) {
                //提交 data.field，跳转到下一步
                var datas = {
                    apply_id: '{{ datas.id }}',
                    family_name: data.field.family_name,
                    given_name: data.field.given_name,
                    gender: parseInt(data.field.gender),
                    email: data.field.email,
                    verify_code: data.field.verify_code,
                    invite_code: data.field.invite_code
                };
                $.ajax({
                    url: '/ib/register/step1',
                    async: true,
                    type: 'post',
                    data: datas,
                    dataType: "json",
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    success: function (data) {
                        if (data.status == 200) {

                            $("#userID").val(JSON.parse(data.datas).id);
                            //点击下一步后，获取当前注册用户的Id,以id为role_id再渲染上传组件


                            $("#first_page").hide();
                            $("#second_page").show();

                            //保留当前注册用的id,提交注册完成时需要
                            $('#uid').val(JSON.parse(data.datas).id);
                            return false;
                        } else {
                            if (data.msg && data.msg.indexOf("验证码") >= 0) {//TODO 根据服务器返回的信息判断
                                layer.msg(data.msg, {
                                    icon: 2
                                });
                            } else {
                                return layer.msg(data.msg);
                            }
                        }
                        return false;
                    }
                });
                return false;
            });


            form.verify({
                identity_no : function(value){
                    //判断证件类型
                    var identityType = $('select[name="identity_type"]').val();
                    var result = isIdentity(identityType,value);
                    if(result != true){
                        return result
                    }
                },
                date_of_birth: function (value) {
                    if (value == '') {
                        return "{{ Lang.validate_birthday_not_null || "出生日期必填项" }}";
                    }
                },
                mobile: function (value) {
                    if (value.trim() != '' && !mobileReg.test(value)) {
                        return '{{ Lang.validate_mobile_format_error || "手机号码格式有误" }}';
                    }
                },
                zip_code: function (value) {
                    var reg = /^[0-9]{6}$/;
                    if (!reg.test(value)) {
                        return value.trim().length == 0 ? '{{ Lang.validate_zip_code_not_null || "请输入邮政编码" }}' : '{{ Lang.validate_zip_format_error || "邮政编码有误" }}';
                    }
                },
                password: function (value) {
                    if ((/^\s*$/.test(value))) {
                        return "{{ Lang.validate_login_password_not_null || "登录密码是必填项" }}";
                    }
                    if (!passwordReg.test(value)) {
                        return passwordErrorMsg;
                    }
                },
                password2: function (value) {
                    if (value !== $('input[name="password"]').val()) {
                        $('input[name="password2"]').val('');
                        return '{{ Lang.validate_twice_password_error || "两次密码输入不一致" }}';
                    }
                },
                country: function (value) {
                    if (value.length == 0) {
                        return '{{ Lang.validate_country_not_null || "请选择居住国家" }}';
                    }
                },
                city: function (value) {
                    if (value.length == 0) {
                        return '{{ Lang.validate_city_not_null || "请输入城市" }}';
                    }
                },
                address: function (value) {
                    if (value.length == 0) {
                        return '{{ Lang.validate_address_not_null || "请输入居住地址" }}';
                    }
                },
                identity1_path: function (value) {
                    if (value.length == 0) {
                        return '{{ Lang.validate_identity1_path_not_null || "证件正面照片必须上传" }}';
                    }
                },
                identity2_path: function (value) {
                    if (value.length == 0) {
                        return '{{ Lang.validate_identity2_path_not_null || "证件反面照片必须上传" }}';
                    }
                },
                agree: function (value) {
                    var agree = jQuery("#agree").is(":checked");
                    if (!agree) {
                        return "{{ Lang.msg_check_ib_register_file || "您需要勾选声明" }}";
                    }
                },
                NotBlank: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return $(item).attr("msg");
                    }
                }
            });

            var flag = false;
            var i = 0;
            form.on('checkbox(chekSound)', function (data) {
                flag = data.elem.checked ? true : false;
            });
            //第二步提交（共两步）
            form.on("submit(complate)", function (data) {
                var params = {
                    id: $("#uid").val(),
                    identity_type: parseInt(data.field.identity_type),
                    identity_no: data.field.identity_no,
                    date_of_birth: data.field.date_of_birth + " 00:00:00",
                    mobile: data.field.mobile,
                    country: data.field.country,
                    province: "默认",
                    city: data.field.city,
                    address: data.field.address,
                    zip_code: data.field.zip_code,
                    password: data.field.password,
                    account_type: parseInt(data.field.account_type),
                    identity1_path: data.field.identity1_path,
                    identity2_path: data.field.identity2_path
                };
                if (flag) {
                    $.ajax({
                        url: '/ib/register/step2',
                        async: true,
                        data: params,
                        type: 'POST',
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        success: function (data) {
                            if (data.status == 200) {
                                $("#third").show();
                                $("#second_page").hide();
                                return false;
                            }else if (data.status == 508) {
                                $("#first_page").show();
                                $("#second_page").hide();
                                layer.msg("{{ Lang.msg_request_timeout_back1 || "请求已超时，请返回第一步" }}", {icon: 5, time: 2000});
                            } else {
                                return layer.msg('{{ Lang.msg_retister_error || "注册失败" }}：' + data.msg);
                                return false;
                            }
                        }
                    });
                } else {
                    layer.msg('{{ Lang.msg_check_register_file || "请勾选注册协议文件" }}', {icon: 5, time: 2000});
                }
                return false;
            });

        });

        //上一步 提交 (注册第二步页面上的按钮，回到前一页)
        function back() {
            $("#first_page").show();
            $("#second_page").hide();
            return false;
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
        function getVerifyCode(val) {
            var email = $('input[name="email"]').val();
            if (email == '') {
                layer.msg('{{ Lang.msg_email_not_null || "请输入电子邮箱" }}', {icon: 5, time: 2000});
                return false;
            }
            if (!emailReg.test(email)) {
                layer.msg('{{ Lang.alert_email_format_error || "邮箱格式不正确" }}', {icon: 5, time: 2000});
                return false;
            }
            //验证电子邮箱
            checkEmail(email, function (flag) {
                if (!flag) {
                    layer.msg("{{ Lang.msg_email_already_existed || "电子邮箱已存在" }}", {icon: 5, time: 2000});
                    return false;
                }
                $.ajax({
                    url: "/common/send_mail",
                    async: true,
                    data: {'email': email},
                    type: 'post',
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=utf-8",
                    success: function (data) {
                        if (data.status == 200) {
                            layer.msg('{{ Lang.msg_verify_code_send_success || "验证码已发送，请及时查收！" }}', {icon: 1, time: 2000});
                            setTime(val)
                        } else {
                            layer.msg(data.msg, {icon: 5, time: 2000});
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            });
        }

        var countdown = 60;

        function setTime(val) {
            if (countdown == 0) {
                val.removeAttribute("disabled");
                $(val).removeClass("layui-btn-disabled")
                val.value = "{{ Lang.btn_getCode || "获取验证码" }}";
                countdown = 60;
            } else {
                $(val).addClass("layui-btn-disabled")
                val.setAttribute("disabled", true);
                val.value = "{{ Lang.btn_reset_email_retry || "重新发送" }}(" + countdown + ")";
                countdown--;
                setTimeout(function () {
                    setTime(val)
                }, 1000)
            }
        }
    </script>
{% endblock %}
{% block content %}
    {#html内容#}
    {#第一步#}
    <div class="register" id="first_page">
        <div class="register-title">
            <span>1</span>/2 {{ Lang.page_register_dl_step_title || "代理注册" }}
        </div>
        <div class="register-form">
            <p class="reg-title-1">{{ Lang.page_register_dl_tips_msg || "账户信息 "1 }}</p>
            <p class="reg-title-2">{{ Lang.page_register_dl_tips_msg || "账户信息 "2 || "基础信息 " }}<span>{{ Lang.page_register_dl_tips_msg3 || "（邮箱是您接收通知和交易信息的重要渠道，请认真填写。） " }}</span></p>
            <form class="layui-form" action="">

                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_gender || "称呼" }}:</label>
                            <div class="layui-input-block">
                                <select name="gender" lay-verify="NotBlank" msg="{{ Lang.validate_gender_not_chose || "请选择您的称呼" }}" disabled>
                                    {% for at in Lang.select.ib.register.gender %}
                                        <option value="{{ at.value }}"
                                                {% if at.value == datas.gender %}selected="selected"{% endif %} >{{ at.label }}</option>
                                    {% endfor %}

                                </select>
                            </div>

                        </div>
                    </div>

                </div>


                <div class="layui-row">

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_family_name || "姓" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="family_name" value="{{ datas.family_name }}"
                                       lay-verify="family_name"
                                       autocomplete="off" class="layui-input" disabled="disabled">
                            </div>
                        </div>

                    </div>

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_given_name || "名" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="given_name" value="{{ datas.given_name }}"
                                       lay-verify="given_name"
                                       aocomplete="off" class="layui-input" disabled="disabled">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_email || "电子邮箱" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="email" lay-verify="email" value="{{ datas.email }}"
                                       placeholder=""
                                       autocomplete="off" class="layui-input" disabled="disabled">
                            </div>
                        </div>
                    </div>
                    {#<div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_login_code || "验证码" }}:</label>
                            <div class="layui-input-inline">
                                <input type="text" name="verify_code" lay-verify="NotBlank" msg="{{ Lang.validate_email_captcha_not_null || "请输入邮箱验证码" }}"
                                       placeholder="{{ Lang.validate_email_captcha_not_null || "请输入邮箱验证码" }}" autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-form-mid btn">
                                <input type="button" class="layui-btn layui-btn-sm" id="getVerifyCodeBtn"
                                       onclick="getVerifyCode(this)" value="{{ Lang.btn_getCode || "获取验证码" }}"/>
                            </div>
                        </div>
                    </div>#}
                </div>
                <br> <br>
                <p class="reg-title-2">{{ Lang.page_register_dl_tips_msg || "账户信息 "4 }}<span>{{ Lang.page_register_dl_tips_msg5 || "（填入销售的邀请码，将建立您与他的关联关系；若无，可不填） " }}</span></p>
                <div class="layui-form-item">
                    <label class="layui-form-label">{{ Lang.form_label_invite_code || "邀请码" }}:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="invite_code" autocomplete="off" value="{{ datas.invite_code }}"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item  submit-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="next" onclick="return false;">{{ Lang.btn_next || "下一步" }}
                        </button>
                    </div>
                </div>
            </form>


        </div>
    </div>

    {#第二步#}
    <div class="register" id="second_page" style="display:none">
        <div class="register-title">
            <span>2</span>/2 {{ Lang.page_register_dl_step_title || "代理注册" }}
        </div>
        <div class="register-form">
            <p class="reg-title-2">{{ Lang.page_register_dl_tips_msg || "账户信息 "2 || "基础信息 " }}</p>
            <form class="layui-form" action="">

                <div class="layui-row">

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity_type || "证件类型" }}:</label>
                            <div class="layui-input-block">
                                <select name="identity_type" lay-verify="identity_type" disabled>
                                    {% for at in Lang.select.ib.register.identity_type %}
                                        <option value="{{ at.value }}"
                                                {% if at.value == datas.identity_type %}selected="selected"{% endif %} >{{ at.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity_no || "证件号码" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="identity_no" lay-verify="identity_no"
                                       value="{{ datas.identity_no }}"
                                       autocomplete="off" class="layui-input" disabled="disabled">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_date_of_birth || "出生日期" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="date_of_birth" id="birthday" lay-verify="date_of_birth"
                                       class="layui-input"/>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label">{{ Lang.form_text_mobile || "手机号码" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="mobile" lay-verify="mobile" placeholder="" aocomplete="off"
                                       class="layui-input"/>
                            </div>
                        </div>
                    </div>

                </div>


                <div class="layui-row">

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_country || "国家" }}:</label>
                            <div class="layui-input-block" width="190px">
                                <select name="country" lay-verify="NotBlank" msg="{{ Lang.validate_country_not_null || "请选择居住国家" }}" lay-search="">
                                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_city || "城市" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="city" lay-verify="city" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>

                </div>


                <div class="layui-row">

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_address || "居住地址" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="address" lay-verify="address" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>

                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_zip_code || "邮政编码" }}:</label>
                            <div class="layui-input-block">
                                <input type="text" name="zip_code" lay-verify="zip_code" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>

                </div>

                <p class="reg-title-2">{{ Lang.page_register_dl_tips_msg || "账户信息 "6 }}</p>
                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_type || "账户类型" }}:</label>
                            <div class="layui-input-block">
                                <select name="account_type" lay-verify="NotBlank" msg="{{ Lang.validate_account_type_not_chose || "请选择账户类型" }}">
                                    {% for at in Lang.select.ib.register.account_type %}
                                        <option value="{{ at.value }}">{{ at.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <p class="reg-title-2">{{ Lang.page_register_dl_tips_msg || "账户信息 "7 }}</p>
                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_login_password || "登录密码" }}:</label>
                            <div class="layui-input-block">
                                <input type="password" name="password" lay-verify="password" placeholder="{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md5 layui-col-xs12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_confirm_password || "确认密码" }}:</label>
                            <div class="layui-input-block">
                                <input type="password" name="password2" lay-verify="password2" placeholder="{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>

                <p class="reg-title-2">{{ Lang.page_register_dl_tips_msg || "账户信息 "8 }}<span>{{ Lang.page_register_dl_tips_msg9 || "(目前只支持png、jpg格式，大小控制在2MB之内) " }}</span></p>
                <input type="hidden" id="" />
                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs12">

                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity1_path || "证件正面" }}:</label>

                            <div class="layui-input-block">
                                <input type="hidden" name="identity1_path" id="identity1_path"
                                       lay-verify="identity1_path"/>
                                <div class="layui-upload-drag" id="identity1_upload">
                                    <i class="layui-icon"></i>
                                    <p>{{ Lang.form_text_upload_files || "点击上传，或将文件拖拽到此处" }}</p>

                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity2_path || "证件反面" }}:</label>
                            <div class="layui-input-block">
                                <input type="hidden" name="identity2_path" id="identity2_path"
                                       lay-verify="identity2_path"/>
                                <div class="layui-upload-drag" id="identity2_upload">
                                    <i class="layui-icon"></i>
                                    <p>{{ Lang.form_text_upload_files || "点击上传，或将文件拖拽到此处" }}</p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <br/><br/>
                <hr/>
                <br/><br/>

                <div class="layui-form-item">
                    <p class="layui-input-block" style="margin-left: 0px;">
                        <input type="checkbox" name="" lay-skin="primary" lay-filter="chekSound">
                        <span>{{ Lang.form_text_agree_span_split || " 同意 " }}<a href="/assets/kh/file/cn/i.pdf" target="_blank" style="color: blue">{{ Lang.form_text_ib_agreement || " 代理协议 " }}</a></span>
                    </p>
                </div>

                <div class="layui-form-item submit-item">
                    <div class="layui-input-block">
                        <input type="hidden" name="id" id="uid" value="" autocomplete="off" class="layui-input"/>
                        <input class="layui-btn" onclick="back()" style="width: 78px" value="{{ Lang.btn_previous || "上一步" }}"/>
                        <button class="layui-btn" lay-submit="" lay-filter="complate" onclick="return false;">{{ Lang.btn_sub || "提交" }}
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    {#完成#}
    <div class="register" style="display:none" id="third">
        <div class="succ succ_page" id="succMsg">
            <div class="succ-icon">
                <img src="/assets/kh/images/succ-icon.png">
            </div>
            <h4><span>{{ Lang.form_text_ib_submit_success || " 代理注册申请提交成功！ " }}</span><br/></h4>
            <p>{{ Lang.form_text_ib_background_review_to_send || " 后台会尽快审核，并邮件通知审核结果！ " }}</p>
        </div>

    </div>
{% endblock %}
