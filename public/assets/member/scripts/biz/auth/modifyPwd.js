$.curCSS=$.css;

var isinitial_pwd = 1;//不需要强制修改密码

var modifyPwdDiv = $('#modifyPwdDiv');
/*var isOldPwdCor = 0;*/ 
var isOldPwdCor = 1;//0尚未检查，1正在检查，2验证成功，3密码不符
var isSubing = false;

function modifyPwd(){
	cleanModifyPwd();
	$('#modifyPwdDiv').dialog("open");
}
function modifyPwdSub(){
	if(isSubing){
		return false;
	}
	isSubing = true;
	
	if(!chkPara()){
		isSubing = false;
		return false;
	}
	
	$('#pwdOldEM').empty();
	var url= basePath + "/account/modifyPwd.html?rid="+Math.random();
	var data={
		"passwordOld":$.trim($('#pwdOld').val()),
		"password":$.trim($('#pwdNew1').val())
		};
	$.ajax({
		url :url, 
		async :false,
		data:data,
		dataType:"text",
		success:function(data){
			switch(data){
				case "SUCCESS":
					//$('#pwdOldEM').append("OK");
					//isOldPwdCor=2;
					alert(modifyLangres.success_info);
					$('#modifyPwdDiv').dialog( "close" );
					break;
				case "FAIL":
					$('#pwdOldEM').append(modifyLangres.fail_info);
					isOldPwdCor=3;
					break;
				case "WRONG":
					$('#pwdOldEM').append(modifyLangres.wrong_info);
					isOldPwdCor=3;
					break;
				case "SESSION_EXP":
					$('#pwdOldEM').append(modifyLangres.session_exp);
					isOldPwdCor=3;
					break;
				default:
					$('#pwdOldEM').append(modifyLangres.error_info);
					break;
			}
			isSubing = false;
			//cleanModifyPwd();
		},
		error:function(jqXHR, textStatus, errorThrown){
			alert("ajax req error:"+textStatus+"\n"+
					"errorThrown:"+errorThrown);
			isSubing = false;
		}
	});
}
function chkPara(){
	if(''==$.trim($('#pwdOld').val())){
		$('#pwdOldEM').empty().append(passwordcheckres.pwdoldem);
		return false;
	}
	
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
	return true;
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
function cleanModifyPwd(){
	$('#pwdOld').val('');
	$('#pwdNew1').val('');
	$('#pwdNew2').val('');
	$('#pwdOldEM').empty();
	$('#pwdNew1EM').empty();
	$('#pwdNew2EM').empty();
}
$(function(){
	
	
	
	$('#pwdNew1').keyup(function(){
		chkTheNew1PWD();
	});
	$('#pwdNew2').keyup(function(){
		chkTheNew2PWD();
	});
	
	$('#pwdOld').blur(function(){
		if(1==isOldPwdCor){
			return false;
		}
		isOldPwdCor = 1;
		
		$('#pwdOldEM').empty();
		var pwdOldVal = $.trim($(this).val());
		if(''==pwdOldVal){
			$('#pwdOldEM').append(passwordcheckres.pwdem);
			isOldPwdCor = 0;
			return false;
		}
		
		var url=path+"/account/modifyPwd.html?rid="+Math.random();
		var data={"passwordOld":pwdOldVal};
		$.ajax({
			url :url, 
			async :true,
			data:data,
			dataType:"text",
			success:function(data){
				switch(data){
					case "SUCCESS":
						$('#pwdOldEM').append(passwordcheckres.pwdok);
						isOldPwdCor=2;
						break;
					case "ERROR":
						$('#pwdOldEM').append(modifyLangres.wrong_info);
						isOldPwdCor=3;
						break;
					case "WRONG":
						$('#pwdOldEM').append(modifyLangres.wrong_info);
						isOldPwdCor=3;
						break;
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("ajax req error:"+textStatus+"\n"+
						"errorThrown:"+errorThrown);
				isOldPwdCor=3;
			}
		});
	});

	var modifyTitle;
	if('0' == isinitial_pwd){
		modifyTitle = passwordcheckres.pwdno;
	}else{
		modifyTitle = passwordcheckres.pwdemail;
	}
	$("#modifyPwdDiv").dialog({
		title:modifyTitle,
		autoOpen: false,
		modal: true,
		width: 750,
		height:360,
		resizable :false,
		draggable :false,
		open: function (event, ui) {
             $(".ui-dialog-titlebar-close", $(this).parent()).hide();
         },
		buttons: [
			{
				text: backres.ok,
				click: function() {
					modifyPwdSub();
				}
			},
			{
				text: backres.cancel,
				click: function() {
					if('0' != isinitial_pwd){
						$('#modifyPwdDiv').dialog( "close" );
						cleanModifyPwd();
					}
				}
			}
		]
	});
	
	
	/*if('0' == isinitial_pwd){
		modifyPwd();
	}*/
});
