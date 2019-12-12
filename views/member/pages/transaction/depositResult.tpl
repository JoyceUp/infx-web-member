{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}

{% endblock %}


{% block js_assets %}
    <script>
        $(function(){
            var status = getQueryString("status");
            var order_no = getQueryString("order_no");
            var amount = getQueryString("amount");
            if(status == "success"){
                $("#succMsg").show();
                $("#errMsg").hide();
                $("#order_no").text(order_no);
                $("#amount").text(amount);
            }else{
                $("#succMsg").hide();
                $("#errMsg").show();
            }
        })
    </script>

{% endblock %}

{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_transfer_depositresult_tips || "充值结果 " }}
                    </div>
                    <div class="main_head_text required"></div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">

                            <div class="register">
                                <div class="succ succ_page" id="succMsg">
                                    <div class="succ-icon">
                                        <img src="/assets/kh/images/succ-icon.png">
                                    </div>
                                    <h4><span>{{ Lang.form_text_success || " 恭喜，充值成功！ " }}</span><br/></h4>
                                    <p>{{ Lang.form_text_order_no || " 订单号 " }}:<em id="order_no"></em></p>
                                    <p>{{ Lang.form_text_recharge_amount || " 充值金额 " }}:<em id="amount"></em></p>
                           {#         <button class="layui-btn" lay-submit="" lay-filter="formSubmit1" >{{ Lang.btn_back || "返回" }}</button>#}
                                </div>
                                <div class="succ fail_page none" id="errMsg">
                                    <div class="succ-icon">
                                        <img src="/assets/kh/images/err-icon.png">
                                    </div>
                                    <h4>{{ Lang.form_text_fail || " 抱歉,充值失败！ " }}</h4>
                                  {#  <p>{{ Lang.page_reg_signup_dl_tips4 || "失败原因： " }}<em id="res_err_acc"></em></p>#}
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

{% endblock %}


