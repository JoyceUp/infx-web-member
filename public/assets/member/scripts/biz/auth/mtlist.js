//翻页(已弃用)
function go(pageNum){
	$('#pageNum').val(pageNum);
	var p_type=$("#atype").val();
	var p_status=$("#astatus").val();
	$("#accounttype").val(p_type);
	$("#statusval").val("1");
	$('#mtlstFrom').submit();
}

//隐藏账号
function hideRow(mt){
	$.ajax({
		type : "post",
		url : basePath+"account/hideAccount.html",
		data : { account : mt },
		success : function(e) {
			$('#mtlstFrom').submit();
		},
		error : function() {
			$('#mtlstFrom').submit();
		}
	});
}

//显示所有账号
function showAllAccount(){
	var hideNum = $("#hideNum").val();
	if(null != hideNum && 0 !=hideNum && undefined != hideNum){
		$.ajax({
			type : "post",
			url : basePath+"account/showAllAccount.html",
			success : function(e) {
				$('#mtlstFrom').submit();
			},
			error : function() {
				$('#mtlstFrom').submit();
			}
		});
	}
}

$(document).ready(function(){
	
	$("#btn_submit").click(function(){
		var p_type=$("#atype").val();
		var astatus = $("#astatus").val();
		$("#accounttype").val(p_type);
		$("#statusval").val(astatus);
		$('#pageNum').val(0);
		$('#mtlstFrom').submit();
	});
	
	 $('table.display').dataTable({
	 	'bStateSave': true,//页面刷新后保留当前页
		"pagingType": "full_numbers",
		"info": false,//基本信息开关
		lengthChange: false,//显示条数设置开关
		searching: false,
		"stripeClasses": ['', 'odd'],
		"dom": '<"top"i>rt<"bottom"flp><"clear">',
		"language": {
			'paginate': {  
             'first':      commonLangres.first_page, 
             'last':       commonLangres.last_page, 
             'next':       commonLangres.next_page,  
             'previous':   commonLangres.back_page  
         },  
		},"aoColumnDefs": [
		   				{ "sType": "html-percent",
		   					"aTargets":[4]
		   				},
		   				{ "bSortable": false, "aTargets": [ 6 ] }
		   		]
		});
});
