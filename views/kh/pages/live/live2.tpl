<style>
    .reg-title-2 span{
        font-size:14px;
        color:#999;
    }
</style>

<div class="register">
    <div class="register-title">
        <span>2</span>/3  {{ Lang.page_register_step_title || "真实账户注册" }}
    </div>
    <div class="register-form">
        <form class="layui-form" action="">
            <p class="reg-title-2">{{ Lang.form_text_personal_info || "个人信息" }}</p>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity_type || "证件类型" }}:</label>
                        <div class="layui-input-block">
                            <select name="identity_type" lay-filter="identity_type" lay-verify="NotBlank" msg="{{ Lang.validate_identity_type_not_chose || "请选择您的证件类型" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.identity_type %}
                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity_no || "证件号码" }}:</label>
                        <div class="layui-input-block">
                            <input type="text" name="identity_no" lay-verify="identity_no" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>
            </div>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_date_of_birth || "出生日期" }}:</label>
                        <div class="layui-input-block">
                            <input type="text" name="date_of_birth" id="date_of_birth" lay-verify="NotBlank" msg="{{ Lang.validate_birthday_not_null || "出生日期必填项" }}" class="layui-input" id="test2">
                        </div>
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_mobile || "手机号码" }}:</label>
                        <div class="layui-input-block">
                            <input type="tel" name="mobile" lay-verify="mobile" {#placeholder="{{ Lang.form_placeholder_mobile_yes || "用于节日祝福和活动推送，建议填写" }}"#} autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>
            </div>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_country || "国家" }}:</label>
                        <div class="layui-input-block">
                            <select name="country" lay-verify="NotBlank" msg="{{ Lang.validate_country_not_null || "请选择居住国家" }}" lay-search="">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_city || "城市" }}:</label>
                        <div class="layui-input-block">
                            <input type="text" name="city" lay-verify="NotBlank" msg="{{ Lang.validate_city_not_null || "请输入城市" }}" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>

            </div>

            <div class="layui-row">
                <div class="layui-col-md5 ">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_address || "居住地址" }}:</label>
                        <div class="layui-input-block">
                            <input type="text" name="address" lay-verify="NotBlank" msg="{{ Lang.validate_address_not_null || "请输入居住地址" }}" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item ">
                        <labetext class="layui-form-label"><i>*</i>{{ Lang.form_text_zip_code || "邮政编码" }}:</labetext>
                        <div class="layui-input-block">
                            <input type="text" name="zip_code" lay-verify="zip_code" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>

            </div>

            <p class="reg-title-2 mt30">{{ Lang.form_text_account_info_ || "账户信息" }}</p>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_type || "账户类型" }}:</label>
                        <div class="layui-input-block">
                            <select name="account_type" lay-filter="account_type" lay-verify="NotBlank" msg="{{ Lang.validate_account_type_not_chose || "请选择账户类型" }}">
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_leverage || "交易杠杆" }}:</label>
                        <div class="layui-input-block">
                            <select name="leverage" lay-verify="NotBlank" msg="{{ Lang.validate_account_leverage_not_chose || "请选杠杆比例" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.leverage %}
                                    <option value="{{ item.value }}" >{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
            </div>

            <p class="reg-title-2 mt30">{{ Lang.form_text_password_info || "密码信息" }}</p>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_login_password || "登录密码" }}:</label>
                        <div class="layui-input-block">
                            <input type="password" name="password" lay-verify="password" autocomplete="off" class="layui-input" placeholder="{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}">
                        </div>
                     {#   <div class="layui-form-mid layui-word-aux">{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}</div>#}
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_confirm_password || "确认密码" }}:</label>
                        <div class="layui-input-block">
                            <input type="password" name="password2" lay-verify="password2" autocomplete="off" class="layui-input" placeholder="{{ Lang.form_placeholder_msg_password || "6-18位数字字母组合，可包含下划线" }}">
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-form-item submit-item">
                <div class="layui-input-block">
                    <input type="hidden" name="id" id="user_id_2" value="" autocomplete="off" class="layui-input" />
                    <input type="button" class="layui-btn layui-btn-primary" onclick="backStep(1)" value="{{ Lang.btn_previous || "上一步" }}" />
                    <button name="next" id="live2_next" class="layui-btn" lay-submit lay-filter="live2_next" onclick="return false;">{{ Lang.btn_next || "下一步" }}</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="/assets/kh/js/country.js"></script>
{% block js_assets %}
    <script>
        var identity_type = 1;
        var accountTypeMap = []
        {% for at in Lang.select.common.address.countries %}
        accountTypeMap.push (["{{ at[0] }}","{{ at[1] }}"]) ;
        {% endfor %}


        $(function () {
            var proHtml = '';
            for (var i = 0; i < accountTypeMap.length; i++) {
                if(country[i][0].toLowerCase() == 'id'){
                    proHtml += '<option value="' + accountTypeMap[i][0] + '" selected>' + accountTypeMap[i][1] + '</option>';
                }else{
                    proHtml += '<option value="' + accountTypeMap[i][0] + '">' + accountTypeMap[i][1] + '</option>';
                }
            }
            //初始化省数据
            $('select[name=country]').append(proHtml);
        })
        //Demo
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            laydate.render({
                elem: '#date_of_birth' ,
                lang:laylang//指定元素
            });
        });

        layui.use('form', function(){
            var form = layui.form;
            form.on('select(identity_type)', function (data) {
                identity_type = data.value;
            });
            form.on('select(account_type)', function (data) {
                current_account_type = data.value;
            });

            // 自定义校验规则
            form.verify({
                identity_no : function(value){
                    if(value.trim().length == 0){
                        return '{{ Lang.validate_is_identity_null || "证件号码不能为空" }}';
                    }
                    //判断证件类型
                    /*var identityType = $('select[name="identity_type"]').val();
                    var result = isIdentity(identityType, value);
                    if(result != true){
                        return result
                    }*/
                },
                mobile : function(value){
                    if(value.trim() == '' || !/^\d*$/.test(value)){
                        return '{{ Lang.validate_mobile_format_error || "手机号码格式有误" }}';
                    }
                },
                zip_code : function(value){
                    if(value.trim().length == 0){
                        return '{{ Lang.validate_zip_code_not_null || "请输入邮政编码" }}';
                    }
                    /*
                    var reg=/^[0-9]{6}$/;
                    if(!reg.test(value)){
                        return value.trim().length == 0 ? '{{ Lang.validate_zip_code_not_null || "请输入邮政编码" }}' : '{{ Lang.validate_zip_format_error || "邮政编码有误" }}';
                    }*/
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
                NotBlank: function(value, item){        //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });

            //监听提交
            form.on('submit(live2_next)', function(data){
                var datas = {
                    "id": data.field.id,
                    "mobile": data.field.mobile,
                    "country": data.field.country,
                    "province": '北京',
                    "city": data.field.city,
                    "address": data.field.address,
                    "leverage": parseInt(data.field.leverage),              //int
                    "password": data.field.password,
                    "identity_type": parseInt(data.field.identity_type),    //int
                    "identity_no": data.field.identity_no,
                    "date_of_birth": data.field.date_of_birth + " 00:00:00",
                    "zip_code": data.field.zip_code,
                    "account_type": parseInt(data.field.account_type)       //int
                };
                loading();
                $.ajax({
                    url :'/member/reg/step2',
                    async: true,
                    data: datas,
                    type:'POST',
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    success:function(data){
                        closeLoading();
                        if (data.status == 200) {
                            $('div#live2').attr('style','display: none;');
                            $('div#live3').attr('style','display: block;');

                            //护照只上传一面证件信息
                            if (identity_type == 3) {
                                $("#card2_div").hide();
                            }else{
                                $("#card2_div").show();
                            }
                        }else if (data.status == 508) {
                            $('div#live1').attr('style','display: block;');
                            $('div#live2').attr('style','display: none;');
                            layer.msg("{{ Lang.msg_request_timeout_back1 || "请求已超时，请返回第一步" }}", {icon: 5, time: 2000});
                        }else{
                            $("button[name='next']").text("下一步");
                            layer.msg(data.msg, {icon: 5, time: 2000});
                        }
                        //返回顶端
                        $("html,body").animate({
                            scrollTop: 0
                        }, 400); //点击go to top按钮时，以400的速度回到顶部，这里的400可以根据你的需求修改
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        closeLoading();
                    }
                });
                return false;
            });

        });

        function backStep(lastLive){
            //document.documentElement.scrollTop = document.body.scrollTop =0;
            $('#live'+lastLive).attr('style','display: block;');
            lastLive++;
            $('#live'+lastLive).attr('style','display: none;');
            //返回顶端
            $("html,body").animate({
                scrollTop: 0
            }, 800); //点击go to top按钮时，以400的速度回到顶部，这里的400可以根据你的需求修改
        }

        $('input[name="identity_no"]').blur(function(){
            var identityType = $('select[name="identity_type"]').val();
            if(identityType == 1){
                checkBirthday(this.value);
            }
        })
        //验证身份证的年龄
        function checkBirthday(obj){
            var len = obj.length;
            //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
            if(len == '15')
            {
                var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
                var arr_data = obj.match(re_fifteen);
                var year = arr_data[2];
                var month = arr_data[3];
                var day = arr_data[4];
                var birthday = new Date('19'+year+'/'+month+'/'+day);

                if($('input[name="date_of_birth"]').val().length == 0){
                    $('input[name="date_of_birth"]').val('19'+year+'-'+month+'-'+day);
                }

                return verifyBirthday('19'+year,month,day,birthday);
            }
            //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
            if(len == '18')
            {
                var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X|x)$/;
                var arr_data = obj.match(re_eighteen);
                var year = arr_data[2];
                var month = arr_data[3];
                var day = arr_data[4];
                var birthday = new Date(year+'/'+month+'/'+day);

                $('input[name="date_of_birth"]').val( year+'-'+month+'-'+day);
                return verifyBirthday(year,month,day,birthday);
            }
            return false;
        }
        function verifyBirthday(year,month,day,birthday){
            var now = new Date();
            var now_year = now.getFullYear();

            //年月日是否合理
            if(birthday.getFullYear() == year && (birthday.getMonth() + 1) == month && birthday.getDate() == day)
            {
                //判断年份的范围（年龄小于18岁（等于18岁可以注册）也不允许注册，提示“18岁以下用户禁止注册)
                var time = now_year - year;
                if(time >= 18)
                {
                    return true;
                }
                return false;
            }
            return false;
        }

    </script>
{% endblock %}