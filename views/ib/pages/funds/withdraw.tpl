
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}

{% endblock %}

{% block js_assets %}
    {# 引入js #}

    <script>
        var current_balance = 0;
        var fee = 0;
        $(function () {
            //获取出金手续费
            getWithDrawFee();
        });
        function getWithDrawFee(){
            $.ajax({
                url: "/ib/funds/withdraw/withdraw_fee",
                async: true,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        fee = parseInt(JSON.parse(data.datas).fee) / 100;
                        $(".fee_msg").html(fee);
                        // $("#bc_fee").html(fee);
                        // $("#bc_fee_hidden_input").val(fee);
                        $("#tt_fee").html(fee);
                        $("#tt_fee_hidden_input").val(fee);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }
        var form;
        layui.use(['form','element'], function(){
            form = layui.form;
            var element = layui.element;

            //监听确认页 银行卡
            form.on('submit(bank_confirm)', function (data) {
                data.field.type = 1;
                showConfirm(data.field);
                return false;
            });
            //监听提交 银行卡
            form.on('submit(formSubmit1)', function (data) {
                data.field.type = 1;
                submit(data.field);
                return false;
            });

            //监听确认页 电汇
            form.on('submit(tt_confirm)', function (data) {
                data.field.type = 2;
                if(!data.field.bankcard_no){
                    layer.alert("{{ Lang.alert_bank_no_not_null || "银行账号不能为空" }}", {
                        title: '{{ Lang.page_msg_h3 || "提示：" }}'
                    });
                    return false;
                }
                showConfirm(data.field);
                return false;
            });
            //监听提交 电汇
            form.on('submit(formSubmit2)', function (data) {
                data.field.type = 2;
                submit(data.field);
                return false;
            });

            //监听tab 切换
            var tabIndex = 0;
            element.on('tab(TabBrief)', function(data){
                tabIndex = data.index

            });
            form.verify({
                balance: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return '{{ Lang.validate_amount_not_null || "请填写申请金额" }}';
                    }
                    if(!/^[0-9.]*$/.test(value)){
                        return '{{ Lang.validate_amount_only_number || "申请金额必须为数字" }}!';
                    }
                    if(current_balance < value){
                        return '{{ Lang.validate_amount_more_than_the_balance || "申请金额不能大于账户可用余额" }}';
                    }
                    if(value < 30){
                        return '{{ Lang.validate_withdraw_amount_minimum || "出金最少额度为" }}{{ system_setting.withdraw_min_limit / 100 }}{{ Lang.validate_amount_dollar || "美元" }}';
                    }
                    if(value < fee){
                        return '{{ Lang.validate_amount_more_than_the_fee || "申请金额必须大于手续费" }}';
                    }
                },
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                },
                NotBlankBankNo: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return "{{ Lang.validate_card_no_not_null || "请填写银行卡号" }}";
                    }
                    if (!(/^([1-9]{1})(\d{15}|\d{18})$/.test(value))) {
                        return '{{ Lang.validate_card_no_format_error || "请填写正确的银行卡号" }}';
                    }
                }
            });

            form.on('select(account)', function(data){
                //console.log($(data.elem).attr("balance-id"));
                //console.log(data.elem); //得到checkbox原始DOM对象
                // console.log(data.elem.checked); //开关是否开启，true或者false
                // console.log(data.value); //开关value值，也可以通过data.elem.value得到
                //console.log(data.othis); //得到美化后的DOM对象
                var balanceItem = tabIndex==0?$("#balanceBank"):$("#balanceTel");
                if(data.value) {
                    var id = data.value.split(",")[0];
                    balanceItem.show();
                    getAccountBalance(id, $(data.elem).attr("balance-id"));
                }else{
                    balanceItem.hide();
                }
            });
        });
        function showConfirm(data) {
            $("#type").val(data.type);

            var account = data.account.split(",");
            if(data.type == 1) {
                $("#account_no_confirm_show").html(account[1]);
                $("#account_id_confirm_hidden").val(account[0]);
            }else if(data.type == 2){
                $("#tt_account_no_confirm_show").html(account[1]);
                $("#tt_account_id_confirm_hidden").val(account[0]);
            }

            if(data.type == 1){
                //汇率
                $("#rate_confirm_show").html(data.rate / 10000);
                $("#rate_confirm_hidden").val(data.rate);
                //申请金额
                $("#amount_confirm_show").html(data.amount);
                $("#amount_confirm_hidden").val(data.amount);
                //手续费
                $("#fee_confirm_show").html("0.00");
                $("#fee_confirm_hidden").val(0);
                //支付金额
                $("#pay_amount_confirm_show").html(data.pay_amount);
                $("#pay_amount_confirm_hidden").val(data.pay_amount);

                //银行信息
                var bankcard = data.bankcard.split("##");
                $("#bankcard_id_confirm_show").html(bankcard[1]+"<br/>"+bankcard[2]);
                $("#bankcard_id_confirm_hidden").val(bankcard[0]);

                layer.open({
                    type:1,
                    title:'{{ Lang.dialog_withdraw_confirm || "出金订单确认" }}',
                    area:['500px', 'auto'],
                    content:$('#bank_confirm')
                });
            }else{
                //申请金额
                $("#tt_amount_confirm_show").html(data.amount);
                $("#tt_amount_confirm_hidden").val(data.amount);
                //手续费
                $("#tt_fee_confirm_show").html(data.fee);
                $("#tt_fee_confirm_hidden").val(data.fee);
                //支付金额
                $("#tt_pay_amount_confirm_show").html(data.pay_amount);
                $("#tt_pay_amount_confirm_hidden").val(data.pay_amount);

                layer.open({
                    type:1,
                    title:'{{ Lang.dialog_withdraw_confirm || "出金订单确认" }}',
                    area:['500px', 'auto'],
                    content:$('#tt_confirm')
                });
            }

        }
        function closeConfirm() {
            layer.closeAll();
        }

        var submit_f = false;
        function submit(data) {
            if(submit_f){
                return false;
            }
            submit_f = true;
            var type = data.type;
            var msg = "";
            if(type == 1){
                msg = "{{ Lang.msg_withdraw_success || "您的出金请求已被系统接收，我们的工作人员将会尽快为您办理，请耐心等待，款项一般会在2个工作日后转入您所登记的银行账户内。" }}";
            }else{
                msg = "{{ Lang.msg_withdraw_error || "您的出金请求已被系统接收，我们的工作人员将会尽快为您办理，请耐心等待，款项一般会在3-5个工作日后转入您所登记的银行账户内。" }}";
            }
            $.ajax({
                url: "/ib/funds/withdraw/submit_withdraw",
                async: true,
                data: data,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    submit_f = false;
                    if (data.status == 200) {
                        layer.alert(msg + "<br/>" +
                            "<a href=\"/ib/funds/withdraw_record\">{{ Lang.alert_content_withdraw_cancel || "若您需要取消出金，请点击此处进行操作。" }}</a>", {
                            title: '{{ Lang.alert_content_submit_success || "提交成功" }}'
                            ,closeBtn: 0    //是否显示关闭按钮,0隐藏 1显示
                        }, function(index){
                            if(type == 1){
                                //银行卡出金
                                $("#bank_balance").html("$0.00");
                                $("#bank_pay_amount_show").html("0");
                                $("#bank_pay_amount").val("0");
                                $("#bank_form_reset_button").click();
                            }else{
                                //电汇出金
                                $("#tt_balance").html("$0.00");
                                $("#tt_pay_amount_show").html("0");
                                $("#tt_pay_amount").val("0");
                                $("#tt_form_reset_button").click();

                                //获取出金手续费
                                getWithDrawFee();
                            }
                            form.render();      //重新渲染form组建
                            layer.closeAll();
                        });
                    }else{
                        layer.alert(data.msg, {
                            title: '{{ Lang.page_msg_h3 || "提示：" }}'
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        function getAccountBalance(id, show_id) {
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
                        $("#" + show_id).html("$" + current_balance);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }
        var rate = {{ rate * 10000 }};
        function usd2rmb(e, id) {
            var v = 0;
            if($(e).val()){
                var value = keepMoney(e);
                if(id == "tt_pay_amount"){
                    v = toFixed(parseFloat(accSub(fee, value)), 2);
                }else{
                    v = toFixed(accDiv(accMul(value, rate), 10000), 2);
                }
            }
            if(v < 0){
                v = 0;
            }
            $("#" + id + "_show").html(v);
            $("#" + id).val(v);
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

    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_transaction_withdraw_title || "账户出金" }}
                    </div>
                    <div class="main_head_text required"></div>
                </div>

                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">

                            <div class="layui-tab" lay-filter="TabBrief">
                                <ul class="layui-tab-title">
                                    <li class="layui-this">{{ Lang.form_text_bank_card_withdraw || "银行卡出金" }}</li>
                                    <li>{{ Lang.form_text_transfer_withdraw || "电汇出金" }}</li>
                                </ul>
                                <div class="layui-tab-content">

                                    <div class="layui-tab-item layui-show">
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_disclaimers || "免责声明：" }}</h3>
                                            <p>{{ Lang.page_disclaimers_msg_txt1 || "1. 请阁下仔细阅读出金申请的声明，在您提交出金申请后，我们将会发送相关邮件至您的开户邮箱，请确保邮箱的真实有效；" }}</p>
                                            <p>{{ Lang.page_disclaimers_msg_txt2_1 || "2. 在您填写出金申请过程中，请阁下仔细确认您的银行卡等相关信息的准确有效，银行卡持有人需与开户身份信息保持一致，" }}</p>
                                            <p>{{ Lang.page_disclaimers_msg_txt2_2 || "3. 若信息填写或操作出现错误均由客户本人承担责任；若递交信息不完整则平台有权拒绝此次出金，待阁下重新填写递交后再次处理；" }}</p>
                                            {#<p>{{ Lang.page_disclaimers_msg_txt3_1 || "3.为节约财务成本，平台每月只受理" }}{{ system_setting.withdraw_free_times }}{{ Lang.page_disclaimers_msg_txt3_2 || "次免费出金申请，第" }}{{ system_setting.withdraw_free_times + 1 }}{{ Lang.page_disclaimers_msg_txt3_3 || "次出金将扣除" }}{{ system_setting.withdraw_poundage / 100 }}{{ Lang.page_disclaimers_msg_txt3_4 || "美金手续费；出金一般在后台扣款后的1-2个工作日到账；" }}</p>#}
                                            <p>{{ Lang.page_disclaimers_msg_txt4 || "4. 请阁下仔细核算出金金额，避免对交易中的账户产生影响，否则由于出金后保证金不足所引发的损失均由阁下本人承担。" }}</p>
                                            <p>{{ Lang.page_disclaimers_msg_txt5 || "5. 每次最低出金金额为" }}{{ system_setting.withdraw_min_limit / 100 }}{{ Lang.page_transaction_deposit_dh_msg_txt1_2 || "美金；" }}</p>
                                            <p>{{ Lang.page_disclaimers_msg_txt6 || "6. 银行卡出金免费。" }}</p>
                                        </div>

                                        <div class="form">

                                            <form class="layui-form w500" action="">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}</label>
                                                    <div class="layui-input-inline">
                                                        <select name="account" lay-filter="account" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择账号" }}" class="layui-input" balance-id="bank_balance">
                                                            <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            {% for ac in account %}
                                                                {% if ac.state != 51 %}
                                                                    <option value="{{ ac.id }},{{ ac.account_no }}-{{ ac.account_type | accountType }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                                                {% endif %}
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <div class="layui-form-mid">{{ Lang.form_text_available_balance || "可用余额" }}: <span id="bank_balance">$0.00</span></div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_label_rate || "汇率" }}：</label>
                                                    <div class="layui-form-mid layui-word-aux" id="rate">{{ rate }}</div>
                                                    <input type="hidden" name="rate" value="{{ rate * 10000 }}"/>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount || "申请金额(USD)" }}：</label>
                                                    <div class="layui-input-inline">
                                                        <input type="input" name="amount" lay-verify="balance" class="layui-input" oninput="usd2rmb(this, 'bank_pay_amount')"/>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_label_fee || "手续费(USD)" }}：</label>
                                                    <div class="layui-form-mid" id="bc_fee">0.00</div>
                                                    <input type="hidden" name="fee" id="bc_fee_hidden_input"/>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_label_pay_amount || "支付金额(CNY)" }}：</label>
                                                    <div class="layui-form-mid layui-word-aux" id="bank_pay_amount_show">0.00</div>
                                                    <input type="hidden" name="pay_amount" id="bank_pay_amount" autocomplete="off" class="layui-input">
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bankcard || "收款银行" }}：</label>
                                                    <div class="layui-input-inline">
                                                        <select style="width: 240px"name="bankcard" name="bankcard" lay-verify="NotBlank" msg="{{ Lang.validate_withdraw_bankcard_not_chose || "请选择收款银行" }}">
                                                            <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            {% for b in banklist %}
                                                                <option value="{{ b.id }}##{{ b.bank_name }} {{ b.city }} {{ b.branch_name }}##{{ b.card_no }}">{{ b.bank_name}}-{{ b.card_no | bankNoLast }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <div class="layui-form-mid btn">
                                                        <a class="layui-btn layui-btn-sm" href="/ib/account/info?preferred=bank">{{ Lang.btn_manager_bank_card || "管理银行卡" }}</a>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <div class="layui-input-block">
                                                        <button class="layui-btn" lay-submit lay-filter="bank_confirm" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                                                        <button type="reset" style="display: none;" id="bank_form_reset_button" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>

                                    </div>
                                    <div class="layui-tab-item">
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_transaction_withdraw_dh_msg_h3 || "电汇出金操作说明：" }}</h3>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt1 || "1.为保证顺利出金，请在提交申请时，务必确认电汇账号等银行信息的正确性，一般为英文或数字，请勿书写中文；" }}</p>
                                            {#<p>{{ Lang.page_transaction_withdraw_dh_msg_txt2_1 || "2.系统每月为单个客户（一个有效身份证明对应一个客户）提供免费电汇出金" }}{{ system_setting.withdraw_free_times }}{{ Lang.page_transaction_withdraw_dh_msg_txt2_2 || "次，若您是第" }}{{ system_setting.withdraw_free_times + 1 }}{{ Lang.page_transaction_withdraw_dh_msg_txt2_3 || "次出金，将收取" }}{{ system_setting.withdraw_poundage / 100 }}{{ Lang.page_transaction_withdraw_dh_msg_txt2_4 || "美元的资金中转费用，谢谢您的理解!" }}</p>#}
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt2_1 || "2.系统每月为单个客户（一个有效身份证明对应一个客户）提供免费电汇出金" }}{{ system_setting.withdraw_free_times }}{{ Lang.page_transaction_withdraw_dh_msg_txt2_2 || "次，若您是第" }}{{ system_setting.withdraw_free_times + 1 }}{{ Lang.page_transaction_withdraw_dh_msg_txt2_3 || "次出金，将收取" }}{{ system_setting.withdraw_poundage / 100 }}{{ Lang.page_transaction_withdraw_dh_msg_txt2_4 || "美元的资金中转费用，谢谢您的理解!" }}</p>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt3_1 || "3.每次出金金额不得低于" }}{{ system_setting.withdraw_min_limit / 100 }}{{ Lang.page_transaction_withdraw_dh_msg_txt3_2 || "美金，到账时间一般3-5个工作日。" }}</p>

                                        </div>

                                        <div class="form">

                                            <form class="layui-form w500" action="">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}</label>
                                                    <div class="layui-input-inline">
                                                        <select name="account" lay-filter="account" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择账号" }}" class="layui-input" balance-id="tt_balance">
                                                            <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            {% for ac in account %}
                                                                {% if ac.state != 51 %}
                                                                    <option value="{{ ac.id }},{{ ac.account_no }}-{{ ac.account_type | accountType }}">{{ ac.account_no }}-{{ ac.account_type | accountType }}</option>
                                                                {% endif %}
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <div class="layui-form-mid" id="balanceTel" style="display:none">{{ Lang.form_text_available_balance || "可用余额" }}: <span id="tt_balance">$0.00</span></div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount || "申请金额(USD)" }}：</label>
                                                    <div class="layui-input-inline">
                                                        <input type="input" name="amount" lay-verify="balance" class="layui-input" onblur="usd2rmb(this, 'bank_pay_amount')" oninput="usd2rmb(this, 'tt_pay_amount')"/>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_label_fee || "手续费(USD)" }}：</label>
                                                    <div class="layui-form-mid" id="tt_fee">0.00</div>
                                                    <input type="hidden" name="fee" id="tt_fee_hidden_input"/>
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label">{{ Lang.form_label_pay_amount_usd || "支付金额(USD)" }}：</label>
                                                    <div class="layui-form-mid layui-word-aux" id="tt_pay_amount_show">0.00</div>
                                                    <input type="hidden" name="pay_amount" id="tt_pay_amount" autocomplete="off" class="layui-input">
                                                </div>

                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}：</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="bankcard_no" value="{{ tt.card_no }}" lay-verify="NotBlank" msg="{{ Lang.validate_withdraw_bankcard_not_chose || "请选择收款银行" }}" disabled="disabled" autocomplete="off" class="layui-input">
                                                    </div>
                                                    <div class="layui-form-mid btn">
                                                        <a class="layui-btn layui-btn-sm" onclick="" href="/ib/account/info?preferred=tt">{{ Lang.btn_manager_transfer || "管理电汇信息" }}</a>
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <div class="layui-input-block">
                                                        <button class="layui-btn" lay-submit lay-filter="tt_confirm" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                                                        <button type="reset" style="display: none;" id="tt_form_reset_button" class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
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
            </div>
        </div>
    </div>

    <div id="bank_confirm" style="display:none">
        <div id="msg" style="margin: 20px 30px -16px 30px;">{{ Lang.page_withdraw_msg_txt || "您的出金信息如下所示，请确认信息无误后，点击“确定”按钮。 " }}</div>
        <form class="layui-form show-detail" action="">
            <input type="hidden" id="type" name="type">
            <input type="hidden" name="tt_path" id="tt_path_confirm_hidden"/>
            <div class="d-item">
                <label>{{ Lang.form_label_ib_account_no || "代理账号" }}:</label>
                <span id="account_no_confirm_show"></span>
                <input type="hidden" id="account_id_confirm_hidden" name="account_id"/>
            </div>

            <div class="d-item" id="rate_confirm_show_div">
                <label>{{ Lang.form_label_withdraw_rate || "出金汇率" }}:</label>
                <span id="rate_confirm_show"></span>
                <input type="hidden" id="rate_confirm_hidden" name="rate"/>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span id="amount_confirm_show"></span>
                <input type="hidden" id="amount_confirm_hidden" name="amount"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_fee || "手续费(USD)" }}:</label>
                <span id="fee_confirm_show"></span>
                <input type="hidden" id="fee_confirm_hidden" name="fee"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_pay_amount || "支付金额(CNY)" }}:</label>
                <span id="pay_amount_confirm_show"></span>
                <input type="hidden" id="pay_amount_confirm_hidden" name="pay_amount"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_text_bank_info || "银行信息" }}:</label>
                <span id="bankcard_id_confirm_show"></span>
                <input type="hidden" id="bankcard_id_confirm_hidden" name="bankcard_id"/>
            </div>

            <div class="canceApply" id="cancel_btn_div">
                <input lay-submit="" type="button" lay-filter="formSubmit1" class="layui-btn" value="{{ Lang.btn_true || "确定" }}"/>
                <input type="button" onclick="closeConfirm()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
            </div>
        </form>
    </div>
    <div id="tt_confirm" style="display:none">
        <div id="msg" style="margin: 20px 30px -16px 30px;">{{ Lang.page_withdraw_msg_txt || "您的出金信息如下所示，请确认信息无误后，点击“确定”按钮。 " }}</div>
        <form class="layui-form show-detail" action="">
            <input type="hidden" id="type" name="type">
            <input type="hidden" name="tt_path" id="tt_path_confirm_hidden"/>
            <div class="d-item">
                <label>{{ Lang.form_label_ib_account_no || "代理账号" }}:</label>
                <span id="tt_account_no_confirm_show"></span>
                <input type="hidden" id="tt_account_id_confirm_hidden" name="account_id"/>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span id="tt_amount_confirm_show"></span>
                <input type="hidden" id="tt_amount_confirm_hidden" name="amount"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_fee || "手续费(USD)" }}:</label>
                <span id="tt_fee_confirm_show"></span>
                <input type="hidden" id="tt_fee_confirm_hidden" name="fee"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_pay_amount_usd || "支付金额(USD)" }}:</label>
                <span id="tt_pay_amount_confirm_show"></span>
                <input type="hidden" id="tt_pay_amount_confirm_hidden" name="pay_amount"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_account_no || "银行账号" }}:</label>
                <span id="_confirm_show">{{ tt.card_no }}</span>
                <input type="hidden" name="bankcard_no" value="{{ tt.card_no }}"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_card_user_name || "银行账户户名" }}:</label>
                <span id="_confirm_show">{{ tt.card_user_name }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_name || "银行名称" }}:</label>
                <span id="_confirm_show">{{ tt.bank_name }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_country || "银行国家" }}:</label>
                <span id="_confirm_show">{{ tt.country }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_province || "地区（省）" }}:</label>
                <span id="_confirm_show">{{ tt.province }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_city || "地区（市）" }}:</label>
                <span id="_confirm_show">{{ tt.city }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_branch_name || "银行开户行" }}:</label>
                <span id="_confirm_show">{{ tt.branch_name }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_branch_address || "开户行地址" }}:</label>
                <span id="_confirm_show">{{ tt.branch_address }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_branch_swift_code || "国际汇款代码" }}:</label>
                <span id="_confirm_show">{{ tt.branch_swift_code }}</span>
            </div>

            <div class="canceApply" id="cancel_btn_div">
                <input lay-submit="" type="button" lay-filter="formSubmit2" class="layui-btn" value="{{ Lang.btn_true || "确定" }}"/>
                <input type="button" onclick="closeConfirm()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
            </div>
        </form>
    </div>
{% endblock %}


