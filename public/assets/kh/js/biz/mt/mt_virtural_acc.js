$(function(){
	var msgCtnSelector = 'i[class="reg-hint-error"]';
	$("#submit-btn").click(function(){
		if(chkForm("formMtVA",msgCtnSelector)){
			subIt();
		}
	});

	function showSubing(){
		$('#submit-btn').hide();
		$('#subIngBtn').show();
	}
	function showSubit(){
		$('#subIngBtn').hide();
		$('#submit-btn').show();
	}

	function isSubing(){
		if("block" == $('#subIngBtn')[0].style.display){
			return true;
		}else{
			return false;
		}
	}

	function subIt(){
		if(isSubing()){
			return false;
		}
		showSubing();
		var url = 'mt/mt_applyMtVA.shtml?rid='+Math.random();
		var data = $('#formMtVA').serialize();
		$.ajax({
			url :url, 
			async :false,
			data:data,
			dataType:"json",
			contentType:"application/x-www-form-urlencoded;charset=utf-8;",
			success:function(data){
				try{
					if("ERROR" == data.STATUS){
						alert("ERROR:" + viraccLangres.failed);
					}else if("SUCCESS" == data.STATUS){
						alert(viraccLangres.success);
						$('#formMtVA')[0].reset();
					}
				}catch(e){
					alert("ERROR:" + viraccLangres.failed);
				}finally{
					showSubit();
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				showSubit();
			}
		});
	}	
})