{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
{% endblock %}
{% block content %}
{# 内容 #}
<div class="main_content">
    <div class="main_content_holder">
        <div id="fund">
            <div class="main_head">
                <div class="main_head_unit">
                    {{ Lang.page_funds_return_to_balance_title || "返利转余额" }}
                </div>
                <div class="main_head_text required">

                </div>
            </div>
            <div class="main_page_Info">
                <div class="form">
                    <div class="form_input">
                        <div class="form">
                            <form class="layui-form" action="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}：</label>
                                    <div class="layui-input-inline">
                                        <select name="account_id" id="account_id" lay-filter="account_id" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择账号" }}" class="layui-input">
                                        </select>
                                    </div>
                                    <div class="layui-form-mid">{{ Lang.form_text_transfer_amount || "可转金额" }}: <span id="account_balance">$0.00</span></div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit lay-filter="formSubmit" onclick="return false;">{{ Lang.btn_sub || "提交" }}</button>
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
{% endblock %}
{% block js_assets %}
    {# 引入js #}

    <script>
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}
        // 账户下拉框
        var accountHtml = '<option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>';
        var flag = false;
        {% for ac in account %}
        {% if ac.state != 51 %}
            accountHtml += '<option value="{{ ac.id }}" selected>{{ ac.account_no }}-'+accountTypeMap[{{ ac.account_type }}]+'</option>';
            if(!flag){
                getAccountRebate('{{ ac.id }}');
                flag = true;
            }
        {% endif %}
        {% endfor %}
        $('select[name="account_id"]').html(accountHtml);

        var current_rebate = 0;
        layui.use(['form'], function(){
            var form = layui.form;
            //监听提交
            form.on('submit(formSubmit)', function (data) {
                if(current_rebate <= 0){
                    layer.alert("{{ Lang.alert_return_to_balance_no_rebate || "该账户无可转返利" }}", {
                        title: '{{ Lang.page_msg_h3 || "提示：" }}'
                    });
                    return false;
                }
                submit(data.field);
                return false;
            });

            form.verify({
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });

            form.on('select(account_id)', function(data){
                // console.log(data.elem); //得到checkbox原始DOM对象
                // console.log(data.elem.checked); //开关是否开启，true或者false
                // console.log(data.value); //开关value值，也可以通过data.elem.value得到
                // console.log(data.othis); //得到美化后的DOM对象
                if(data.value){
                    getAccountRebate(data.value);
                }
            });
        });

        function submit(data) {
            $.ajax({
                url: "/member/funds/return_to_balance/submit_return_to_balance",
                async: true,
                data: data,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        layer.alert("{{ Lang.alert_submit_success || "提交成功" }}", {
                            title: '{{ Lang.page_msg_h3 || "提示：" }}'
                            ,closeBtn: 0    //是否显示关闭按钮,0隐藏 1显示
                        }, function (index) {
                            location.reload();
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

        function getAccountRebate(id) {
            $.ajax({
                url: "/member/account/mt/rebate",
                async: true,
                data: {id: id},
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    if (data.status == 200) {
                        current_rebate = data.datas.rebate / 100;
                        $("#account_balance").html("$" + current_rebate.toFixed(2));
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }
    </script>
{% endblock %}



