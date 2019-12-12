<style>
    .reg-title-2 span{
        font-size:14px;
        color:#999;
    }
    .country_code{
        display: inline-block;
        width: 60px;
        padding-left: 20px;
    }
</style>

<div class="register">
    <div class="register-title">
      {{ Lang.page_register_step_title || "账户注册" }}
    </div>
    <div class="register-form">
        {#<p class="reg-title-1">{{ Lang.form_text_three_minutes_span || " 完成注册预计需要1分钟 " }}</p>
        <p class="reg-title-2">{{ Lang.form_text_base_info_ || "基础信息" }}<span>{{ Lang.form_text_basic_span || " （邮箱是您接收通知和交易信息的重要渠道，请认真填写。） " }}</span></p>#}
        <form class="layui-form" action="">
           <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_gender || "称呼" }}:</label>
                        <div class="layui-input-block">
                            <select name="gender" lay-verify="NotBlank"  lay-verType="tips" msg="{{ Lang.validate_gender_not_chose || "请选择您的称呼" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.gender %}
                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>
                </div>
           </div>
            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_user_name || "姓名" }}:</label>
                        <div class="layui-input-block">
                            <input lay-verType="tips"type="text" name="full_name" lay-verify="full_name" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">
                    <div class="layui-form-item" >

                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_mobile || "手机号码" }}:</label>

                        <div class="layui-input-block" style="margin-bottom:10px">

                            <select lay-verType="tips" id="card_province" name="country_code" lay-verify="country_code" lay-filter="country_code"  lay-search="" >
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                            </select>
                            {#<input lay-verType="tips"type="text" name="country_code" maxlength="3" lay-verify="country_code"  class="layui-input country_code">#}

                        </div>

                        <div class="layui-input-block" >
                            <input lay-verType="tips"type="text" name="mobile" lay-verify="mobile" class="layui-input">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_email || "电子邮箱" }}:</label>
                        <div class="layui-input-block">
                            <input lay-verType="tips"type="text" name="email" lay-verify="email" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
            </div>


            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_login_password || "密码" }}:</label>
                        <div class="layui-input-block">
                            <input lay-verType="tips"type="password" name="password" lay-verify="password" autocomplete="off" class="layui-input" placeholder="{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}">
                        </div>
                    </div>

                </div>
            </div>

            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_confirm_password || "确认密码" }}:</label>
                        <div class="layui-input-block">
                            <input lay-verType="tips" type="password" name="password2" lay-verify="password2" autocomplete="off" class="layui-input" placeholder="{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}">
                        </div>
                    </div>

                </div>
            </div>
            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>
                            {{ Lang.table_source_account_type||"账户类型" }}:
                        </label>
                        <div class="layui-input-block">
                            <select lay-verType="tips" name="account_type" class="form-control" lay-filter="account_type" lay-verify="required">
                                <option value="">{{ Lang.form_select||"请选择" }}</option>
                                {% for st in Lang.select.member.register.demo_account_type %}
                                    <option value="{{ st.value }}">{{ st.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
            </div>

            <div class="layui-row" style="display: none">
            <p class="reg-title-2 mt30">{{ Lang.form_text_invite_info || "邀请信息" }}<span>{{ Lang.form_text_invite_ }}</span></p>
            <div class="layui-form-item">
                <label class="layui-form-label">{{ Lang.form_label_invite_code || "邀请码" }}:</label>
                <div class="layui-input-inline">
                    <input lay-verType="tips" type="text" name="invite_code" lay-verify="invite_code" value="{{ no }}" autocomplete="off" class="layui-input" >
                </div>
            </div>
            </div>
            <div class="layui-row">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input lay-verType="tips" type="hidden" name="channel" value="1" autocomplete="off" class="layui-input">
                    <input lay-verType="tips" type="hidden" name="register_ip" value="127.0.0.1" autocomplete="off" class="layui-input" />
                    <span id="keleyivisitorip" style="display: none"></span>
                   {# <button class="layui-btn" lay-submit lay-filter="live1_next" onclick="return false;">{{ Lang.btn_next || "下一步" }}</button>#}
                    <button class="layui-btn" lay-submit lay-filter="live1_next" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                </div>
            </div>
            </div>
        </form>

    </div>
</div>

<script type="text/javascript" src="/assets/vendors/layui/country_code.js"></script>
{% block js_assets %}
    <script>
        $(function () {

           setCountryCode()

        })
        var account_type = new Object();
        {% for item in Lang.select.member.register.account_type %}
        account_type[{{ item.value }}] = "{{ item.label }}";
        {% endfor %}
        var current_account_type;
        var form
        layui.use('form', function(){
            form = layui.form;
            // 自定义校验规则
            form.verify({
                family_name : function(value){
                    var nameReg=/^[a-zA-Z ']{1,50}$/;
                    if(!nameReg.test(value)){
                        return '{{ Lang.validate_family_name_format_error || "姓的长度1-50位的字母" }}';
                    }
                },
                full_name : function(value){
                    var nameReg=/^[a-zA-Z ']{1,50}$/;
                    if(!nameReg.test(value)){
                        return '{{ Lang.validate_given_name_format_error || "姓名的长度1-50位的字母" }}';
                    }
                },
                country_code:function(value){
                    if(value.trim() == ''|| value.trim().length == 0){ //必须是数字
                        return '{{ Lang.validate_country_code_not_null||"请选择 Country Code" }}';
                    }
                },
                mobile : function(value){
                    if(value.trim() == '' || value.trim().length == 0){
                        return '{{ Lang.validate_mobile_numble || "手机号码为必填项" }}';
                    }
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return '{{ Lang.validate_bank_mobile_is_number||"手机号必须是数字" }}'
                    }
                },
                password : function (value) {
                    if(!passwordReg.test(value)){
                        return value.trim().length == 0 ? '{{ Lang.validate_login_password_not_null || "登录密码是必填项" }}' : passwordErrorMsg;
                    }
                },
                password2 : function (value) {
                    if(value != $('input[name="password"]').val()){
                        $('input[name="password2"]').val('');
                        return '{{ Lang.validate_twice_password_error || "两次密码输入不一致" }}';
                    }
                },
                email : function(value){
                    if(!emailReg.test(value)){
                        return value.trim().length == 0 ? '{{ Lang.msg_email_not_null || "请输入电子邮箱" }}' : '{{ Lang.alert_email_format_error || "邮箱格式不正确" }}';
                    }
                },
                invite_code : function (value) {

                },
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });
            var initUploadLeMa = false
            //监听提交
            form.on('select(country_code)', function(data){


            });
            form.on('submit(live1_next)', function(data){
                // form.render();//全部更新
                var iip = $('#keleyivisitorip')[0].innerHTML;
                data.field.register_ip = iip;
                loading()
                $.ajax({
                    url: '/member/reg/step1',
                    async: true,
                    data: data.field,
                    type:'POST',
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    success:function(data){
                        closeLoading()
                        if (data.status == 200) {
                            $('div#live1').attr('style', 'display: none;');
                            $('div#live4').attr('style', 'display: block;');
                            //countDown(10, '/member/login');
                        }else if (data.status == 508) {
                                $('div#live1').attr('style', 'display: block;');
                                $('div#live3').attr('style', 'display: none;');
                                layer.msg("{{ Lang.msg_request_timeout_back1 || "请求已超时，请返回第一步" }}", {icon: 5, time: 2000});
                            }else{
                            // layer.msg(data.msg, {icon: 5});
                            layer.msg(data.msg, {
                                icon: 5,
                                time: 2000 //2秒关闭（如果不配置，默认是3秒）
                            });
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){}
                });
                $("html,body").animate({
                    scrollTop: 0
                }, 400); //点击go to top按钮时，以400的速度回到顶部，这里的400可以根据你的需求修改
                // return false;
                return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
            });
            form.render()
        });

        //验证电子邮箱
        function checkEmail(email, cb){
            $.ajax({
                url : 'reg/email_unique',
                async: true,
                data:{'email':email},
                type:'GET',
                dataType: "json",
                contentType:'application/json;charset=utf-8',
                success:function(data){
                    if (data.status == 200){
                        cb(true);
                    }else{
                        cb(false);
                    }
                },
                error : function(jqXHR, textStatus, errorThrown){
                    cb(false);
                }
            });
        }

        /*获取验证码*/
        function getCode(){
            var email = $('input[name="email"]').val();
            if(email == '') {
                layer.msg('{{ Lang.msg_email_not_null || "请输入电子邮箱" }}', {icon: 5, time: 2000});
                return false;
            }
            if(!emailReg.test(email)){
                layer.msg('{{ Lang.alert_email_format_error || "邮箱格式不正确" }}', {icon: 5, time: 2000});
                return false;
            }
            layer.load(2); //上传loading
            //验证电子邮箱
            checkEmail(email, function (flag) {
                layer.closeAll('loading'); //关闭loading
                if(!flag){
                    layer.msg("{{ Lang.msg_email_already_existed || '电子邮箱已存在' }}", {icon: 5, time: 2000});
                    return false;
                }
                $.ajax({
                    url :'reg/verify_code',
                    async: true,
                    data:{'email':email},
                    type:'GET',
                    dataType: "json",
                    contentType:'application/json;charset=utf-8',
                    success:function(data){
                        if (data.status == 200) {

                            resetCode(); //倒计时
                            layer.msg('{{ Lang.msg_verify_code_send_success || "验证码已发送，请及时查收！" }}', {icon: 1, time: 2000});
                        }else{
                            layer.msg(data.msg, {icon: 5, time: 2000});
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){}
                });
            });
        }
        //倒计时
        function resetCode(){
            $('#J_getCode').hide();
            $('#J_second').html('60');
            $('#J_resetCode').show();
            $('#J_resetCode').addClass('layui-btn layui-btn-disabled');
            var second = 60;
            var timer = null;
            timer = setInterval(function(){
                second -= 1;
                if(second >0 ){
                    $('#J_second').html(second);
                }else{
                    clearInterval(timer);
                    $('#J_getCode').show();
                    $('#J_resetCode').hide();
                }
            },1000);
        }

    </script>
{% endblock %}