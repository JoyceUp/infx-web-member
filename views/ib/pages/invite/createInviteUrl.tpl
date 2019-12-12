{% extends '../../common/layouts/layout.tpl' %}
{% block content %}
    <div class="main_content">
        <div class="main_content_holder">

            <div class="register" id="first_page">
                <div class="register-title main_head_unit">
                    {{ Lang.page_ib_invite_title || "开户链接" }}
                </div>
                <div class="register-form" style="padding: 30px 0;">
                    <form class="layui-form" action="">
                        <div class="layui-form-item">
                            <label class="layui-form-label">{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                            <div class="layui-input-inline">
                                <select name="account_type" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择账号" }}">
                                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                    {% for ac in account %}
                                        <option value="{{ ac.account_type }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                    {% endfor %}
                                </select>
                            </div>
                            <button class="layui-btn" lay-submit="" lay-filter="create">{{ Lang.btn_create_link || "生成链接" }}</button>
                        </div>

                        <div style="display:none" id="invite_info">
                            <p class="reg-title-2">{{ Lang.form_text_sponsored_links || "推广链接" }}</p>
                            <div class="layui-form-item">
                                <div class="layui-form-inline">
                                    <!-- Target -->
                                    <input id="invite_url" name="invite_url" style="width:400px">

                                    <!-- Trigger -->
                                    <button class="clipboard_btn layui-btn" data-clipboard-action="copy" data-clipboard-target="#invite_url" onclick="return false;">
                                        {{ Lang.btn_copy || "复制" }}
                                    </button>
                                    <input type="button" class="layui-btn" onclick="createQRCode()" value="{{ Lang.btn_QRCode || "二维码" }}"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div id="qrcode" class="qrcode"></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

{% endblock %}

{% block js_assets %}
    <script src="/assets/vendors/clipboard/dist/clipboard.js"></script>
    <script type="text/javascript" src="/assets/vendors/qrcode/qrcode.js"></script>
    <script>
        layui.use(['form'], function () {
            var form = layui.form;

            form.verify({
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });

            form.on('submit(create)', function (data) {
                $.ajax({
                    url: '/ib/invite/info',
                    async: true,
                    data: data.field,
                    type: "post",
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        if (data.status == 200) {
                            var url = JSON.parse(data.datas).url
                            var path = url.split("com")[1]
                            $("#invite_url").val("http://"+window.location.host+path);//data.datas 是 邀请链接
                       //     $("#invite_url").val(JSON.parse(data.datas).url);
                            $("#invite_info").show();
                        } else {
                            return layer.msg(data.msg);
                        }
                    }
                });
                return false;
            });
        });


        //复制到剪贴板
        var clipboard = new Clipboard('.clipboard_btn');

        clipboard.on('success', function(e) {
            console.info('Action:', e.action);
            console.info('Text:', e.text);
            console.info('Trigger:', e.trigger);
            layer.tips('{{ Lang.tips_copy_success || "复制成功" }}', '.clipboard_btn');
            e.clearSelection();
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