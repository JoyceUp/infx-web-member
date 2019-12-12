{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
    <style>
        .tt_detail .d-item span,
        .tt_detail .d-item label {
            width: 100%;
            display: block;
            margin-left: 0;
            text-align: left;
            padding-left: 0;
        }

        .tt_detail .d-item {
            padding-left: 0;
        }
    </style>

{% endblock %}


{% block js_assets %}
    {# 引入js #}
    <script type="text/javascript" src="/assets/vendors/mathUtil.js"></script>
    <script>

        var company_ind_bank = {
            "CCB": [{no: "1010862228", card_user_name: "PT. REAL TIME FUTURES", branch_swift_code: "BWKIIDJA"}],
            "BCA": [{no: "0353251012", card_user_name: "PT. REAL TIME FUTURES", branch_swift_code: "CENAIDJA"}]
        }
        var company_usd_bank = {
            "CCB": [{no: "1010862333", card_user_name: "PT. REAL TIME FUTURES", branch_swift_code: "BWKIIDJA"}],
            "BCA": [{no: "0353251021", card_user_name: "PT. REAL TIME FUTURES", branch_swift_code: "CENAIDJA"}]
        }


        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}

        // 账户下拉框
        var accountHtml = '';
        var accountName = []
        accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
        {% for ac in account %}

        {% if ac.state != 51 and  ac.account_type != 9 %}
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

        {% if at.bank_name == tt.bank_name and tt.currency == 1 %}
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
        {% if at.bank_name == tt.bank_name and tt.currency == 2 %}
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








        function initBank() {
            /**
             * 印尼入金
             * **/

            var saVal="",js=0,selectDom
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';




                for ( cc in indBank) {

                    if(js==0){ saVal = cc; }

                    accountHtml += '<option value="' + cc + '">' + indBank[cc][js].name + '</option>';
                    js++
                }


            selectDom =  $('select[name="customer_bank_name"]')
            selectDom.html(accountHtml);

//            autoSelect(selectDom,saVal)



            js=0
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';

                for (cc in company_ind_bank) {
                    if (js == 0) {
                        saVal = cc;
                        js++
                    }
                    accountHtml += '<option value="' + cc + '">' + cc + '</option>';
                }

            selectDom = $('select[name="company_bank_name"]')
            selectDom.html(accountHtml);
//            autoSelect(selectDom,saVal)

            /**
             * USD入金
             * **/
            js=0
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in usdBank) {
                if(js==0){ saVal = cc; }

                accountHtml += '<option value="' + cc + '">' + usdBank[cc][js].name + '</option>';
                js++
            }


            selectDom = $('select[name="usd_customer_bank_name"]')
            selectDom.html(accountHtml);
//            autoSelect(selectDom,saVal)

            js=0
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in company_usd_bank) {
                if(js==0){ saVal = cc; js++}
                accountHtml += '<option value="' + cc + '">' + cc + '</option>';
            }


            selectDom = $('select[name="usd_company_bank_name"]')
            selectDom.html(accountHtml);
