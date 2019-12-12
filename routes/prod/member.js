/**
 * Created by zlp on 2017-12-10.
 */

let express = require('express');
let router =  express.Router();
let auth = require("../../app/controller/prod/member/middleware/auth");
let login = require("../../app/controller/prod/member/login");
let account = require("../../app/controller/prod/member/account");
let transaction = require("../../app/controller/prod/member/transaction");
let funds = require("../../app/controller/prod/member/funds");
let user = require("../../app/controller/prod/member/user");
let ib = require("../../app/controller/prod/member/ib");
let register = require("../../app/controller/prod/member/register");
let client = require('../../app/controller/prod/member/client');
let rebate = require('../../app/controller/prod/member/rebate');
let real_accounts = require('../../app/controller/prod/member/real_accounts');


router.get(['/account/*','/transaction/*','/funds/*','/user/*', '/client/*'],auth.auth)


router.get('/', function(req, res) {
    res.redirect('/member/login');
});

/*
* 新注册流程
* */
router.get("/real_accounts/profile",real_accounts.profile.page);
router.get("/real_accounts/step",real_accounts.step.page);


router.get("/real_accounts/list",real_accounts.profile.listPage);  //账户列表页面
router.post("/real_accounts/list",real_accounts.profile.list);     //获取账户列表
router.post("/demo_accounts/list",real_accounts.profile.demo_list);     //获取账户列表
router.post("/real_accounts/open_account_list",real_accounts.step.open_real_account);
router.post("/real_accounts/confirm",real_accounts.step.confirm);




router.get("/login",login.login);
router.post("/signup",login.signup);
router.post("/logout",login.logout);
router.post("/reset_pwd",login.resetPwd);

//通过邮箱找回密码第一步，往指定邮箱发送找回链接
router.get("/password/retrieve",login.retrieve.page);
router.post("/password/retrieve",login.retrieve.sendMail);

//通过邮箱找回密码第二步，修改密码
router.get("/password/retrieve/reset",login.retrieve.resetPage);
router.post("/password/retrieve/reset",login.retrieve.reset);

//注册
router.get("/register",register.page);
router.get("/register/active",register.acitvePage);
//注册第一步
router.post("/reg/step1",register.step1);
router.post("/submit/real_account",register.real_account);


router.get("/reg/email_unique",register.email_unique); /*验证邮箱唯一性*/
router.get("/reg/verify_code",register.verify_code);   /*获取验证码到邮箱*/
//注册第二步
router.post("/reg/step2",register.step2);
//注册第三步
router.post("/reg/step3",register.step3);
// router.post("/reg/images",register.images); /*图片上传*/

//#我的账户
//账户列表
router.get("/account/mt",account.mt.page);
router.post("/account/mt/list",account.mt.list);
router.post("/account/mt/info",account.mt.info);
//获取指定账户余额
router.post("/account/mt/balance",account.mt.accountBalance);
//获取指定账户返利
router.post("/account/mt/rebate",account.mt.accountRebate);
//修改杠杆
router.get("/account/modify_lev",account.modifyLev.page);
router.post("/account/change_leverage_ajax",account.modifyLev.changeLeverageAjax);
//账户清零
router.get("/account/balance_flush",account.balanceFlush.page);
router.post("/account/submit_balance_flush",account.balanceFlush.submit);


//#资金交易
//账户入金
router.get("/transaction/deposit",transaction.deposit.page);
router.post("/transaction/deposit/submit_deposit",transaction.deposit.submitDeposit);
router.get("/transaction/deposit/result",transaction.deposit.resultPage);
router.post("/transaction/deposit/check",transaction.deposit.checkDeposit);
//账户出金
router.get("/transaction/withdraw",transaction.withdraw.page);
router.post("/transaction/withdraw/submit_withdraw",transaction.withdraw.submitWithdraw);
router.post("/transaction/withdraw/cancel_withdraw",transaction.withdraw.cancelWithdraw);
router.post("/transaction/withdraw/withdraw_fee",transaction.withdraw.withdrawFee);
//返利转余额 new
router.get("/funds/return_to_balance", transaction.returnToBalance.page);
router.post("/funds/return_to_balance/submit_return_to_balance", transaction.returnToBalance.submitReturnToBalance);

//#资金信息
//资金记录
router.get("/funds/fundsrecord",funds.fundsrecord.page);
router.post("/funds/fundsrecord/list",funds.fundsrecord.list);
//出入金记录
router.get("/funds/deposit",funds.deposit.page);
router.post("/funds/deposit/list",funds.deposit.list);
router.post("/funds/deposit/info",funds.deposit.info);
router.post("/funds/deposit/cancel",funds.deposit.cancel);
//返利转余额记录 new
router.get("/funds/return_to_balance_record",funds.returnToBalanceRecord.page);
router.post("/funds/return_to_balance_record/list",funds.returnToBalanceRecord.list);
//余额清零记录
router.get("/funds/blanceflush",funds.blanceflush.page);
router.post("/funds/balance_flush/list",funds.blanceflush.list);
router.post("/funds/balance_flush/info",funds.blanceflush.info);

//客户信息
router.get("/user/telinfo",user.telInfo.page);
router.get("/user/userinfo",user.userInfo.page);
router.get("/user/workinfo",user.workInfo.page);
router.get("/user/info",real_accounts.step.userInfoPage);

//申请代理
router.get("/ib/applay",ib.applay);
router.get("/ib/submit_applay",ib.submitApplay);

//个人信息
router.post("/customer/userinfo/update", user.userInfo.update);
router.post("/customer/identity/update", user.userInfo.update_identity);
router.post("/customer/address/update",user.address.update);

//电汇信息
router.post("/customer/telinfo/list",user.telInfo.list);
router.post("/customer/telinfo/info",user.telInfo.info);
router.post("/customer/telinfo/update",user.telInfo.update);
router.post("/customer/telinfo/add",user.telInfo.add);
router.post("/customer/telinfo/delete",user.telInfo.del);

//投资者信息
router.post("/customer/workinfo/update",user.workInfo.update);

//#我的客户 new
//客户信息
router.get("/client/list", client.customer_list.page);
router.post("/client/list_datas", client.customer_list.list);

//#我的佣金 new
//交易返佣明细
router.get("/rebates/trade",rebate.trade.page);
router.post("/rebates/trade/list",rebate.trade.list);
//余额返利记录
router.get("/rebates/balance", rebate.balance.page);
router.post("/rebates/balance/oneday", rebate.balance.oneday);
router.post("/rebates/balance/list", rebate.balance.list);

//#开户链接 new
//开户链接
router.get("/invite/page",account.invite.page); //开户页面
router.post("/invite/info",account.invite.info); //生成推广链接

module.exports = router;