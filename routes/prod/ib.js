/**
 * Created by zlp on 2017-12-10.
 */
let express = require('express');
let router = express.Router();
let auth = require("../../app/controller/prod/ib/middleware/auth");
let login = require("../../app/controller/prod/ib/login");
let account = require("../../app/controller/prod/ib/account");
let register = require("../../app/controller/prod/ib/register");
let funds = require("../../app/controller/prod/ib/funds");
let rebate = require('../../app/controller/prod/ib/rebate');
let client = require('../../app/controller/prod/ib/client');

router.get(['/account/*','/transaction/*','/funds/*','/user/*','/rebates/*','/client/*','/invite/*'],auth.auth)
//转向
router.get('/', function (req, res) {
    res.redirect('/ib/login');
});

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

//代理登记
router.get("/reg/signup",register.enter.page);
router.post("/reg/signup",register.enter.submit);

//#代理注册
router.get("/register", register.ibReg.page);
//注册第一步
router.post("/register/step1",register.ibReg.submitStep1);
//注册第二步
router.post("/register/step2",register.ibReg.submitStep2);



//#我的账户
//账户摘要
router.get("/account/mt", account.mt.page);
router.post("/account/mt/list",account.mt.list);
router.post("/account/mt/info",account.mt.info);
//获取指定账户余额
router.post("/account/mt/balance",account.mt.accountBalance);
//获取指定账户返利
router.post("/account/mt/rebate",account.mt.accountRebate);

//创建同名账号
router.get("/account/append", account.append.page);
router.post("/account/append_account",account.append.submit);
//个人资料
router.get("/account/info", account.userinfo.page);
//个人资料-基本信息
router.post("/account/info/basic/update", account.userinfo.update);
//个人资料-地址信息
router.post("/account/info/address/update",account.address.update);
//个人资料-银行信息
router.post("/account/info/bankcard/add",account.bankInfo.add);
router.post("/account/info/bankcard/update",account.bankInfo.update);
router.post("/account/info/bankcard/delete",account.bankInfo.del);
router.post("/account/info/bankcard/info",account.bankInfo.info);
//个人资料-电汇信息
router.post("/account/info/tt/update",account.telInfo.update);
router.post("/account/info/tt/add",account.telInfo.add);



//#我的资金
//账户出金
router.get("/funds/withdraw", funds.withdraw.page);
router.post("/funds/withdraw/submit_withdraw", funds.withdraw.submitWithdraw);
router.post("/funds/withdraw/withdraw_fee",funds.withdraw.withdrawFee);
router.post("/funds/withdraw/cancel_withdraw",funds.withdraw.cancelWithdraw);
//账户转账
router.get("/funds/transfer", funds.transfer.page);
router.post("/funds/transfer/submit_transfer", funds.transfer.submitTransfer);
router.post("/funds/transfer/cancel_transfer",funds.transfer.cancelTransfer);
//返利转余额
router.get("/funds/return_to_balance", funds.returnToBalance.page);
router.post("/funds/return_to_balance/submit_return_to_balance", funds.returnToBalance.submitReturnToBalance);
//资金记录
router.get("/funds/fundsrecord",funds.fundsrecord.page);
router.post("/funds/fundsrecord/list",funds.fundsrecord.list);
//出金记录
router.get("/funds/withdraw_record", funds.withdrawRecord.page);
router.post("/funds/withdraw_record/list", funds.withdrawRecord.list);
router.post("/funds/withdraw_record/info", funds.withdrawRecord.info);
//转账记录
router.get("/funds/transfer_record",funds.transferRecord.page);
router.post("/funds/transfer_record/list",funds.transferRecord.list);
router.post("/funds/transfer_record/info",funds.transferRecord.info);
//返利转余额记录
router.get("/funds/return_to_balance_record",funds.returnToBalanceRecord.page);
router.post("/funds/return_to_balance_record/list",funds.returnToBalanceRecord.list);

//#我的佣金
//交易返佣明细
router.get("/rebates/trade",rebate.trade.page);
router.post("/rebates/trade/list",rebate.trade.list);
//余额返利记录
router.get("/rebates/balance", rebate.balance.page);
router.post("/rebates/balance/oneday", rebate.balance.oneday);
router.post("/rebates/balance/list", rebate.balance.list);
router.post("/rebates/balance/info", rebate.balance.info);

//#客户交易数据
//历史交易
router.get("/transaction/history",rebate.history);
router.get("/transaction/history_datas",rebate.history_datas);
//持仓交易
router.get("/transaction/position",rebate.position);
router.get("/transaction/position_datas",rebate.position_datas);

//#我的客户
//客户信息
router.get("/client/list",client.customer_list.page);
router.post("/client/list_datas",client.customer_list.list);
//跳转客户信息详情
router.get("/client/info",client.client_info.page);
router.get("/client/account",client.client_info.account_list);     //账户信息
router.get("/client/dep_draw",client.client_info.dep_draw_list);   //出入金信息
router.get("/client/transfer",client.client_info.transfer_list);   //转账信息
router.get("/client/trade",client.client_info.trade_list);         //交易信息

//#开户链接
//开户链接
router.get("/invite/page",account.invite.page); //开户页面
router.post("/invite/info",account.invite.info); //生成推广链接

module.exports = router;