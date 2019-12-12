//格式化数字
function format(num, length) {
	return Math.round(num * Math.pow(10, length)) / Math.pow(10, length);
}
// 只能输入数字
$("#amount").keydown(
	function(e) {
		var keyCode = e.which;
		
		if ($("#amount").val() == "" && (keyCode == 48 || keyCode == 96)) 
			return false;
		if ((keyCode >= 96 && keyCode <= 105) || (keyCode >= 48 && keyCode <= 57) || (keyCode == 8)) {
			return true;
		} else {
			return false;
		}
});

$("#amount").keyup(
	function(e) {
		var keyCode = e.which;
		// debugger;
		if ((keyCode >= 96 && keyCode <= 105) || (keyCode >= 48 && keyCode <= 57) || (keyCode == 8)) {
			var rate = $("#rate").val();
			var amount = $("#amount").val();
			if (amount.length == 0) {
				$("#pay").html("");
				return true;
			} else {
				var payAmount = format(rate * amount, 2);
				$("#pay").html("￥" + payAmount);
				$("#payAmount").val(payAmount);
				return true;
			}
		} else {
			return false;
		}
});

$("#btn_submit").click(
	function() {
		var mt = $("#account_list").val();
		var amount = $("#amount").val();
		
		if ("" == amount) {
			alert(depositLangres.notempty);
			return;
		} else {
			var flag = isInteger(amount);
			if (flag && amount >= 50) {
				var rate = $("#rate").val();
				if(format(rate * amount, 2) > 40000){
					alert(depositLangres.de_wx);
					return;
				}
				if (confirm(depositLangres.ok_mt + mt
						+ depositLangres.deposit + amount
						+ depositLangres.dollar)) {
					$("#orderForm").submit();
					$("#amount").val("");
					$("#pay").html("");
					debugger;
					$("#payDiv").dialog("open");
				} else {
					return;
				}
			} else {
				alert(depositLangres.de_rule);
				return;
			}
		}
});


//check rate		
function changeProfi(mt){
	var profitMt = $("#profitMt").val();
	var profitRate = $("#profitRate").val();
	var nprofitRate = $("#nprofitRate").val();
	if(profitMt != null && profitMt != "" && profitMt != undefined  && profitMt == mt
		&&	profitRate != null && profitRate != "" && profitRate != undefined ){
		$("#rate_span").empty().html(profitRate + fundsLangres.profit_rate);
		$("#rate").val(profitRate);
	}else{
		$("#rate_span").empty().html(nprofitRate);
		$("#rate").val(nprofitRate);
	}
}

$(function() {
	
	var currentMt = $("#account_list").val();
	changeProfi(currentMt);
	$("#account_list").change(function(){
		currentMt = $("#account_list").val();
		changeProfi(currentMt);
		$("#amount").val("");
		$("#pay").empty();
	});
	
	var modifyTitle = fundsLangres.paycase;

	$("#payDiv").dialog({
		title : modifyTitle,
		autoOpen : false,
		modal : true,
		width : 758,
		height : 351,
		resizable : false,
		draggable : false,
		open : function(event, ui) {
			$(".ui-dialog-titlebar-close", $(this).parent()).hide();
		},
		buttons : [ {
			text : backres.ok,
			click : function() {
				$('#payDiv').dialog("close");
				window.location.href = window.location.href;
			}
		}, {
			text : backres.cancel,
			click : function() {
				$('#payDiv').dialog("close");
				window.location.href = window.location.href;
			}
		} ]
	});
});