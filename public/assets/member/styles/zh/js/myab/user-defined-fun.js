
function initMemuClass(index) {
		$('#menu li a').eq(index).addClass('active');
	}
 
 

function pmessHint(message,title,confirmLink) {

	 $('.boxmin').show();
	 $('#pmesstitle').html(title);
	 $('#messHintDIV').html(message);
	 $('#pmessDIV').show();
	  
	  
	  $('#pmessConfirm').click(function(){
		  if (confirmLink != null && confirmLink != '') {
			 	window.location.href=confirmLink;		 
		  }
		  else {
			 $('#pmessDIV').hide();
			 $('.boxmin').hide();
		  }
	   });
}
 

function pmessCCHint(message,title,confirmLink,cancelLink) {
 
	 $('.boxmin').show();
	 $('#pmessCCtitle').html(title);
	 $('#pmessCCHintDIV').html(message);
	 $('#pmessCCDIV').show();
	 $('#pmessCCConfirm').click(function(){
		 if (confirmLink != null && confirmLink != '') {
	 		window.location.href=confirmLink;
		 }
		 else {
		 	 $('.boxmin').hide();
			 $('#pmessCCDIV').hide();
		 }
	 });

	 $('#pmessCCCancel').click(function(){
		 if (cancelLink != null && cancelLink != '') {
	 		window.location.href=cancelLink;
		 }
		 else {
		 	 $('.boxmin').hide();
		 	$('#pmessCCDIV').hide();
		 }
	 });
}