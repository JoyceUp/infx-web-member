{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}

{% endblock %}

{% block js_assets %}
    {# 引入js #}
    <script type="text/javascript" src="/assets/vendors/mathUtil.js"></script>

    <script>
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        // 账户下拉框
        var accountHtml = '<option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>';
        {% for ac in account %}
        {% if ac.state != 51  %}
        accountHtml += '<option value="{{ ac.id }},{{ ac.account_no }}-' + accountTypeMap[{{ ac.account_type }}] + ',{{ ac.account_type }},{{ ac.full_name }},{{ ac.account_rate_type }}" >{{ ac.account_no }}-' + accountTypeMap[{{ ac.account_type }}] + '</option>';
        {% endif %}
        {% endfor %}
        $('select[name="account"]').html(accountHtml);


        //账户类型 id-value

        var indBank = new Object();
        var usdBank = new Object();

        {% if bank.length>0 %}

        {% for at in bank %}
        {% if at.currency == 1 %}
        var js = 0
        {% for tt in bank %}
        {% if at.bank_name == tt.bank_name  and tt.currency == 1 %}
        usdBank[js]=[]
        usdBank[js++].push({
            "name": "{{ tt.bank_name }}",
            "id": "{{ tt.id }}",
            "no": "{{ tt.card_no }}",
            "card_user_name": "{{ tt.card_user_name }}",
            "branch_swift_code": "{{ tt.branch_swift_code }}"


        })
        {% endif %}
        {% endfor %}

        {% else %}
        var js = 0
        {% for tt in bank %}
        {% if at.bank_name == tt.bank_name  and tt.currency == 2 %}
        indBank[js]=[]
        indBank[js++].push({
            "name": "{{ tt.bank_name }}",
            "id": "{{ tt.id }}",
            "no": "{{ tt.card_no }}",
            "card_user_name": "{{ tt.card_user_name }}",
            "branch_swift_code": "{{ tt.branch_swift_code }}"
        })
        {% endif %}
        {% endfor %}
        {% endif %}
        {% endfor %}

        {% endif %}



        var seVal = "", js = 0, selectDom

        function initBank() {

            /**
             * 印尼入金
             * **/
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in indBank) {
                if (js == 0) {
                    saVal = cc;

                }
                accountHtml += '<option value="' + cc + '">' + indBank[cc][js++].name + '</option>';
            }

            selectDom = $('select[name="customer_bank_name"]')
            selectDom.html(accountHtml);
//            autoSelect(selectDom, saVal)


            /**
             * USD入金
             * **/
            js = 0
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in usdBank) {
                if (js == 0) {
                    saVal = cc;
                }
                accountHtml += '<option value="' + cc + '">' + usdBank[cc][js++].name + '</option>';
            }
            selectDom =  $('select[name="usd_customer_bank_name"]')
            selectDom.html(accountHtml);
