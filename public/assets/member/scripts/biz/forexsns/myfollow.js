function go(page){
	$("#page").val(page);
	$("#myfollowForm").submit();
}
	
function _onwatch(mid){
	if(confirm(forexsnsRank.qx_relation)){
		$.ajax({
			url :basePath + "forexsns/ajaxBindAdvisor.html",
		async :false,
		data:{"mid":mid,"action":false},
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			$("#myfollowForm").submit();
			},
			error:function(jqXHR, textStatus, errorThrown){}
		});
	}
}

function _advisor(mid){
	window.location.href = basePath + "forexsns/advisor.html?mid=" + mid;
}