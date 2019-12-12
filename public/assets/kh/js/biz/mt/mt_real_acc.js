var lastLive = 1;
var msgCtnSelector = 'i[class="reg-hint-error"]';
var isSubmit = false;
//选择页面
function liveClick(){
	switch(lastLive){
	case(1):
		if( chkForm("live1",msgCtnSelector) && valiSfz() && valiStdhhm() && valiEmail() && storePrmInf() ){
			$("#sfz_show").val($("#sfz").val());
			$('#live'+lastLive).hide();
			lastLive++;
			$('#live2').slideDown();
			$('#live'+lastLive).slideDown();
		}
		break;
	case(2):
		if( checkCsrq() && chkForm("live2",msgCtnSelector) && valiIB()){
			$('#live'+lastLive).hide();
			lastLive++;
			$('#live'+lastLive).slideDown();
			$("#err_idcard_front").removeClass("reg-hint-error");
			$("#err_idcard_back").removeClass("reg-hint-error");
			$("#err_idcard_front").empty();
			$("#err_idcard_back").empty();
		}
		break;
	case(3):
		if(isSubmit){
			alert(summitLangres.wait);
			return;
		}
		if( checkPic() && checkTk() && storeAllInf()){
			$('#live'+lastLive).hide();
			lastLive++;
			$('#live'+lastLive).slideDown();
		}
		break;
	}
}

//后退
function backStep(){
	document.documentElement.scrollTop = document.body.scrollTop =0;
	$('#live'+lastLive).hide();
	lastLive--;
	$('#live'+lastLive).slideDown();
}

//验证身份证
function valiSfz(){
	var isvali = false;
	var sfz = $("#sfz");
	var xb = $("#gender-select").val();
	var url = 'mt/mt_valiSfz.shtml?rid='+Math.random();
	var data = {'sfz':$.trim(sfz.val()),'xb' : $.trim(xb)};
	$.ajax({ 
		url :url, 
		async :false,
		data:data,
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			if('ERROR' == data.STATUS){
				$(theNextMsg(sfz,msgCtnSelector)).empty().append(data.MSG);
				sfz.focus();
			}else if("SUCCESS" == data.STATUS){
				isvali = true;
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
	return isvali;
}

//验证手机号
function valiStdhhm(){
	var isvali = false;
	var stdhhmInput = $("input[name='realmem.stdhhm']");
	var sfz = $("#sfz");
	var url = 'mt/mt_valiStdhhm.shtml?rid='+Math.random();
	var data = {'phone':$.trim(stdhhmInput.val()), 'sfz' : $.trim(sfz.val()) };
	$.ajax({ 
		url :url, 
		async :false,
		data:data,
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			if('ERROR' == data.STATUS){
				$(theNextMsg(stdhhmInput,msgCtnSelector)).empty().append(data.MSG);
				stdhhmInput.focus();
			}else if("SUCCESS" == data.STATUS){
				isvali = true;
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
	return isvali;
}

//邮箱验证
function valiEmail(){
	var isvali = false;
	var emailInput = $("input[name='realmem.email']");
	var sfz = $("#sfz");
	var url = 'mt/mt_valiEmail.shtml?rid='+Math.random();
	var data = {'email':$.trim(emailInput.val()), 'sfz' : $.trim(sfz.val()) };
	$.ajax({ 
		url :url, 
		async :false,
		data:data,
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			if('ERROR' == data.STATUS){
				$(theNextMsg(emailInput,msgCtnSelector)).empty().append(data.MSG);
				emailInput.focus();
			}else if("SUCCESS" == data.STATUS){
				isvali = true;
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
	return isvali;
}

//保存基础信息
function storePrmInf(){
	if($('#userid').val()>0){//已经保存过
		return true;
	}
	var stored = false;
	var url = 'mt/mt_storePrmInf.shtml?rid='+Math.random();
	var data = $('#formReal').serialize();
	$.ajax({ 
		url :url, 
		async :false,
		data:data,
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			if('ERROR' == data.STATUS){
				alert(backLangres.error+":"+data.MSG);
			}else if("SUCCESS" == data.STATUS){
				$('#userid').val(data.res.id);
				stored = true;
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
	
	return stored;
}

//检查年月日
function checkCsrq() {
	var year = $("#birthday-y").val();
	var month = $("#birthday-m").val();
	var day = $("#birthday-d").val();
	$("#i-csrq").empty();
	if( (year != null && year != '' && undefined != year)
		&&(month != null && month != '' && undefined != month)
		&&(day != null && day != '' && undefined != day)	
	){
		$("input[name='realmem.csrq']").val(year + "-" + month + "-" + day);
		return true;
	}else{
		$("#i-csrq").append(vailLangres.choose);
		return false;
	}
}

//检查IB是否存在
function valiIB(){
	var isvali = false;
	$(theNextMsg($('#jsrmc'),msgCtnSelector)).empty();
	$('#jsrmc').val( $.trim($('#jsrmc').val()) );
	if(''==$('#jsrmc').val() || undefined==$('#jsrmc').val()){
		return true;
	}
	var emailInput = $("input[name='realmem.email']");
	var account = $("input[name='realmemacc.accountype']");
	var sfz = $("#sfz");
	var url = 'mt/mt_valiIbMT.shtml?rid='+Math.random();
	var data = {'ib_mt_id':$('#jsrmc').val(),'email' : $.trim(emailInput.val()),'accountType' : $.trim(account.val()), 'sfz' : $.trim(sfz.val())};
	$.ajax({ 
		url :url, 
		async :false,
		data:data,
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
				if('ERROR' == data.STATUS){
					$(theNextMsg($('#jsrmc'),msgCtnSelector)).empty().append(data.MSG);
					$('#jsrmc').focus();
				}else if("SUCCESS" == data.STATUS){
					isvali = true;
				}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
	return isvali;
}

//检查身份证是否上传
function checkPic(){
	var idcard_front = $("#i_idcard_front").val();
	var idcard_back = $("#i_idcard_back").val();
	if( null == idcard_front || '' == idcard_front || undefined == idcard_front ){
		$("#err_idcard_front").addClass("reg-hint-error");
		$("#err_idcard_front").empty().append(vailLangres.not_empty);
		return false;
	}
	if(null == idcard_back || '' == idcard_back || undefined == idcard_back){
		$("#err_idcard_back").addClass("reg-hint-error");
		$("#err_idcard_back").empty().append(vailLangres.not_empty);
		return false;
	}
	return true;
}

//保存全部信息
function storeAllInf(){
	isSubmit = true;
	var stored = false;
	var url = 'mt/mt_storeAll.shtml?rid='+Math.random();
	var data = $('#formReal').serialize();
	$.ajax({
		url :url, 
		async :false,
		data:data,
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
				if('ERROR' == data.STATUS){
					isSubmit = false;
					alert(backLangres.error+":"+data.MSG);
				}else if("SUCCESS" == data.STATUS){
					stored = true;
					if(undefined!=data.res && undefined!=data.res.login){//自动创建MT
						$("#resmtid em").empty().append(data.res.login);
						$("#resmtid").removeClass("none");
						$("#msgWithMt").removeClass("none");
					}
				}
		},
		error:function(jqXHR, textStatus, errorThrown){
			isSubmit = false;
			alert(backLangres.error);
		}
	});
	return stored;
}
//检查条款
function checkTk(){
	if($("#i-check").is(":checked")){
		$("#i-check-i").empty();
		return true;
	}else{
		$("#i-check-i").empty().append(vailLangres.choose);
		return false;
	}
}