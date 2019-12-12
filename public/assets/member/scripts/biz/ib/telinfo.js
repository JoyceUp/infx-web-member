$(function(){
	
	
	var inputs = $('#form '+'input[vali="require"]');
	var v;

	for(var i=0; i<inputs.length; i++){
		debugger
		v = inputs[i];
		v.onblur= function() {
			$(v).parent().find(".errMsg").empty();
	    }; 
	}
	
})

$("#btn_submit").click(function (){
	
	var msgCtnSelector = 'span[class="errMsg"]';
	var validat=chkForm("form", msgCtnSelector);
	
	if(validat){
		
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		
		$.post('ib/ajaxUpdtelinfo.html',
				{
				 id:$("#id").val(),
				 bank_country:$("#bank_country").val(),
				 bank_name:$("#bank_name").val(),
				 account_withdraw:$("#account_withdraw").val(),
				 bank_account_name:$("#bank_account_name").val(),
				 bank_address:$("#bank_address").val(),
				 bank_province:$("#bank_province").val(),
				 bank_city:$("#bank_city").val(),
				 bank_gjhkdm:$("#bank_gjhkdm").val()
				}, function (data){
					if(null!=data){
						alert(data.MSG);
						location.reload();
					}
					$("#btn_submit").toggle();
					$("#btn_submit_in").toggle();
					
				},'json');
	}
	});