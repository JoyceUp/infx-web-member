$(document).ready(function(){
$.ajaxSetup({   
		   async:false,
	       contentType:"application/x-www-form-urlencoded;charset=utf-8",   
	       complete:function(XMLHttpRequest,textStatus){ 
	    	 //通过XMLHttpRequest取得响应头，sessionstatus，  
	         var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
	             if(sessionstatus=="timeout"){ 
	                 alert(commonLangres.session_missed);
	                 //如果超时就处理 ，指定要跳转的页面  
	                 window.location.replace(basePath+"account/index.html");   
	             }   
	          }   
	     });
});