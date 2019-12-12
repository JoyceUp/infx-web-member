<div class="form bank_card">
    <form class="layui-form" action="">

        <div class="layui-form-item">
            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_country || "银行国家" }}:</label>
            <div class="layui-input-inline">

                <input type="hidden" name="id" id="card_id"/>
                <select name="country" lay-verify="country" lay-filter="country">
                    <option value="{{ Lang.form_select_china || "中国" }}">{{ Lang.form_select_china }}</option>
                </select>
            </div>

            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_province_ || "银行省" }}:</label>
            <div class="layui-input-inline">
                <select id="card_province" name="province" lay-verify="province" lay-filter="province"  lay-search="" >
                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>

                </select>
            </div>

            <label class="layui-form-label" id="city_label"><i>*</i>{{ Lang.form_label_bank_city_ || "银行城市" }}:</label>
            <div class="layui-input-inline">
                <select id="card_city" name="city" lay-verify="city" lay-filter="city"  lay-search="">
                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><i>*</i>{{Lang.form_label_bank_name || "银行名称"}}:</label>
            <div class="layui-input-inline">
                <select id="card_bank_name" name="bank_name" lay-filter="bank_name" lay-verify="bank_name"  lay-search="">
                    <option value="">{{Lang.form_select_invite_type || "请选择"}}</option>
                    {% for bank in banks.cn %}
                        <option value="{{ loop.key }}">{{ loop.key }}</option>
                    {% endfor %}
                    <option value="other">{{Lang.form_select_other || "其它"}}</option>
                </select>
            </div>

            <label class="layui-form-label"><i>*</i>{{Lang.form_label_branch_name_ || "支行名称"}}:</label>
            <div class="layui-input-inline">
                <input type="text" id="card_branch_name" name="branch_name" lay-verify="branch_name" autocomplete="off"
                       placeholder=""
                       class="layui-input">
            </div>


            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_card_no || "银行卡号"}}:</label>
            <div class="layui-input-inline">
                <input type="text" id="card_card_no" name="card_no" lay-verify="card_no" autocomplete="off"
                       placeholder=""
                       class="layui-input">
            </div>


        </div>

        <div class="layui-form-item" >
            <div id="other_bank" style="display: none">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}:</label>
                <div class="layui-input-inline">
                    <input type="text" id="other_bank_name" name="other_bank_name" lay-verify="other_bank_name" autocomplete="off"
                           placeholder=""
                           class="layui-input">
                </div>
            </div>


        </div>


        <div class="layui-form-item">
            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_card_front || "卡片正面"}}:</label>
            <div class="layui-input-block">
                <input type="hidden" id="card_path_bank_card" name="path" lay-verify="bankimgpath" value=""/>
                <div class="layui-upload">
                    <button type="button" class="layui-btn" id="btn_upload_bank_card">{{ Lang.btn_uploadImg || "上传图片" }}</button>
                    <div class="layui-upload-list" id="card_list">
                        <img class="layui-upload-img" id="img_upload_bank_card" src="/assets/member/images/pic.png"/>
                        <p id="txt_upload_bank_card">{{ Lang.form_text_upload_img_limit || " 目前只支持png、jpg格式，大小控制在2MB之内 " }}</p>
                    </div>
                </div>
            </div>

        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="formSubmit" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                <button type="reset" style="display: none;" id="bank_form_reset_button" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>

            </div>
        </div>
    </form>
</div>



<script type="text/javascript" src="/assets/vendors/layui/area.js"></script>


