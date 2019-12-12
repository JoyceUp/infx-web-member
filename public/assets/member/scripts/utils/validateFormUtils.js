
function chkForm(containerid,msgCtnSelector){
	debugger;
	var errors = 0;
	
	//非空验证
	{
		var inputs = $('#'+containerid+' '+'input[vali="require"]');
		
		var v;
		for(var i=0; i<inputs.length; i++){
			v = inputs[i];
			$(v).val( $.trim($(v).val()) );
			
			$(theNextMsg(v,msgCtnSelector)).empty();
			if(undefined != $(v).attr("disabled")){
				continue;
			}
			if('radio' == $(v).attr('type')){//radio
				debugger;
				var tmpRadio$ = $('#'+containerid+' '+'input[type="radio"][name="'+$(v).attr('name')+'"]:checked');
				if(undefined == tmpRadio$ || 0==tmpRadio$.length || '' == tmpRadio$.val()){
					$(theNextMsg(v,msgCtnSelector)).append(commonLangres.choose);
					errors++;
				}
			}else if('checkbox' == $(v).attr('type')){//checkbox
				debugger;
				var tmp$ = $('#'+containerid+' '+'input[type="checkbox"][name="'+$(v).attr('name')+'"]:checked');
				if( undefined == tmp$ || tmp$.length==0 ){
					$(theNextMsg(v,msgCtnSelector)).append(commonLangres.choose);
					errors++;
				}
			}else{
				if($(v).val()=='' || $(v).val()==undefined){
					$(theNextMsg(v,msgCtnSelector)).append(commonLangres.notempty);
					errors++;
				}
			}
		}
	}
	
	{
		var sels = $('#'+containerid+' '+'textarea[vali="require"]');	
		for(var i=0; i<sels.length; i++){
			v = sels[i];
			$(v).val( $.trim($(v).val()) );
	
			$(theNextMsg(v,msgCtnSelector)).empty();
			if($(v).val()=='' || $(v).val()==undefined){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.notempty);
				errors++;
			}
		}
	}
	
	//图片非空
	{
		var sels = $('#'+containerid+' '+'img[vali="require"]');	
		for(var i=0; i<sels.length; i++){
			v = sels[i];
	
			$(theNextMsg(v,msgCtnSelector)).empty();
			if($(v).attr("src")=='' || $(v).attr("src")==undefined){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.notempty);
				errors++;
			}
		}
	}
	
	{
		var sels = $('#'+containerid+' '+'select[vali="require"]');	
		for(var i=0; i<sels.length; i++){
			v = sels[i];
			$(v).val( $.trim($(v).val()) );

			$(theNextMsg(v)).empty();
			if($(v).val()=='' || $(v).val()==undefined){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.choose);
				errors++;
			}
		}
	}
	
	//格式验证
	{//TODO 邮政编码
		debugger;
		var sels = $('#'+containerid+' '+'input[valiformat="zipcode"]');	
		for(var i=0; i<sels.length; i++){
			v = sels[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
			
			if(isNaN($(v).val()) || $(v).val().length!=6){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.errzip);
				errors++;
			}
		}
	}
	
	{
		var emails = $('#'+containerid+' '+'input[valiformat="email"]');	
		for(var i=0; i<emails.length; i++){
			v = emails[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
	
			if(!isEmail( $(v).val() )){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.erremail);
				errors++;
			}
		}
	}
	
	{
		var qqs = $('#'+containerid+' '+'input[valiformat="qq"]');	
		for(var i=0; i<qqs.length; i++){
			v = qqs[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
	
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
			
			if( !isQQ( $(v).val() )){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.erreQQ);
				errors++;
			}
		}
	}
	
	{
		var passwds = $('#'+containerid+' '+'input[valiformat="password"]');	
		for(var i=0; i<passwds.length; i++){
			v = passwds[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
	
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
			
			if(checkStrong( $(v).val() , 6) < 2){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.warnpsw);
				errors++;
			}
		}
	}	
	
	{
		var phones = $('#'+containerid+' '+'input[valiformat="phone"]');	
		for(var i=0; i<phones.length; i++){
			v = phones[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
	
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
			
			if(isNaN($(v).val())){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.errphone);
				errors++;
			}
		}
	}
	//邮箱或mt账户
	{
		var email_mt = $('#'+containerid+' '+'input[valiformat="email_mt"]');	
		for(var i=0; i<email_mt.length; i++){
			v = email_mt[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
			if(!isEmail( $(v).val() )&&!isInteger($(v).val())){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.erremail_mt);
				errors++;
			}
		}
	}
	
	//邮箱或mt账户
	{
		var email_mt = $('#'+containerid+' '+'input[valiformat="money"]');	
		for(var i=0; i<email_mt.length; i++){
			v = email_mt[i];
			$(v).val( $.trim($(v).val()) );
			
			if('require' != $(v).attr('vali')){
				$(theNextMsg(v,msgCtnSelector)).empty();
			}
			
			if( ''==$(v).val() ){//empty needen't to vali format
				continue;
			}
			if(!isDouble($(v).val()) || $(v).val() <= 0 ){
				$(theNextMsg(v,msgCtnSelector)).append(commonLangres.errdecimal);
				errors++;
			}
		}
	}
	
	return (errors==0 ? true : false);
}
function theNextMsg(v,msgCtnSelector){
	return $(v).nextAll(msgCtnSelector)[0];
}