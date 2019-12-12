
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


