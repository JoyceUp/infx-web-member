$(function(){
	var shtp_pic1 = $("#shtp_pic1").val();
	var idcard_front = $("#idcard_front").val();
	var idcard_back = $("#idcard_back").val();
	var shtp_pic2 = $("#shtp_pic2").val();
	var dzzm_pic = $("#dzzm_pic").val();
	if( null!= shtp_pic1 && '' != shtp_pic1 && undefined != shtp_pic1 ){
		$("#shtp_pic1_IMG").attr("src",basePath + upload_prefix + "?type=shtp_pic1&role=1&t=" + new Date().getTime());
	}
	if( null!= idcard_front && '' != idcard_front && undefined != idcard_front ){
		$("#idcard_front_IMG").attr("src",basePath + upload_prefix + "?type=idcard_front&role=1&t=" + new Date().getTime());
	}
	if( null!= idcard_back && '' != idcard_back && undefined != idcard_back ){
		$("#idcard_back_IMG").attr("src",basePath + upload_prefix + "?type=idcard_back&role=1&t=" + new Date().getTime());
	}
	if( null!= shtp_pic2 && '' != shtp_pic2 && undefined != shtp_pic2 ){
		$("#shtp_pic2_IMG").attr("src",basePath + upload_prefix + "?type=shtp_pic2&role=1&t=" + new Date().getTime());
	}
	if( null!= dzzm_pic && '' != dzzm_pic && undefined != dzzm_pic ){
		$("#dzzm_pic_IMG").attr("src",basePath + upload_prefix + "?type=dzzm_pic&role=1&t=" + new Date().getTime());
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
		
		$.post('user/ajaxUpdbankinfo.html',
				{
				 id:$("#id").val(),
				 yhgj:$("#yhgj").val(),
				 yhmc:$("#yhmc").val(),
				 yhdz:$("#yhdz").val(),
				 yhs:$("#yhs").val(),
				 yhcs:$("#yhcs").val(),
				 yhyb:$("#yhyb").val(),
				 yhiban:$("#yhiban").val(),
				 shtp_pic1:$("#shtp_pic1").val(),
				 idcard_front:$("#idcard_front").val(),
				 idcard_back:$("#idcard_back").val(),
				 shtp_pic2:$("#shtp_pic2").val(),
				 dzzm_pic:$("#dzzm_pic").val(),
				 oshtp_pic1:$("#oshtp_pic1").val(),
				 oidcard_front:$("#oidcard_front").val(),
				 oidcard_back:$("#oidcard_back").val(),
				 oshtp_pic2:$("#oshtp_pic2").val(),
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