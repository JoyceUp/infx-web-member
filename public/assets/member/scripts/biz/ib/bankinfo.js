$(function(){
	
	var pic_bank_0 = $("#pic_bank_0").val();
	var pic_id_0 = $("#pic_id_0").val();
	var pic_id_1 = $("#pic_id_1").val();
	var pic_bank_1 = $("#pic_bank_1").val();
	var dzzm_pic = $("#dzzm_pic").val();
	if( null!= pic_bank_0 && '' != pic_bank_0 && undefined != pic_bank_0 ){
		$("#pic_bank_0_IMG").attr("src",basePath + upload_prefix + "?type=pic_bank_0&role=2&t=" + new Date().getTime());
	}
	if( null!= pic_id_0 && '' != pic_id_0 && undefined != pic_id_0 ){
		$("#pic_id_0_IMG").attr("src",basePath + upload_prefix + "?type=pic_id_0&role=2&t=" + new Date().getTime());
	}
	if( null!= pic_id_1 && '' != pic_id_1 && undefined != pic_id_1 ){
		$("#pic_id_1_IMG").attr("src",basePath + upload_prefix + "?type=pic_id_1&role=2&t=" + new Date().getTime());
	}
	if( null!= pic_bank_1 && '' != pic_bank_1 && undefined != pic_bank_1 ){
		$("#pic_bank_1_IMG").attr("src",basePath + upload_prefix + "?type=pic_bank_1&role=2&t=" + new Date().getTime());
	}
	if( null!= dzzm_pic && '' != dzzm_pic && undefined != dzzm_pic ){
		$("#dzzm_pic_IMG").attr("src",basePath + upload_prefix + "?type=dzzm_pic&role=2&t=" + new Date().getTime());
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

$("#btn_submit").click(function (){
		
		var msgCtnSelector = 'span[class="errMsg"]';
		var validat=chkForm("form", msgCtnSelector);
		
		if(validat){
			
			$("#btn_submit").toggle();
			$("#btn_submit_in").toggle();
			
			$.post('ib/ajaxUpdbankinfo.html',
					{
					 id:$("#id").val(),
					 yhgj:$("#yhgj").val(),
					 yhmc:$("#yhmc").val(),
					 yhdz:$("#yhdz").val(),
					 yhs:$("#yhs").val(),
					 yhcs:$("#yhcs").val(),
					 yhyb:$("#yhyb").val(),
					 yhiban:$("#yhiban").val(),
					 pic_bank_0:$("#pic_bank_0").val(),
					 pic_id_0:$("#pic_id_0").val(),
					 pic_id_1:$("#pic_id_1").val(),
					 pic_bank_1:$("#pic_bank_1").val(),
					 dzzm_pic:$("#dzzm_pic").val(),
					 opic_bank_0:$("#opic_bank_0").val(),
					 opic_id_0:$("#opic_id_0").val(),
					 opic_id_1:$("#opic_id_1").val(),
					 opic_bank_1:$("#opic_bank_1").val(),
					 odzzm_pic:$("#odzzm_pic").val()
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