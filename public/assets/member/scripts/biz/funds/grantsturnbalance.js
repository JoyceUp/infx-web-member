$(function(){
	initPresent();
	$("#live_member").change(function(){
		initPresent();
	});
	
	$("#btn_submit").click(function(){
		var mt = $("#live_member").val();
		if(null != mt && "" != mt && undefined != mt){
			$.ajax({ 
				url :basePath + "funds/ajaxGrantsTurnBalance.html",
				async :false,
				data:{"mt" : $.trim(mt) },
				type:'POST',
				dataType:'json',
				contentType:'application/x-www-form-urlencoded;charset=utf-8;',
				success:function(data){
					if(null != data && null != data.MSG){
						alert(data.MSG);
					}
					location.reload();
					
				},
				error:function(jqXHR, textStatus, errorThrown){
					location.reload();
				}
			});
		}
	});
})

function initPresent(){
	var mt = $("#live_member").val();
	if(null == mt || "" == mt || undefined == mt){
		checkBtnShow();
	}else{
		$.ajax({ 
			url :basePath + "funds/checkPresentInfo.html",
			async :false,
			data:{"mt" : $.trim(mt) },
			type:'POST',
			dataType:'json',
			contentType:'application/x-www-form-urlencoded;charset=utf-8;',
			success:function(data){
				if(null == data || null == data.STATUS || null == data.MSG){
					checkBtnShow();
				}
				if("ERROR" == data.STATUS){
					$("#warnSp").empty().text(data.MSG);
					checkBtnShow();
				}else if("SUCCESS" == data.STATUS){
					$("#warnSp").empty().text(data.MSG);
					checkBtnHide();
				}else{
					checkBtnShow();
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				checkBtnShow();
			}
		});
	}
}

function checkBtnShow(){
	$("#btn_submit").hide();
	$("#btn_submit_unsub").show();
	$("#btn_submit_in").hide();
}

function checkBtnHide(){
	$("#btn_submit").show();
	$("#btn_submit_unsub").hide();
	$("#btn_submit_in").hide();
}