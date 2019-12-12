{% extends '../../common/layouts/layout.tpl' %}
{% block css_assets %}
    <style>
    .reg-title-2 span{
    font-size:14px;
    color:#999;
    }
    </style>
{% endblock %}
{% block js_assets %}
    {#引入js#}
    <script>
layui.use(['form'],function(){
    var form = layui.form;
    form.verify({
        NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(!value){
                return $(item).attr("msg");
            }
        }
    });

    form.on('submit(create)',function(data){
        var datas = {
                    url: window.user.url,
             account_no: window.user.account_id,
            invite_code: data.field.invite_code
        };

        $.ajax({
            url:'',
            async: true,
            method:post,
            data:datas,
            dataType: "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (data) {
                if(data.status == 200){
                    $("#invite_url").val(data.datas);//data.datas 是 邀请链接
                }else{
                    return layer.msg(data.msg);
                }
            }
        });
    });
});
    </script>
{% endblock %}
{% block content %}
    {#html内容#}
    {#第一步#}
    <div class="register" id="first_page">
    <div class="register-title">
       {{ Lang.page_createinvite_dl_title || "开户链接 " }}
    </div>
    <div class="register-form">
        <form class="layui-form" action="">
            <div  class="layui-form-item">
                <label class="layui-form-label">{{ Lang.form_label_ib_type || "代理类型" }}:</label>
                <div class="layui-input-inline">
                    <select name="gender" lay-verify="NotBlank" msg="{{ Lang.validate_ib_type_not_chose || "请选择代理类型" }}">
                        {% for at in Lang.select.ib.register.account_type %}
                            <option value="{{ at.value }}">{{ at.label }}</option>
                        {% endfor %}
                    </select>
                </div>
                <button class="layui-btn" lay-submit="" lay-filter="create" onclick="return false;">{{ Lang.btn_create_link || "生成链接" }}</button>
            </div>

            <p class="reg-title-2">{{ Lang.form_text_sponsored_links || "推广链接" }}</p>
            <div  class="layui-form-item">
                <div class="layui-form-inline">
                    <input type="text" name="invite_url" id="invite_url"  autocomplete="off" class="layui-input">
                    <button class="layui-btn" lay-submit="" lay-filter="copy">{{ Lang.btn_copy || "复制" }}</button>
                    <button class="layui-btn" lay-submit="" lay-filter="QR_code">{{ Lang.btn_QRCode || "二维码" }}</button>
                </div>
            </div>
        </form>


    </div>
    </div>

{% endblock %}
