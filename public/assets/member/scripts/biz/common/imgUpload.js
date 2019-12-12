function hideUpDiv(curid){
	$('#'+curid+'_IFDIV').hide();
}
/**
 * 
 */
function showUpDiv(curid){
	//debugger;
	/*if(uploading){
		alert('还有图片在上传，请稍候…');
		return false;
	}*/
	$('#'+curid+'_IFDIV').show();
}
function flushError(form){
	$('#'+form+'_ERR').empty();
}
function showError(form,errormsg){
	$('#'+form+'_ERR').append(errormsg);
}
/**
 * 上传成功回调
 * @param pic_id
 */
function ajaxIFMRES(res){
	flushError(res.form);
	if(null!=res.errormsg && 'null'!=res.errormsg && ''!=res.errormsg && undefined!=res.errormsg){
		showError(res.form,res.errormsg);
		return false;
	}
	var imgId = res.id;
	if( null != imgId && '' != imgId && undefined != imgId){
		$('#'+res.form).val(res.id);
		$('#'+res.form+"_IMG").attr('src',basePath + upload_prefix + "?type=" + res.form +"&role=" + res.role +"&t=" + new Date().getTime());
	}
	hideUpDiv(res.form);
}