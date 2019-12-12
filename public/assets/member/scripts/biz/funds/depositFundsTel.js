	$(document).ready(function(){
		
		$("#btn_submit").click(function(){
			var mt=$("#account_list").val();
			var amount=$("#amount").val();
			var deposit_tel = $("#deposit_tel").val();
			var msgCtnSelector = "span[class='errMsg']";
			var validat = chkForm("orderForm", msgCtnSelector);
			if(validat){
				if(null == deposit_tel || "" == deposit_tel || undefined == deposit_tel){
					alert(depositLangres.notemptypic);
					return;
				}
				if(""==amount){
					alert(depositLangres.notempty);
					return;
				}else{
					var flag=isInteger(amount);
					
					if(flag&&amount >=50){
						if(confirm(depositLangres.ok_mt+mt+depositLangres.deposit+amount+depositLangres.dollar)){
							
							$("#btn_submit").toggle();
							$("#btn_submit_in").toggle();
							
							$.post('funds/ajaxDepositFundsTel.html',
									{
										live_member:mt,
										amount:amount,
										pic_id_0:deposit_tel
									},function(data){
										if(null!=data){
											alert(data.MSG);
										}
										$("#btn_submit").toggle();
										$("#btn_submit_in").toggle();
										location.reload();
										
									},'json'
							);
						}else{
							return;
						}
					}else{
						alert(depositLangres.de_rule);
						return;
					}
				}
			}
		});
	});