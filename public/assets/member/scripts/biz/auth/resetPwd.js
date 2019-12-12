var issubing = false;
var errdiv;
var resetButton$;
var resetPwd_black$;
$(function() {
	
	resetButton$ = $('#resetPwd1');
	errdiv = $('#ERRDIV');
	resetPwd_black$ = $('#resetPwd_black');
	
	
	$('#resetPwd1').click(function() {
		// if(issubing){
		// return false;
		// }
		errdiv.empty();
		hideSendBtn();
		debugger;
		var mduEmail=$("#mduEmail").val();
		if(null==mduEmail||""==mduEmail){
			errdiv.append(resetpwdres.emailnotempty);
			showSendBtn();
			return false;
		}
		resetPwd_black$.empty().append(resetpwdres.emailsend);
		// issubing = true;
	
		var url = path + "account/resetPwd1.html?rid=" + Math.random();
		var data = {
				
			"mduEmail" : $.trim($('#mduEmail').val()),
			"type" : $('input[name="loginType"]:checked').val()
		};
		
		/*
		$.post(
				url,data,function(data){
				if("SUCCESS"==data || "EMAIL_SEND_FAIL"==data){
					errdiv.append("邮件发送成功，请到邮箱接收邮件");
					handleResend();
				}else{
					handleErr(data);
					showSendBtn();
				}},'json'
		);
		*/
		
		$.ajax({
			url :url, 
			async :false,
			data:data,
			dataType:"text",
			success:function(data){
				if("SUCCESS"==data || "EMAIL_SEND_FAIL"==data){
					errdiv.append(resetpwdres.emailsuccess);
					handleResend();
				}else{
					handleErr(data);
					showSendBtn();
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("ajax req error:"+textStatus+"\n"+
						"errorThrown:"+errorThrown);
				showSendBtn();
			}
		});
	});
});
function showSendBtn(){
	resetButton$.show();
	resetPwd_black$.hide();
}
function hideSendBtn(){
	resetButton$.hide();
	resetPwd_black$.show();
}
function handleErr(data){
	errdiv.empty();
	switch(data){
		case "PARA_ERR":
			errdiv.append(resetpwdres.para_err);
			break;
		case "EMAIL_NOT_EXISTS":
			errdiv.append(resetpwdres.emailnotexists);
			break;
		/*
		 * case "EMAIL_SEND_FAIL":
			errdiv.append("邮件发送失败");
			break;*/
	}
}
//定时
var timeReady ;
var overDate ;
var NowTime ;
var EndTime ;
function handleResend(){
	initialTimeOutPara();
	resendTimout();
}
function initialTimeOutPara(){
	timeReady = false;
	overDate = 1000 * 60 * 1;
	NowTime = new Date();
	EndTime = new Date(NowTime.getTime() + overDate);
}
function resendTimout() {
	try {
		NowTime = new Date();
		var nMS = EndTime.getTime() - NowTime.getTime();
		var nM = Math.floor(nMS / (1000 * 60)) % 60;//当前时间所对应的分钟
		var nS = Math.floor(nMS / 1000) % 60;//当前时间所对应的秒
		if (nMS >= 0) {
			resetPwd_black$.html(resendres.notemail + nM + resendres.second + nS + resendres.repeatemail);
			setTimeout("resendTimout()", 1000);
		} else {
			timeReady = true;
			showSendBtn();
		}
	} catch (e) {
		alert("second.js...resends.click..." + e.message);
	}
}