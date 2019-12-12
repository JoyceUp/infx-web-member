{%
set langstr = '';
%}
<script>
    $(function () {
        setMenu();
        $("#userEmail").html(window.user.email);
        layui.use(['form', 'layedit', 'laydate'], function(){
            var form = layui.form
                ,layer = layui.layer;
            //自定义验证规则
            form.verify({
                password: function(value){
                    if(value.length < 1){
                        return '{{ Lang.validate_old_password_not_null || "请输入旧密码" }}';
                    }
                }
                ,new_password: function(value){
                    if(value.length < 1){
                        return '{{ Lang.validate_new_password_not_null || "请输入新密码" }}';
                    }
                    if(!passwordReg.test(value)){
                        return passwordErrorMsg;
                    }
                }
                ,con_password: function(value){
                    if(value.length < 1){
                        return '{{ Lang.validate_confirm_password_not_null || "请输入确认新密码" }}';
                    }
                    var new_password = $('#new_password').val();
                    if(value != new_password){
                        return '{{ Lang.validate_twice_password_error || "两次密码输入不一致" }}!';
                    }
                }
            });

            //监听提交
            form.on('submit(resetPwdSubmit)', function(data){
                resetPwd(data.field);
                return false;
            });


        });


    })

    function setMenu(){
        if(window.user.position == 3){
            $(".side_nav").children("li").eq(4).hide();
        }
    }
    function modifyPwd (){
        layer.open({
            type: 1,
            title: "{{ Lang.dialog_title_reset || "修改密码" }}",
            area: ['510px','auto'], //宽高
            content: $("#resetPwd"),

        });
    }
    function resetPwd(data){

        var params = {
            username : window.user.email,
            password : data.password,
            new_password:data.new_password,
        }
        $.post("/sale/reset_pwd",params,function(result){
            if(result.status == 200){
                delCookie("saletoken");
                delCookie("user");
                layer.msg("{{ Lang.msg_reset_login_password_re_login || "重置密码成功，请重新登录" }}",{icon:1, time: 1000,},function () {
                    window.login()
                })

            }else{
                layer.msg(result.msg,{icon:2})
            }

        })
    }
    function logout(){
        layer.confirm('{{ Lang.open_confirm_logout || "确认退出登录？" }}', {
            btn: ['{{ Lang.btn_true || "确定" }}','{{ Lang.btn_cancel || "取消" }}'] //按钮
        }, function(){
            $.post("/sale/logout",{},function(result){
                if(result.status == 200){
                    delCookie("saletoken");
                    delCookie("user");
                    layer.msg("{{ Lang.msg_retreat_safely || "安全退出" }}",{icon:1, time: 1000,},function () {
                      window.login()
                    },100)

                }

            })

        }, function(){

        });

    }
</script>
<div id="header">
    <div class="header_holder">
        {% if langstr === "cn" || langstr === "" %}
            <a class="logo" href="http://www.rtfgroups.com/"></a>
        {% else %}
            <a class="enlogo" href="http://en.rtfgroups.com/"></a>
        {% endif %}


        <ul class="account">
            <li style="font-size: 14px;color:#fff;">
                <span id="userEmail"></span>
            </li>
            <li>
                <div class="modifypwd" style="cursor:pointer" onclick="modifyPwd();">
                    <a href="javascript:void(0);" >{{ Lang.header_modify_password || "修改密码" }}</a>
                </div>
            </li>
            <li>

                <div class="logout" style="cursor:pointer" onclick="logout()">
                    <a >{{ Lang.header_logout || "退出登录" }}</a>
                </div>
            </li>
        </ul>
    </div>
</div>



<div id="resetPwd" style="display: none">
    <div class="form" style="padding:20px;">

        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label zm-w190">{{ Lang.form_placeholder_old_password || "旧密码" }}</label>
                <div class="layui-input-block zm-ml-220">
                    <input type="password" name="password" lay-verify="password" autocomplete="off"  class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label zm-w190">{{ Lang.form_placeholder_new_password || "新密码" }}</label>
                <div class="layui-input-block zm-ml-220">
                    <input type="password" maxlength="18" id = "new_password" name="new_password" lay-verify="new_password" autocomplete="off"  class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label zm-w190">{{ Lang.form_placeholder_confirm_new_password || "确认新密码" }}</label>
                <div class="layui-input-block zm-ml-220">
                    <input type="password" maxlength="18" name="con_password" lay-verify="con_password" autocomplete="off"  class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block zm-ml-220">
                    <button class="layui-btn" lay-submit="" lay-filter="resetPwdSubmit" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                </div>
            </div>
        </form>

    </div>

</div>