$(function(){
	$("#btn-login").click(function (){
		if(_login()){
			 $('#form').submit();
		}
	});
	
	//回车提交表单 在id_password聚焦的情况下
	$("#id_password").keydown(function(e){
		 var keyCode = e.which;
			if(keyCode ==13) {
				if(_login()){
					 $('#form').submit();
				}
			}
	});
	
	function _login(){
		$("#err").html('');
		if(($.trim($('#id_username').val())=="") && ($.trim($('#id_password').val())=="")){
			$("#id_username").css("border","1px solid #ae42c9");
			$("#id_password").css("border","1px solid #ae42c9");
			$("#err").append(loginLangres.empty_all);
			return false;
		    }
		else if(($.trim($('#id_username').val())!="") && ($.trim($('#id_password').val())=="")){
			$("#id_username").css("border","none");
			$("#id_username").css("border-bottom","1px solid #6242c9");
			$("#id_password").css("border","1px solid #ae42c9");
			$("#err").append(loginLangres.empty_pwd);
			return false;
		}
		else if(($.trim($('#id_username').val())=="") && ($.trim($('#id_password').val())!="")){
			$("#id_username").css("border","1px solid #ae42c9");
			$("#id_password").css("border","none");
			$("#id_password").css("border-bottom","1px solid #6242c9");
			$("#err").append(loginLangres.empty_email);
			return false;
		}
		else {
			if(chkForm("form",null)){
				return true;
			}else{
				
				$("#id_username").css("border","1px solid #ae42c9");
				$("#id_password").css("border","none");
				$("#id_password").css("border-bottom","1px solid #6242c9");
				$("#err").append(loginLangres.erremail);
				return false;
			}
		} 
	}
});