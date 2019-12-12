/**
 * Created by zlp on 2017-12-10.
 */



let express = require('express');
let router = express.Router();

let login = require("../../app/controller/dev/ib/login");
let account = require("../../app/controller/dev/ib/account");
let register = require("../../app/controller/dev/ib/register");
let funds = require("../../app/controller/dev/ib/funds");
let rebate = require('../../app/controller/dev/ib/rebate');
let client = require('../../app/controller/dev/ib/client');


router.get('/', function (req, res) {
    res.redirect('/ib/login');
});


router.get("/login", login.page);

//#代理注册
router.get("/register", register.ibReg.page);
//邮箱唯一性验证
router.post("/register/email_unique",register.ibReg.emailUnique);
//验证码验证
router.get("/register/verify_code",register.ibReg.verifyCode);
//注册第一步
router.get("/register/step1",register.ibReg.submitStep1);
//注册第二步
router.get("/register/step1",register.ibReg.submitStep2);

//#我的账户
//账户摘要
router.get("/account", account.page);
//创建同名账号
router.get("/account/append", account.append);

//#我的资金
//账户出金
router.get("/funds/withdraw", funds.withdraw.page);
router.post("/funds/withdraw/submit_withdraw", funds.withdraw.submitWithdraw);
//账户转账
router.get("/funds/transfer", funds.transfer.page);
router.post("/funds/transfer/submit_transfer", funds.transfer.submitTransfer);
//返利转余额
router.get("/funds/return_to_balance", funds.returnToBalance.page);
router.post("/funds/return_to_balance/submit_return_to_balance", funds.returnToBalance.submitReturnToBalance);
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
router.get("/rebate/balance",rebate.balance);
router.get("/rebate/balance_datas",rebate.balance_datas);
//交易返利明细
router.get("/rebate/trade",rebate.trade);
router.get("/rebate/trade_datas",rebate.trade_datas);

//#客户交易数据
//历史交易
router.get("/transaction/history",rebate.history);
router.get("/transaction/history_datas",rebate.history_datas);
//持仓交易
router.get("/transaction/position",rebate.position);
router.get("/transaction/position_datas",rebate.position_datas);

//#我的客户
//客户信息
router.get("/client/list",client.page);
router.get("/client/list_datas",client.client_list);
//跳转客户信息详情
router.get("/client/info",client.client_info.page);
router.get("/client/account",client.client_info.account_list);     //账户信息
router.get("/client/dep_draw",client.client_info.dep_draw_list);   //出入金信息
router.get("/client/transfer",client.client_info.transfer_list);   //转账信息
router.get("/client/trade",client.client_info.trade_list);         //交易信息

module.exports = router;