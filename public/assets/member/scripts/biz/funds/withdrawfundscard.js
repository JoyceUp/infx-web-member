//格式化数字
function format(num,length){
	 return Math.round(num*Math.pow(10,length))/Math.pow(10,length);
}
//只能输入数字
$("#amount").keydown(function(e) {
	var keyCode = e.which;
	var amount = $("#amount").val();
	//后退无限制
	if ((keyCode == 8)) {
		return true;
	}
	//开头不能为0||.
	if (amount == "" && (keyCode == 48 || keyCode == 96 || keyCode == 110 || keyCode == 190)) {
		return false;
	}
	//限制数字
	if((keyCode >= 96 && keyCode <= 105) || (keyCode >= 48 && keyCode <= 57) || keyCode == 110 || keyCode == 190 ){
		if( amount == "" ){
			return true;
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
	if ((keyCode >= 96 && keyCode <= 105)
			|| (keyCode >= 48 && keyCode <= 57) || (keyCode == 8)
			|| (keyCode == 110) || (keyCode == 190)) {
		var rate = $("#rate").val();
		var amount = $("#amount").val();
		if (amount.length == 0) {
			$("#pay").html("");
			return true;
		} else {
			var payAmount = format(rate * amount, 2);
			if (isDouble(payAmount)) {
				$("#pay").html("￥" + payAmount);
			} else {
				$("#pay").html("");
			}
			return true;
		}
	} else {
		return false;
	}
});

$(function(){
	var mt = $("#account_list").val();
	var nprofitRate = $("#nprofitRate").val();
	$("#rate_span").empty().html(nprofitRate);
	$("#rate").val(nprofitRate);
	//获取信息类型
	var info_type = $("#infoType").val();
	if('custom' == info_type){
		$("#userinfo").toggle();
	}else{
		$("#ibinfo").toggle();
	}
	//切换mt
	$("#account_list").change(function(){
		var mt_id=$("#account_list").val();
		if('7'==mt_id.substring(0,1)||'4'==mt_id.substring(0,1)){
			if('ib'!=info_type){
				info_type='ib';
				$("#userinfo").toggle();
				$("#ibinfo").toggle();
			}
		}else{
			if('custom'!=info_type){
				info_type='custom';
				$("#userinfo").toggle();
				$("#ibinfo").toggle();
			}
		}
		$("#amount").val("");
		$("#pay").empty();
	});
	
	$("#btn_submit").click(function (){
		var msgCtnSelector = "span[class='errMsg']";
		var validat = chkForm("withdrawForm", msgCtnSelector);
		if(!validat){
			return;
		}
		var amount = $("#amount").val();
		if("" == amount){
			alert(withdrawLangres.notempty);
			return;
		}else{
			var flag = isDouble(amount);
			if(flag){
				if(30.00 > amount){
					alert(withdrawLangres.lessamount);
				}else{
					$("#btn_submit").toggle();
					$("#btn_submit_in").toggle();
					$.post('funds/ajaxWithdrawfunds.html',
							{
								type:$("#type").val(),
								live_member:$("#account_list").val(),
								poundage:$("input[name='poundage']").val(),
								amount:$("#amount").val(),
								reason:$("#reason").val(),
								customer_remark:$("#customer_remark").val()
							},
							function(data){
								var thxx ='';	//提示信息
								var url = '';	//跳转url
								if(null != data){
									if("SUCCESS" == data.STATUS){
										alert(data.MSG);
									}else{
										if(null == data.res || "" == data.res || "0" == data.res){
											alert(data.MSG);
										}else{
											if('1' == data.res){
												thxx = withdrawLangres.brokenbankcus;
												url = "/user/custom.html";
											}else{
												thxx = withdrawLangres.brokenbankib;
												url = "/ib/ib.html";
											}
										}
									}
								}
								if(null == url || "" == url){
									location.reload();
								}else{
									if(confirm(thxx)){
										window.location.href = basePath + url;
									}else{
										$("#btn_submit").toggle();
										$("#btn_submit_in").toggle();
										return;
									}
								}
					},'json');
				}
			}else{
				alert(withdrawLangres.wd_rule);
				return;
			}
		}
	});
});