<script>
    //初始数据
    var areaData = Area;
    var $form;
    var form;
    var $;

    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form,
            layer = layui.layer,
            $ = layui.jquery,

            $form = $('form');
        loadProvince();


        //加载省数据
        function loadProvince() {

            if (jQuery("#card_province option").length > 5) {
                return;
            }


            var proHtml = '';
            for (var i = 0; i < areaData.length; i++) {
                proHtml += '<option value="' + areaData[i].provinceName + '_' + areaData[i].mallCityList.length + '_' + i + '">' + areaData[i].provinceName + '</option>';
            }
            //初始化省数据
            $form.find('select[name=province]').append(proHtml);
            form.render();
            form.on('select(province)', function (data) {
                $form.find('select[name=area]').html('<option value="">{{ Lang.dropdown_choose_city || "请选择县/区" }}</option>').parent().hide();
                var value = data.value;
                var d = value.split('_');
                var code = d[0];
                var count = d[1];
                var index = d[2];
                if (count > 0) {
                    loadCity(areaData[index].mallCityList);
                } else {
                    $form.find('select[name=city]').parent().hide();
                }
            });
        }

        //加载市数据
        function loadCity(citys) {
            var cityHtml = '';
            for (var i = 0; i < citys.length; i++) {
                cityHtml += '<option value="' + citys[i].cityName + '">' + citys[i].cityName + '</option>';
            }
            $form.find('select[name=city]').html(cityHtml).parent().show();
            form.render();
            form.on('select(city)', function (data) {
                var value = data.value;
                var d = value.split('_');
                var code = d[0];
                var count = d[1];
                var index = d[2];
            });
        }


        var is_other_bank=false

        form.on('select(bank_name)', function (data) {

            var value = data.value;

            if (value == "other") {
                is_other_bank=true
                $("#other_bank_name").val("");
                $("#other_bank").show()
            }else{
                is_other_bank=false
                $("#other_bank").hide()
            }
        });


        //自定义验证规则
        form.verify({
            country: function (value) {
                if (value.length === 0 || (/^\s+$/.test(value))) {
                    return '{{ Lang.validate_bank_country_not_chose || "请选择银行国家" }}';
                }
            },
            province: function (value) {
                if (value.length === 0 || (/^\s+$/.test(value))) {
                    return '{{ Lang.validate_bank_province_not_chose || "请选择银行省" }}';
                }
            },
            city: function (value) {
                if (value.length === 0 || (/^\s+$/.test(value))) {
                    return '{{ Lang.validate_bank_city_not_chose || "请选择银行市" }}';
                }
            },
            bank_name: function (value) {
                if (value.length === 0 || (/^\s+$/.test(value))) {
                    return '{{ Lang.validate_bank_name_not_chose || "请选择银行名称" }}';
                }
            },
            branch_name: function (value) {
                if (value.length === 0 || (/^\s+$/.test(value))) {
                    return '{{ Lang.validate_branch_name_not_null_please || "请填写支行名称" }}';
                }
            },
            other_bank_name: function (value) {
                if(is_other_bank ==true){
                    if (value.length === 0 || (/^\s+$/.test(value)) ) {
                        return '{{ Lang.validate_bank_name_not_null || "银行名称不能为空" }}';
                    }
                }

            },
            card_no: function (value) {
                if (value.length === 0 || (/^\s+$/.test(value))) {
                    return '{{ Lang.validate_card_no_not_null || "请填写银行卡号" }}';
                }
                if (!(/^([1-9]{1})(\d{15}|\d{18})$/.test(value))) {
                    return '{{ Lang.validate_card_no_format_error || "请填写正确的银行卡号" }}';
                }

            },
            bankimgpath: function (value) {
                if (value.length === 0) {
                    return '{{ Lang.validate_bank_img_path_not_null || "请上传银行卡图片" }}';
                }
            }

        });

        //监听提交
        form.on('submit(formSubmit)', function (data) {
            data.field.province = data.field.province.split('_')[0];

            var url = "/ib/account/info/bankcard/add";
            var type = 0;
            if(data.field.id && data.field.id.length > 0){
                url = "/ib/account/info/bankcard/update";
                type = 1;
            }

            if( data.field.bank_name == "other"){
                data.field.bank_name = data.field.other_bank_name
            }

            jQuery.ajax({
                url: url,
                type: "POST",
                dataType: "JSON",
                data: JSON.stringify(data.field),
                async: true,
                error: function (xData, status) {
                    layer.msg(xData.msg, {
                        icon: 2
                    });
                    return false;
                },
                success: function (xData, status) {
                    if (xData.status === 200) {
                        var card = data.field;
                        if (!card.id || card.id.length === 0) {
                            card.id = xData.datas;
                        }

                        modifyCardList(card);
                        if(type == 0){
                            layer.msg("{{ Lang.alert_add_success || "添加成功" }}", {
                                icon: 1
                            });
                        }else{
                            layer.msg("{{ Lang.msg_update_success || "修改成功" }}", {
                                icon: 1
                            });
                        }
                        jQuery(".layui-layer-ico").click();
                    }
                    else {
                        layer.msg(xData.msg, {
                            icon: 0
                        });
                    }
                    return false;
                },
                contentType: "application/json; charset=\"utf-8\""
            });

            // layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // });
            return false;

        });


    });
    var flag = true;
    function initUpload() {
        if(flag){
            flag = false;
        }else{
            return true;
        }

        if (jQuery("#card_list .layui-upload-file").length > 0) {
            return false;
        }
        var img_base64;
        layui.use('upload', function () {
            var $ = layui.jquery
                , upload = layui.upload;
            //普通图片上传
            var uploadInst = upload.render({
                elem: '#btn_upload_bank_card'
                , url: '/common/upload/'
                , data: {role_type: window.user.role_type, role_id: window.user.user_id}
                 //限制文件大小，单位 KB
                , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                , before: function (obj) {
                    //预读本地文件示例，不支持ie8
                    layer.load(2); //上传loading
                    obj.preview(function (index, file, result) {
                        img_base64 = result;
                        // $('#img_upload_bank_card').attr('src', result); //图片链接（base64）
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
                        jQuery("#card_path_bank_card").val(JSON.parse(res.datas).id);
                        $('#img_upload_bank_card').attr('src', img_base64); //图片链接（base64）
                    }
                }
                , error: function () {
                    //演示失败状态，并实现重传
                    var txt_upload = $('#txt_upload_bank_card');
                    txt_upload.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload_bank_card">{{ Lang.msg_retry || "重试" }}</a>');
                    txt_upload.find('.demo-reload_bank_card').on('click', function () {
                        uploadInst.upload();
                    });
                }
            });


        });
    }

    var bank_option = JSON.parse(jQuery.parseHTML("{{ datas.banksInfo }}")[0].data);
    function initDialogData(data) {
        if (data && data.id.length > 0) {
            jQuery("#img_upload_bank_card").attr("src", "/assets/member/images/pic.png");
            jQuery("#card_id").val(data.id);

            var province = jQuery("#card_province option[value*='" + data.province + "']").val();
            jQuery("#card_branch_name").val(data.branch_name);
            jQuery("#card_card_no").val(data.card_no);

            jQuery("#card_province").val(province);
            jQuery("dd[lay-value='" + province + "']").click();

            jQuery("#card_city").val(data.city);
            jQuery("dd[lay-value='" + data.city + "']").click();

            if(bank_option.cn[data.bank_name]){

                jQuery("#card_bank_name").val(data.bank_name);
            }else{

                $("#card_bank_name").val("other");

                $("#other_bank").show()
                $("#other_bank_name").val(data.bank_name);
                form.render('select');
            }


            jQuery("dd[lay-value='" + data.bank_name + "']").click();

            jQuery("#card_path_bank_card").val(data.path);
            getImages(jQuery("#img_upload_bank_card"), data.path);
        }
        else {
            emptyDialogData();
        }
    }

    function emptyDialogData() {

        $("#card_id").val("");
        // $("#card_province").val("");
        // $("#card_city").val("");
        // $("#card_bank_name").val("");
        $("#card_branch_name").val("");
        $("#card_card_no").val("");


        $("#card_city").val("");
        $("#img_upload_bank_card").attr("src", "/assets/member/images/pic.png");
        $("#card_path_bank_card").val("");
        $("#bank_form_reset_button").click();
        form.render();      //重新渲染form组建
    }


</script>