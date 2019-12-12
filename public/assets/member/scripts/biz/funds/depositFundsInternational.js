//格式化数字
	function format(num,length){
		 return Math.round(num*Math.pow(10,length))/Math.pow(10,length);
	}
    //只能输入数字
	$("#amount").keydown(function(e){
		var keyCode = e.which;
			if((keyCode >=96 && keyCode <= 105) || (keyCode >=48 && keyCode <= 57) || (keyCode == 8)) {
				return true;
			}
			else {
				return false;
				}
		});
		
		$("#amount").keyup(function(e){
			var keyCode = e.which;
//			debugger;
			if((keyCode >=96 && keyCode <= 105) || (keyCode >=48 && keyCode <= 57) || (keyCode == 8)) {
				var amount = $("#amount").val();
				return true;
			}
			else {
				return false;
			}
		});
	
	$("#account_list").change(function(){
		getCardType();
	});
	
		$("#btn_submit").click(function(){
			var msgCtnSelector = "span[class='errMsg']";
			var validat = chkForm("orderForm", msgCtnSelector);
			var mt=$("#account_list").val();
			var amount=$("#amount").val();
			if(validat){
				if(checkIfProfit(mt)){
					alert(depositLangres.not_profit);
					return;
				}
				var flag=isInteger(amount);
				if(flag&&amount >=50){
					if(confirm(depositLangres.ok_mt+mt+depositLangres.deposit+amount+depositLangres.dollar)){
						var card_type = $("#card_type").val();
						$("#card_type").val(card_type.toLowerCase());
						
						$("#card_type").val(card_type);
						$("#orderForm").submit();
						$("#amount").val("");
						$("#pay").html("");
						debugger;
						$("#payDiv").dialog("open");
					}else{
						return;
					}
				}else{
					alert(depositLangres.de_rule);
					return;
				}
			}
		});

		function getCardType(){
			$.ajax({
				url :"funds/findCardType.html", 
				async :false,
				cache :false,
				data:{
					mt : $("#account_list").val()
				},
				dataType:"json",
				success:function(data){
					if("SUCCESS"==data.STATUS){
//						var res = data.res.split("$$");
//						$("#card_type").val(res[0]);
//						$("#user_type").val(res[1]);
						$("#card_type").val(data.res);
					}else{
						alert(data.MSG);
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("ajax req error:"+textStatus+"\n"+
							"errorThrown:"+errorThrown);
				}
			});
			
		}
$(function(){

	var modifyTitle=fundsLangres.paycase;
	
	$("#payDiv").dialog({
		title:modifyTitle,
		autoOpen: false,
		modal: true,
		width: 758,
		height:351,
		resizable :false,
		draggable :false,
		open: function (event, ui) {
             $(".ui-dialog-titlebar-close", $(this).parent()).hide();
         },
		buttons: [
			{
				text: backres.ok,
				click: function() {
					$('#payDiv').dialog( "close" );
					window.location.href=window.location.href;
				}
			},
			{
				text: backres.cancel,
				click: function() {
					$('#payDiv').dialog( "close" );
					window.location.href=window.location.href;
				}
			}
		]
	});
	
	getCardType();
});

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