//            autoSelect(selectDom, saVal)

        }

        function setBankAcc(value, type) {
            js = 0
            var bankList = "", selcetObj = ""
            if (type == 2) {
                bankList = usdBank
                selcetObj = $('select[name="usd_customer_bank_account"]')
            } else {
                bankList = indBank
                selcetObj = $('select[name="customer_bank_account"]')
            }
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in bankList[value]) {
                if (js == 0) {
                    saVal = bankList[value][cc].no;
                    js++
                }
                accountHtml += '<option value="' + bankList[value][cc].no + '">' + bankList[value][cc].no + '</option>';
            }
            selcetObj.html(accountHtml);
            autoSelect(selcetObj, saVal)
            form.render();

        }


        $(function () {
            initBank()
            formatVar();
          /*  var id = $("#select_tt_idr_account").val().split(",")[0];
            getAccountBalance(id, $("#select_tt_idr_account").attr("balance-id"));
            $("#balanceBank").show();*/
        });
        var withdraw_free_times = {{ system_setting.withdraw_free_times }};
        var withdraw_free_times_next = {{ system_setting.withdraw_free_times + 1 }};
        var withdraw_poundage = {{ system_setting.withdraw_poundage / 100 }};
        formatVar = function () {
            $("p").each(function () {
                var html = $(this).html();
//                console.log(html)
                html = html.replace('[withdraw_min_limit]', withdraw_min_limit);
//                html = html.replace(/withdraw_free_times/g, withdraw_free_times);
                html = html.replace('[withdraw_free_times]', withdraw_free_times);
                html = html.replace('[withdraw_free_times]', withdraw_free_times);
                html = html.replace('[withdraw_free_times_next]', withdraw_free_times_next);
                html = html.replace('[withdraw_poundage]', withdraw_poundage);
                $(this).html(html)
            })
        };

        var withdraw_min_limit = {{ system_setting.withdraw_min_limit / 100 }};
        var current_balance = 0;
        var fee = 0;
        var tabIndex = 0;
        $(function () {
            //获取出金手续费
            getWithDrawFee();
        });

        function getWithDrawFee() {
            $.ajax({
                url: "/member/transaction/withdraw/withdraw_fee",
                async: true,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        fee = parseInt(JSON.parse(data.datas).fee) / 100;
                        $(".fee_msg").html(fee);
                        $("#bc_fee").html(fmoney(fee,2));
                        $("#bc_fee_hidden_input").val(fee);
                        $("#tt_fee").html(fmoney(fee,2));
                        $("#tt_fee_hidden_input").val(fee);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        var form;
        layui.use(['form', 'element'], function () {
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
                showConfirm(data.field);
                return false;
            });
            //监听提交 电汇
            form.on('submit(formSubmit2)', function (data) {
                data.field.type = 2;
                submit(data.field);
                return false;
            });


            form.on('select(customer_bank_name)', function (data) {
                setBankAcc(data.value, 1)
            });

            form.on('select(usd_customer_bank_name)', function (data) {
                setBankAcc(data.value, 2)
            });

            form.on('select(customer_bank_account)', function (data) {
                if (data.value != "") {
                    var bank_name = $("select[name='customer_bank_name']").val()
                    var index = data.elem.options.selectedIndex - 1
                    $("input[name='customer_bank_id']").val(indBank[bank_name][index].id)
                    $("input[name='bankAccountName']").val(indBank[bank_name][index].card_user_name)
                    $("input[name='bankAccountSwift']").val(indBank[bank_name][index].branch_swift_code)
                }

            });


            form.on('select(usd_customer_bank_account)', function (data) {
                if (data.value != "") {
                    var bank_name = $("select[name='usd_customer_bank_name']").val()
                    var index = data.elem.options.selectedIndex - 1

                    $("input[name='usd_customer_bank_id']").val(usdBank[bank_name][index].id)
                    $("input[name='bankAccountName']").val(usdBank[bank_name][index].card_user_name)
                    $("input[name='bankAccountSwift']").val(usdBank[bank_name][index].branch_swift_code)
                }

            });


            //监听tab 切换
            element.on('tab(TabBrief)', function (data) {
                tabIndex = data.index;
                var balanceItem = tabIndex == 0 ? $("#balanceBank") : $("#balanceTel");
                var select = tabIndex == 0 ? $("#select_tt_idr_account") : $("#select_tt_account");
                if (select.val()) {
                    var id = select.val().split(",")[0];
                    balanceItem.show();
                    getAccountBalance(id, select.attr("balance-id"));
                } else {
                    balanceItem.hide();
                }
            });
            form.verify({
                balance: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return '{{ Lang.validate_amount_not_null || "请填写申请金额" }}';
                    }
                    if (!/^[0-9.]*$/.test(value)) {
                        return '{{ Lang.validate_amount_only_number || "申请金额必须为数字" }}!';
                    }
                    if (current_balance < value) {
                        return '{{ Lang.validate_amount_more_than_the_balance || "申请金额不能大于账户可用余额" }}';
                    }
                    if (value < withdraw_min_limit) {
                        return '{{ Lang.validate_withdraw_amount_minimum || "出金最少额度为" }}' + withdraw_min_limit + '{{ Lang.validate_amount_dollar || "美元" }}';
                    }
                    if (value <= fee) {
                        return '{{ Lang.validate_amount_more_than_the_fee || "申请金额必须大于手续费" }}';
                    }
                },
                NotBlank: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return $(item).attr("msg");
                    }
                },
                NotBlankBankNo: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return "{{ Lang.validate_card_no_not_null || "请填写银行卡号" }}";
                    }
                    if (!(/^([1-9]{1})(\d{15}|\d{18})$/.test(value))) {
                        return '{{ Lang.validate_card_no_format_error || "请填写正确的银行卡号" }}';
                    }
                }
            });

            form.on('select(account)', function (data) {
                //console.log($(data.elem).attr("balance-id"));
                //console.log(data.elem); //得到checkbox原始DOM对象
                // console.log(data.elem.checked); //开关是否开启，true或者false
                // console.log(data.value); //开关value值，也可以通过data.elem.value得到
                //console.log(data.othis); //得到美化后的DOM对象
                getRate(data.value.split(",")[4])
                $("input[name='accountName']").val(data.value.split(",")[3])

                var balanceItem = tabIndex == 0 ? $("#balanceBank") : $("#balanceTel");
                if (data.value) {
                    var id = data.value.split(",")[0];
                    balanceItem.show();
                    getAccountBalance(id, $(data.elem).attr("balance-id"));
                } else {
                    balanceItem.hide();
                }
            });
        });


        var rate = 0

        function getRate(type) {
            $.ajax({
                type: "post",
                url: "/common/rate_withdraw",
                data: {"type": type, "token": getCookie("token")},
                success: function (res) {

                    rate = accDiv(res.datas, 10000)

                    $("#rate").html(fmoney(rate,4));
                    $("input[name=rate]").val(rate);

                },
                error: function () {

                }
            });
        }

        function showConfirm(data) {

            var account = data.account.split(",");
            var customer_bank_id=data.customer_bank_id


            $("#subType").val(data.type);
            if (data.type == 1) {
                $("#tt_idr_account_no_confirm_show").html(account[1]);
//                $("#tt_idr_account_id_confirm_hidden").val(account[0]);
                $("#tt_account_id_confirm_hidden").val(account[0]);
            } else if (data.type == 2) {
                $("#tt_account_no_confirm_show").html(account[1]);
                $("#tt_account_id_confirm_hidden").val(account[0]);
            }

            if (data.type == 1) {
                $("#tt_id").val(data.customer_bank_id);
                $("#indConfim").show()
                $("#usdConfim").hide()

                //汇率
                $("#rate_confirm_show").html(fmoney(data.rate,4));
                $("#rate_confirm_hidden").val(accMul(data.rate, 10000));
                //申请金额
                $("#amount_usd_confirm_show").html(fmoney(data.amount_usd,2));
                $("#amount_usd_confirm_hidden").val(data.amount_usd );

                //手续费
                $("#fee_confirm_show").html(fmoney(data.fee,2));
                $("input[name='fee']").val(data.fee);
                //支付金额
                $("#amount_idr_confirm_show").html(fmoney(data.amount_idr,2));
                $("#amount_idr_confirm_hidden").val(data.amount_idr );


            } else {
                customer_bank_id=data.usd_customer_bank_id
                $("#tt_id").val(data.usd_customer_bank_id);
                $("#usdConfim").show()
                $("#indConfim").hide()
                //申请金额
                $("#tt_amount_confirm_show").html(fmoney(data.amount,2));
                $("#tt_amount_confirm_hidden").val(data.amount );
                //手续费
                $("#tt_fee_confirm_show").html(fmoney(data.fee,2));
                $("input[name='fee']").val(data.fee);
                //支付金额
                $("#tt_pay_amount_confirm_show").html(fmoney(data.pay_amount,2));
                $("#tt_pay_amount_confirm_hidden").val(data.pay_amount  );

                //电汇信息
                $("#tt_id_confirm_hidden").val(data.customer_bank_id);

            }


            $.ajax({
                url: '/member/customer/telinfo/info',
                async: true,
                data: {"id": customer_bank_id},
                type: 'post',
                dataType: 'json',
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success: function (data) {
                    if (data.status == 200) {
                        var deposit = JSON.parse(data.datas);
                        $('#card_no_confirm_show').html(deposit.card_no);
                        $('#card_user_name_confirm_show').html(deposit.card_user_name);
                        $('#bank_name_confirm_show').html(deposit.bank_name);
                        $('#country_confirm_show').html(deposit.country);
                        $('#province_confirm_show').html(deposit.province);
                        $('#city_confirm_show').html(deposit.city);
                        $('#branch_name_confirm_show').html(deposit.branch_name);
                        $('#branch_address_confirm_show').html(deposit.branch_address);
                        $('#branch_swift_code_confirm_show').html(deposit.branch_swift_code);

                        layer.open({
                            type: 1,
                            title: '{{ Lang.dialog_withdraw_confirm || "出金订单确认" }}',
                            area: ['500px', 'auto'],
                            content: $('#tt_confirm')
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });

        }

        function closeConfirm() {
            layer.closeAll();
        }

        var submit_f = false;

        function submit(data) {
            if (submit_f) {
                return false;
            }
            submit_f = true;
            var type = data.type;
            var msg = "";
            if (type == 1) {
                msg = "{{ Lang.msg_withdraw_success || "您的出金请求已被系统接收，我们的工作人员将会尽快为您办理，请耐心等待，款项一般会在2个工作日后转入您所登记的银行账户内。" }}";
            } else {
                msg = "{{ Lang.msg_withdraw_error || "您的出金请求已被系统接收，我们的工作人员将会尽快为您办理，请耐心等待，款项一般会在3-5个工作日后转入您所登记的银行账户内。" }}";
            }

            $.ajax({
                url: "/member/transaction/withdraw/submit_withdraw",
                async: true,
                data: data,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    submit_f = false;
                    if (data.status == 200) {
                        layer.alert(msg + "<br/>" +
                            "<a href=\"/member/funds/deposit\">{{ Lang.alert_content_withdraw_cancel || "若您需要取消出金，请点击此处进行操作。" }}</a>", {
                            title: '{{ Lang.page_transaction_withdraw_order_sub_title || "出金提交成功" }}'
                            , closeBtn: 0    //是否显示关闭按钮,0隐藏 1显示
                        }, function (index) {
                            if (type == 1) {
                                //银行卡出金
                                // $("#bank_balance").html("$0.00");
                                $("#bank_pay_amount_show").html("0");
                                $("#bank_pay_amount").val("0");
                                $("#bank_form_reset_button").click();
                            } else {
                                //电汇出金
                                // $("#tt_balance").html("$0.00");
                                $("#tt_pay_amount_show").html("0");
                                $("#tt_pay_amount").val("0");
                                $("#tt_form_reset_button").click();
                            }
                            //获取出金手续费
                            getWithDrawFee();
                            form.render();      //重新渲染form组建
                            layer.closeAll();
                        });
                    } else {
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
                url: "/member/account/mt/balance",
                async: true,
                data: {id: id},
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        current_balance = data.datas.balance / 100;
                        $("#" + show_id).html("$" + fmoney(current_balance,2));
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }


        function usd2rmb(e, id) {
            var v = 0;
            if ($(e).val()) {
                var value = keepMoney(e);
                if (id == "tt_pay_amount") {
                    v = toFixed(parseFloat(accSub(fee, value)), 2);
                } else {
//                    v = toFixed(accDiv(accMul(accSub(fee, value), rate), 10000), 2);
                    v = toFixed(accMul(accSub(fee, value), rate), 2);
                }
            }
            if (v < 0) {
                v = 0;
            }
            $("#" + id + "_show").html(fmoney(v,2));
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
                                    <li class="layui-this">{{ Lang.form_text_transfer_withdraw || "电汇出金" }}{{ Lang.idr || "（IDR）" }}</li>
                                    <li>{{ Lang.form_text_transfer_withdraw || "电汇出金" }}{{ Lang.usd || "（USD）" }}</li>
                                </ul>
                                <div class="layui-tab-content">

                                    <div class="layui-tab-item layui-show">
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_transaction_withdraw_dh_msg_h3_idr || "电汇出金（IDR）操作说明：" }}</h3>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt1 || "1. 为保证顺利出金，请在提交申请时，务必确认电汇账号等银行信息的正确性，一般为英文或数字，请勿书写中文；" }}</p>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt2 || "2. 系统每月为单个客户（一个有效身份证明对应一个客户）提供免费电汇出金[withdraw_free_times]次，若您是第[withdraw_free_times_next]次出金，将收取[withdraw_poundage]美元的资金中转费用，谢谢您的理解!" }}</p>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt3 || "3. 每次出金金额不得低于[withdraw_min_limit]美金，到账时间一般3-5个工作日" }}</p>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt4 || "4. 请输入申请金额(USD),系统根据当天汇率自动换算成印尼盾（IDR）" }}</p>
                                        </div>
                                        <div class="form">
                                            <form class="layui-form deposit-form" action="">
                                                <div class="layui-row">
                                                    <div class="layui-col-md7 layui-col-xs12">
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}
                                                                ：</label>
                                                            <div class="layui-input-inline">
                                                                <select name="account" id="select_tt_idr_account"
                                                                        lay-filter="account" lay-verify="NotBlank"
                                                                        msg="{{ Lang.validate_account_not_chose || "请选择账号" }}"
                                                                        class="layui-input" balance-id="bank_balance">
                                                                </select>
                                                            </div>
                                                            <div class="layui-form-mid" id="balanceBank"
                                                                 style="display:none">{{ Lang.table_balance || "账户余额" }}
                                                                : <span id="bank_balance">$0.00</span></div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.form_placeholder_name || "姓名" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" class="layui-input"
                                                                       name="accountName"
                                                                       style="border:none" disabled/>
                                                            </div>
                                                        </div>
                                                    </div>



                                                </div>

                                                <div class="layui-row" style="margin-top: 30px;margin-bottom: 30px">

                                                    <div class="layui-col-md12 layui-col-xs12">
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"
                                                                   style="font-size:16px;">{{ Lang.form_title_customer_bank || "客户银行信息" }}</label>
                                                            <hr/>
                                                        </div>
                                                    </div>

                                                    <div class="layui-col-md5 layui-col-xs12">
                                                      
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <select name="customer_bank_name"
                                                                        lay-filter="customer_bank_name"
                                                                        lay-verify="NotBlank"
                                                                        msg="{{ Lang.validate_bank_name_chose || "请选择银行" }}">
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <select name="customer_bank_account"
                                                                        lay-filter="customer_bank_account"
                                                                        lay-verify="NotBlank"
                                                                        msg="{{ Lang.validate_bank_name_account_chose || "请选择账号" }}">
                                                                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>

                                                                </select>
                                                                <input type="hidden" name="customer_bank_id"
                                                                       lay-filter="customer_bank_id"/>
                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.validate_bank_name_account_name || "银行户名" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" class="layui-input"
                                                                       name="bankAccountName"
                                                                       style="border:none" disabled/>

                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.validate_bank_name_account_swift || "Swift Code" }}
                                                                ：</label>
                                                            <div class="layui-input-block">

                                                                <input type="text" class="layui-input"
                                                                       name="bankAccountSwift"
                                                                       style="border:none" disabled/>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>


                                                <div class="layui-row" style="margin-top: 30px;margin-bottom: 30px">
                                                    <div class="layui-col-md5 layui-col-xs12">

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount || "申请金额(USD)" }}
                                                                ：</label>
                                                            <div class="layui-input-inline">
                                                                <input type="text" id="bank_amount" name="amount_usd"
                                                                       lay-verify="balance" class="layui-input"
                                                                       oninput="usd2rmb(this, 'bank_pay_amount')"/>
                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.form_label_fee || "手续费(USD)" }}
                                                                ：</label>
                                                            <div class="layui-form-mid" id="bc_fee">0.00</div>
                                                            <input type="hidden" name="fee" id="bc_fee_hidden_input"/>
                                                        </div>


                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.form_label_rate || "汇率" }}
                                                                ：</label>
                                                            <div class="layui-form-mid layui-word-aux"
                                                                 id="rate">{{ rate }}</div>
                                                            <input type="hidden" name="rate" value=""/>
                                                        </div>


                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.form_label_pay_amount || "支付金额(IDR)" }}
                                                                ：</label>
                                                            <div class="layui-form-mid layui-word-aux"
                                                                 id="bank_pay_amount_show">0.00
                                                            </div>
                                                            <input type="hidden" name="amount_idr" id="bank_pay_amount"
                                                                   autocomplete="off" class="layui-input">
                                                        </div>

                                                        {#<div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}：</label>
                                                            <div class="layui-input-inline">
                                                                <select name="tt_info"  lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择收款银行" }}" class="layui-input" balance-id="tt_balance">
                                                                    {% for b in tt_idr %}
                                                                        <option value="{{ b.id }}##{{ b.bank_name }} {{ b.city }} {{ b.branch_name }}##{{ b.card_no }}">{{ b.card_no }}</option>
                                                                    {% endfor %}
                                                                </select>
                                                            </div>
                                                            <div class="layui-form-mid btn">
                                                                <a class="layui-btn layui-btn-sm" onclick="" href="/member/user/telinfo">{{ Lang.btn_manager_transfer || "管理电汇信息" }}</a>
                                                            </div>
                                                        </div>#}
                                                    </div>
                                                </div>

                                                <div class="layui-form-item">
                                                    <div class="layui-input-block">
                                                        <button class="layui-btn" lay-submit lay-filter="bank_confirm"
                                                                onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                                                        <button type="reset" style="display: none;"
                                                                id="bank_form_reset_button"
                                                                class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="layui-tab-item">
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_transaction_withdraw_dh_msg_h3_usd || "电汇出金（USD）操作说明：" }}</h3>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt1 || "1.为保证顺利出金，请在提交申请时，务必确认电汇账号等银行信息的正确性，一般为英文或数字，请勿书写中文；" }}</p>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt2 || "2.系统每月为单个客户（一个有效身份证明对应一个客户）提供免费电汇出金[withdraw_free_times]次，若您是第[withdraw_free_times_next]次出金，将收取[withdraw_poundage]美元的资金中转费用，谢谢您的理解!" }}</p>
                                            <p>{{ Lang.page_transaction_withdraw_dh_msg_txt3 || "3.每次出金金额不得低于[withdraw_min_limit]美金，到账时间一般3-5个工作日" }}</p>
                                        </div>

                                        <div class="form">

                                            <form class="layui-form deposit-form" action="">

                                                <div class="layui-row">
                                                    <div class="layui-col-md7 layui-col-xs12">

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}
                                                                ：</label>
                                                            <div class="layui-input-inline">
                                                                <select name="account" id="select_tt_account"
                                                                        lay-filter="account" lay-verify="NotBlank"
                                                                        msg="{{ Lang.validate_account_not_chose || "请选择账号" }}"
                                                                        class="layui-input" balance-id="tt_balance">
                                                                </select>
                                                            </div>
                                                            <div class="layui-form-mid" id="balanceTel"
                                                                 style="display:none">{{ Lang.table_balance || "账户余额" }}
                                                                : <span id="tt_balance">$0.00</span></div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.form_placeholder_name || "姓名" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" class="layui-input"
                                                                       name="accountName"
                                                                       style="border:none" disabled/>
                                                            </div>
                                                        </div>
                                                    </div>



                                                </div>


                                                <div class="layui-row" style="margin-top: 30px;margin-bottom: 30px">


                                                    <div class="layui-col-md12 layui-col-xs12">
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"
                                                                   style="font-size:16px;">{{ Lang.form_title_customer_bank || "客户银行信息" }}</label>
                                                            <hr/>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-md5 layui-col-xs12">


                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <select name="usd_customer_bank_name"
                                                                        lay-filter="usd_customer_bank_name"
                                                                        lay-verify="NotBlank"
                                                                        msg="{{ Lang.validate_bank_name_chose || "请选择银行" }}">
                                                                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <select name="usd_customer_bank_account"
                                                                        lay-filter="usd_customer_bank_account"
                                                                        lay-verify="NotBlank"
                                                                        msg="{{ Lang.validate_bank_name_account_chose || "请选择账号" }}">

                                                                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>

                                                                </select>
                                                                <input type="hidden" name="usd_customer_bank_id"
                                                                       lay-filter="usd_customer_bank_id"/>
                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.validate_bank_name_account_name || "银行户名" }}
                                                                ：</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" class="layui-input"
                                                                       name="bankAccountName"
                                                                       style="border:none" disabled/>

                                                            </div>
                                                        </div>

                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">{{ Lang.validate_bank_name_account_swift || "Swift Code" }}
                                                                ：</label>
                                                            <div class="layui-input-block">

                                                                <input type="text" class="layui-input"
                                                                       name="bankAccountSwift"
                                                                       style="border:none" disabled/>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    </div>
                                                    <div class="layui-row" style="margin-top: 30px;margin-bottom: 30px">
                                                    <div class="layui-col-md5 layui-col-xs12">
                                                        <div class="layui-form-item">

                                                            <div class="layui-form-item">
                                                                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount || "申请金额(USD)" }}
                                                                    ：</label>
                                                                <div class="layui-input-inline">
                                                                    <input type="text" id="tt_amount" name="amount"
                                                                           lay-verify="balance" class="layui-input"
                                                                           oninput="usd2rmb(this, 'tt_pay_amount')"/>
                                                                </div>
                                                            </div>

                                                            <div class="layui-form-item">
                                                                <label class="layui-form-label">{{ Lang.form_label_fee || "手续费(USD)" }}
                                                                    ：</label>
                                                                <div class="layui-form-mid" id="tt_fee">0.00</div>
                                                                <input type="hidden" name="fee"
                                                                       id="tt_fee_hidden_input"/>
                                                            </div>

                                                            <div class="layui-form-item">
                                                                <label class="layui-form-label">{{ Lang.form_label_pay_amount_usd || "支付金额(USD)" }}
                                                                    ：</label>
                                                                <div class="layui-form-mid layui-word-aux"
                                                                     id="tt_pay_amount_show">0.00
                                                                </div>
                                                                <input type="hidden" name="pay_amount"
                                                                       id="tt_pay_amount" autocomplete="off"
                                                                       class="layui-input">
                                                            </div>
                                                        </div>

                                                    {#  <div class="layui-form-item">
                                                          <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}：</label>
                                                          <div class="layui-input-inline">
                                                              <select name="tt_id" lay-filter="account" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择收款银行" }}" class="layui-input" balance-id="tt_balance">
                                                                  {% for ac in tt_usd %}
                                                                      <option value="{{ ac.id }}">{{ ac.card_no }}</option>
                                                                  {% endfor %}
                                                              </select>
                                                          </div>
                                                          <div class="layui-form-mid btn">
                                                              <a class="layui-btn layui-btn-sm" onclick="" href="/member/user/telinfo">{{ Lang.btn_manager_transfer || "管理电汇信息" }}</a>
                                                          </div>
                                                      </div>#}

                                                    <div class="layui-form-item">
                                                        <div class="layui-input-block">
                                                            <button class="layui-btn" lay-submit lay-filter="tt_confirm"
                                                                    onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
                                                            <button type="reset" style="display: none;"
                                                                    id="tt_form_reset_button"
                                                                    class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
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
    {#  <div id="bank_confirm" style="display:none">
          <div id="msg" style="margin: 20px 30px -16px 30px;">{{ Lang.form_text_withdraw_info_true || " 您的出金信息如下所示，请确认信息无误后，点击“确定”按钮。 " }}</div>
          <form class="layui-form show-detail" action="">
            <input type="hidden" value="1" name="type">
              <div class="d-item">
                  <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                  <span id="tt_idr_account_no_confirm_show"></span>
                  <input type="hidden" id="tt_idr_account_id_confirm_hidden" name="account_id"/>
              </div>

              <div class="d-item" id="rate_confirm_show_div">
                  <label>{{ Lang.form_label_rate || "汇率" }}:</label>
                  <span id="rate_confirm_show"></span>
                  <input type="hidden" id="rate_confirm_hidden" name="rate"/>
              </div>

              <div class="d-item">
                  <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                  <span id="amount_usd_confirm_show"></span>
                  <input type="hidden" id="amount_usd_confirm_hidden" name="amount_usd"/>
              </div>

              <div class="d-item" id="pay_amount_confirm_show_div">
                  <label>{{ Lang.form_label_fee || "手续费(USD)" }}:</label>
                  <span id="fee_confirm_show"></span>
                  <input type="hidden" id="fee_confirm_hidden" name="fee"/>
              </div>

              <div class="d-item" id="pay_amount_confirm_show_div">
                  <label>{{ Lang.form_label_pay_amount || "支付金额(IDR)" }}:</label>
                  <span id="amount_idr_confirm_show"></span>
                  <input type="hidden" id="amount_idr_confirm_hidden" name="amount_idr"/>
              </div>

              <div class="d-item" id="pay_amount_confirm_show_div">
                  <label>{{ Lang.page_user_bankinfo_title || "银行信息" }}:</label>
                  <span id="bankcard_id_confirm_show"></span>
                  <input type="hidden" id="tt_idr_id_confirm_hidden" name="tt_id"/>
              </div>

              <div class="canceApply" id="cancel_btn_div">
                  <input lay-submit="" type="button" lay-filter="formSubmit1" class="layui-btn" value="{{ Lang.btn_true || "确定" }}"/>
                  <input type="button" onclick="closeConfirm()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
              </div>
          </form>
      </div>#}
    <div id="tt_confirm" style="display:none">
        <div id="msg"
             style="margin: 20px 30px -16px 30px;">{{ Lang.form_text_withdraw_info_true || " 您的出金信息如下所示，请确认信息无误后，点击“确定”按钮。 " }}</div>
        <form class="layui-form show-detail" action="">

            <div id="indConfim">
                <input type="hidden" value="1" id="subType" name="sub_type">
                <div class="d-item">
                    <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                    <span id="tt_idr_account_no_confirm_show"></span>
                    <input type="hidden" id="tt_idr_account_id_confirm_hidden" name="account_id"/>
                </div>

                <div class="d-item" id="rate_confirm_show_div">
                    <label>{{ Lang.form_label_rate || "汇率" }}:</label>
                    <span id="rate_confirm_show"></span>
                    <input type="hidden" id="rate_confirm_hidden" name="rate"/>
                </div>

                <div class="d-item">
                    <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                    <span id="amount_usd_confirm_show"></span>
                    <input type="hidden" id="amount_usd_confirm_hidden" name="amount_usd"/>
                </div>

                <div class="d-item" id="pay_amount_confirm_show_div">
                    <label>{{ Lang.form_label_fee || "手续费(USD)" }}:</label>
                    <span id="fee_confirm_show"></span>
                    <input type="hidden" id="fee_confirm_hidden" name="fee"/>
                </div>

                <div class="d-item" id="pay_amount_confirm_show_div">
                    <label>{{ Lang.form_label_pay_amount || "支付金额(IDR)" }}:</label>
                    <span id="amount_idr_confirm_show"></span>
                    <input type="hidden" id="amount_idr_confirm_hidden" name="amount_idr"/>
                </div>
            </div>

            <input type="hidden" id="tt_id" name="tt_id"/>
            <div id="usdConfim">

                <div class="d-item">
                    <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
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
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_account_no || "银行账号" }}:</label>
                <span id="card_no_confirm_show">{{ tt.card_no }}</span>
                <input type="hidden" name="bankcard_no" value="{{ tt.card_no }}"/>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_card_user_name || "银行账户户名" }}:</label>
                <span id="card_user_name_confirm_show">{{ tt.card_user_name }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_name || "银行名称" }}:</label>
                <span id="bank_name_confirm_show">{{ tt.bank_name }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_country || "银行国家" }}:</label>
                <span id="country_confirm_show">{{ tt.country }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_province || "地区（省）" }}:</label>
                <span id="province_confirm_show">{{ tt.province }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_bank_city || "地区（市）" }}:</label>
                <span id="city_confirm_show">{{ tt.city }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_branch_name || "银行开户行" }}:</label>
                <span id="branch_name_confirm_show">{{ tt.branch_name }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_branch_address || "开户行地址" }}:</label>
                <span id="branch_address_confirm_show">{{ tt.branch_address }}</span>
            </div>

            <div class="d-item" id="pay_amount_confirm_show_div">
                <label>{{ Lang.form_label_branch_swift_code || "国际汇款代码" }}:</label>
                <span id="branch_swift_code_confirm_show">{{ tt.branch_swift_code }}</span>
            </div>

            <div class="canceApply" id="cancel_btn_div">
                <input lay-submit="" type="button" lay-filter="formSubmit2" class="layui-btn"
                       value="{{ Lang.btn_true || "确定" }}"/>
                <input type="button" onclick="closeConfirm()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
            </div>
        </form>
    </div>
{% endblock %}


