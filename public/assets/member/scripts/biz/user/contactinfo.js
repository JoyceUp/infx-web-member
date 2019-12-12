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
			
			var $id=jQuery("input[name='id']").val();
			var $gj=jQuery("select[name='gj']").val();
			var $jzgj=jQuery("select[name='jzgj']").val();
			var $jzdz1=jQuery("input[name='jzdz1']").val();
			var $cs=jQuery("input[name='cs']").val();
			var $yzbm=jQuery("input[name='yzbm']").val();
			var $stdhhm=jQuery("input[name='stdhhm']").val();
			var $dhhm=jQuery("input[name='dhhm']").val();
			debugger;
			$.post('user/ajaxUpdcontactinfo.html',
					{
					 id:$id,
					 gj:$gj,
					 jzgj:$jzgj,
					 jzdz1:$jzdz1,
					 cs:$cs,
					 yzbm:$yzbm,
					 stdhhm:$stdhhm,
					 dhhm:$dhhm
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