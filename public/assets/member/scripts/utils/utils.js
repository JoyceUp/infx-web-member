
function ShowDialog(url,winObj,iWidth,iHeight) {
           var iTop=(window.screen.height-iHeight)/2;
           var iLeft=(window.screen.width-iWidth)/2;
           window.showModalDialog(url,winObj,"dialogHeight: "+iHeight+"px; dialogWidth: "+iWidth+"px;dialogTop: "+iTop+"; dialogLeft: "+iLeft+"; resizable: no; status: no;scroll:no");
} 
function openNewWin(url,w,h){
 		var w_width=screen.width;
		var w_height=screen.height;
		var width_new=Math.ceil( (w_width-w)/2 );
		var height_new=0;
//		h-w_height?height_new=h:height_new=Math.ceil( (w_height-h)/2 );
		height_new=Math.ceil( (w_height-h)/2 );
	
		var att="height="+h+",width="+w+",left="+width_new+",top="+height_new+",toolbar=no,menubar=no,toolbar=no,titlebar =no,scrollbars=yes,resizable=no,location=no, status=yes";
 		var mod_str="dialogHeight="+h+"px;dialogWidth="+w+"px;dialogLeft="+width_new+"px;dialogTop="+height_new+"px;status=yes;scroll=yes";
		//if(document.all){window.showModalDialog(url,'',mod_str);}else{window.open(url,'',att);} //parse brower 
		//return window.showModalDialog(url,'',mod_str);
		return window.open(url,'',att);
 }
 function openNewWinIE(url,w,h){
 		var w_width=screen.width;
		var w_height=screen.height;
		var width_new=Math.ceil( (w_width-w)/2 );
		var height_new=0;
//		h-w_height?height_new=h:height_new=Math.ceil( (w_height-h)/2 );
		height_new=Math.ceil( (w_height-h)/2 );
	
		var att="height="+h+",width="+w+",left="+width_new+",top="+height_new+",toolbar=no,menubar=no,toolbar=no,titlebar =no,scrollbars=yes,resizable=no,location=yes, status=yes";
 		var mod_str="dialogHeight="+h+"px;dialogWidth="+w+"px;dialogLeft="+width_new+"px;dialogTop="+height_new+"px;status=yes;scroll=yes";
		// if(document.all){window.showModalDialog(url,window.document,mod_str);}else{window.showModalDialog(url,window.document,mod_str);} //parse brower 
 		//window.showModalDialog(url,window.document,mod_str);
 		 window.open(url,'',att)
 }
function isNumber(oNum)
{
	if(!oNum) 
		return false;
	var strP=/^\d+(\.\d+)?$/;
	if(!strP.test(oNum)) 
		return false;
	try{
		if(parseFloat(oNum)!=oNum) 
			return false;
	}
	catch(E)
	{
		alert("isNumber execption: " + E.description);
		return false;
	}
	return true;
}

function compareTimeString(varFirst, varSecond)
{
	try 
	{ 
		var arSrc = varFirst.split(":");
		var arCmp = varSecond.split(":");
		if (arSrc.length != 3 || arCmp.length != 3){
			alert("ScheduleItem.prototype.setDuration: " +
				"The duration format must be 00:00:00!\nYour input is " + 
				varFirst + " " + varSecond);
			return 0;
		}
		if (arSrc[0] > 23 || arSrc[0] < 0 || !isNumber(arSrc[0]) || 
			arCmp[0] > 23 || arCmp[0] < 0 || !isNumber(arCmp[0])){
			alert("ScheduleItem.prototype.setDuration: " +
				"Valid hours is from 00 to 23!\nYour input is " + 
				varFirst + " " + varSecond);
			return false;
		}
		if (arSrc[1] > 59 || arSrc[1] < 0 || !isNumber(arSrc[1]) || 
			arCmp[0] > 23 || arCmp[0] < 0 || !isNumber(arCmp[0])){
			alert("ScheduleItem.prototype.setDuration: " +
				"Valid minute is from 00 to 59!\nYour input is " + 
				varFirst + " " + varSecond);
			return false;
		}
		if (arSrc[2] > 59 || arSrc[2] < 0 || !isNumber(arSrc[2]) || 
			arCmp[0] > 23 || arCmp[0] < 0 || !isNumber(arCmp[0])){
			alert("ScheduleItem.prototype.setDuration: " +
				"Valid second is from 00 to 59!\nYour input is " + 
				varFirst + " " + varSecond);
			return false;
		}
		var varSrc = arSrc[0] * 3600 + arSrc[1] * 60 + arSrc[2] * 1;
		var varCmp = arCmp[0] * 3600 + arCmp[1] * 60 + arCmp[2] * 1;
		if (varSrc == varCmp)
			return 0;
			
		if (varSrc > varCmp)
			return 1;
			
		if (varSrc < varCmp)
			return -1;	
	}
	catch(E)
	{
		alert("isNumber execption: " + E.description);
		
	}
	return false;
}


