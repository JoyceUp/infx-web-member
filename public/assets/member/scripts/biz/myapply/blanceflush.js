$(function(){
	$("#btn_submit").click(function(){
		
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		
		$.post(
				"myapply/ajaxBlanceFlush.html",
				{
					mt:$("#account_list").val()
				},
				function(data){
					if(null!=data){
						alert(data.MSG);
						location.reload();
					}
					
					$("#btn_submit").toggle();
					$("#btn_submit_in").toggle();
					
				},"json"
		);
	});
});