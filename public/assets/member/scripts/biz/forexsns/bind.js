$(function(){
	$("#btn_submit").click(function(){
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		$.ajax({
			url :basePath + "forexsns/ajaxRepalceBindMt4.html",
			async :false,
			data:{"mt":$.trim($("#account_list").val())},
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
	});
})