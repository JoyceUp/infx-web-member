{% extends '../../common/layouts/layout.tpl' %}


{% block css_assets %}
<link href="/assets/member/styles/plugins/jquery.step.css" rel="stylesheet" type="text/css">
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
      integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!--表单验证-->
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
<style>
    p{
        margin: 8px 0 10px;
    }
    button {
        display: inline-block;
        padding: 6px 12px;
        font-size: 14px;
        line-height: 1.42857143;
        text-align: center;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 4px;
        color: #fff;
        background-color: #dad9d9;
    }

    .main {
        width: 100%;
        margin: 50px auto 30px;
    }

    #step,.ui-step {
        height: 96px;
    }

    .btns {
        float: left;
        width: 100%;
        padding-top: 30px;
    }

    .btns #nextBtn {
        float: right;
    }
    .warninginfo{
        color:red;
        font-size: 12px;
        font-weight: normal;
        display: none;
    }
    .warning input{
        vertical-align: top;
     }
    .info {
        float: left;
        height: 34px;
        line-height: 34px;
        margin-left: 40px;
        font-size: 28px;
        font-weight: bold;
        color: #928787;
    }

    .info span {
        color: red;
    }

    .tab-pane {
        display: none;
    }

    #RealAccountWizardTab1.tab-pane {
        display: block;
    }
    .sign-date-year,
    .sign-date-month,
    .sign-date-day{
        display: inline-block;

    }
    .submitInfo{
        text-align: center;
    }
    #submitInfo{
        display: none;
    }
    #step-fun{
        position: relative;
    }
    .warninginfo.step-next-tips{
        position: absolute;
        top: -45px;
        left: 34.5%;
    }
    #RealAccountWizardTab8 .form-control-static{
        display: inline-block;
        margin: 0px;
        padding: 0;
    }
    #RealAccountWizardTab2 .form-control-static{
        display: inline-block;
        margin: 8px 0 10px;
        padding: 0;
        min-height:12px
    }
    #RealAccountWizardTab5 input[type=checkbox]{
        vertical-align: top;
    }
    .form-control-static{
        padding-top: 0;
        min-height:12px
    }
</style>
{% endblock %}


{% block content %}
<div class="real_accounts main_content" style=" ">
    <div class="main container">
        <div id="step"></div>
        {% include "./step/RealAccountWizardTab1.html" %}
        {% include "./step/RealAccountWizardTab2.html" %}
        {% include "./step/RealAccountWizardTab3.html" %}
        {% include "./step/RealAccountWizardTab4.html" %}
        {% include "./step/RealAccountWizardTab5.html" %}
        {% include "./step/RealAccountWizardTab6.html" %}
        {% include "./step/RealAccountWizardTab7.html" %}
        {% include "./step/RealAccountWizardTab8.html" %}
        {% include "./step/RealAccountWizardTab9.html" %}
    </div>
    <!-- 步骤验证 -->
    <div class="step-next-verify">
        <div  style="margin-top: 30px; display: table; width: 100%">
            <div class="col-md-4 col-sm-12">Pernyataan menerima</div>
            <div class="col-md-8 col-sm-12">
                <label class="radio-inline">
                    <input type="radio" name="RealAccountSimulationStatementAccept" value="1" class="valid-true">
                    Ya
                </label>
                <label class="radio-inline" disabled="disabled">
                    <input type="radio" name="RealAccountSimulationStatementAccept" disabled  value="0" class="valid">
                    Tidak
                </label>
            </div>
        </div>
        <div style="margin-top: 30px; display: table; width: 100%">
            <div class="col-md-4 col-sm-12">Menyatakan pada Tanggal</div>
            <div class="col-md-8 col-sm-12"> {{ userDatas.gmt_modified }}</div>
        </div>
    </div>
    <div class="btns" id="step-fun">
        <span class="warninginfo step-next-tips" style="width: 100%; ">This field is required.</span>
        <button id="prevBtn">Previous</button>
        <button id="nextBtn"  class="submit" type="submit">Next</button>
        {% if userDatas.state === 1 %}
        <button id="submitInfo">submitInfo</button>
        {% else %}
        <button id="submitInfo"  onClick="javascript :history.back(-1);">Back</button>
        {% endif %}
    </div>
