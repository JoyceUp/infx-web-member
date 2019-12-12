<div class="register">
    <div class="succ succ_page">
        <div class="succ-icon">
            <img src="/assets/kh/images/succ-icon.png">
        </div>
        <h4>
            <span>{{ Lang.page_register_submit_succ_msg || "提交成功，请查收邮件激活账户" }}</span><br/>
        </h4>
        <p></p>
        <p></p>
    </div>
    <div class="succ fail_page none">
        <h4>{{ Lang.page_register_step4_tips3 || "抱歉！注册失败！失败原因为 " }}<em id="res_err_acc"></em></h4>
    </div>
</div>

{% block js_assets %}
    {#/member/account/mt#}

{% endblock %}