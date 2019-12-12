{% extends '../../common/layouts/layout.tpl' %}
{% set registerInfo =  Lang.select.ib.register %}
{% set myselect =  Lang.select.ib.userinfo %}
{% block content %}


    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_account_info_title || "个人资料" }}
                    </div>
                    <div class="main_head_text required"></div>
                </div>


                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">

                            <div class="layui-tab">
                                <ul class="layui-tab-title">
                                    <li {% if preferred === '' %}class="layui-this"{% endif %}>{{ Lang.form_text_base_info || "基本信息" }}</li>
                                    <li>{{ Lang.form_text_identity_info || "身份信息" }}</li>
                                    <li>{{ Lang.form_text_address_info || "居住信息" }}</li>
                                    {% if preferred == 'bank' %}
                                        <li class="layui-this">{{ Lang.form_text_bank_card_info || "银行卡信息" }}</li>
                                    {% else %}
                                        <li>{{ Lang.form_text_bank_card_info || "银行卡信息" }}</li>
                                    {% endif %}
                                    {% if preferred == 'tt' %}
                                        <li class="layui-this">{{ Lang.form_text_tt_info || "电汇信息" }}</li>
                                    {% else %}
                                        <li>{{ Lang.form_text_tt_info || "电汇信息" }}</li>
                                    {% endif %}
                                </ul>
                                <div class="layui-tab-content">
                                    {#基本信息#}
                                    {% if preferred == '' %}
                                    <div class="layui-tab-item layui-show">
                                    {% else %}
                                    <div class="layui-tab-item">
                                    {% endif %}
                                        <div class="form">
                                            <form class="layui-form" action="">

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_text_family_name || "姓" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">{{ datas.basic.family_name }}</div>
                                                    </div>

                                                    <label class="layui-form-label">{{ Lang.form_text_given_name || "名" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">{{ datas.basic.given_name }}</div>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_text_gender || "称呼" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">
                                                            {% for item in registerInfo.gender %}
                                                                {% if datas.basic.gender === item.value %}
                                                                    {{ item.label }}
                                                                {% endif %}
                                                            {% endfor %}
                                                        </div>
                                                    </div>

                                                    <label class="layui-form-label">{{ Lang.form_text_date_of_birth || "出生日期" }}</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">{{ datas.basic.date_of_birth }}</div>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_text_email || "电子邮箱" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">{{ datas.basic.email }}</div>
                                                    </div>

                                                    <label class="layui-form-label">{{ Lang.form_text_mobile || "手机号码" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <input value="{{ datas.basic.mobile }}" type="text"
                                                               name="mobile" lay-verify="mobile" autocomplete="off"
                                                               placeholder="{{ Lang.form_placeholder_mobile || "用于节日祝福和活动推送" }}" class="layui-input">
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <div class="layui-input-block">
                                                        <button class="layui-btn" lay-submit="" lay-filter="from_submit_1" onclick="return false;">{{ Lang.btn_save || "保存" }}</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_msg_h3 || "提示：" }}</h3>
                                            <p>
                                                {{ Lang.page_account_info_basics_msg_txt || "为了保障您的资金安全及权益，我们不允许主动修改您的姓名及出生日期等资料。如果您确实需要对以下内容进行修改，请提供必须的证明文件（如身份证，护照或社保卡等），将证明发送至我们的客户服务邮箱service@rtfgroups.com，邮件标题请注明为：“账户个人资料修改+您的账户编号”，或者致电我们的客服热线：400-002-8180，我们的客服人员会协助您完成操作。" }}</p>
                                        </div>
                                    </div>
                                    {#身份信息#}
                                    <div class="layui-tab-item">
                                        <div class="form">
                                            <form class="layui-form" action="">

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_text_identity_type || "证件类型" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">
                                                            {% for item in registerInfo.identity_type %}
                                                                {% if datas.basic.identity_type === item.value %}
                                                                    {{ item.label }}
                                                                {% endif %}
                                                            {% endfor %}
                                                        </div>
                                                    </div>

                                                    <label class="layui-form-label">{{ Lang.form_text_identity_no || "证件号码" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <div class="layui-form-mid">{{ datas.basic.identity_no | hideIdentityNo(datas.basic.identity_type) }}</div>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_text_identity1_path || "证件正面" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <span>
                                                            <img style="width:192px;height:132px"
                                                                 src="/assets/member/images/pic.png"
                                                                 onload="javascript:getImages(this,'{{ datas.basic.identity1_path }}');"/>
                                                        </span>
                                                    </div>
                                                    <label class="layui-form-label">{{ Lang.form_text_identity2_path || "证件反面" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <span>
                                                            <img style="width:192px;height:132px"
                                                                 src="/assets/member/images/pic.png"
                                                                 onload="javascript:getImages(this,'{{ datas.basic.identity2_path }}')"/>
                                                        </span>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_msg_h3 || "提示：" }}</h3>
                                            <p>
                                                {{ Lang.page_account_info_id_msg_txt || "为了保障您的资金安全及权益，我们不允许主动修改您的身份信息。如果您确实需要对以下内容进行修改，请提供必须的证明文件（如身份证，护照或社保卡等），将证明发送至我们的客户服务邮箱service@rtfgroups.com，邮件标题请注明为：“账户个人资料修改+您的账户编号”，或者致电我们的客服热线：400-002-8180，我们的客服人员会协助您完成操作。" }}
                                            </p>
                                        </div>
                                    </div>
                                    {#居住信息#}
                                    <div class="layui-tab-item">
                                        <div class="form">

                                            <form class="layui-form" action="">

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_text_country || "国家" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <select name="country" lay-verify="country">
                                                            <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>

                                                            {#{% for item in myselect.address.countries %}#}
                                                            {% for item in Lang.select.common.address.countries %}
                                                                {% if datas.address.country === item[1] %}
                                                                    <option value="{{ item[1] }}"
                                                                            selected="selected">{{ item[1] }}</option>
                                                                {% else %}
                                                                    <option value="{{ item[1] }}">{{ item[1] }}</option>
                                                                {% endif %}
                                                            {% endfor %}
                                                        </select>
                                                    </div>

                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_text_city || "城市" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <input value="{{ datas.address.city }}" type="text" name="city"
                                                               lay-verify="city" autocomplete="off"
                                                               placeholder="{{ Lang.form_placeholder_city || "请输入居住城市" }}" class="layui-input">
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_text_address || "居住地址" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <input value="{{ datas.address.address }}" type="text"
                                                               name="address" lay-verify="address" autocomplete="off"
                                                               placeholder="{{ Lang.form_placeholder_address || "请输入居住地址" }}" class="layui-input">
                                                    </div>
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_text_zip_code || "邮政编码" }}:</label>
                                                    <div class="layui-input-inline">
                                                        <input value="{{ datas.address.zip_code }}" type="text"
                                                               name="zip_code" lay-verify="zip_code" autocomplete="off"
                                                               placeholder="{{ Lang.form_placeholder_zip_code || "请输入邮政编码" }}" class="layui-input">
                                                    </div>
                                                </div>
                                                {#<div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_address || "地址证明" }}:</label>
                                                    <div class="layui-input-block">
                                                        <div class="layui-upload">
                                                            <button type="button" class="layui-btn" id="btn_upload" onclick="return false;">
                                                                {{ Lang.btn_uploadImg || "上传图片" }}
                                                            </button>
                                                            <div class="layui-upload-list">
                                                                <img class="layui-upload-img" id="img_upload"
                                                                     src="/assets/member/images/pic.png"
                                                                     onload="javascript:getImages(this, '{{ datas.address.path }}')"/>
                                                                <p id="txt_upload">{{ Lang.form_text_upload_img_limit || " 目前只支持png、jpg格式，大小控制在2MB之内 " }}</p>
                                                            </div>
                                                        </div>
                                                        <input type="hidden" id="address_path" name="path" lay-verify="path" value="{{ datas.address.path }}"/>
                                                        <input type="hidden" name="id" value="{{ datas.address.id }}"/>
                                                    </div>

                                                </div>#}

                                                <div class="layui-form-item">
                                                    <div class="layui-input-block">
                                                        <button class="layui-btn" lay-submit=""
                                                                lay-filter="from_submit_3" onclick="return false;">{{ Lang.btn_save || "保存" }}
                                                        </button>

                                                    </div>
                                                </div>
                                            </form>

                                        </div>

                                    </div>
                                    {#银行卡信息#}
                                    {% if preferred == 'bank' %}
                                    <div class="layui-tab-item layui-show">
                                    {% else %}
                                    <div class="layui-tab-item">
                                    {% endif %}
                                        <div class="form">
                                            <div class="fund-box">
                                                <div class="con-fund con-show clearfix my-bank-card-list">
                                                    {% for card in datas.bankcard.items %}
                                                        <div class="card-b rad4 brick my-bank-card"
                                                             id="card_{{ card.id }}">
                                                            <h1 class="clearfix rad1-2">
                                                                {% if banks.cn[card.bank_name] %}
                                                                    <span><img src="{{ banks.cn[card.bank_name].logo }}"></span>
                                                                {% else %}
                                                                    {#<span><img src="{{ myselect.banks.other.logo }}"></span>#}
                                                                {% endif %}
                                                                <span>{{ card.bank_name }}</span>
                                                                <a href="javascript:void(0);"
                                                                   class="car-btn rad2 del delete"
                                                                   onclick="javascript:delWindowOpen('{{ card.id }}');">{{ Lang.btn_delete || "删除" }}</a>
                                                                <a href="javascript:void(0);"
                                                                   class="car-btn rad2 revise btn1"
                                                                   onclick="javascript:showCardInfo('{{ card.id }}');">{{ Lang.btn_update || "修改" }}</a>
                                                            </h1>
                                                            <div class="info-c">
                                                                <p><strong>{{ Lang.form_label_card_no || "银行卡号" }}</strong>{{ card.card_no | hideBankCardNo }}</p>
                                                                <p><strong>{{ Lang.form_label_bank_account || "开户银行" }}</strong>{{ card.branch_name }}</p>
                                                            </div>
                                                        </div>
                                                    {% endfor %}

                                                    <div class="card-c rad4 btn1 card-b"
                                                         onclick="javascript:showCardInfo();"></div>

                                                </div>
                                            </div>
                                        </div>
                                        <div id="cardInfo" style="display:none">
                                            {% include "./bankinfo_card.tpl" %}
                                        </div>
                                    </div>
                                    {#电汇信息#}
                                    {% if preferred == 'tt' %}
                                    <div class="layui-tab-item layui-show">
                                    {% else %}
                                    <div class="layui-tab-item">
                                    {% endif %}
                                        <div class="form">

                                            {#注意要把name改成相关的字段名#}
                                            <form class="layui-form form w500" action="">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_card_no || "银行卡号" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="hidden" name="id" value="{{ datas.tt.id }}"/>
                                                        <input type="text" name="card_no"
                                                               lay-verify="tt_card_no"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.card_no }}"/>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_card_user_name || "银行账户户名" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="card_user_name"
                                                               lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_card_user_name_not_null || "银行账户户名不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.card_user_name }}"/>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="bank_name"
                                                               lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_bank_name_not_null || "银行名称不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.bank_name }}"/>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_country || "银行国家" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="country" lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_bank_country_not_null || "银行国家不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.country }}"/>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_province || "地区（省）" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="province"
                                                               lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_bank_province_not_null || "地区（省）不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.province }}"/>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_city || "地区（市）" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="city" lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_bank_city_not_null || "地区（市）不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.city }}"/>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_branch_name || "银行开户行" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="branch_name"
                                                               lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_branch_name_not_null || "银行开户行不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.branch_name }}"/>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_branch_address || "开户行地址" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="branch_address"
                                                               lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_branch_address_not_null || "开户行地址不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.branch_address }}"/>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_branch_swift_code || "国际汇款代码" }}：</label>
                                                    <div class="layui-input-block">
                                                        <input type="text" name="branch_swift_code"
                                                               lay-verify="NotBlank|onlyEn" msg="{{ Lang.validate_branch_swift_code_not_null || "国际汇款代码不能为空" }}"
                                                               autocomplete="off" class="layui-input"
                                                               value="{{ datas.tt.branch_swift_code }}"/>
                                                    </div>
                                                </div>


                                                <div class="layui-form-item mt50">
                                                    <div class="layui-input-block">
                                                        <button class="layui-btn" lay-submit lay-filter="ttSubmit" onclick="return false;">{{ Lang.btn_sub || "提交" }}
                                                        </button>

                                                    </div>
                                                </div>
                                            </form>

                                        </div>

                                        <div class="from_alert">
                                            <h3>{{ Lang.page_msg_h3 || "提示：" }}</h3>
                                            <p>{{ Lang.page_account_info_dh_msg_txt || "请正确填写属于您本人的电汇账号等银行信息，通常为英文或数字，请勿书写中文。" }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>



    <script>


        layui.use('upload', function () {
            var $ = layui.jquery
                , upload = layui.upload;

            //普通图片上传
            var uploadInst = upload.render({
                elem: '#btn_upload'
                , url: '/common/upload/'
                , data: {role_type: window.user.role_type, role_id: window.user.user_id}
                 //限制文件大小，单位 KB
                , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                , before: function (obj) {
                     layer.load(2); //上传loading
                    //预读本地文件示例，不支持ie8
                    obj.preview(function (index, file, result) {
                        $('#img_upload').attr('src', result); //图片链接（base64）
                    });
                }
                , done: function (res) {
                     layer.closeAll('loading'); //关闭loading
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('{{ Lang.msg_upload_error || "上传失败" }}');
                    }
                    //上传成功
                    if (res.status === 200) {
                        jQuery("#address_path").val(JSON.parse(res.datas).id);
                    }
                }
                , error: function () {
                    //演示失败状态，并实现重传
                    var txt_upload = $('#txt_upload');
                    txt_upload.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload">{{ Lang.msg_retry || "重试" }}</a>');
                    txt_upload.find('.demo-reload').on('click', function () {
                        uploadInst.upload();
                    });
                }
            });


        });

        layui.use('element', function () {
            var element = layui.element;

            //…
        });
    </script>


{% endblock %}

{% block js_assets %}

    <script type="text/javascript">

        var bank_logo = JSON.parse(jQuery.parseHTML("{{ datas.banksInfo }}")[0].data);

        //显示银行卡信息
        function showCardInfo(id) {
            if (null == id || "" == id || undefined == id) {
                var title = "{{ Lang.page_user_bankinfo_add_title || "添加银行卡" }}";
                emptyDialogData();
                showCardBox(title);

            } else {
                $.when(findCardData(id)).done(function (data) {
                    var title = "{{ Lang.page_user_bankinfo_up_title || "修改银行卡" }}";
                    showCardBox(title);

                });
            }
        }

        //
        function showCardBox(title) {
            layer.open({
                type: 1,
                title: title,
                area: ['1100px', 'auto'], //宽高
                content: $("#cardInfo"),
                success: function () {

                    initUpload()
                }
            });
        }

        //获取数据
        function findCardData(id) {

            var data = {"id": id};

            var defer = $.Deferred();
            jQuery.ajax({
                url: '/ib/account/info/bankcard/info',
                timeout: 2 * 60 * 1000,
                async: true,
                data: JSON.stringify(data),
                type: 'POST',
                dataType: 'JSON',
                contentType: "application/json; charset=\"utf-8\"",
                success: function (result, status) {
                    initDialogData(JSON.parse(result.datas));
                    defer.resolve(result);
                },
                error: function (result, status) {
                    defer.resolve();
                }
            });
            return defer.promise();
        }


        //删除银行卡
        function delWindowOpen(id) {
            if (jQuery(".my-bank-card").length < 2) {
                layer.msg("{{ Lang.msg_keep_a_bank_card || "请至少保留一张银行卡" }}", {
                    icon: 2
                });
                return;
            }
            layer.confirm('{{ Lang.open_confirm_delete_bank || "确定要删除该银行卡" }}', {
                btn: ['{{ Lang.btn_yes || "是" }}', '{{ Lang.btn_no || "否" }}'] //按钮
            }, function () {
                //是

                var data = {"id": id};
                jQuery.ajax({
                    url: '/ib/account/info/bankcard/delete',
                    timeout: 2 * 60 * 1000,
                    async: true,
                    data: JSON.stringify(data),
                    type: 'POST',
                    dataType: 'JSON',
                    contentType: "application/json; charset=\"utf-8\"",
                    success: function (result, status) {
                        if (result.status === 200) {
                            layer.msg("{{ Lang.msg_update_success || "修改成功" }}", {
                                icon: 1
                            });

                            jQuery("#card_" + id).remove();
                        }
                        else {
                            layer.msg(result.msg, {
                                icon: 0
                            });
                        }
                        return false;
                    },
                    error: function (result, status) {
                        layer.msg(result.msg, {
                            icon: 2
                        });
                    }
                });
            }, function () {
                //否
            });

        }

        //编辑页面银行卡数据
        function modifyCardList(data) {
            var logo = bank_logo.other.logo;
            if (bank_logo.cn[data.bank_name]) {
                logo = bank_logo.cn[data.bank_name].logo;
            }
            var innerHtml = "";
            innerHtml += "<h1 class=\"clearfix rad1-2\">";
            innerHtml += "<span><img src=\"" + logo + "\"></span>";
            innerHtml += "<span>" + data.bank_name + "</span>";
            innerHtml += "<a href=\"javascript:void(0);\" class=\"car-btn rad2 del delete\" onclick=\"javascript:delWindowOpen('" + data.id + "');\">{{ Lang.btn_delete || "删除" }}</a>";
            innerHtml += "<a href=\"javascript:void(0);\" class=\"car-btn rad2 revise btn1\" onclick=\"javascript:showCardInfo('" + data.id + "');\">{{ Lang.btn_update || "修改" }}</a>";
            innerHtml += "</h1>";
            innerHtml += "<div class=\"info-c\">";
            innerHtml += "<p><strong>{{ Lang.form_label_card_no || "银行卡号"}}</strong>" + data.card_no + "</p>";
            innerHtml += "<p><strong>{{ Lang.form_label_bank_account || "开户银行" }}</strong>" + data.branch_name + "</p>";
            innerHtml += "</div>";
            if (jQuery("#card_" + data.id).length > 0) {
                jQuery("#card_" + data.id).html(innerHtml);
            } else {
                var outerHtml = ("<div class=\"card-b rad4 brick my-bank-card\" id=\"card_" + data.id + "\">");
                outerHtml += innerHtml;
                outerHtml += "</div>";
                jQuery(".my-bank-card-list .card-c").before(outerHtml);
            }
        }
    </script>
    <script>
        layui.use('form', function () {
            var form = layui.form;


            //自定义验证规则
            form.verify({
                card_no: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_card_no_not_null || "请填写银行卡号" }}';
                    }
                    if (!(/^(\d)*$/.test(value))) {
                        return '{{ Lang.validate_card_no_only_number || "银行卡号只能输入数字" }}';
                    }
                },
                tt_card_no: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_card_no_not_null || "请填写银行卡号" }}';
                    }
                    if (!(/^(\d)*$/.test(value))) {
                        return '{{ Lang.validate_card_no_only_number || "银行卡号只能输入数字" }}';
                    }
                },
                mobile: function(value){
                    if(value.trim() != '' && !mobileReg.test(value)){
                        return '{{ Lang.validate_mobile_format_error || "手机号码格式有误" }}';
                    }
                },
                country: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_country_not_null || "请选择居住国家" }}';
                    }
                },
                city: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_city_not_null || "请输入城市" }}';
                    }
                },
                address: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_address_not_null || "请输入居住地址" }}';
                    }
                },
                zip_code: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_zip_code_not_null || "请输入邮政编码" }}';
                    }
                    ;
                    if (!(/^\d{6}$/.test(value))) {
                        return '{{ Lang.validate_zip_format_error || "邮政编码有误" }}';
                    }
                    ;
                },
                path: function (value) {
                    if (value.length === 0) {
                        return '{{ Lang.validate_path_not_null || "请上传地址证明" }}';
                    }
                },
                onlyEn: function(value) {
                    if(/[\u4E00-\u9FA5]/i.test(value)){
                        return "{{ Lang.validate_unchinese || "请输入非中文" }}"
                    }
                },
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }

            });

            //监听提交基本信息
            form.on('submit(from_submit_1)', function (data) {

                data.field.id = window.user.user_id;

                jQuery.ajax({
                    url: "/ib/account/info/basic/update",
                    type: "POST",
                    dataType: "JSON",
                    data: JSON.stringify(data.field),
                    async: true,
                    error: function (result, status) {

                        layer.msg(result.msg, {
                            icon: 2
                        });
                        return false;
                    },
                    success: function (result, status) {
                        if (result.status === 200) {
                            layer.msg("{{ Lang.msg_update_success || "修改成功" }}", {
                                icon: 1
                            });
                        }
                        else {
                            layer.msg(result.msg, {
                                icon: 0
                            });
                        }
                        return false;
                    },
                    contentType: "application/json; charset=\"utf-8\""
                });

                return false;
            });
            //监听提交地址信息
            form.on('submit(from_submit_3)', function (data) {

                jQuery.ajax({
                    url: "/ib/account/info/address/update",
                    type: "POST",
                    dataType: "JSON",
                    data: JSON.stringify(data.field),
                    async: true,
                    error: function (result, status) {
                        layer.msg(result.msg, {
                            icon: 2
                        });
                        return false;
                    },
                    success: function (result, status) {
                        if (result.status === 200) {
                            layer.msg("{{ Lang.msg_update_success || "修改成功" }}", {
                                icon: 1
                            });
                        }
                        else {
                            layer.msg(result.msg, {
                                icon: 0
                            });
                        }
                        return false;
                    },
                    contentType: "application/json; charset=\"utf-8\""
                });

                return false;
            });

            //监听提交电汇信息
            form.on('submit(ttSubmit)', function (data) {

                var url = (data.field.id && data.field.id.length > 0) ? "/ib/account/info/tt/update" : "/ib/account/info/tt/add";
                jQuery.ajax({
                    url: url,
                    type: "POST",
                    dataType: "JSON",
                    data: JSON.stringify(data.field),
                    async: true,
                    error: function (result, status) {
                        layer.msg(result.msg, {
                            icon: 2
                        });
                        return false;
                    },
                    success: function (result, status) {
                        if (result.status === 200) {
                            layer.msg("{{ Lang.msg_update_success || "修改成功" }}", {
                                icon: 1
                            });
                        }
                        else {
                            layer.msg(result.msg, {
                                icon: 0
                            });

                        }
                        return false;
                    },
                    contentType: "application/json; charset=\"utf-8\""
                });

                return false;
            });
        });
    </script>

{% endblock %}