</div>
</div>
{% endblock %}


{% block js_assets %}

<script type="text/javascript">
    $(document).ready(function () {
        stepBoxDisplay();
       // getAccountInfo(userFormId);
        wealthOthers();
        wealthTotal();
        wealthTimeDeposit();
        wealthHouseTaxValue();
    });
    var $step = $("#step");
    var accountsState = $(".accounts-state").html();
    var stepBox = $('.tab-pane');
    var stepVerify = $('.valid-true');
    var userFormId = getQueryString("no");
    var confirmationVerify = $('#RealAccountWizardTab5').find('.confirmation-verify').find('input');
    var confirmationVerifySix = $('#RealAccountWizardTab6').find('.confirmation-verify').find('input');

    //页面初始化步骤条
    $step.step({
        index: 0,
        time: 500,
        title: ["Step 1", "Step 2.1", "Step 2.2", "Step 3", "Step 4", "Step 5", "Step 6", "Step 7", "Step 8"],
    });
    function wealthOthers(){
       var textNumber = $('.wealth_others').text().trim();
       $('.wealth_others').text(toThousands(textNumber));
    }
    function wealthTotal(){
       var textNumber = $('.wealth_total').text().trim();
       $('.wealth_total').text(toThousands(textNumber));
    }
    function wealthTimeDeposit(){
       var textNumber = $('.wealth_time_deposit').text().trim();
       $('.wealth_time_deposit').text(toThousands(textNumber));
    }
    function wealthHouseTaxValue(){
       var textNumber = $('.wealth_house_tax_value').text().trim();
       $('.wealth_house_tax_value').text(toThousands(textNumber));
    }

    //数字千位符格式化
    function toThousands(Id) {
        value = Id.toString().replace(/,/g,'');
        var num = (value || 0).toString(), result = '';
        while (num.length > 3) {
            result = ',' + num.slice(-3) + result;
            num = num.slice(0, num.length - 3);
        }
        if (num) {
            result = num + result;
        }
        return result;
    }

    //页面跳转上一步
    $("#prevBtn").on("click", function () {
        $step.prevStep();
        stepBoxDisplay();
        window.scrollTo(0, 0);
    });

    //页面初始化step5/6所有checked为不可选择
    $(confirmationVerify).each(function() {
        $(this).attr('disabled', 'false');
    });
    $(confirmationVerifySix).each(function() {
        $(this).attr('disabled', 'false');
    });

    if( accountsState == 1 ){
        //页面跳转下一步
        $("#nextBtn").on("click", function () {
            if($step.getIndex() == 4){
                if( typeof confirmationItemsVerify() == "number" ){
                    window.scrollTo(0, confirmationItemsVerify() - 260);
                    return  false;
                }
            }
            if($step.getIndex() == 5){
                if( typeof confirmationItemsVerifySix() == "number" ){
                    window.scrollTo(0, confirmationItemsVerifySix() - 260);
                    return  false;
                }
                if($('#RealAccountStepFifeBranchId1').val() == ""){
                    $('.step-6-select-tips').show()
                    return  false;
                }
                if($('#RealAccountStepFifeSettlementOfDisputes1PengadilanNegeri').is(':checked') &&  $('#RealAccountSfftForm24PengadilanNegeri').val() == "" ){
                    $('.step-6-input-tips').show()
                    return  false;
                }
            }
            if ($(stepVerify).is(':checked')) {
                $('.step-next-tips').hide();
                $step.nextStep();
                $(stepVerify).removeAttr("checked");
                stepBoxDisplay();
                window.scrollTo(0, 0);
            } else {
                $('.step-next-tips').show()
            }
        });
        $('#RealAccountStepFifeBranchId1').change(function(){
            if($('#RealAccountStepFifeBranchId1').val() == 1){
                $('.step-6-select-tips').hide()
            }
        })
        $('#RealAccountStepFifeSettlementOfDisputes1Bakti').change(function(){
            $('#RealAccountStepFifeSettlementOfDisputes1PengadilanNegeri').removeAttr("checked");
        })
        $('#RealAccountSfftForm24PengadilanNegeri').blur(function(){
            $('.step-6-input-tips').hide()
        })

        //页面初始化step5/6所有checked为第一个可选择
        $(confirmationVerify).eq(0).removeAttr('disabled');
        $(confirmationVerifySix).eq(0).removeAttr('disabled');
        if($('#RealAccountStepFifeSettlementOfDisputes1Bakti').is(':checked')){
            $('#RealAccountSfftForm24PengadilanNegeri').attr('disabled',true);
            // $('#RealAccountStepFifeBranchId1').attr('disabled',true);
        }
        //必填选项提示文字
        $(stepVerify).change(function() {
            if ($(stepVerify).is(':checked')) {
                $('.step-next-tips').hide()
            } else {
                $('.step-next-tips').show()
            }
        })

        //步骤跳转 只可以跳转当前步骤的向前
        $(".ui-step-item").on("click", function (e) {
            if ($(this).index() < $step.getIndex()) {
                $step.toStep($(this).index());
                stepBoxDisplay();
            }
        });

        //step5条款确认
        function confirmationItemsVerify(){
            for(var i = 0; i < confirmationVerify.length; i++){
                if($(confirmationVerify[i]).is(':checked')){
                    $(confirmationVerify[i]).siblings('strong').find('span').hide()
                }else{
                    $(confirmationVerify[i]).siblings('strong').find('span').css("display","block");
                    $(confirmationVerify).each(function() {
                        $(this).attr('disabled', 'false');
                    });
                    $(confirmationVerify[i]).removeAttr('disabled');
                    return $(confirmationVerify[i]).offset().top;
                }
            }
        }
        $(confirmationVerify).change(function(){
            confirmationItemsVerify();
        })

        //step6条款确认
        function confirmationItemsVerifySix(){
            for(var i = 0; i < confirmationVerifySix.length; i++){
                if($(confirmationVerifySix[i]).is(':checked')){
                    $(confirmationVerifySix[i]).siblings('strong').find('span').hide()
                }else{
                    $(confirmationVerifySix[i]).siblings('strong').find('span').css("display","block");
                    $(confirmationVerifySix).each(function() {
                        $(this).attr('disabled', 'false');
                    });
                    $(confirmationVerifySix[i]).removeAttr('disabled');
                    return $(confirmationVerifySix[i]).offset().top;
                }
            }
        }
        $(confirmationVerifySix).change(function(){
            confirmationItemsVerifySix();
        })
        $('.s51-settlement_of_disputes').change(function(){
            if($('#RealAccountStepFifeSettlementOfDisputes1Bakti').is(':checked')){
                $('#RealAccountSfftForm24PengadilanNegeri').attr('disabled',true);
               // $('#RealAccountStepFifeBranchId1').attr('disabled',true);
            }else{
                $('#RealAccountSfftForm24PengadilanNegeri').removeAttr('disabled');
                // $('#RealAccountStepFifeBranchId1').removeAttr('disabled');
            }
        })

        // 确认开户
        $("#submitInfo").on("click", function () {
            if($('#RealAccountWaiverClientAccept').is(':checked')){
                $('.opne-acc-submit-tips').hide()
                var programme = $('.s51-settlement_of_disputes').val();
                var court = $('#RealAccountSfftForm24PengadilanNegeri').val();
                var branch = $('#RealAccountStepFifeBranchId1').val();
                $("#submitInfo").attr('disabled', true);
                $("#submitInfo").css({
                    "background": "#dad9d9",
                    "cursor": "not-allowed"
                })
                $.ajax({
                    url: '/member/real_accounts/confirm',
                    async: true,
                    data: {
                        "id":userFormId,
                        "programme":programme,
                        "court":court,
                        "branch":branch
                    },
                    type: 'post',
                    dataType: 'json',
                    contentType: "application/x-www-form-urlencoded;charset=utf-8",
                    success: function (data) {
                        if(data.status == 200){
                            layer.open({
                                content: '{{ Lang.form_confirm_succee_tips_ok || "提交成功，请等待审核！"}} ',
                                yes: function(index, layero){
                                    //do something
                                    layer.close(index); //如果设定了yes回调，需进行手工关闭
                                    window.location.href = "/member/real_accounts/list"
                                }
                            });
                        }else {
                            layer.open({
                                content: '{{ Lang.form_confirm_succee_tips_failed || "提交失败，请等重新提交！"}} ',
                                yes: function(index, layero){
                                    //do something
                                    layer.close(index); //如果设定了yes回调，需进行手工关闭
                                }
                            });
                            $("#submitInfo").attr('disabled', false);
                            $("#submitInfo").css({
                                "background": "#64BD2E",
                                "cursor": "pointer"
                            })
                        }
                    }
                });
            }else{
                $('.opne-acc-submit-tips').show();
                $('.opne-acc-submit-tips').css('display','block');
            }
        });

    }else{
        //步骤跳转 只可以跳转当前步骤的向前
        $(".ui-step-item").on("click", function (e) {
            $step.toStep($(this).index());
            stepBoxDisplay();
            window.scrollTo(0, 0);
        });
        //页面跳转下一步
        $("#nextBtn").on("click", function () {
            $step.nextStep();
            stepBoxDisplay();
            window.scrollTo(0, 0);
        });

        $(confirmationVerify).each(function() {
            $(this).attr('checked', true);
        });
        $(confirmationVerifySix).each(function() {
            $(this).attr('checked', true);
        });
        $(stepVerify).attr('checked',true);
        $(stepVerify).attr('disabled',true);
        $('#107BPK022').removeClass('hidden');
        $('.step-next-verify').css({
            "display": "block",
        });
       // $('#RealAccountTradeExperienceExperienced').attr('disabled',true);
        $('.s51-settlement_of_disputes').attr('disabled',true);
        $('#RealAccountSfftForm24PengadilanNegeri').attr('disabled',true);
        $('#RealAccountStepFifeBranchId1').attr('disabled',true);
        $('#submitInfo').css({
            "background": "#64BD2E",
            "cursor": "pointer"
        });
    }

    //翻页按钮
    function stepBoxDisplay() {
        $(stepBox).css("display", "none");
        $(stepBox[$step.getIndex()]).css("display", "block");
        if ($step.getIndex() == 0) {
            $('#prevBtn').css({
                "background": "#dad9d9",
                "cursor": "not-allowed"
            });
            $('#nextBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer",
                "display": "block"
            });
            $('#submitInfo').css({
                "display": "none",
            });
        } else if ($step.getIndex() == 8) {
            $('#nextBtn').css({
                "display": "none",
            });
            $('#submitInfo').css({
                "display": "block",
                "float": "right",
            });
            $('.step-next-verify').css({
                "display": "none",
            });
            $('#prevBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer"
            });
        }/* else if ($step.getIndex() == 2) {
            $('.step-next-verify').css({
                "display": "none",
            });
        }*/ else {
            $('#prevBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer"
            });
            $('#nextBtn').css({
                "background": "#64BD2E",
                "cursor": "pointer",
                "display": "block"
            });
            $('#submitInfo').css({
                "display": "none",
            });
            $('.step-next-verify').css({
                "display": "block",
            });
        }


    }

    //
    $('#RealAccountWaiverClientAccept').change(function(){
        if($('#RealAccountWaiverClientAccept').is(':checked')){
            $('#submitInfo').css({
                "background": "#64BD2E",
                "cursor": "pointer",
            })
        }else{
            $('#submitInfo').css({
                "background": "#dad9d9",
                "cursor": "not-allowed",
            });
        }
    })

    //RealAccountTradeExperienceExperienced
    /*$('#RealAccountTradeExperienceExperienced').change(function () {
        if ($('#RealAccountTradeExperienceExperienced').val() && $('#RealAccountTradeExperienceExperienced').val() == 1) {
            $('#107BPK022').removeClass('hidden');
            $('.step-next-verify').css({
                "display": "block",
            });
            $('.step-next-tips').hide();
        } else if ($('#RealAccountTradeExperienceExperienced').val() == 0) {
            $('#107BPK022').addClass('hidden');
            $('.step-next-verify').css({
                "display": "none",
            });
        }
    });*/


</script>

{% endblock %}