//            autoSelect(selectDom,saVal)


        }

        function setBankAcc(value, type) {
            var bankList="",selcetObj="",saVal="",js=0
            if (type == 2) {
                bankList= usdBank
                selcetObj =$('select[name="usd_customer_bank_account"]')
            } else {
                bankList= indBank
                 selcetObj =$('select[name="customer_bank_account"]')
            }
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in bankList[value]) {
                if(js==0){ saVal = bankList[value][cc].no; js++}
                accountHtml += '<option value="' + bankList[value][cc].no + '" >' + bankList[value][cc].no + '</option>';
            }
            selcetObj.html(accountHtml);
            autoSelect(selcetObj,saVal)
            form.render();

        }

        function setCompanyBankAcc(value, type) {

            var bankList="",selcetObj="",saVal="",js=0
            if (type == 2) {
                bankList= company_usd_bank
                selcetObj =$('select[name="usd_company_bank_account"]')
            } else {
                bankList= company_ind_bank
                selcetObj =$('select[name="company_bank_account"]')
            }
            var accountHtml = '<option value="" >{{ Lang.form_select_invite_type || "请选择" }}' + '</option>';
            for (cc in bankList[value]) {
                if(js==0){ saVal = bankList[value][cc].no; js++}
                accountHtml += '<option value="' + bankList[value][cc].no + '">' + bankList[value][cc].no + '</option>';
            }
            selcetObj.html(accountHtml);

            autoSelect(selcetObj,saVal)
            form.render();

        }

        $(function () {
            initBank()
            formatVar()
        })
        var deposit_min_limit ={{ system_setting.deposit_min_limit / 100 }}
        var step = 1
        formatVar = function () {
            $("p").each(function () {
                var html = $(this).html();
                console.log(html)
                html = html.replace('[deposit_min_limit]', deposit_min_limit);
                $(this).html(html);

                if (html.indexOf("--") > -1) {
                    var htmlArr = html.split("--");
                    var newHtml = "";

                    if (step == 1) {
                        step = 2
                        newHtml = htmlArr[0] + "<a href='javascript:;' onclick='showCompTTIDRInfo()'>" + htmlArr[1] + "</a>" + htmlArr[2]
                    } else {
                        newHtml = htmlArr[0] + "<a href='javascript:;' onclick='showCompTTUSDInfo()'>" + htmlArr[1] + "</a>" + htmlArr[2]
                    }
                    $(this).html(newHtml)
                }
            })

        }

        var deposit_min_limit = {{ system_setting.deposit_min_limit / 100 }};

        layui.use('upload', function () {
            var $ = layui.jquery
                , upload = layui.upload;

            var img_base64;
            //普通图片上传
            var uploadInst = upload.render({
                elem: '#upload_idr'
                , url: '/common/upload/'
                , data: {role_type: window.user.role_type, role_id: window.user.user_id}
                , size: 2048 //限制文件大小，单位 KB
                , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                , before: function (obj) {
                    //预读本地文件示例，不支持ie8
                    layer.load(2); //上传loading
                    obj.preview(function (index, file, result) {
                        img_base64 = result;
                    });

                }
                , done: function (res) {
                    layer.closeAll('loading'); //关闭loading
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('{{ Lang.msg_upload_error || "上传失败" }}');
                    }
                    $("#img_id").val(JSON.parse(res.datas).id);
                    //上传成功
                    $('#upload_img').attr('src', img_base64); //图片链接（base64）
                }
                , error: function () {
                    layer.closeAll('loading'); //关闭loading
                    //演示失败状态，并实现重传
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload">{{ Lang.msg_retry || "重试" }}</a>');
                    demoText.find('.demo-reload').on('click', function () {
                        uploadInst.upload();
                    });
                }
            });
            var img_base64_usd;
            //普通图片上传
            var uploadInstUsd = upload.render({
                elem: '#upload_usd'
                , url: '/common/upload/'
                , data: {role_type: window.user.role_type, role_id: window.user.user_id}
                , size: 2048 //限制文件大小，单位 KB
                , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                , before: function (obj) {
                    //预读本地文件示例，不支持ie8
                    layer.load(2); //上传loading
                    obj.preview(function (index, file, result) {
                        img_base64_usd = result;
                    });

                }
                , done: function (res) {
                    layer.closeAll('loading'); //关闭loading
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('{{ Lang.msg_upload_error || "上传失败" }}');
                    }
                    $("#img_id_usd").val(JSON.parse(res.datas).id);
                    //上传成功
                    $('#upload_img_usd').attr('src', img_base64_usd); //图片链接（base64）
                }
                , error: function () {
                    layer.closeAll('loading'); //关闭loading
                    //演示失败状态，并实现重传
                    var demoTextUSD = $('#demoTextUSD');
                    demoTextUSD.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload">{{ Lang.msg_retry || "重试" }}</a>');
                    demoTextUSD.find('.demo-reload').on('click', function () {
                        uploadInstUsd.upload();
                    });
                }
            });
        });
        var tabIndex = 0
        var form
        layui.use(['form', 'element'], function () {
            form = layui.form;
            var layer = layui.layer;
            var element = layui.element;
            element.on('tab(dh-tab)', function (data) {
/*                $("#bank_form_reset_button").click();
                $("#tt_form_reset_button").click();*/

                tabIndex = data.index;

            });
            form.verify({
                balance: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return '{{ Lang.validate_amount_not_null || "请填写申请金额" }}';
                    }
                    //因为格式化了金额，所有暂时屏蔽掉验证类型
//                    if (!/^[0-9.]*$/.test(value)) {
                        {#return '{{ Lang.validate_deopsit_amount_only_number || "入金金额必须为数字" }}';#}
//                    }

                    if ( rmoney(value) < deposit_min_limit) {
                        return '{{ Lang.validate_deopsit_amount_minimum || "入金最少额度为" }}' + deposit_min_limit + '{{ Lang.validate_amount_dollar || "美元" }}';
                    }
                },
                NotBlank: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (!value) {
                        return $(item).attr("msg");
                    }
                }
            });

            //监听提交 电汇入金-idr
            form.on('submit(sub_btn_1)', function (data) {
                data.field.type = 1;
                data.field.msg = "{{ Lang.page_member_withdraw_dh_msg_txt || "您的入金信息如下所示，请确认信息无误后，点击“确定”按钮。" }}";
                showConfirm(data.field);
                return false;
            });

            //监听提交 电汇入金-usd
            form.on('submit(sub_btn_2)', function (data) {
                data.field.type = 2;
                data.field.msg = "{{ Lang.page_member_withdraw_dh_msg_txt || "您的入金信息如下所示，请确认信息无误后，点击“确定”按钮。" }}";
                showConfirm(data.field);
                return false;
            });

            form.on('select(account)', function (data) {
                getRate(data.value.split(",")[4])
                $("input[name='accountName']").val(data.value.split(",")[3])
            });

            form.on('select(customer_bank_name)', function (data) {
                setBankAcc(data.value,1)
            });

            form.on('select(usd_customer_bank_name)', function (data) {
                setBankAcc(data.value,2)
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


            form.on('select(company_bank_name)', function (data) {
                setCompanyBankAcc(data.value,1)
            });
            form.on('select(usd_company_bank_name)', function (data) {
                setCompanyBankAcc(data.value,2)
            });

            form.on('select(company_bank_account)', function (data) {
                if (data.value != "") {
                    var bank_name = $("select[name='company_bank_name']").val()
                    var index = data.elem.options.selectedIndex - 1
                    $("input[name='companyBankAccountName']").val(company_ind_bank[bank_name][index].card_user_name)
                }
            });

            form.on('select(usd_company_bank_account)', function (data) {
                if (data.value != "") {
                    var bank_name = $("select[name='usd_company_bank_name']").val()
                    var index = data.elem.options.selectedIndex - 1
                    $("input[name='companyBankAccountName']").val(company_usd_bank[bank_name][index].card_user_name)
                }
            });


            //监听确认
            form.on('submit(confirm)', function (data) {
                layer.closeAll();
                submit(data.field);
                return false;
            });
        });
        var rate = 0
        function getRate(type) {
            $.ajax({
                type: "post",
                url: "/common/rate_deposit",
                data: {"type": type, "token": getCookie("token")},
                success: function (res) {
                    if(res.datas) {
                        rate = accDiv(res.datas, 10000)
                    }
                    $("#rate").html(fmoney(rate,4));
                    $("input[name=rate]").val(rate);

                },
                error: function () {

                }
            });
        }

        function showConfirm(data) {
            $("#confirm #msg").html(data.msg);
            $("#type").val(data.type);

            var account = data.account.split(",");
            $("#account_no_confirm_show").html(account[1]);
            $("#account_id_confirm_hidden").val(account[0]);

            $("#tt_path_confirm_hidden").val(data.tt_path);





            if (data.type == 1) {
                $("#tt_id").val(data.customer_bank_id);
                $("#company_bank_name").val(data.company_bank_name);
                $("#company_bank_card_no").val(data.company_bank_account);

                //汇率
                $("#rate_confirm_show").html(fmoney(data.rate,4));
                $("#rate_confirm_hidden").val(accMul(data.rate, 10000));
                $("#rate_confirm_show_div").show();

                //美元金额
                $("#amount_usd_confirm_show").html(data.amount_usd);
//
                $("#amount_usd_confirm_hidden").val(accMul(rmoney(data.amount_usd), 100));

                //印尼盾金额
                $("#amount_idr_confirm_show").html(fmoney(data.amount_idr,2));
//
                $("#amount_idr_confirm_hidden").val(accMul(data.amount_idr, 100));

                $("#amount_idr_confirm_show_div").show();
            } else {
                $("#tt_id").val(data.usd_customer_bank_id);

                $("#company_bank_name").val(data.usd_company_bank_name);
                $("#company_bank_card_no").val(data.usd_company_bank_account);
                //美元金额
                $("#amount_usd_confirm_show").html(fmoney(data.amount_usd,2));
                $("#amount_usd_confirm_hidden").val(accMul(rmoney(data.amount_usd), 100));

                //汇率
                $("#rate_confirm_show").html(0);
                $("#rate_confirm_hidden").val(0);
                $("#rate_confirm_show_div").hide();

                //印尼盾金额
                $("#amount_idr_confirm_show").html(0);
                $("#amount_idr_confirm_hidden").val(0);
                $("#amount_idr_confirm_show_div").hide();
            }

            layer.open({
                type: 1,
                title: '{{ validate_entry_order }}',
                area: ['500px', 'auto'],
                content: $('#confirm')
            });
        }

        function closeConfirm() {
            layer.closeAll();
        }

        var submit_f = false;

        function submit(data) {
            console.log(data)
            if (submit_f) {
                return false;
            }
            submit_f = true;
            var type = data.type;
            $.ajax({
                url: "/member/transaction/deposit/submit_deposit",
                async: true,
                data: data,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    submit_f = false;
                    if (data.status == 200) {
                        layer.alert("{{ Lang.alert_deposit_submit_success || "我们已收到您的电汇入金申请，工作人员会在确认收到款项之后为您办理入金，请耐心等待。" }}", {
                            title: '{{ Lang.page_text_submit_success || "提交完成" }}'
                            , closeBtn: 0    //是否显示关闭按钮,0隐藏 1显示
                        }, function (index) {
                            if (type == 1) {
                                $("#bank_form_reset_button").click();
                                //清空汇票
                                $("#img_id").val("");
                                $('#upload_img').attr('src', "");
                            } else {
                                $("#tt_form_reset_button").click();
                                //清空汇票
                                $("#img_id_usd").val("");
                                $('#upload_img_usd').attr('src', "");
                            }
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

        //计算支付金额
        var rate = 0;

        /* rate = accMul(rate, 10000);
         $("input[name=rate]").val(rate);*/
        function usd2idr(e) {
            if (e.value.length > 12) {
                e.value = e.value.slice(0, 12);
            }

            var idr = 0;
            var usd = 0;
            if ($(e).val()) {
                usd = $(e).val();
//                idr = toFixed(accDiv(accMul(usd, rate), 10000), 2);
                idr = toFixed(accMul(usd, rate), 2);
            }
            //实际支付的钱
            if (!idr) {
                idr = 0;
            }
            //计算显示的钱
            $("#amount_idr").val(idr);
        }

        function idr2usd(e) {
            if (e.value.length > 12) {
                e.value = e.value.slice(0, 12);
            }
            e.value = e.value.replace(/[^0-9]+/, "");

            var usd = 0;
            var idr = 0;
            if ($(e).val()) {
                idr = $(e).val();
//                usd = toFixed(accMul(accDiv(idr, rate), 10000), 2);
                usd = toFixed(accDiv(idr, rate), 2);
            }
            //实际支付的钱
            if (!usd) {
                usd = 0;
            }
            $("#amount_usd").val(fmoney(usd,2));
        }

        function keepMoney(obj) {

            var A = $(obj);
            var value = A.val();
            if (value == "-" || value == "") {
                A.attr("lastValue", "");
                A.val("");
                return true;
            }
            var reg = new RegExp(/^\d{1,12}($)/);
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

        //显示公司idr电汇信息
        function showCompTTIDRInfo() {
            layer.open({
                type: 1,
                title: "{{ Lang.tt_detail_idr_title || "电汇（IDR）收款信息" }}",
                area: ['650px', '90%'], //宽高
                content: $("#tt_idr_detail")
            });
        }

        //显示公司usd电汇信息
        function showCompTTUSDInfo() {
            layer.open({
                type: 1,
                title: "{{ Lang.tt_detail_usd_title || "电汇（USD）收款信息" }}",
                area: ['650px', '90%'], //宽高
                content: $("#tt_usd_detail")
            });
        }
    </script>
{% endblock %}

{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_transaction_deposit_title || "账户入金" }}
                    </div>
                    <div class="main_head_text required"></div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">

                            <div class="layui-tab" lay-filter="dh-tab">
                                <ul class="layui-tab-title">
                                    <li class="layui-this"
                                        index="IDR">{{ Lang.form_text_transfer_gold || "电汇入金" }}{{ Lang.idr || "（IDR）" }}</li>
                                    <li index="USD">{{ Lang.form_text_transfer_gold || "电汇入金" }}{{ Lang.usd || "（USD）" }}</li>
                                </ul>
                                <div class="layui-tab-content">
                                    {#电汇入金（IDR）#}
                                    <div class="layui-tab-item layui-show">
                                        <div class="from_alert">
                                            <h3>{{ Lang.page_transaction_deposit_dh_msg_h3_idr || "电汇入金（IDR）操作说明：" }}</h3>
                                            <p>{{ Lang.page_idr_deposit_dh_msg_txt1 || "1. 每次最低入金金额不得低于" }}</p>
                                            <p>{{ Lang.page_transaction_deposit_dh_msg_txt2 || "2. 请电汇至 <a onclick='showCompTTUSDInfo()'>公司电汇账户</a> 后，将汇票凭证上传至页面" }}</p>
                                            <p>{{ Lang.page_transaction_deposit_dh_msg_txt3 || "3. 电汇入金，平台不收取任何费用，但银行可能产生一定的服务费用。" }}</p>

                                        </div>
                                        <form class="layui-form deposit-form" action="">

                                            <div class="layui-row">

                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="account" lay-filter="account"
                                                                    lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_account_not_chose || "请选择账号" }}">
                                                            </select>
                                                           {# <input type="hidden" id="bank_account_id_hidden"
                                                                   name="account_id"/>#}
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.form_placeholder_name || "姓名" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                        <input type="text" class="layui-input" name="accountName"
                                                               style="border:none" disabled/>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>


                                            <div class="layui-row" style="margin-top: 30px;margin-bottom: 30px">

                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"
                                                               style="font-size:16px;">{{ Lang.form_title_customer_bank || "客户银行信息" }}</label>
                                                        <hr/>
                                                    </div>
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="customer_bank_name"
                                                                    lay-filter="customer_bank_name"
                                                                    lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_bank_name_chose || "请选择银行" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
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

                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            </select>
                                                            <input type="hidden" name="customer_bank_id"
                                                                   lay-filter="customer_bank_id"/>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.validate_bank_name_account_name || "银行户名" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" class="layui-input" name="bankAccountName"
                                                                   style="border:none" disabled/>

                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.validate_bank_name_account_swift || "Swift Code" }}
                                                            ：</label>
                                                        <div class="layui-input-block">

                                                            <input type="text" class="layui-input" name="bankAccountSwift"
                                                                   style="border:none" disabled/>
                                                        </div>
                                                    </div>


                                                </div>

                                                <div class="layui-col-md5 layui-col-xs12">

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"
                                                               style="font-size:16px;">{{ Lang.form_title_company_bank || "公司银行信息" }}</label>
                                                        <hr/>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="company_bank_name"
                                                                    lay-filter="company_bank_name" lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_bank_name_chose || "请选择银行" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="company_bank_account"
                                                                    lay-filter="company_bank_account"
                                                                    lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_bank_name_account_chose || "请选择账号" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.validate_bank_name_account_name || "银行户名" }}
                                                            ：</label>
                                                        <div class="layui-input-block">

                                                            <input type="text" class="layui-input"
                                                                   name="companyBankAccountName" style="border:none"
                                                                   disabled/>
                                                        </div>
                                                    </div>


                                                </div>

                                            </div>


                                            <div class="layui-row">
                                                <div class="layui-col-md5 layui-col-xs12">

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.form_label_rate || "汇率" }}
                                                            ：</label>
                                                        <div class="layui-form-mid layui-word-aux"
                                                             id="rate">{{ rate }}</div>
                                                        <input type="hidden" name="rate" value="{{ rate * 10000 }}"/>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount_idr || "申请金额(IDR)" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" name="amount_idr" id="amount_idr"
                                                                   {#lay-verify="NotBlank|number"#}

                                                                   msg="{{ Lang.validate_amount_not_null || "请填写申请金额" }}"
                                                                   autocomplete="off" class="layui-input"
                                                                   oninput="idr2usd(this);"/>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount || "申请金额(USD)" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" name="amount_usd" id="amount_usd"
                                                                   lay-verify="balance" class="layui-input" disabled
                                                                   oninput="usd2idr(this)" style="border:none"
                                                                   disabled/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_proof_photo || "汇票凭证" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <div class="layui-upload">
                                                                <button type="button" class="layui-btn" id="upload_idr"
                                                                        onclick="return false;">{{ Lang.btn_upload || "上传" }}</button>
                                                                <div class="layui-upload-list">
                                                                    <img class="layui-upload-img" id="upload_img">
                                                                    <input type="hidden" name="tt_path" id="img_id"
                                                                           value="" lay-verify="NotBlank"
                                                                           msg="{{ Lang.validate_tt_path_not_null || "请上传汇票凭证" }}"/>
                                                                    <p id="demoText"></p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="layui-form-item">
                                                <div class="layui-input-block">
                                                    <button class="layui-btn" lay-submit="" lay-filter="sub_btn_1"
                                                            onclick="javascript:return false;">{{ Lang.btn_sub || "提交" }}</button>
                                                    <button type="reset" style="display: none;"
                                                            id="bank_form_reset_button"
                                                            class="layui-btn layui-btn-primary">{{ Lang.btn_reset || "清空" }}</button>
                                                </div>
                                            </div>
                                        </form>

                                    </div>
                                    {#电汇入金（USD）#}
                                    <div class="layui-tab-item">
                                        <div class="from_alert">

                                            <h3>{{ Lang.page_transaction_deposit_dh_msg_h3_usd || "电汇入金操(USD)作说明：" }}</h3>
                                            <p>{{ Lang.page_transaction_deposit_dh_msg_txt1 || "1. 每次最低入金金额不得低于[deposit_min_limit]美金" }}</p>
                                            <p>{{ Lang.page_transaction_deposit_dh_msg_txt2 || "2. 请电汇至 <a onclick='showCompTTUSDInfo()'>公司电汇账户</a> 后，将汇票凭证上传至页面" }}</p>
                                            <p>{{ Lang.page_transaction_deposit_dh_msg_txt3 || "3. 电汇入金，平台不收取任何费用，但银行可能产生一定的服务费用。" }}</p>

                                        </div>

                                        <form class="layui-form deposit-form" action="">

                                            <div class="layui-row">

                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="account" lay-filter="account"
                                                                    lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_account_not_chose || "请选择账号" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            </select>
                                                    {#        <input type="hidden" id="bank_account_id_hidden"
                                                                   name="account_id"/>#}
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.form_placeholder_name || "姓名" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                        <input type="text" class="layui-input" name="accountName"
                                                               style="border:none" disabled/>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>


                                            <div class="layui-row" style="margin-top: 30px;margin-bottom: 30px">

                                                <div class="layui-col-md5 layui-col-xs12">
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"
                                                               style="font-size:16px;">{{ Lang.form_title_customer_bank || "客户银行信息" }}</label>
                                                        <hr/>
                                                    </div>
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="usd_customer_bank_name"
                                                                    lay-filter="usd_customer_bank_name"
                                                                    lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_bank_name_chose || "请选择银行" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
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

                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>

                                                            </select>
                                                            <input type="hidden" name="usd_customer_bank_id" lay-filter="usd_customer_bank_id"/>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.validate_bank_name_account_name || "银行户名" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" class="layui-input" name="bankAccountName"
                                                                   style="border:none" disabled/>

                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.validate_bank_name_account_swift || "Swift Code" }}
                                                            ：</label>
                                                        <div class="layui-input-block">

                                                            <input type="text" class="layui-input" name="bankAccountSwift"
                                                                   style="border:none" disabled/>
                                                        </div>
                                                    </div>


                                                </div>

                                                <div class="layui-col-md5 layui-col-xs12">

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"
                                                               style="font-size:16px;">{{ Lang.form_title_company_bank || "公司银行信息" }}</label>
                                                        <hr/>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_name || "银行名称" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="usd_company_bank_name"
                                                                    lay-filter="usd_company_bank_name" lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_bank_name_chose || "请选择银行" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_bank_account_no || "银行账号" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <select name="usd_company_bank_account"
                                                                    lay-filter="usd_company_bank_account"
                                                                    lay-verify="NotBlank"
                                                                    msg="{{ Lang.validate_bank_name_account_chose || "请选择账号" }}">
                                                                <option value="" >{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label">{{ Lang.validate_bank_name_account_name || "银行户名" }}
                                                            ：</label>
                                                        <div class="layui-input-block">

                                                            <input type="text" class="layui-input"
                                                                   name="companyBankAccountName" style="border:none"
                                                                   disabled/>
                                                        </div>
                                                    </div>


                                                </div>

                                            </div>


                                            <div class="layui-row">
                                                <div class="layui-col-md5 layui-col-xs12">

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_application_amount || "申请金额(USD)" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" name="amount_usd" lay-verify="balance"
                                                                   oninput="keepMoney(this)" class="layui-input"/>
                                                        </div>
                                                    </div>

                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label"><i>*</i>{{ Lang.form_label_proof_photo || "汇票凭证" }}
                                                            ：</label>
                                                        <div class="layui-input-block">
                                                            <div class="layui-upload">
                                                                <button type="button" class="layui-btn" id="upload_usd"
                                                                        onclick="return false;">{{ Lang.btn_upload || "上传" }}</button>
                                                                <div class="layui-upload-list">
                                                                    <img class="layui-upload-img" id="upload_img_usd">
                                                                    <input type="hidden" name="tt_path" id="img_id_usd"
                                                                           value="" lay-verify="NotBlank"
                                                                           msg="{{ Lang.validate_tt_path_not_null || "请上传汇票凭证" }}"/>
                                                                    <p id="demoTextUSD"></p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="layui-form-item">
                                                <div class="layui-input-block">
                                                    <button class="layui-btn" lay-submit="" lay-filter="sub_btn_2"
                                                            onclick="javascript:return false;">{{ Lang.btn_sub || "提交" }}</button>
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

    <div id="tt_idr_detail" class="tt_detail" style="display:none;">
        <form class="layui-form show-detail" action="">
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_account || " 收款人账号 " }}:</label>
                <span>1010862228（IDR）</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_name || " 收款人名称 " }}:</label>
                <span>PT. REAL TIME FUTURES</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_address || " 收款人地址 " }}:</label>
                <span>International Financial Center 2, lt 19.JL. Jendral Sudirman Kav.              22-23, RT.10/RW.1, Karet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta12920</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_name || " 收款人开户银行名称 " }}:</label>
                <span>PT. BANK CHINA CONSTRUCTION BANK INDONESIA,TBK(CCB)</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_address || " 收款人开户银行地址 " }}:</label>
                <span>KK. RAWAMANGUN Jl. Pemuda No. 33 A Rawamangun Jakarta Timur 13220</span>
            </div>
            <div class="d-item">
                <label>SWIFT CODE:</label>
                <span>BWKIIDJA</span>
            </div>
            <hr>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_account || " 收款人账号 " }}:</label>
                <span>0353251012（IDR）</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_name || " 收款人名称 " }}:</label>
                <span>PT. REAL TIME FUTURES</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_address || " 收款人地址 " }}:</label>
                <span> International Financial Center 2, lt 19.JL. Jendral Sudirman Kav. 22-23, RT.10/RW.1, Karet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12920</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_name || " 收款人开户银行名称 " }}:</label>
                <span>Bank central asia sudirman  (BCA)</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_address || " 收款人开户银行地址 " }}:</label>
                <span>Gedung Chase Plaza, Jl. Jend. Sudirman Kav. 21
                    <br>
                    Jakarta Selatan, DKI Jakarta, Indonesia</span>
            </div>
            <div class="d-item">
                <label>SWIFT CODE:</label>
                <span> CENAIDJA</span>
            </div>
        </form>

    </div>
    <div id="tt_usd_detail" class="tt_detail" style="display:none;">
        <form class="layui-form show-detail" action="">
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_account || " 收款人账号 " }}:</label>
                <span>1010862333 (USD)</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_name || " 收款人名称 " }}:</label>
                <span>PT. REAL TIME FUTURES</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_address || " 收款人地址 " }}:</label>
                <span> International Financial Center 2, lt 19.JL. Jendral Sudirman Kav. 22-23, RT.10/RW.1, Karet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12920,

                </span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_name || " 收款人开户银行名称 " }}:</label>
                <span>PT. BANK CHINA CONSTRUCTION BANK INDONESIA,TBK(CCB)</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_address || " 收款人开户银行地址 " }}:</label>
                <span>KK. RAWAMANGUN Jl. Pemuda No. 33 A Rawamangun Jakarta Timur 13220
                </span>
            </div>
            <div class="d-item">
                <label>SWIFT CODE:</label>
                <span> BWKIIDJA</span>
            </div>
            <hr>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_account || " 收款人账号 " }}:</label>
                <span>0353251021 (USD)</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_name || " 收款人名称 " }}:</label>
                <span>PT. REAL TIME FUTURES</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_address || " 收款人地址 " }}:</label>
                <span> International Financial Center 2, lt 19.JL. Jendral Sudirman Kav. 22-23, RT.10/RW.1, Karet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12920,


                </span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_name || " 收款人开户银行名称 " }}:</label>
                <span>Bank central asia sudirman  (BCA)</span>
            </div>
            <div class="d-item">
                <label>{{ Lang.form_text_beneficiary_branch_address || " 收款人开户银行地址 " }}:</label>
                <span>Gedung Chase Plaza, Jl. Jend. Sudirman Kav. 21<br>
