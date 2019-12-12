$(function() {
	_onChange();
	$("#account_list").change(function() {
		_onChange();
	});
	
	$("#btn_submit").click(function() {
		var _mt = $("#account_list").find("option:selected").text();
		$("#btn_submit").toggle();
		$("#btn_submit_in").toggle();
		$.ajax({
			url : basePath + "myapply/ajaxChangeleverage.html",
			async : false,
			data : { "mt" : _mt,"leverage" : $("#leverageList").val() },
			type : "POST",
			dataType : "json",
			contentType : "application/x-www-form-urlencoded;charset=utf-8;",
			success : function(data) {
				if (null != data) {
					alert(data.MSG);
				}
				$("#btn_submit").toggle();
				$("#btn_submit_in").toggle();
				location.reload();
			},
			error:function(jqXHR, textStatus, errorThrown){}
		});
	});
})

function fillSelect(array){
	$("#leverageList").empty();
	for(var i=0; i<array.length; i++){
		$("#leverageList").append('<option value="'+array[i][0]+'">'+array[i][1]+'</option>');
	}
}

function initLeverage(balance, a_type,leverage,ignore) {
	var leverage10W = [ [ 100, '1:100' ] ];
	var leverage5W=[ [ 200, '1:200' ] ];
	var leverageSpecial = [ [ 500, '1:500' ], [ 400, '1:400' ],
			[ 200, '1:200' ], [ 100, '1:100' ], [ 50, '1:50' ] ];
	var leverageOrdinary = [ [ 400, '1:400' ], [ 200, '1:200' ],
			[ 100, '1:100' ], [ 50, '1:50' ] ];
	var _balance = (( null == balance || "" == balance || undefined == balance)) ? 0 : parseFloat(balance);
	if (_balance >= 100000) {
		if("100" == leverage && !ignore){
			fillSelect(leverage10W);
			changeColor(true);
		}else{
			fillSelect(leverageOrdinary);
			$("#leverageList").val(leverage);
			$("#leverageList").removeAttr("disabled");
			changeColor(false);
		}
	}else if (_balance < 100000 && _balance >= 50000) {
		if("200" == leverage && !ignore){
			fillSelect(leverage5W);
			changeColor(true);
		}else{
			fillSelect(leverageOrdinary);
			$("#leverageList").val(leverage);
			$("#leverageList").removeAttr("disabled");
			changeColor(false);
		}
	}else{
		if("4" == a_type){
			if("500" == leverage && !ignore){
				fillSelect(leverageSpecial);
				$("#leverageList").val( 500 );
				$("#leverageList").attr("disabled",true);
				changeColor(true);
			}else{
				fillSelect(leverageOrdinary);
				$("#leverageList").val(leverage);
				$("#leverageList").removeAttr("disabled");
				changeColor(false);
			}
		}else if ("11" == a_type){
			if("200" == leverage && !ignore){
				fillSelect(leverage5W);
				changeColor(true);
			}else{
				fillSelect(leverageOrdinary);
				$("#leverageList").val(leverage);
				$("#leverageList").removeAttr("disabled");
				changeColor(false);
			}
		}else{
			fillSelect(leverageOrdinary);
			$("#leverageList").val(leverage);
			$("#leverageList").removeAttr("disabled");
			changeColor(false);
		}
	}
}

function changeColor(flag){
	if(flag){
		$("#btn_submit").css("background-color","#384554");
		$("#btn_submit").attr("disabled","disabled");
	}else{
		$("#btn_submit").css("background-color","#198fcc");
		$("#btn_submit").removeAttr("disabled");
	}
}

function _onChange(){
	var mt = $("#account_list").find("option:selected").text(); 
	$("#account_list").find("option:selected").attr("selected","selected");
	var a_type = $("#account_list").val();
	$.ajax({
		url : basePath + "myapply/ajaxFindleverage.html",
		async : false,
		data : { "mt" : $.trim(mt) },
		type : "POST",
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset=utf-8;",
		success : function(data) {
			if (null != data) {
				initLeverage(data.balance, a_type, data.leverage,data.ignore);
			}
		},
		error:function(jqXHR, textStatus, errorThrown){}
	});
}
