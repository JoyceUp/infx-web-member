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
function flushError(from){
	$('#'+from+'_ERR').empty();
}
function showError(from,errormsg){
	$('#'+from+'_ERR').append(errormsg);
}
/**
 * 上传成功回调
 * @param pic_id
 */
function ajaxIFMRES(res){
	flushError(res.from);
	if(null!=res.errormsg && 'null'!=res.errormsg && ''!=res.errormsg && undefined!=res.errormsg){
		showError(res.from,res.errormsg);
		return false;
	}
	var imgId = res.imgid;
	if( null != imgId && '' != imgId && undefined != imgId){
		$('#'+res.from).val(imgId);
		$('#'+res.from+"_IMG").attr('src',basePath + "imgftp/showIMG.shtml?type=" + res.from + "&t=" + new Date().getTime());
	}
	hideUpDiv(res.from);
}