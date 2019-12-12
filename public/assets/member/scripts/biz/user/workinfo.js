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



$(document).ready(function () {
	    
		$("#btn_submit").click(function (){
			
			var msgCtnSelector = 'span[class="errMsg"]';
			var validat=chkForm("form", msgCtnSelector);
			
			if(validat){
				debugger;
				$("#btn_submit").toggle();
				$("#btn_submit_in").toggle();
				$.post(
						'user/ajaxUpdworkinfo.html',
						{
							id:$("#id").val(),
							jyzk:$("#jyzk").val(),
							nx:$("#nx").val(),
							jzc:$("#jzc").val(),
							zjly:$("#zjly").val()
							
						},function(data){
							if(null!=data){
								alert(data.MSG);
							}
							$("#btn_submit").toggle();
							$("#btn_submit_in").toggle();
						},'json'
				);
				 
			}
		});
	});