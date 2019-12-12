var issubing = false;
var resetButton$;
var pwdNew1$;
var pwdNew2$;
var pwdNew1EM$;
var pwdNew2EM$;

$(function(){
	resetButton$ = $('#resetPwd2');
	pwdNew1$ = $('#pwdNew1');
	pwdNew2$ = $('#pwdNew2');
	pwdNew1EM$ = $('#pwdNew1EM');
	pwdNew2EM$ = $('#pwdNew2EM');
	
	$('#pwdNew1').keyup(function(){
		chkTheNew1PWD();
	});
	$('#pwdNew2').keyup(function(){
		chkTheNew2PWD();
	});
	
	
	$('#resetPwd2').click(function(){
		debugger;
		if(issubing){
			return false;
		}
		issubing = true;
		if(!chkPara()){
			issubing = false;
			return false;
		}
		pwdNew1EM$.empty();
		pwdNew2EM$.empty();
		resetButton$.empty().append(resendres.submit_info);
		
		var url = path+"account/resetPwd3.html?rid="+Math.random();
		var data = {
				"password":$.trim(pwdNew2$.val()),
				"accountype":$('input[name="accountype"]').val(),
				"vcode":$('input[name="vcode"]').val()
		};
		$.ajax({
			url :url, 
			async :false,
			data:data,
			dataType:"text",
			success:function(data){
				debugger;
				if("SUCCESS"==data){
					alert(modifyLangres.success_info);
					window.location.href=path+"account/index.html";
				}else{
					handleErr(data);
					resetButton$.empty().append(passwordcheckres.edit_info);
				}
				issubing = false;
			},
			error:function(jqXHR, textStatus, errorThrown){
				handleErr("PARA_ERROR");
				resetButton$.empty().append(passwordcheckres.edit_info);
				issubing = false;
			}
		});
	});
});

function handleErr(data){
	$("#ERRDIV").empty();
	switch(data){
		case "PARA_ERROR":
		pwdNew2EM$.append(resetpwdres.para_err);
		break;
	}
}

function chkPara(){
	if(!chkTheNew1PWD()){
		return false;
	}
	if(!chkTheNew2PWD()){
		return false;
	}
	return true;
}

function chkTheNew1PWD(){
	$('#pwdNew1EM').empty();
	if(''==$.trim($('#pwdNew1').val())){
		$('#pwdNew1EM').append(passwordcheckres.pwdnewem);
		return false;
	}
	var pwdstrong = checkStrong($.trim($('#pwdNew1').val()),6);
	if(pwdstrong==-1){
		$('#pwdNew1EM').append(passwordcheckres.pwdlength);
		return false;
	}
	if(pwdstrong < 3){
		$('#pwdNew1EM').append(passwordcheckres.pwdtype);
		return false;
	}
	$('#pwdNew1EM').append(passwordcheckres.pwdok);
	return true;5
}
function chkTheNew2PWD(){
	$('#pwdNew2EM').empty();
	if(''==$.trim($('#pwdNew2').val())){
		$('#pwdNew2EM').append(passwordcheckres.pwdrepeat);
		return false;
	}
	if($.trim($('#pwdNew1').val())!=$.trim($('#pwdNew2').val())){
		$('#pwdNew2EM').append(passwordcheckres.pwddiffer);
		return false;
	}
	$('#pwdNew2EM').append(passwordcheckres.pwdok);
	return true;
}