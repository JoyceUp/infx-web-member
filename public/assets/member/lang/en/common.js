
//verification

var loginLangres = 
{
	"empty_all":"Please enter the E-mail or MT account and password!",
	"empty_pwd":"Please enter password !",
	"empty_email":"Please enter the E-mail or MT account!",
	"erremail":"Please enter the correct E-mail or MT account!"
};

var commonLangres = 
{
	"choose":"please choose",
	"notempty":"Required field",
	"errzip":"The format of  postal code is incorrect",
	"erremail":"The format of E-mail is incorrect",
	"erreQQ":"The format of QQ number  is incorrect",
	"errphone":"Enter your mobile number please",
	"warnpsw":"Please enter the 11 digits mobilephone number",
	"erremail_mt":"Please enter the E-mail or MT account",
	"session_missed":"Logon failure, please login again",
	"alert":"hint",
	"pt_agent":"IB application successfully",
	"zhu_agent":" main IB application successfully",
	"errdecimal" : "Please input correct amount",
	"first_page" : "first",
	"last_page" : "last",
	"back_page" : "previous",
	"next_page" : "next"
};

//withdraw
var withdrawLangres = 
{
	"notempty":"Please fill in the amount!",
	"lessamount":"the lowest amount of withdraw is for $30.00",
	"brokenbankcus":"Please fill out the complete customer bank information,click OK to go on",
	"brokenbankib":"Please fill out the complete bank information,click OK to go on",
	"brokentelcus":"Please fill out the complete wire transfer information,click OK to go on",
	"brokentelib":"Please fill out the complete IB wire transfer information,click OK to go on",
	"brokencreditcus":"Please completely fill in credit card information, click next",
	"brokencreditib":"Please completely fill in IB credit card information, click next",
	"wd_confirm_px":"The account balance at present is",
	"wd_confirm_sx":"dollars, confirm to submit?",
	"wd_rule":"Please fill it out according to the rules!"
};
//transfer
var transferLangres = 
{
	"mt":"account",
	"tf_warn":"tranfer into prohibitted!",
	"notequal":"transfer into account should be different with transfer out account!",
	"notempty":"Please fill in the amount!",
	"tf_confirm_px":"The account balance at present is",
	"tf_confirm_sx":"dollars, confirm to transfer?",
	"tf_rule":"Please fill it out according to the rules!",
	"notempty_in":"please fill in the transfer out account!",
	"not_7":"transfer to IB account is prohibitted!",
	"error_input":"transfer into this account type is prohibitted!",
	"tf_confirm_apply":"make sure to submit an internal transfer application?",
	"tf_not_profit":"In order to provide better service，internal transfer is not allowed currently!"
};

//applygold
var applygoldLangres = 
{
	"nomt":"Account cannot be empty!",
	"notempty":"Please fill in the amount!",
	"ap_confirm_px":"deposit amount is",
	"ap_confirm_mx":"dollars,bouns ratio",
	"ap_confirm_sx":",make sure to apply?",
	"ap_rule":"Please fill it out according to the rules!",
	"ap_not_ib":"IB accout is not allowed to apply bonus!"
};

//deposit
var depositLangres = 
{
	"mt":"account",
	"de_warn":"deposit is not allowed！if you need to deposit, please open an tradeable account.",
	"notemptypic":"deposit draft documents can not be empty!",
	"notempty":"Please fill in the amount!",
	"ok_mt":"Confirm the account",
	"deposit":"deposit?",
	"dollar":"dollars?",
	"de_rule":"Please input the correct amount of deposit，which must be the integer no less than 50!",
	"de_wx":"Maximum payment amount is 40000 RMB， please try again！",
	"not_profit":"In order to provide better service，international credit card is not allowed currently!"
};

//funds
var fundsLangres = {
		"cancelgoldapply_apply":"make sure to cancel the withdraw submission?",
		"canceltransferapply_apply":"make sure to cancel the transfer submission?",
		"grantsturnbalance_apply":"make sure to cancel the bonus to balance submission?",
		"paycase":"payment status",
		"profit_rate":" (steady account A settlement is according to fixed exchange rate，and doesn't take any loss that caused by exchange rate changing)"
};

//$post turn back to previous amount
var postres = {
		"back_info":"Canceling",
		"turnbalance_info":"applying"
};

//error back
var errorres = {
		"back_error":"Can't find the page, please contact administrator！"
};

//modify back
var modifyLangres = {
		"success_info":"Congratulations, the password is changed！",
		"fail_info":"Modify failure！",
		"wrong_info":"wrong password！",
		"session_exp":"dialogue expired , please login again！",
		"error_info":"System error, please try again later or contact administrator！"
};

//passwordcheck information

var passwordcheckres = {
		"pwdoldem":"Please enter the old password！",
		"pwdnewem":"Please enter the new password！",
		"pwdlength":"Password not less than six numbers！",
		"pwdtype":"the password has to including three types among uppercase and lowercase letters, characters, numbers！",
		"pwdok":"OK",
		"pwdrepeat":"Enter the password again！",
		"pwddiffer":"the password you entered twice is different！",
		"pwdem":"Please enter your password!",
		"pwdno":"You haven't modified the password， for your account security, please change the password!",
		"pwdemail":"modify your E-mail password!",
		"edit_info":"click to modify!"
};

//submit back
var backres = {
		"ok":"ok",
		"cancel":"cancel"
};

//resetpwd information

var resetpwdres = {
		"emailnotempty":"E-mail cannot be empty!",
		"emailsend":"sending mail, please wait……",
		"emailsuccess":"Mail sent successfully, please receive to the mailbox",
		"para_err":"parameter error",
		"emailnotexists":"Email does not exist"
};

//resendtime information
var resendres = {
		"notemail":"Haven't received the mail？",
		"second":"minutes",
		"repeatemail":"Resend a message after  seconds",
		"submit_info":"submitting，please wait……",
		"back":"back",
		"":""
};
//赠金转余额
var credit2balacne = {
		"not_profit":"this application is not available for steady account!"
};
//收益转余额
var profit2balacne = {
		"less_credit":"Income turn to balance failed since income is not enough, please apply after checking."
};
//
var forexsnsRank = {
		"title":"Set Lots",
		"_double" : "please enter number",
		"limit1" : "For ensuring trading quility, please control your order over 0.01 lots",
		"limit2" : "For ensuring trading quility, please limit in 1 lot. ",
		"qx_relation" : "Are you sure to cancel the strategy right now?"
};