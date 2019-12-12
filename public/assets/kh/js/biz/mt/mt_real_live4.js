var lervArrNm = [
                 [400,'1:400'],
                 [200,'1:200'],
                 [100,'1:100'],
                 [50,'1:50']
					];
var lervArrSpec = [
                   [500,'1:500'],
                   [400,'1:400'],
                   [200,'1:200'],
                   [100,'1:100'],
                  [50,'1:50']
				];
var accTypePara;
var lervage;
function fillSelect(obj,arr){
	$(obj).empty();
	for(var i=0; i<arr.length; i++){
		$(obj).append('<option value="'+arr[i][0]+'">'+arr[i][1]+'</option>');
	}
}
function initLeverage(_accTypePara){
	
	switch (_accTypePara) {
	case 11:
		fillSelect(lervage,lervArrNm);
		
		$('#lervage').val( 200 );
		lervageChg();
		$('#lervage').attr('disabled',true);
		break;
	case 4://优势账户
		fillSelect(lervage,lervArrSpec);
		
		$('#lervage').val( 500 );
		lervageChg();
		$('#lervage').attr('disabled',true);
		break;
	default:
		var levtmp = $('#lervage').val();
		fillSelect(lervage,lervArrNm);
		$('#lervage').val(levtmp);
		lervageChg();
	
		$('#lervage').removeAttr('disabled');
		break;
	}
}
function lervageChg(){
	$('#leverageH').val($('#lervage').val());
}
$(function(){
	accTypePara = parseInt($('#accTypeParaId').val(),10);
	lervage = $('#lervage');
	
	initLeverage(accTypePara);
	
	
	$('#accountType').change(function(){
		$('#accounttypeH').val( $('#accountType').val() );
		initLeverage(parseInt( $('#accountType').val(),10 ))
	});
	$('#lervage').change(function(){
		lervageChg();
	});
	//alert('>'+$('#leverageH').val());
	//接收url的值若存在，则disabled accountType
	var url_account=$("#url_account").val();
	if(null!=url_account && ''!=url_account && undefined!=url_account){
		$("#accountType").attr("disabled","disabled");
	}else{
		$("#accountType").removeAttr("disabled");
	}
});