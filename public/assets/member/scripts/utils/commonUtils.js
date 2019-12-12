function fmoney(s, n) {
    n = n > 0 && n <= 20 ? n : 2;
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";

    //处理含有正负号的数字
    var perfix='';
    if(s.indexOf('-') != -1 || s.indexOf('+') != -1){
        perfix = s.substring(0,1);
        s = s.substring(1);
    }

    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
    t = "";
    for (i = 0; i < l.length; i++) {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    return  perfix + t.split("").reverse().join("") + "." + r;
}

function rmoney(s) {
    return parseFloat(s.replace(/[^\d\.-]/g, ""));
}

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

var autoSelect=  function (selectDom,seVal){
    selectDom.next().find('.layui-select-title input').click();
    setTimeout(function () {
        selectDom.next().find('.layui-anim').children('dd[lay-value='+seVal+']').click();
    },100);
}

function getImages(who,id){
	var id = String(id)
	if(id && id != '' && $(who)[0].src.indexOf("pic.png") > 0){
        $.post("/common/images/",{id:id},function(result){
            if(result){
                $(who).attr("src",result)
            }
        });
	}

}

function loading(){
    var loadingIndex = layer.load(2, {
        shade: [0.6,'#fff'] //0.1透明度的白色背景
    });
}

function closeLoading(){
    layer.closeAll('loading');
}

//四舍五入
function toFixed(num, s) {
    var times = Math.pow(10, s + 1),
        des = parseInt(num * times),
        rest = des % 10;
    if (rest == 5) {
        return ((parseFloat(des) + 1) / times).toFixed(s);
    }
    return num.toFixed(s);
}


function setCountryCode(){
    var proHtml = '';
    var cArr=[]
    for (var i = 0; i < country_code.length; i++) {
        cArr = country_code[i].split("-")
        proHtml += '<option value="' + cArr[2] + '">' + cArr[0] + '(+' + cArr[2] + ')' + '</option>';
    }

    $("select[name=country_code]").append(proHtml);

    // form.render();
}