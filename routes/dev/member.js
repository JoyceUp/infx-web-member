/**
 * Created by zlp on 2017-12-10.
 */

let express = require('express');
let router =  express.Router();

let login = require("../../app/controller/dev/member/login");
let account = require("../../app/controller/dev/member/account");
let transaction = require("../../app/controller/dev/member/transaction");
let funds = require("../../app/controller/dev/member/funds");
let user = require("../../app/controller/dev/member/user");
let ib = require("../../app/controller/dev/member/ib");
let register = require("../../app/controller/dev/member/register");

router.get('/', function(req, res) {
    res.redirect('/login');
});
router.get("/login",login.login);
router.post("/signup",login.signup);
router.post("/logout",login.logout);

//#注册
router.get("/register",register.page);
//注册第一步
router.get("/reg/step1",register.step1);
router.get("/reg/email_unique",register.email_unique);  /*验证邮箱唯一性*/
router.get("/reg/verify_code",register.verify_code);    /*获取验证码*/
//注册第二步
router.get("/reg/step2",register.step2);
router.get("/reg/identityNo_unique",register.identityNo_unique); /*验证证件号码唯一性*/
router.get("/reg/mobile_unique",register.mobile_unique);         /*判断手机号是否在黑名单*/
//注册第三步
router.get("/reg/step3",register.step3);
router.get("/reg/images",register.images); /*图片上传*/

//#我的账户
//账户列表
router.get("/account/mt",account.mt.page);
router.post("/account/mt/list",account.mt.list);
router.post("/account/mt/info",account.mt.info);
//获取指定账户余额
router.post("/account/mt/balance",account.mt.accountBalance);
//注册附加账号
router.get("/account/append",account.append.page);
//修改杠杆
router.get("/account/modify_lev",account.modifyLev.page);
router.post("/account/change_leverage_ajax",account.modifyLev.changeLeverageAjax);
//账户清零
router.get("/account/balance_flush",account.balanceFlush.page);

//#资金交易
//账户入金
router.get("/transaction/deposit",transaction.deposit.page);
router.post("/transaction/deposit/submit_deposit",transaction.deposit.submitDeposit);
//账户出金
router.get("/transaction/withdraw",transaction.withdraw.page);
router.post("/transaction/withdraw/submit_withdraw",transaction.withdraw.submitWithdraw);
//账户转账
router.get("/transaction/transfer",transaction.transfer.page);
router.post("/transaction/transfer/submit_transfer",transaction.transfer.submitTransfer);

//#资金信息
//资金记录
router.get("/funds/fundsrecord",funds.fundsrecord.page);
router.post("/funds/fundsrecord/list",funds.fundsrecord.list);
//出入金记录
router.get("/funds/deposit",funds.deposit.page);
router.post("/funds/deposit/list",funds.deposit.list);
router.post("/funds/deposit/info",funds.deposit.info);
//转账记录
router.get("/funds/transfer",funds.transfer.page);
router.post("/funds/transfer/list",funds.transfer.list);
router.post("/funds/transfer/info",funds.transfer.info);
//余额清零记录
router.get("/funds/blanceflush",funds.blanceflush.page);
router.post("/funds/blanceflush/list",funds.blanceflush.list);
router.post("/funds/blanceflush/info",funds.blanceflush.info);
//交易记录
router.get("/funds/transaction",funds.transaction.page);
router.post("/funds/transaction/list",funds.transaction.list);
router.post("/funds/transaction/info",funds.transaction.info);
//#资金信息
//资金记录
router.get("/funds/funds_record",funds.fundsrecord.page);
router.post("/funds/funds_record/list",funds.fundsrecord.list);
//出入金记录
router.get("/funds/withdraw_deposit_record",funds.deposit.page);
router.post("/funds/withdraw_deposit_record/list",funds.deposit.list);
router.post("/funds/withdraw_deposit_record/info",funds.deposit.info);
//转账记录
router.get("/funds/transfer",funds.transfer.page);
router.post("/funds/transfer/list",funds.transfer.list);
router.post("/funds/transfer/info",funds.transfer.info);
//余额清零记录
router.get("/funds/balance_flush",funds.blanceflush.page);
router.post("/funds/balance_flush/list",funds.blanceflush.list);
router.post("/funds/balance_flush/info",funds.blanceflush.info);
//交易记录
router.get("/funds/transaction",funds.transaction.page);
router.post("/funds/transaction/list",funds.transaction.list);
router.post("/funds/transaction/info",funds.transaction.info);

//客户信息
router.get("/user/userinfo",user.userInfo.page);
router.get("/user/bankinfo",user.bankInfo.page);
router.get("/user/telinfo",user.telInfo.page);
router.get("/user/workinfo",user.workInfo.page);


//申请代理
router.get("/ib/applay",ib.applay);
router.get("/ib/submit_applay",ib.submitApplay);

//推广链接
router.get("/ib/invite/page",ib.inviteUrl.page);

//个人信息
router.post("/customer/userinfo/update", user.userInfo.update);
router.post("/customer/address/update",user.address.update);

//银行信息
router.post("/customer/bankinfo/add",user.bankInfo.add);
router.post("/customer/bankinfo/update",user.bankInfo.update);
router.post("/customer/bankinfo/delete",user.bankInfo.del);
router.post("/customer/bankinfo/info",user.bankInfo.info);

//电汇信息
router.post("/customer/telinfo/update",user.telInfo.update);
router.post("/customer/telinfo/add",user.telInfo.add);
//投资者信息
router.post("/customer/workinfo/update",user.workInfo.update);


module.exports = router;