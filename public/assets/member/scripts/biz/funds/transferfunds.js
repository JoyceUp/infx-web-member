$(function(){
	//只能输入数字
	$("#amount").keydown(function(e) {
		var keyCode = e.which;
		var amount = $("#amount").val();
		//后退无限制
		if ((keyCode == 8)) {
			return true;
		}
		//开头不能为0||.
		if (amount == "" && (keyCode == 110 || keyCode == 190)) {
			return false;
		}
		//限制数字
		if((keyCode >= 96 && keyCode <= 105) || (keyCode >= 48 && keyCode <= 57) || keyCode == 110 || keyCode == 190 ){
			if( amount == "" ){
				return true;
			}
			if(amount == "0" && amount.toString().length == 1 && keyCode != 110 && keyCode != 190){
				return false;
			}
			var isDecimal = amount.toString().indexOf(".") > -1;
			if(isDecimal){
				if((keyCode == 110 || keyCode == 190)){
					return false;
				}
				if(amount.toString().substr(amount.toString().indexOf(".") + 1,amount.toString().length).length >= 2){
					return false;
				}
			}
			var flag = doLimitNumberSize(amount, 8);
			if( !isDecimal && !flag && (keyCode == 110 || keyCode == 19)){
				return true;
			}
			return flag;
		}else{
			return false;
		}
	});

	$("#amount").keyup(function(e) {
		var keyCode = e.which;
		if ($("#amount").val() == "" && (keyCode == 48 || keyCode == 96)) {
			return false;
		}
		if ((keyCode >= 96 && keyCode <= 105)
				|| (keyCode >= 48 && keyCode <= 57) || (keyCode == 8)
				|| (keyCode == 110) || (keyCode == 190)) {
			return true;
		} else {
			return false;
		}
	});
	
	$("#btn_submit").click(function(){
		var amount=$("#amount").val();
		var output=$("#outputAccount").val();
		var input=$("#inputAccount").val();
		var msgCtnSelector = "span[class='errMsg']";
		var validat = chkForm("transferForm", msgCtnSelector);
		if(!validat){
			return;
		}
		if(!checkInput(output, input)){
			alert(transferLangres.error_input);
			return;
		}
		if(output==input){
			alert(transferLangres.notequal);
			return;
		}
		if(checkIfProfit(output) || checkIfProfit(input)){
			alert(transferLangres.tf_not_profit);
			return;
		}
		if(""==amount){
			alert(transferLangres.notempty);
			return;
		}else{
			var flag=isDouble(amount);
			if(flag){
					if(confirm(transferLangres.tf_confirm_apply)){
						$("#btn_submit").toggle();
						$("#btn_submit_in").toggle();
						$.post('funds/ajaxTransferfunds.html',
								{
									type:$("#type").val(),
									output:$("#outputAccount").val(),
									input:$("#inputAccount").val(),
									amount:$("#amount").val()
								},
								function(data){
									if(null!=data){
										alert(data.MSG);
									}
									$("#btn_submit").toggle();
									$("#btn_submit_in").toggle();
									location.reload();
									
								},'json');
						}
			}else{
				alert(transferLangres.tf_rule);
				return;
			}
		}
	});
})

//转账限制
function checkInput(output,input){
	var p_output=output.substr(0 ,1);
	var p_input=input.substr(0 ,1);
	if(p_output == p_input){
		return true;
	}else if('4'==p_output||'7'==p_output){
		if('7'==p_input||'8'==p_input){
			return true;
		}else{
			return false;
		}
	}else if('8'==p_output){
		if('8'==p_input){
			return true;
		}else{
			return false;
		}	
	}else{
		return false;
	}
}

function checkIfProfit(mt){
	var flag = false;
	$.ajax({ 
		url :basePath + "profit/checkProfit.html",
		async :false,
		data:{"mt":$.trim(mt)},
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			if(data.STATUS == "SUCCESS"){
				flag = true; 
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
	return flag;
}