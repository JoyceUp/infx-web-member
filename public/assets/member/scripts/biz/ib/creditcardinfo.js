
$(function(){
	
	var credit_bank_front = $("#credit_bank_front").val();
	var credit_bank_back = $("#credit_bank_back").val();
	if( null!= credit_bank_front && '' != credit_bank_front && undefined != credit_bank_front ){
		$("#credit_bank_front_IMG").attr("src",basePath + upload_prefix + "?type=credit_bank_front&role=2&t=" + new Date().getTime());
	}
	if( null!= credit_bank_back && '' != credit_bank_back && undefined != credit_bank_back ){
		$("#credit_bank_back_IMG").attr("src",basePath + upload_prefix + "?type=credit_bank_back&role=2&t=" + new Date().getTime());
	}
	var credit_other = $("#credit_other").val();
	var credit_other_name = $("#credit_other_name").val();
	
	if( null!= credit_other && '' != credit_other && undefined != credit_other 
		&&	null!= credit_other_name && '' != credit_other_name && undefined != credit_other_name ){
		$("#credit_other_A").text(credit_other_name);
		$("#credit_other_A").attr("href",basePath+upload_prefix + "?type=credit_other&role=2&t=" + new Date().getTime()); 
	}
	
	var inputs = $('#form '+'input[vali="require"]');
	var v;

	for(var i=0; i<inputs.length; i++){
		v = inputs[i];
		v.onblur= function() {
			$(v).parent().find(".errMsg").empty();
	    }; 
	}
	

})

 

function _showUpDiv(id){
	var _other=$("#"+id).val();
	hideUpDiv(id);
	if(null==_other||""==_other){
		showUpDiv(id);
	}
}
function _hideUpDiv(id){
	var _other=$("#"+id).val();
	if(null==_other||""==_other){
		hideUpDiv(id);
	}
}

$("#btn_submit").click(function (){
	
	var msgCtnSelector = 'span[class="errMsg"]';
	var validat=chkForm("form", msgCtnSelector);
	
	if(validat){
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		
		$.post('ib/ajaxUpdcreditcard.html',
				{
				 id:$("#id").val(),
				 credit_bank_cardno:$("#bank_cardno").val(),
				 credit_type:$("#type").val(),
				 credit_bank_front:$("#credit_bank_front").val(),
				 credit_bank_back:$("#credit_bank_back").val(),
				 credit_other:$("#credit_other").val(),
				 ocredit_bank_front:$("#ocredit_bank_front").val(),
				 ocredit_bank_back:$("#ocredit_bank_back").val(),
				 ocredit_other:$("#ocredit_other").val()
				},
				 function (data){
					if(null!=data){
						alert(data.MSG);
						location.reload();
					}
					$("#btn_submit").toggle();
					$("#btn_submit_in").toggle();
		},'json');
	}
	});