function LTrim(str)

{

    var whitespace = new String(" \t\n\r");

    var s = new String(str);

    

    if (whitespace.indexOf(s.charAt(0)) != -1)

    {

        var j=0, i = s.length;

        while (j < i && whitespace.indexOf(s.charAt(j)) != -1)

        {

            j++;

        }

        s = s.substring(j, i);

    }

    return s;

} 

 



function RTrim(str)

{

    var whitespace = new String(" \t\n\r");

    var s = new String(str);

 

    if (whitespace.indexOf(s.charAt(s.length-1)) != -1)

    {

        var i = s.length - 1;

        while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)

        {

            i--;

        }

        s = s.substring(0, i+1);

    }

    return s;

}

 



function Trim(str)

{

    return RTrim(LTrim(str));

}


//除法函数，用来得到精确的除法结果
//说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。
//调用：accDiv(arg1,arg2)
//返回值：arg1除以arg2的精确结果
function accDiv(arg1,arg2){
    var t1=0,t2=0,r1,r2;
    try{t1=arg1.toString().split(".")[1].length}catch(e){}
    try{t2=arg2.toString().split(".")[1].length}catch(e){}
    with(Math){
        r1=Number(arg1.toString().replace(".",""));
        r2=Number(arg2.toString().replace(".",""));
        return (r1/r2)*pow(10,t2-t1);
    }
}
//给Number类型增加一个div方法，调用起来更加方便。
Number.prototype.div = function (arg){
    return accDiv(this, arg);
};
//乘法函数，用来得到精确的乘法结果
//说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。
//调用：accMul(arg1,arg2)
//返回值：arg1乘以arg2的精确结果
function accMul(arg1,arg2)
{
    var m=0,s1=arg1.toString(),s2=arg2.toString();
    try{m+=s1.split(".")[1].length}catch(e){}
    try{m+=s2.split(".")[1].length}catch(e){}
    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
}
//给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function (arg){
    return accMul(arg, this);
};
//加法函数，用来得到精确的加法结果
//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
//调用：accAdd(arg1,arg2)
//返回值：arg1加上arg2的精确结果
function accAdd(arg1,arg2){
    var r1,r2,m;
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2));
    return (arg1*m+arg2*m)/m;
}
//给Number类型增加一个add方法，调用起来更加方便。
Number.prototype.add = function (arg){
    return accAdd(arg,this);
}
//减法函数 arg2-arg1
function accSub(arg1,arg2){
    var r1,r2,m,n;
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2));
    //last modify by deeka
    //动态控制精度长度
    n=(r1>=r2)?r1:r2;
    return ((arg2*m-arg1*m)/m).toFixed(n);
}
///给number类增加一个sub方法，调用起来更加方便
Number.prototype.sub = function (arg){
    return accSub(arg,this);
}

/**
 * 限制输入框只能输入数字和小数点
 * **/
function onlyNumber(obj){

    //得到第一个字符是否为负号
    var t = obj.value.charAt(0);
    //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d\.]/g,'');
    //必须保证第一个为数字而不是.
    obj.value = obj.value.replace(/^\./g,'');
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\.{2,}/g,'.');
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace('.','$#$').replace(/\./g,'').replace('$#$','.');
    //如果第一位是负号，则允许添加
    if(t == '-'){
        obj.value = '-'+obj.value;
    }

}


/**
 * 判断设备
 * **/
function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
        "SymbianOS", "Windows Phone",
        "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}

/**
 * 图片压缩上传
 * **/
function resizeImageUpload(file,data,input_path){

    /* 压缩图片 */
    lrz(file, {
        width: 1280 //设置压缩参数
    }).then(function (rst) {
        /* 处理成功后执行 */
        rst.formData.append('base64img', rst.base64); // 添加额外参数
        rst.formData.append('role_type', data.role_type); // 添加额外参数
        rst.formData.append('role_id', data.role_id); // 添加额外参数
        $.ajax({
            url: "/common/upload/",
            type: "POST",
            data: rst.formData,
            processData: false,
            contentType: false,
            success: function (res) {
                uploadSucc(res,input_path)
            }
        });


    })
}
/**
 * 图片上传成功
 * **/
function uploadSucc(res,input){
    layer.closeAll('loading'); //关闭loading
    //如果上传失败
    if (res.code > 0) {
        return layer.msg(msg_upload_error, {icon: 5, time: 2000});
    }

    //上传成功
    if (res.status === 200) {
//                jQuery("#address_path2").val(res.datas);
        var obj = JSON.parse(res.datas);

        input.val(obj.id);
    }
}