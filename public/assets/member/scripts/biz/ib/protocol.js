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

$(function(){
	
	var inputs = $('#form '+'input[vali="require"]');
	var v;

	for(var i=0; i<inputs.length; i++){
		v = inputs[i];
		v.onblur= function() {
			$(v).parent().find(".errMsg").empty();
	    }; 
	}
	
})

function _change(id){
	$("#ib_ERR").empty();
	$("#other_ERR").empty();
	$("#other").val("");
	$("#"+id+"_A").text("");
	$("#uploadHidden").attr("src","");
	var ib_id = $("#iblist").val();
	if( null!= ib_id && '' != ib_id && undefined != ib_id){
		$("#uploadHidden").attr("src",basePath + "upload/rar/index.html?form="+id+"&role=2"+"&ibId=" + ib_id);
		$.post('ib/findProtocol.html',
				{
					ib_id:ib_id
				},
				 function (data){
					$("#"+id+"_A").text(data.res.orgName);
					$("#"+id+"_A").attr("href",basePath+upload_prefix + "?type="+id+"&role=2"+"&ibId=" + ib_id+"&t=" + new Date().getTime()); 
					$("#"+id).val(data.res.other);
		},'json');
	}
}

$("#btn_submit").click(function (){
	
	var validat=true;
	$("#ib_ERR").empty();
	$("#other_ERR").empty();
	var id=$("#iblist").val();
	var $other=$("#other").val();
	if(null==id||''==id){
		$("#ib_ERR").append(commonLangres.choose);
		validat=false;
	}
	if(null==$other||''==$other){
		$("#other_ERR").append(commonLangres.notempty);
		validat=false;
	}
	
	if(validat){
		
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		
		$.post('ib/ajaxUpdProtocol.html',
				{
					ib_id:id,
					other:$other
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