function hideUpDiv(curid){
	$('#'+curid+'_IFDIV').hide();
}
/**
 * 
 */
function showUpDiv(curid){
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
function ajaxIFMRESR(res){
	flushError(res.form);
	if(null!=res.errormsg && 'null'!=res.errormsg && ''!=res.errormsg && undefined!=res.errormsg){
		showError(res.form,res.errormsg);
		return false;
	}
	var imgId = res.id;
	if( null != imgId && '' != imgId && undefined != imgId){
		$('#'+res.form).val(imgId);
		$("#"+res.form+"_A").attr("href",basePath + upload_prefix + "?type=" + res.form +"&role=" + res.role +"&ibId=" + res.ibId +"&t=" + new Date().getTime());
		$("#"+res.form+"_A").text(res.orgName);
	}
	
	hideUpDiv(res.form);
}