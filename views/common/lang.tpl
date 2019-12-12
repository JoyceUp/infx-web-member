<script>
    var msg_upload_error = "{{ Lang.msg_upload_error || "上传失败" }}"
        , passwordErrorMsg = "{{ Lang.validate_password_format_error || "密码格式错误，6-18位数字字母组合，可包含下划线" }}"
        , validate_is_identity_err = "{{ Lang.validate_is_identity_err || "身份证号格式错误" }}"
        , validate_is_identity_zip = "{{ Lang.validate_is_identity_zip || "地址编码错误" }}"
        , validate_is_identity_no_reg = "{{ Lang.validate_is_identity_no_reg || "该证件地区禁止注册" }}"
        , validate_is_identity_no_age = "{{ Lang.validate_is_identity_no_age || "18岁以下用户禁止注册" }}"
        , validate_is_identity_fail = "{{ Lang.validate_is_identity_fail || "身份证校验失败" }}"
        , validate_is_identity_null = "{{ Lang.validate_is_identity_null || "证件号码不能为空" }}"
        , validate_is_identity_passport_err = "{{ Lang.validate_is_identity_passport_err || "请输入正确的护照号" }}"
        , validate_captcha_err = "{{ Lang.validate_captcha_err || "验证码错误" }}"

        , table_layui_paging_goto = "{{ Lang.table_layui_paging_goto || "到第" }}"
        , table_layui_paging_page = "{{ Lang.table_layui_paging_page || "页" }}"
        , table_layui_paging_total = "{{ Lang.table_layui_paging_total || "共" }}"
        , table_layui_paging_item = "{{ Lang.table_layui_paging_item || "条" }}"
        , table_layui_paging_page_size = "{{ Lang.table_layui_paging_page_size || "条/页" }}"
        , table_layui_data_null = "{{ Lang.table_layui_data_null || "无数据" }}"
        , table_layui_data_request = "{{ Lang.table_layui_data_request || "Loading" }}"
        , btn_true = "{{ Lang.btn_true || "确定" }}"
        , btn_cancel = "{{ Lang.btn_cancel|| "取消" }}"
        , layui_data_api_err = "{{ Lang.layui_data_api_err || "数据接口请求异常" }}"

        , layui_validate_required_empty = "{{ Lang.validate_required_empty || "必填项不能为空" }}"
        , lang = "{{ Lang.lang  }}"
    var laylang = "en"
    if(lang=="zh"){
        laylang="cn"
    }else{
        laylang="en"
    }
</script>