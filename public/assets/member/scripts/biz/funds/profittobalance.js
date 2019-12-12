$("#amount").keydown(function(e){
 var keyCode = e.which;
	if((keyCode >=96 && keyCode <= 105) || (keyCode >=48 && keyCode <= 57) || (keyCode == 8)|| (keyCode == 110)|| (keyCode == 190)) {
		return true;
	}
	else {
		return false;
	}
});

$("#amount").keyup(function(e){
	var keyCode = e.which;
	if((keyCode >=96 && keyCode <= 105) || (keyCode >=48 && keyCode <= 57) || (keyCode == 8)|| (keyCode == 110)|| (keyCode == 190)) {
			return true;
	}
	else {
		return false;
	}
});

$("#btn_submit").click(function(){
	if(chkForm("form", 'span[class="errMsg"]')){
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		var mt = $("#mt").val();
		var amount = $("#amount").val();
		$.ajax({ 
			url :basePath + "profit/ajaxProfitToBalance.html",
			async :false,
			data:{"mt":$.trim(mt),"amount":$.trim(amount)},
			type:'POST',
			dataType:'json',
			contentType:'application/x-www-form-urlencoded;charset=utf-8;',
			success:function(data){
				if(null!=data){
					alert(data.MSG);
					location.reload();
				}
				$("#btn_submit").toggle();
				$("#btn_submit_in").toggle();
			},
			error:function(jqXHR, textStatus, errorThrown){}
		});
	}
});
	
function checkCredit(){
	var flag = false;
	var mt = $("#mt").val();
	var amount = $("#amount").val();
	$.ajax({ 
		url :basePath + "profit/checkCredit.html",
		async :false,
		data:{"mt":$.trim(mt),"amount":$.trim(amount)},
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

$("#mt").change(function(){
	var mt = $("#mt").val();
	$.ajax({ 
		url :basePath + "profit/getCurrentCredit.html",
		async :false,
		data:{"mt":$.trim(mt)},
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			if(data.STATUS == "SUCCESS"){
				$("#currCredit").empty().html(data.res);
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
});