$(document).ready(function(){
$("#btn_submit").click(function(){
			var depositFunds=$("#depositFunds").val();
			var rate=$("#rate").find("option:selected").text();
			var live_member=$("#live_member").val();
			if(null==live_member){
				alert(applygoldLangres.nomt);
				return;
			}
			if('7'==live_member.substr(0,1)||'4'==live_member.substr(0,1)){
				alert(applygoldLangres.ap_not_ib);
				return;
			}
			if(""==depositFunds){
				alert(applygoldLangres.notempty);
				return;
			}else{
				var flag=isDouble(depositFunds);
				
				if(flag){
					if(confirm(live_member+"  "+applygoldLangres.ap_confirm_px+"  "+depositFunds+applygoldLangres.ap_confirm_mx+rate+applygoldLangres.ap_confirm_sx)){
						$("#btn_submit").toggle();
						$("#btn_submit_in").toggle();
						
						$.post('funds/ajaxApplyGoldFunds.html',
								{
									live_member:$("#live_member").val(),
									depositFunds:$("#depositFunds").val(),
									rate:$("#rate").val()
								},
								function(data){
									if(null!=data){
										alert(data.MSG);
									}
									
									$("#btn_submit").toggle();
									$("#btn_submit_in").toggle();
									location.reload();
									
								},'json');
					}else{
						return;
					}
				}else{
					alert(applygoldLangres.ap_rule);
					return;
				}
			}
		});
});