function next() {
	var type = $('input:radio:checked').val();
	if(type == 1) {
		window.location.href=path+"funds/withdrawfundstel.html";
	} else if(type == 2) {
		window.location.href=path+"funds/withdrawfundscard.html";
	}else if(type == 3) {
		window.location.href=path+"funds/withdrawfundscredit.html";
	}
}

function changeItem(item) {
	if(item.value == 3) {
		$("#cardtips").css('display','block');
	} else if(item.value == 1) {
		$("#cardtips").css('display','none');
	} 
}