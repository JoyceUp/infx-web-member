<style>
    .reg-title-2 span {
        font-size: 14px;
        color: #999;
    }

    .statement a {
        color: #2681e2;
    }
</style>

<div class="register">
    <div class="register-title">
        <span>3</span>/3 {{ Lang.page_register_step_title || "真实账户注册" }}
    </div>
    <div class="register-form">
        <form class="layui-form" action="">
            <p class="reg-title-2">{{ Lang.form_text_investment_info || "投资信息" }}</p>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_job || "就业情况" }}:</label>
                        <div class="layui-input-block">
                            <select name="job" lay-verify="NotBlank" msg="{{ Lang.validate_job_not_null || "请选择就业情况" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.job %}
                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_capital_source || "资金来源" }}:</label>
                        <div class="layui-input-block">
                            <select name="capital_source" lay-verify="NotBlank" msg="{{ Lang.validate_capital_source_not_null || "请选择资金来源" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.capital_source %}
                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
            </div>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_annual_income || "年收入" }}:</label>
                        <div class="layui-input-block">
                            <select name="annual_income" lay-verify="NotBlank" msg="{{ Lang.validate_annual_income_not_null || "请选择年收入" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.annual_income %}
                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_total_asset || "总资产" }}:</label>
                        <div class="layui-input-block">
                            <select name="total_asset" lay-verify="NotBlank" msg="{{ Lang.validate_total_asset_not_null || "请选择总资产" }}">
                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                {% for item in Lang.select.member.register.total_asset %}
                                    <option value="{{ item.value }}">{{ item.label }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                </div>
            </div>

            <p class="reg-title-2 mt30">{{ Lang.form_text_experience || "交易经验及知识 " }}</p>
            <div class="layui-form-item switch-item">
                <div class="layui-input-block">
                    <input type="checkbox" name="experience" lay-skin="switch" lay-text="{{ Lang.btn_switch || "是|否" }}" lay-filter="exp_switch"/>
                    <span>{{ Lang.form_text_experience_span || "外汇，差价合约（CFDs）以及其他金融衍生品经验 。" }}</span>
                </div>
            </div>
            <div class="layui-form-item switch-item">
                <div class="layui-input-block">
                    <input type="checkbox" name="assess_risk" lay-skin="switch" title="" lay-text="{{ Lang.btn_switch || "是|否" }}" lay-filter="ass_switch" />
                    <span>{{ Lang.form_text_assess_risk_span || "我了解金融衍生品是我投资目标和风险投资的一部分，因此我能评估交易所涉及的风险，包括我所有投资资金的损失。" }}</span>
                </div>
            </div>
            <div class="layui-form-item switch-item">
                <div class="layui-input-block">
                    <input type="checkbox" name="professional" lay-skin="switch" lay-text="{{ Lang.btn_switch || "是|否" }}"
                           lay-filter="pro_switch"/>
                    <span>{{ Lang.form_text_professional_span || "关于金融和投资金融衍生品我有相关学术知识/专业知识。" }}</span>
                </div>
            </div>

            <p class="reg-title-2 mt30">{{ Lang.form_text_upload_img || "证件图片上传 " }}<span>{{ Lang.form_text_upload_img_span || "（目前只支持png、jpg格式，大小控制在2MB之内）" }}</span></p>

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12">

                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity1_path || "证件正面" }}:</label>
                        <div class="layui-input-block">
                            <input type="hidden" id="card_path" name="identity1_path" lay-verify="NotBlank"
                                   msg="{{ Lang.validate_identity1_path_not_null || "证件正面照片必须上传" }}"/>
                            <div class="layui-upload">
                                <button type="button" class="layui-btn" lay-filter="identity1_img1" id="btn_upload"
                                        onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                </button>
                                <div class="layui-upload-list">
                                    <img class="layui-upload-img" id="img_upload" src=""
                                         style="width:150px; height: 150px; display:none"/>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div id="card2_div" class="layui-col-md5 layui-col-xs12 layui-col-md-offset2 layui-col-xs-offset0">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><i>*</i>{{ Lang.form_text_identity2_path || "证件反面" }}:</label>
                        <div class="layui-input-block">
                            <input type="hidden" id="card_path2" name="identity2_path"/>
                            <div class="layui-upload">
                                <button type="button" class="layui-btn" id="btn_upload2" onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                </button>
                                <div class="layui-upload-list">
                                    <img class="layui-upload-img" id="img_upload2" src=""
                                         style="width:150px; height: 150px; display:none"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br/><br/>
            <hr/>
            <br/><br/>

            <div class="layui-form-item">
                <p class="layui-input-block statement" style="margin-left: 0px;">
                    <input type="checkbox" name="" lay-skin="primary" lay-filter="chekSound">
                    <span>{{ Lang.form_text_details_span || "我声明我已经仔细阅读并且了解以下条例 " }}
                        <a href="/assets/kh/file/cn/隐私声明.pdf" target="_blank">{{ Lang.form_text_privacy_statement_span || " 隐私声明。" }}</a>,
                       <a href="/assets/kh/file/cn/RISK WARNING.pdf" target="_blank"> {{ Lang.form_text_risk_warning_span || " Risk Warning" }}, </a>
                       <a href="/assets/kh/file/cn/Complaints handling procedure.pdf" target="_blank">{{ Lang.form_text_chp_span || " Complaints Handling Procedure " }}, </a>
                        <a href="/assets/kh/file/cn/legal Information.pdf" target="_blank">{{ Lang.form_text_legal_information_span || " Legal Information " }}, </a>
                       <a href="/assets/kh/file/cn/Privacy Policy.pdf" target="_blank"> {{ Lang.form_text_privacy_policy_span || " Privacy Policy " }}</a>
                        {{ Lang.form_text_agree_span || " 我完全明白并且同意。" }}</span>
                </p>
            </div>

            <div class="layui-form-item submit-item">
                <div class="layui-input-block">
                    <input type="hidden" name="id" id="user_id_3" value="" autocomplete="off" class="layui-input"/>
                    <input type="button" class="layui-btn layui-btn-primary" onclick="backStep(2)" value="{{ Lang.btn_previous || "上一步" }}"/>
                    <button class="layui-btn" lay-submit lay-filter="live3_next" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                </div>
            </div>
        </form>
    </div>
