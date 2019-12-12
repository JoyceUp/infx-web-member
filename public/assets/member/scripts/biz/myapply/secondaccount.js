$(function() {
	$("#btn_submit").click(function() {
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		var account_type = $("#accountType").val();
		var ib = $("#ibList").val();
		if(undefined == ib ){
			ib = '';
		}
		var lev = 400;
		$.post("myapply/ajaxSecondAccount.html", {
			accounttype : account_type,
			lev : lev,
			ib:ib
		}, function(data) {
			if(null!=data){
				alert(data.MSG);
			}
			$("#btn_submit").toggle();
			$("#btn_submit_in").toggle();
			location.reload();
		}, 'json');
	})
});