$(function(){
		
		$("#account_list").change(function(){
			$("#yjlxli").toggle();
		});
		
		$("#btn_submit").click(function(){
			var account=$("#account_list").val();
			var yjlx=$("#yjlxList").val();
			var alert_info=null;
			if('1'==account){
				yjlx=null;
				alert_info=commonLangres.zhu_agent;
			}else{
				alert_info=commonLangres.pt_agent;
			}
			
			$("#btn_submit").toggle();
			$("#btn_submit_in").toggle();
			
			$.post(
				"myapply/ajaxApplyAgent.html",
				{
					accountype:account,
					yjlx:yjlx
				},
				function(data){
					if(null!=data){
						if('SUCCESS'==data.STATUS){
							alert(alert_info);
						}else{
							alert(data.MSG);
						}
						
						$("#btn_submit").toggle();
						$("#btn_submit_in").toggle();
						
						location.reload();
					}
			},'json');
		});
		
	});