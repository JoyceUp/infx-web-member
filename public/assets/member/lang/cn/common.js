
//验证

var loginLangres = 
{
	"empty_all":"请输入邮箱或MT账号和密码!",
	"empty_pwd":"请输入密码!",
	"empty_email":"请输入邮箱或MT账号!",
	"erremail":"请输入正确的邮箱或MT账号!"
};

var commonLangres = 
{
	"choose":"请选择",
	"notempty":"不能为空",
	"errzip":"邮政编码格式不正确",
	"erremail":"邮箱格式不正确",
	"erreQQ":"QQ号格式不正确",
	"errphone":"请输入手机号",
	"warnpsw":"请输入11位数字手机号",
	"erremail_mt":"请输入邮箱或mt账号",
	"session_missed":"会话失效，请重新登录",
	"alert":"提示信息",
	"pt_agent":"申请普通代理商成功",
	"zhu_agent":"申请主代理商成功",
	"errdecimal" : "请输入正确的金额",
	"first_page" : "第一页",
	"last_page" : "最后一页",
	"back_page" : "上一页",
	"next_page" : "下一页"
};

//withdraw
var withdrawLangres = 
{
	"notempty":"请填写金额!",
	"lessamount":"每次最低出金金额为30.00美元",
	"brokenbankcus":"请填写完整客户银行信息,点击确定前往",
	"brokenbankib":"请填写完整代理商银行信息,点击确定前往",
	"brokentelcus":"请填写完整客户电汇信息,点击确定前往",
	"brokentelib":"请填写完整代理商电汇信息,点击确定前往",
	"brokencreditcus":"请填写完整客户信用卡信息,点击确定前往",
	"brokencreditib":"请填写完整代理商信用卡信息,点击确定前往",
	"wd_confirm_px":"该账号目前余额为",
	"wd_confirm_sx":"美元,确认提交?",
	"wd_rule":"请按照规则填写!"
};
//transfer
var transferLangres = 
{
	"mt":"账号",
	"tf_warn":"不允许转入!",
	"notequal":"转出账号和转入账号不能相同!",
	"notempty":"请填写金额!",
	"tf_confirm_px":"该账号目前余额为",
	"tf_confirm_sx":"美元,确认转账?",
	"tf_rule":"请按照规则填写!",
	"notempty_in":"请填写转入账号!",
	"not_7":"禁止向代理账户转账!",
	"error_input":"不允许转入该类型账号!",
	"tf_confirm_apply":"确定要提交内部转账申请?",
	"tf_not_profit":"为了更好的为您提供服务，稳盈账户暂不支持转账!"
};

//applygold
var applygoldLangres = 
{
	"nomt":"账号不能为空!",
	"notempty":"请填写金额!",
	"ap_confirm_px":"入金金额为",
	"ap_confirm_mx":"美元,申请赠金比例为",
	"ap_confirm_sx":",确认申请赠金转余额?",
	"ap_rule":"请按照规则填写!",
	"ap_not_ib":"代理商账号不允许申请赠金!"
};

//deposit
var depositLangres = 
{
	"mt":"账号",
	"de_warn":"不允许入金！如果您需要入金，请开设一个可以交易的账号。",
	"notemptypic":"入金汇票单据不能为空!",
	"notempty":"请填写金额!",
	"ok_mt":"确认账号",
	"deposit":"入金",
	"dollar":"美元?",
	"de_rule":"请输入正确的存款金额，必须为不小于50的整数!",
	"de_wx":"您支付的金额超过单笔40000元上限，请重新输入！",
	"not_profit":"为了更好的为您提供服务，稳盈账户暂不支持国际信用卡入金！"
};

//funds
var fundsLangres = {
		"cancelgoldapply_apply":"确定要提交取消出金申请?",
		"canceltransferapply_apply":"确定要提交取消转账申请?",
		"grantsturnbalance_apply":"确定要提交赠金转余额申请?",
		"paycase":"支付情况",
		"profit_rate":" (稳盈账户A按固定汇率结算，不承担汇率变化带来的资金损失)"
};

//$post请求返回需要修改的值
var postres = {
		"back_info":"取消中",
		"turnbalance_info":"申请中"
};

//error返回信息
var errorres = {
		"back_error":"找不到页面，请尽快联系管理员！"
};

//modify返回信息
var modifyLangres = {
		"success_info":"恭喜您，密码修改成功！",
		"fail_info":"修改失败！",
		"wrong_info":"密码错误！",
		"session_exp":"会话过期，请重新登录！",
		"error_info":"系统错误，请稍后重试或联系管理员！"
};

//passwordcheck信息

var passwordcheckres = {
		"pwdoldem":"请输入老密码！",
		"pwdnewem":"请输入新密码！",
		"pwdlength":"密码不要少于6位！",
		"pwdtype":"密码至少要包含大写字母、小写字母、字符、数字四种类型中的三种！",
		"pwdok":"OK",
		"pwdrepeat":"请输入重复密码！",
		"pwddiffer":"两次密码不一致！",
		"pwdem":"请输入密码!",
		"pwdno":"您还没修改过密码，为了您的账户安全，请您修改密码!",
		"pwdemail":"修改邮箱密码!",
		"edit_info":"点击修改!"
};

//submit返回信息
var backres = {
		"ok":"确定",
		"cancel":"取消"
};

//resetpwd信息

var resetpwdres = {
		"emailnotempty":"邮箱不能为空!",
		"emailsend":"正在发送邮件，请稍候……",
		"emailsuccess":"邮件发送成功，请到邮箱接收邮件",
		"para_err":"参数错误",
		"emailnotexists":"邮箱不存在"
};

//resendtime信息
var resendres = {
		"notemail":"没接到邮件？",
		"second":"分",
		"repeatemail":"秒之后可重新发送邮件",
		"submit_info":"正在提交，请稍候……",
		"back":"返回",
		"":""
};
//赠金转余额
var credit2balacne = {
		"not_profit":"稳盈账户不支持该操作!"
};
//收益转余额
var profit2balacne = {
		"less_credit":"您的账户收益金额不足,不能进行收益转余额操作,请核准后申请!"
};
//
var forexsnsRank = {
		"title":"设置手数",
		"_double" : "请输入数字",
		"limit1" : "为了保证订单的成交质量，手数请大于0.01。",
		"limit2" : "为了保证订单的成交质量，请将手数限制在1手以内。",
		"qx_relation" : "确定取消当前定制策略?"
};