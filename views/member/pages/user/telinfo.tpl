{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
{% endblock %}

{% block js_assets %}
    {# 引入js #}

    <script>
        //币种
        var currencyTypeMap = new Object();
        {% for at in Lang.select.member.funds.currency_type %}
        currencyTypeMap[{{ at.value }}] ="{{ at.label }}";
        {% endfor %}
        $('.bank_type_other').hide()
        var type = 1;
        var form;
        //查看详情
        function showDetail(id) {
            $("#cancel_btn").hide();
            $("#delete_btn").show();
            type = 2;
            $.ajax({
                url: '/member/customer/telinfo/info',
                async: true,
                data: {"id": id},
                type: 'post',
                dataType: 'json',
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success: function (data) {
                    if (data.status == 200) {
                        var deposit = JSON.parse(data.datas);
                        var currency = deposit.currency;
                        var full_name = deposit.card_user_name;
                        if(full_name == null || full_name =='null' ||full_name.length == 0){
                            full_name = window.user.full_name;
                        }
                        if(currency == 2){
                            $("#delete_btn").hide();
                            $("#cancel_btn").show();
                        }
                        $('input[name="id"]').val(deposit.id);
                        $('input[name="card_no"]').val(deposit.card_no);
                        $('.card_user_name').text(full_name);
                        $('.card_currency').text( currencyTypeMap[currency]);
                        $('.add_card_user_name').val($('div.laytable-cell-1-card_user_name')[1].innerText);
                        $('input[name="bank_name"]').val(deposit.bank_name);
                        $('input[name="add_card_currency"]').val(deposit.currency);
                        $('input[name="country"]').val(deposit.country);
                        $('input[name="province"]').val(deposit.province);
                        $('input[name="bank_type"]').val(deposit.bank_type);
                        $('input[name="city"]').val(deposit.city);
                        $('input[name="branch_name"]').val(deposit.branch_name);
                        $('input[name="branch_address"]').val(deposit.branch_address);
                        $('input[name="branch_swift_code"]').val(deposit.branch_swift_code);
                        $('input[name="bank_type_other"]').val(deposit.bank_type_other);
                        var num = deposit.bank_type;
                        if(num == 2){
                            $('.bank_type_other').show()
                            $('.add_bank_type_other').attr('lay-verify' ,"onlyEn")
                        }else{
                            $('.bank_type_other').hide()
                            $('.add_bank_type_other').removeAttr('lay-verify')
                        }
                        var numbers = $("#select_bank_type").find("option");
                        for (var j = 1; j < numbers.length; j++) {
                            if ($(numbers[j]).val() == num) {
                                $(numbers[j]).attr("selected", "selected");
                            }
                        }
                        layer.open({
                            type: 1,
                            title: "{{ Lang.form_text_tt_info || '电汇信息' }}",
                            area: ["800px", "80%"],
                            content: $("#detail"),
                            cancel: function(index, layero){
                                $("#reset_button").click();
                                layer.close(index);
                                deposit = "";
                                return false;
                            }
                        });
                        form.render('select');
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }
        //显示添加
        function showAdd() {
            $("#cancel_btn").show();
            $("#delete_btn").hide();
            type = 1;
            $('.card_currency').text( currencyTypeMap[type]);
            $('.card_user_name').text($('div.laytable-cell-1-card_user_name')[1].innerText);
            $('.add_card_user_name').val($('div.laytable-cell-1-card_user_name')[1].innerText);
            layer.open({
                type: 1,
                title: "{{ Lang.form_text_tt_info || '电汇信息' }}",
                area: '700px',
                content: $("#detail"),
                cancel: function(index, layero){
                    $("#reset_button").click();
                    layer.close(index);
                    return false;
                }
            });
        }

        layui.use(['form', 'table'], function () {
            form = layui.form;
            //列表
            var table = layui.table;
            tableIns = table.render({
                elem:"#telInfoList",
                url:'/member/customer/telinfo/list',
                method: 'post',
                done:function (data) {
                    console.log(data.datas.length)
                    if(data.datas.length >= 2 ){
                        $(".add-telinfo").hide();
                    }else if(data.datas.length == 1){
                        $(".add-telinfo").show();
                    }
                },
                cols:[[
                    {field:'order_no', title:'{{ Lang.table_serial_number || "序号"}}', align:'center', templet:function(d){
                            return d.LAY_INDEX;
                        }},
                    {field:'bank_name',title:'{{ Lang.form_label_bank_name || "银行名称"}}',align:'center'},
                    {field:'card_user_name',title:'{{ Lang.form_label_card_user_name || "账户"}}',align:'center'},
                    {field: 'card_no', title: '{{ Lang.form_label_bank_account_no || "账号"}}', align: 'center', templet: function (d) {
                        if(d.card_no) {
                            return '<a onclick="showDetail(\'' + d.id + '\')" href="javascript:;">' + d.card_no + '</a>';
                        }else{
                            return '';
                        }
                        }
                    },
                    {field:'currency', title:'{{Lang.table_currency || "币种" }}', align:'center', templet: function (d) {
                            return '<a onclick="showDetail(\'' + d.id + '\')" href="javascript:;">' + currencyTypeMap[d.currency] + '</a>';
                        }}
                ]],
                page: false,
                response:{
                    statusName:'status',
                    statusCode :200,
                    msgName:'msg',
                    countName:'count',
                    dataName:'datas'
                },
            });

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
                onlyEn: function(value, item) {
                    if(!value){
                        return $(item).attr("msg");
                    }

                    if(/[\u4E00-\u9FA5]/i.test(value)){
                        return '{{ Lang.validate_unchinese || "请输入非中文" }}'
                    }
                },
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });
            var flag = false;
            //监听提交
            form.on('submit(formSubmit)', function (data) {
                if(flag){
                    return false;
                }
                flag = true;
                var url = "/member/customer/telinfo/add";
                if(type == 1){

                }
                if(type == 2){
                    url = "/member/customer/telinfo/update";
                }
                jQuery.ajax({
                    url: url,
                    type: "POST",
                    dataType: "JSON",
                    data: JSON.stringify(data.field),
                    async: true,
                    error: function (result, status) {
                        flag = false;
                        layer.msg(result.msg, {
                            icon: 2
                        });
                        return false;
                    },
                    success: function (result, status) {
                        flag = false;
                        if(result.status === 200) {
                            if(type == 1){
                                layer.confirm('{{ Lang.alert_add_success || "添加成功" }}', {
                                    btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                                }, function(){
                                    cancel();
                                    tableIns.reload();
                                });
                            }else{
                                layer.confirm('{{ Lang.msg_update_success || "修改成功" }}', {
                                    btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                                }, function(){
                                    cancel();
                                    tableIns.reload();
                                });
                            }
                        }else{
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

            form.on('select(select_bank_type)', function(data){
                $('.bank_type').val(data.value)
                console.log($('.add_bank_type_other').val())
                if(data.value == 2){
                    $('.bank_type_other').show()
                    $('.add_bank_type_other').attr('lay-verify' ,"onlyEn")

                }else{
                    $('.bank_type_other').hide()
                    $('.add_bank_type_other').removeAttr('lay-verify')
                }
            });

            //监听删除
            form.on('submit(delete)', function (data) {
                layer.confirm('{{ Lang.open_confirm_delete_tt || "确定删除电汇信息" }}', {
                    btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                }, function(){
                    $.ajax({
                        url: "/member/customer/telinfo/delete",
                        async: true,
                        data: {"id": data.field.id},
                        type: 'post',
                        dataType: 'json',
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        success: function (result) {
                            if(result.status === 200) {
                                layer.confirm('{{ Lang.msg_delete_success || "删除成功" }}', {
                                    btn: ['{{ Lang.btn_true || "确定" }}'] //按钮
                                }, function(){
                                    cancel();
                                    tableIns.reload();
                                });
                            }else{
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
                            return false;
                        },
                    });
                });
                return false;
            });

        });
        function cancel(){
            $("#reset_button").click();
            layer.closeAll();
        }

    </script>

{% endblock %}

{% block content %}
    {# 内容 #}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_user_telinfo_title || "电汇信息" }}
                    </div>
                    <div class="main_head_text required" style="width: 100%; display: table">
                        <button class="layui-btn add-telinfo" style="float: right" lay-submit="" onclick="showAdd()">{{ Lang.button_add_to || "添加" }}</button>
                    </div>
                </div>
                <div class="main_page_Info">
                    <table class="layui-hide" id="telInfoList" lay-filter="dataTable"></table>
                    <div class="page"></div>
                </div>
            </div>
        </div>
    </div>

    {# 添加\修改 #}
    <div id="detail" class="dh-detail" style="display:none">
        <form class="layui-form form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}：</label>
                <div class="layui-input-block">
                    <input type="text" name="bank_name" lay-verify="onlyEn" msg="{{ Lang.validate_bank_name_not_null || "银行名称不能为空" }}"
                    autocomplete="off" class="layui-input"
                    value="{{ datas.bank_name }}"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "账号" }}：</label>
                <div class="layui-input-block">
                    <input type="hidden" name="id" value="{{ datas.id }}" />
                    <input type="text" name="card_no" lay-verify="card_no"
                           autocomplete="off" class="layui-input" value="{{ datas.card_no }}"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_card_user_name || "账户名称" }}：</label>
                <div class="layui-input-block">
                    <span class="card_user_name" style="line-height: 38px"></span>
                    <input type="hidden" name="add_card_user_name"
                           autocomplete="off" class="layui-input add_card_user_name"
                           value="{{ datas.add_card_user_name }}"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.table_currency || "币种" }}：</label>
                <div class="layui-input-block">
                    <span class="card_currency" style="line-height: 38px"></span>
                    <input type="hidden" name="add_card_currency"
                           autocomplete="off" class="layui-input add_card_currency"
                           value="{{ datas.currency }}"/>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_branch_swift_code || "Swift Code" }}：</label>
                <div class="layui-input-block">
                    <input type="text" name="branch_swift_code" lay-verify="onlyEn" msg="{{ Lang.validate_branch_swift_code_not_null || 'Swift Code不能为空' }}"
                    autocomplete="off" class="layui-input"
                    value="{{ datas.branch_swift_code }}"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_branch_name || "银行开户行" }}：</label>
                <div class="layui-input-block">
                    <input type="text" name="branch_name" lay-verify="onlyEn" msg="{{ Lang.validate_branch_name_not_null || "银行开户行不能为空" }}"
                    autocomplete="off" class="layui-input"
                    value="{{ datas.branch_name }}"/>
                </div>
            </div>

           <div class="layui-form-item">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_type || "储蓄账户类型" }}：</label>
                <div class="layui-input-block">
                    <input type="hidden" name="bank_type" class="bank_type" value="{{ datas.bank_type }}" />
                    <select id="select_bank_type" lay-filter="select_bank_type" lay-verify="onlyEn" msg="{{ Lang.form_msg_account_type || '请选择储蓄账户类型' }}">
                        <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                        {% for bank in Lang.select.member.register.bank_account_type %}
                            <option value="{{ bank.value }}">{{ bank.label }}</option>
                        {% endfor %}
                    </select>
                </div>
            </div>
            <div class="layui-form-item bank_type_other">
                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_other || "其他账户类型" }}：</label>
                <div class="layui-input-block">
                    <input type="text" class="add_bank_type_other layui-input" name="bank_type_other"  msg="{{ Lang.validate_other_account_type || '请输入其他帐户类型' }}"
                           autocomplete="off"  value="{{ datas.bank_type_other }}"/>
                </div>
            </div>
            <!--  <div class="layui-form-item">
                 <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_city || "地区（市）" }}：</label>
                 <div class="layui-input-block">
                     <input type="text" name="city" lay-verify="onlyEn" msg="{{ Lang.validate_bank_city_not_null || "地区（市）不能为空" }}"
                            autocomplete="off" class="layui-input" value="{{ datas.city }}"/>
                 </div>
             </div>



             <div class="layui-form-item">
                 <label class="layui-form-label"><i>*</i>{{ Lang.form_label_branch_address || "开户行地址" }}：</label>
                 <div class="layui-input-block">
                     <input type="text" name="branch_address" lay-verify="onlyEn" msg="{{ Lang.validate_branch_address_not_null || "开户行地址不能为空" }}"
                            autocomplete="off" class="layui-input"
                            value="{{ datas.branch_address }}"/>
                 </div>
             </div>-->


            <div class="layui-form-item mt50">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formSubmit" onclick="javascript:return false;">{{ Lang.btn_save || "保存" }}</button>
                    <input id="cancel_btn" class="layui-btn" style="display:none" type="button" onclick="cancel()" value="{{ Lang.btn_cancel || "取消" }}"/>

                    <button id="delete_btn" class="layui-btn" lay-submit lay-filter="delete" onclick="javascript:return false;">{{ Lang.btn_delete || "删除" }}{{ datas.currency }}</button>

                    <input type="reset" style="display: none;" id="reset_button" class="layui-btn layui-btn-primary" value="{{ Lang.btn_reset || "清空" }}"/>
                </div>
            </div>
        </form>
    </div>
{% endblock %}

