{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
{% endblock %}

{% block js_assets %}
    {# 引入js #}

    <script>
        var current_balance = 0;
        var form;
        layui.use(['form'], function () {
            form = layui.form;

            form.verify({
                balance: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return "{{ Lang.validate_transfer_amount_not_null || "请填写转账金额" }}";
                    }
                    if(!/^[0-9.]*$/.test(value)){
                        return "{{ Lang.validate_transfer_amount_only_number || "转账金额必须为数字！" }}!";
                    }
                    if(value < 1){
                        return "{{ Lang.validate_transfer_amount_minimum || "转账金额不能低于1美元" }}";
                    }
                    if(current_balance < value){
                        return "{{ Lang.validate_transfer_amount_more_than_the_balance || "转账金额不能大于账户可用余额" }}";
                    }
                },
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                },
                differentAccount: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(value == $("#account_id_from").val()){
                        return "{{ Lang.validate_transfer_from_account_is_to_account || "转入账户不能和转出账户一样" }}";
                    }
                }
            });

            form.on('select(account_id_from)', function(data){
                // console.log(data.elem); //得到checkbox原始DOM对象
                // console.log(data.elem.checked); //开关是否开启，true或者false
                // console.log(data.value); //开关value值，也可以通过data.elem.value得到
                // console.log(data.othis); //得到美化后的DOM对象
                if(data.value) {
                    $("#balanceItem").show()
                    getAccountBalance(data.value.split(',')[0]);
                }else{
                    $("#balanceItem").hide()
                }
            });
            //监听提交转账
            form.on('submit(formSubmit)', function (data) {
                showConfirm(data.field);
                return false;
            });

            //监听确认
            form.on('submit(confirm)', function (data) {
                submit(data.field);
                return false;
            });
        });
        var submit_f = false;
        function submit(data) {
            if(submit_f){
                return false;
            }
            submit_f = true;
            $.ajax({
                url: "/ib/funds/transfer/submit_transfer",
                async: true,
                data: data,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    submit_f = false;
                    if (data.status == 200) {
                        layer.alert("{{ Lang.alert_transfer_submit_success1 || "您的转账请求已被系统接收，我们的工作人员将会尽快为您办理，请耐心等待。" }}<br/>" +
                            "<a href=\"/ib/funds/transfer_record\">{{ Lang.alert_transfer_submit_success2 || "若您需要取消，请点击此处进行操作。" }}</a>", {
                            title: '{{ Lang.alert_title_info || "信息" }}'
                            ,closeBtn: 0    //是否显示关闭按钮,0隐藏 1显示
                        }, function (index) {
                            $("#account_balance").html("$0.00");
                            $("#transfer_form_reset_button").click();
                            layer.closeAll();
                        });
                    } else {
                        layer.alert(data.msg, {
                            title: '{{ Lang.alert_title_info || "信息" }}'
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }
        function showConfirm(data) {
            //转出账号
            var account_from = data.account_from.split(",");
            $("#account_id_from_confirm_show").html(account_from[1]);
            $("#account_id_from_confirm_hidden").val(account_from[0]);
            //转入账号
            var account_to = data.account_to.split(",");
            $("#account_id_to_confirm_show").html(account_to[1]);
            $("#account_id_to_confirm_hidden").val(account_to[0]);
            //支付金额
            $("#transfer_amount_confirm_show").html(data.transfer_amount);
            $("#transfer_amount_confirm_hidden").val(data.transfer_amount);

            layer.open({
                type:1,
                title:'{{ Lang.dialog_transfer_confirm || "转账订单确认" }}',
                area:['500px', 'auto'],
                content:$('#confirm')
            });
        }
        function closeConfirm() {
            layer.closeAll();
        }

        function getAccountBalance(id) {
            $.ajax({
                url: "/ib/account/mt/balance",
                async: true,
                data: {id: id},
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        current_balance = data.datas.balance / 100;
                        $("#account_balance").html("$" + current_balance);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        function keepMoney(obj) {
            var A = $(obj);
            var value = A.val();
            if (value == "-" || value == "") {
                A.attr("lastValue", "");
                A.val("");
                return true;
            }
            var reg = new RegExp(/^\d{1,12}(\.\d{0,2}$|$)/);
            var lastValue = A.attr("lastValue") || "";
            var flag = reg.test(value);
            if (flag) {
                lastValue = value;
                A.attr("lastValue", lastValue);
                return lastValue;
            } else {
                A.val(lastValue);
                return lastValue;
            }
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
                        {{ Lang.page_transaction_transfer_title || "账户转账" }}
                    </div>
                    <div class="main_head_text required">

                    </div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">

                            <div class="form">

                                <form class="layui-form w500" action="">

                                    <div class="layui-form-item">
                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no_from || "转出账号" }}：</label>
                                        <div class="layui-input-inline">
                                            <select name="account_from" id="account_id_from" lay-filter="account_id_from" lay-verify="NotBlank" msg="{{ Lang.validate_transfer_account_from_not_chose || "请选择转出账号" }}" class="layui-input">
                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                {% for ac in account %}
                                                    {% if ac.state != 51 %}
                                                        <option value="{{ ac.id }},{{ ac.account_no }}-{{ ac.account_type | accountType }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                                    {% endif %}
                                                {% endfor %}
                                            </select>
                                        </div>
                                        <div class="layui-form-mid" id="balanceItem" style="display:none">{{ Lang.form_text_available_balance || "可用余额" }}: <span id="account_balance">$0.00</span></div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no_to || "转入账号" }}：</label>
                                        <div class="layui-input-inline">
                                            <select name="account_to" id="account_id_to" lay-verify="NotBlank|differentAccount" msg="{{ Lang.validate_transfer_account_to_not_chose || "请选择转入账号" }}">
                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                {% for ac in account %}
                                                    {% if ac.state != 51 %}
                                                        <option value="{{ ac.id }},{{ ac.account_no }}-{{ ac.account_type | accountType }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                                    {% endif %}
                                                {% endfor %}
                                            </select>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_transfer_amount || "转账金额(USD)" }}：</label>
                                        <div class="layui-input-inline">
                                            <input type="text" name="transfer_amount" id="transfer_amount" lay-verify="balance"
                                                   autocomplete="off" class="layui-input" onkeydown="keepMoney(this)" onkeyup="keepMoney(this)">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-inline">
                                            <button class="layui-btn" lay-submit lay-filter="formSubmit" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                                            <button type="reset" style="display: none;" id="transfer_form_reset_button" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                                        </div>
                                    </div>
                                </form>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="confirm" style="display:none">
        <div id="msg" style="margin: 20px 30px -16px 30px;">
            {{ Lang.page_transfer_msg_txt || "您的转账信息如下所示，请确认信息无误后，点击“确定”按钮。 " }}
        </div>
        <form class="layui-form show-detail" action="">
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no_from || "转出账号" }}:</label>
                <span id="account_id_from_confirm_show"></span>
                <input type="hidden" id="account_id_from_confirm_hidden" name="account_id_from"/>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no_to || "转入账号" }}:</label>
                <span id="account_id_to_confirm_show"></span>
                <input type="hidden" id="account_id_to_confirm_hidden" name="account_id_to"/>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_transfer_amount || "转账金额(USD)" }}:</label>
                <span id="transfer_amount_confirm_show"></span>
                <input type="hidden" id="transfer_amount_confirm_hidden" name="transfer_amount"/>
            </div>

            <div class="canceApply" id="cancel_btn_div">
                <input lay-submit="" type="button" lay-filter="confirm" class="layui-btn" value="{{ Lang.btn_true || "确定" }}"/>
                <input type="button" onclick="closeConfirm()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
            </div>
        </form>
    </div>
{% endblock %}

