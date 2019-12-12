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
    <script src="/assets/vendors/clipboard/dist/clipboard.js"></script>
    <script type="text/javascript" src="/assets/vendors/qrcode/qrcode.js"></script>
    {#引入js#}
    <script>

    $(function () {
        creatLink()
    })
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
               /* var datas = {
                    //url: window.user.url,
                    //account_no: window.user.account_id,
                    ／／type: data.field.type
                };*/
                $.ajax({
                    url:'/sale/invite/info',
                    async: true,
                    type:'post',
                   // data:datas,
                    dataType: "json",
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    success: function (data) {
                        if(data.status == 200){
                            $("#div_url").show();
                            var url = JSON.parse(data.datas).url
                            var path = url.split("com")[1]
                            $("#invite_url").val("http://"+window.location.host+path);//data.datas 是 邀请链接
                        }else{
                            return layer.msg(data.msg);
                        }
                        return false;
                    },
                    error:function (data) {
                        return false;
                    }
                });
                return false;
            });

        });


        function creatLink() {
            $.ajax({
                url:'/sale/invite/info',
                async: true,
                type:'post',
                // data:datas,
                dataType: "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (data) {
                    if(data.status == 200){
                        $("#div_url").show();
                        var url = JSON.parse(data.datas).url
                        var path = url.split("com")[1]
                        $("#invite_url").val("http://"+window.location.host+path);//data.datas 是 邀请链接
                    }else{
                        return layer.msg(data.msg);
                    }
                    return false;
                },
                error:function (data) {
                    return false;
                }
            });
        }


        //复制到剪贴板
        var clipboard = new Clipboard('.clipboard_btn');

        clipboard.on('success', function(e) {
            console.info('Action:', e.action);
            console.info('Text:', e.text);
            console.info('Trigger:', e.trigger);
            layer.tips('{{ Lang.tips_copy_success || "复制成功" }}', '.clipboard_btn');
            // e.clearSelection();
        });

        clipboard.on('error', function(e) {
            console.error('Action:', e.action);
            console.error('Trigger:', e.trigger);
        });



        function createQRCode() {

            $(".qrcode canvas").remove();
            $(".qrcode img").remove();
            // new QRCode(document.getElementById("qrcode"), $("#invite_url").val());
            var qrcode = new QRCode("qrcode", {
                text: $("#invite_url").val(),
                width: 128,
                height: 128,
                colorDark : "#000000",
                colorLight : "#ffffff",
                correctLevel : QRCode.CorrectLevel.H
            });
            // qrcode.clear(); // 清除代码
            // qrcode.makeCode("http://www.w3cschool.cc"); // 生成另外一个二维码
            return false;
        }
    </script>
{% endblock %}


{% block content %}
    {#html内容#}
<div class="main_content">
    <div class="main_content_holder">
        <div class="main_head_unit">
            {{ Lang.menu_sale_invitation || "邀请管理" }}
        </div>
        <div id="search_box">
            <form class="layui-form" action="">
                <div  class="layui-form-item">
                   {# <label class="layui-form-label"><i>*</i>{{ Lang.form_label_invite_type || "邀请类型" }}:</label>
                    <div class="layui-input-inline">
                        <select name="type" lay-verify="NotBlank" msg="{{ Lang.validate_invite_type_not_chose || "请选择邀请类型" }}">
                            <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                            {% for at in Lang.select.sale.invite_type %}
                                <option value="{{ at.value }}">{{ at.label }}</option>
                            {% endfor %}
                        </select>
                    </div>#}
                    {#<button class="layui-btn" lay-submit="" lay-filter="create" onclick="return false;" style="vertical-align: top;">{{ Lang.btn_create_link || "生成链接" }}</button>#}
                </div>

                <div id="div_url" style="display:none" class="layui-form-item">
                    <p class="reg-title-2">{{ Lang.form_text_sponsored_links || "推广链接" }}</p>
                    <div class="layui-form-inline">
                        <!-- Target -->
                        <input id="invite_url" name="invite_url" style="width:400px">

                        <!-- Trigger -->
                        <button class="clipboard_btn layui-btn" data-clipboard-action="copy" data-clipboard-target="#invite_url" onclick="return false;">
                          {{ Lang.btn_copy || "复制" }}
                        </button>

                        <input type="hidden" class="layui-btn" onclick="createQRCode()" value="{{ Lang.btn_QRCode || "二维码" }}"/>
                    </div>
                    <div class="layui-form-item">
                        <div id="qrcode" class="qrcode"></div>
                    </div>
                </div>
            </form>
        </div>
</div>
    </div>


{% endblock %}
