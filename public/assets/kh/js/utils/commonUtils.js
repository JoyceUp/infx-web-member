function str2display(para){
	switch(para){
	case undefined:
		return "";
	default:
		return para;
	}
}
function canFillHTML(power2vali,powerAttr,htmlStr){
	if(canDo(power2vali,powerAttr)){
		return htmlStr;
	}
	return "";
}
function canDo(power2vali,powerAttr){
	if((power2vali&powerAttr) == powerAttr){
		return true;
	}
	return false;
}