Jakarta Selatan, DKI Jakarta, Indonesia

                </span>
            </div>
            <div class="d-item">
                <label>SWIFT CODE:</label>
                <span> CENAIDJA</span>
            </div>


        </form>

    </div>
    <div id="confirm" style="display:none">
        <div id="msg" style="margin: 20px 30px -16px 30px;"></div>
        <form class="layui-form show-detail" action="">
            <input type="hidden" id="type" name="type">
            <input type="hidden" name="tt_path" id="tt_path_confirm_hidden"/>

            <input type="hidden" name="tt_id" id="tt_id"/>

            <input type="hidden" name="company_bank_name" id="company_bank_name"/>
            <input type="hidden" name="company_bank_card_no" id="company_bank_card_no"/>

            <div class="d-item">
                <label>{{ Lang.form_placeholder_account_no || "账号" }}:</label>
                <span id="account_no_confirm_show"></span>
                <input type="hidden" id="account_id_confirm_hidden" name="account_id"/>
            </div>

            <div class="d-item" id="amount_idr_confirm_show_div">
                <label>{{ Lang.form_label_application_amount_cny || "申请金额(IDR)" }}:</label>
                <span id="amount_idr_confirm_show"></span>
                <input type="hidden" id="amount_idr_confirm_hidden" name="amount_idr"/>
            </div>

            <div class="d-item" id="rate_confirm_show_div" style="display: none">
                <label>{{ Lang.form_label_rate || "汇率" }}:</label>
                <span id="rate_confirm_show"></span>
                <input type="hidden" id="rate_confirm_hidden" name="rate"/>
            </div>

            <div class="d-item">
                <label>{{ Lang.form_label_application_amount || "申请金额(USD)" }}:</label>
                <span id="amount_usd_confirm_show"></span>
                <input type="hidden" id="amount_usd_confirm_hidden" name="amount_usd"/>
            </div>

            <div class="canceApply" id="cancel_btn_div">
                <input lay-submit="" type="button" lay-filter="confirm" class="layui-btn"
                       value="{{ Lang.btn_true || "确定" }}"/>
                <input type="button" onclick="closeConfirm()" class="layui-btn" value="{{ Lang.btn_cancel || "取消" }}"/>
            </div>
        </form>
    </div>
{% endblock %}


