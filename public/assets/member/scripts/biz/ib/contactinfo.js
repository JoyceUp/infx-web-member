onblur= $(function(){
//	alert("a");
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
				var $id=$("input[name='id']").val();
				var $address=$("input[name='address']").val();
				var $zip_code=$("input[name='zip_code']").val();
				var $tel=$("input[name='tel']").val();
				
				$.post('ib/ajaxUpdcontactinfo.html',
						{
						 id:$id,
						 address:$address,
						 zip_code:$zip_code,
						 tel:$tel
						},
						 function (data){
							if(null!=data){
								alert(data.MSG);
							}
							$("#btn_submit").toggle();
							$("#btn_submit_in").toggle();
			},'json');
			}
		});