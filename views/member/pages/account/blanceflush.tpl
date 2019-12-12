
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
	{# 引入css #}
{% endblock %}

{% block js_assets %}
    <script type="text/javascript">
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}
        // 账户下拉框
        var accountHtml = '<option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>';
        var flag = false;
        {% for ac in account %}
        {% if ac.state != 51 and ac.account_type != 9 %}
            accountHtml += '<option value="{{ ac.id }}" selected>{{ ac.account_no }}-'+accountTypeMap[{{ ac.account_type }}]+'</option>';
            if(!flag){
                $("#balanceItem").show();
                getAccountBalance('{{ ac.id }}');
                flag = true;
            }
            {% endif %}
        {% endfor %}
        $('select[name="account_id"]').html(accountHtml);

        var current_balance = 0;
        layui.use(['form'], function () {
            var form = layui.form
                , layer = layui.layer;

            form.verify({
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });

            form.on('select(account)', function (data) {
                //console.log($(data.elem).attr("balance-id"));
                //console.log(data.elem); //得到checkbox原始DOM对象
                // console.log(data.elem.checked); //开关是否开启，true或者false
                // console.log(data.value); //开关value值，也可以通过data.elem.value得到
                //console.log(data.othis); //得到美化后的DOM对象
                if(data.value) {
                    $("#balanceItem").show();
                    getAccountBalance(data.value);
                }else{
                    $("#balanceItem").hide()
                }
            });

            //监听提交
            var submit_f = false;
            form.on('submit(sub_btn)', function (data) {
                if(submit_f){
                    return false;
                }
                submit_f = true;
                if ($("#balance_hidden").val() >= 0) {
                    layer.alert("{{ Lang.alert_balance_flush_balance_zero1 || "可用余额：" }}"+$("#balance_hidden").val()+"<br/>{{ Lang.alert_balance_flush_balance_zero2 || "您的账户余额不小于0，不能申请余额清零！" }}", {
                        title: '{{ Lang.page_msg_h3 || "提示：" }}'
                    });
                    submit_f = false;
                    return false;
                }
                $.ajax({
                    url: "/member/account/submit_balance_flush",
                    async: true,
                    data: data.field,
                    type: "post",
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    success: function (data) {
                        submit_f = false;
                        if (data.status == 200) {
                            layer.alert("{{ Lang.alert_balance_flush_submit_success || "您的余额清零请求已被系统接收，我们的工作人员将会尽快为您办理，请耐心等待。" }}", {
                                title: '{{ Lang.page_text_upsuccessfully || "提交成功：" }}'
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
                return false;
            });
        });

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
                        $("#balance").html("$" + current_balance.toFixed(2));
                        $("#balance_hidden").val(current_balance);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
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
                        {{ Lang.page_account_balance_flush_title || "余额清零" }}
                    </div>
                    <div class="main_head_text required">
                    </div>
                </div>

                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">


                            <form class="layui-form form w800" action="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}</label>
                                    <div class="layui-input-inline" style="width: 240px">
                                        <select id="account_id" lay-filter="account" name="account_id" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择账号" }}">
                                        </select>
                                    </div>
                                    <div class="layui-form-mid" id="balanceItem" style="display:none">
                                        {{ Lang.form_text_available_balance || "可用余额" }}: <span id="balance">$0</span>
                                        <input type="hidden" id="balance_hidden"/>
                                    </div>
                                </div>

                                <div class="layui-form-item mt50">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit="" lay-filter="sub_btn" onclick="javascript:return false;">{{ Lang.btn_sub || "提交" }}</button>
                                    </div>
                                </div>
                            </form>



                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}