</div>

<input type="hidden" id="userID"/>

{% block js_assets %}
    <script>
        function resetUpload() {
            $("#card_path,#card_path2").val("");
            $("#img_upload,#img_upload2").attr("src", "");
        }

        function initUpload() {
            var identity1_path = $('input[name="identity1_path"]');
            var identity2_path = $('input[name="identity2_path"]');
            layui.use('upload', function () {
                var upload = layui.upload;
                //执行实例
                var uploadInstA = upload.render({
                    elem: '#btn_upload' //绑定元素
                    , url: '/common/upload/' //上传接口
                    , data: {role_type: 1, role_id: $('input[name="id"]').val()}
                    , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                    , accept: 'images' //允许上传的文件类型
                    , size: IsPC()? 2048:0 //最大允许上传的文件大小
                    , auto: false
                    , choose: function (obj) {
                        loading();
                        if (!IsPC()) {
                            obj.preview(function (index, file, result) {
                                var data = {role_type: 1, role_id: $('input[name="id"]').val()}
                                resizeImageUpload(file, data,identity1_path)
                            })
                        } else {
                            uploadInstA.upload()
                        }
                        obj.preview(function (index, file, result) {
                            $('#img_upload').attr('src', result); //图片链接（base64）
                            $('#img_upload').show()
                            //$('input[name="identity2_path"]').val(result);
                        });
                    }
                    , before: function (obj) {
                        //预读本地文件示例，不支持ie8
                    }
                    , done: function (res) {
                        jQuery("#address_path1").val(res.datas);
                        uploadSucc(res, identity1_path)
                    }
                    , error: function () {
                        closeLoading();
                        //演示失败状态，并实现重传
                        var txt_upload = $('#txt_upload');
                        txt_upload.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload">{{ Lang.msg_retry || "重试" }}</a>');
                        txt_upload.find('.demo-reload').on('click', function () {
                            uploadInstA.upload();
                        });
                    }
                });

                var uploadInstB =  upload.render({
                    elem: '#btn_upload2' //绑定元素
                    , url: '/common/upload/' //上传接口
                    , data: {role_type: 1, role_id: $('input[name="id"]').val()}
                    , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                    , accept: 'images' //允许上传的文件类型
                    , size: IsPC()? 2048:0 //最大允许上传的文件大小
                    , auto: false
                    , choose: function (obj) {
                        loading();
                        if (!IsPC() ) {
                            obj.preview(function (index, file, result) {
                                var data = {role_type: 1, role_id: $('input[name="id"]').val()};
                                resizeImageUpload(file,data,identity2_path)
                            })

                        } else {
                            uploadInstB.upload()
                        }

                        obj.preview(function (index, file, result) {
                            $('#img_upload2').attr('src', result); //图片链接（base64）
                            $('#img_upload2').show();
                            //$('input[name="identity2_path"]').val(result);
                        });

                    }
                    , before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        loading(); //上传loading
                    }
                    , done: function (res) {
                        uploadSucc(res,identity2_path);
                    }
                    , error: function () {
                        closeLoading();
                        //演示失败状态，并实现重传
                        var txt_upload = $('#txt_upload2');
                        txt_upload.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload">{{ Lang.msg_retry || "重试" }}</a>');
                        txt_upload.find('.demo-reload').on('click', function () {
                            uploadInst.upload();
                        });
                    }
                });
            });
        }

        layui.use('form', function () {
            var form = layui.form;

            // 自定义校验规则
            form.verify({
                NotBlank: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return $(item).attr("msg");
                    }
                }
            });

            //监听switch开关
            var exp_switch = 2;
            form.on('switch(exp_switch)', function (data) {
                exp_switch = data.othis[0].innerText == '{{ Lang.btn_yes || "是" }}' ? 1 : 2;
            });
            var ass_switch = 2;
            form.on('switch(ass_switch)', function (data) {
                ass_switch = data.othis[0].innerText == '{{ Lang.btn_yes || "是" }}' ? 1 : 2;
            });
            var pro_switch = 2;
            form.on('switch(pro_switch)', function (data) {
                pro_switch = data.othis[0].innerText == '{{ Lang.btn_yes || "是" }}' ? 1 : 2;
            });

            var flag = false;
            var i = 0;
            form.on('checkbox(chekSound)', function (data) {
                flag = data.elem.checked ? true : false
            });

            //监听提交
            form.on('submit(live3_next)', function (data) {
                if(identity_type == 1 && !$("#card_path2").val()){
                    layer.msg("{{ Lang.validate_identity2_path_not_null || "证件反面照片必须上传" }}", {icon: 5, time: 2000});
                    return false;
                }

                var datas = {
                    "id": data.field.id,
                    "job": parseInt(data.field.job),
                    "experience": exp_switch,
                    "capital_source": parseInt(data.field.capital_source),
                    "professional": pro_switch,
                    "annual_income": parseInt(data.field.annual_income),
                    "assess_risk": ass_switch,
                    "total_asset": parseInt(data.field.total_asset),
                    "identity1_path": data.field.identity1_path,
                    "identity2_path": data.field.identity2_path
                };
                if (flag) {
                    loading();
                    $.ajax({
                        url: '/member/reg/step3',
                        async: false,
                        data: datas,
                        type: 'POST',
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        success: function (data) {
                            closeLoading();
                            if (data.status == 200) {
                                // layer.msg(data.msg, {icon: 1});
                                var obj = JSON.parse(data.datas);
                                $('div#live3').attr('style', 'display: none;');
                                $('div#live4').attr('style', 'display: block;');
                                $('h4 em#res_acc').text(obj.account_no);
                                countDown(10, '/member/login');
                            } else if (data.status == 505) {
                                $('div#live3').attr('style', 'display: none;');
                                $('div#live4').attr('style', 'display: block;');
                                $('div.fail_page').removeClass('none');
                                $('div.succ_page').addClass('none');
                                $('em#res_err_acc').text(data.msg);
                            } else if (data.status == 508) {
                                $('div#live1').attr('style', 'display: block;');
                                $('div#live3').attr('style', 'display: none;');
                                layer.msg("{{ Lang.msg_request_timeout_back1 || "请求已超时，请返回第一步" }}", {icon: 5, time: 2000});
                            } else {
                                layer.msg(data.msg, {icon: 5, time: 2000});
                            }
                            //返回顶端
                            $("html,body").animate({
                                scrollTop: 0
                            }, 400); //点击go to top按钮时，以400的速度回到顶部，这里的400可以根据你的需求修改
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            closeLoading();
                        }
                    });
                } else {
                    layer.msg('{{ Lang.msg_check_register_file }}', {icon: 5, time: 2000});
                }
                return false;
            });

        });

    </script>
{% endblock %}