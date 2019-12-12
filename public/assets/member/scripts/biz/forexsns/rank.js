$(function(){
	var rank = $("#rank").val();
	changeRanks(rank);
	$("#ranks").change(function(){
		changeRanks($("#ranks").val());
	});
	$("#lotsType").change(function(){
		$("#lotsInput").val("");
		$("#ip_warn").empty();
		$("#sp2_warn").empty();
	});
})

function initForm(){
	var ranks = $("#ranks").val();
	$("#rank").val(ranks);
	$("#date").val($("#date" + ranks).val());
	$("#order").val($("#orders").val());
}

function rankSubmit(){
	initForm();
	$("#page").val("1");
	$("#rankForm").submit();
}

function go(page){
	initForm();
	$("#page").val(page);
	$("#rankForm").submit();
}

function changeRanks(rank){
	if(rank == "1"){
		$("#date2").css("display","none");
		$("#h2").css("display","none");
		$("#date1").css("display","block");
		$("#h1").css("display","block");
	}
	if(rank == "2"){
		$("#date1").css("display","none");
		$("#h1").css("display","none");
		$("#date2").css("display","block");
		$("#h2").css("display","block");
	}
}

function _onwatch(obj,mid,action){
	var _action = action == "false" ? true : false;
	if(!_action){
		if(confirm(forexsnsRank.qx_relation)){
			ajaxBind(mid, _action, "", "");
		}
	}else{
		$("#lotsInput").val("");
		$("#ip_warn").empty();
		$("#sp_warn").empty();
		layer.open({
			type: 1,
			title: forexsnsRank.title,
			skin: "layui-layer-rim", //加上边框
			area: ["420px", "280px"], //宽高
			content: $("#watchDiv"),
			btn: [backres.ok, backres.cancel],
			btn1: function(index, layero){
				var error = false;
				var lotsType = $("#lotsType").val();
				var lots = $.trim($("#lotsInput").val());
				if(lots == "" || lots == undefined){
					$("#ip_warn").empty().append(commonLangres.notempty);
					error = true;
				}else{
					if(!isDecimal(lots) || lots == 0){
						$("#ip_warn").empty().append(forexsnsRank._double);
						error = true;
					}else{
						if("1" == lotsType && lots < 0.01){
							$("#sp_warn").empty().append(forexsnsRank.limit1);
							error = true;
						}
						if("2" == lotsType && lots > 1){
							$("#sp_warn").empty().append(forexsnsRank.limit2);
							error = true;
						}
					}
				}
				if(!error){
					ajaxBind(mid, _action, lotsType, lots);
					location.reload();
				}
			}
			,btn2: function(index, layero){
				//do nothing
			}
		});
		$(".layui-layer-content").css("height","174px");
	}
}

function ajaxBind(mid,action,type,lots){
	$.ajax({
		url :basePath + "forexsns/ajaxBindAdvisor.html",
		async :false,
		data:{"mid":mid,"action":action,"type":type,"lots":lots},
		type:'POST',
		dataType:'json',
		contentType:'application/x-www-form-urlencoded;charset=utf-8;',
		success:function(data){
			$("#rankForm").submit();
		},
		error:function(jqXHR, textStatus, errorThrown){}
	}); 
}

function _advisor(mid){
	window.location.href = basePath + "forexsns/advisor.html?mid=" + mid;
}

function decimalPress(obj){
	var event = event || window.event;
  	var keyCode = event.keyCode;
  	var val = obj.value;
  	//48-57是大键盘的数字键,96-105是小键盘的数字键,8是退格符,110 190小数点,37<-,39->
  	//第一个字符不能为小数点
  	if((val== null || val == "" || val == undefined) && (keyCode == 110 || keyCode == 190)){
  		return false;
  	}
  	//只能有一个小数点
  	if((val.indexOf('.') != -1) && (keyCode == 110 || keyCode == 190)){
  		return false;
  	}
  	//数字和特殊按键
  	if(!( (keyCode >=96 && keyCode <= 105) 
  			|| (keyCode >=48 && keyCode <= 57) 
  			|| (keyCode == 8) || (keyCode == 37) || (keyCode == 39)
  			|| (keyCode == 110) || (keyCode == 190) )){
  		return false;
  	}
  	return true;
}