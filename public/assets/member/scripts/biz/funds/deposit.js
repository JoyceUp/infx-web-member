function gotoDepositFundsInternational() {
	var thxx='';
	var url='';
	$.ajax({
		type :"get",
		url :"funds/findCreditCardMsg.html", 
		async :false,
		cache :false,
		dataType:"json",
		success:function(data){
			if("SUCCESS"==data.STATUS){
				var flag = data.res;
				if(flag == "denied"){
					alert(data.MSG);
					window.location.href = basePath + "funds/deposit.html";
				}else if(flag == "user"){
					thxx=withdrawLangres.brokencreditcus;
					if(confirm(thxx)){
						window.location.href=basePath+"/user/custom.html";
					}else{
						return;
					}
				}else if(flag == "ib"){
					thxx=withdrawLangres.brokencreditib;
					if(confirm(thxx)){
						window.location.href=basePath+"/ib/ib.html";
					}else{
						return;
					}
				}else if(flag == "true"){
					window.location.href=basePath+"/funds/depositFundsInternational.html";
				}
			}
		},
	});

		

}