/**
 * Created by zlp on 2017-12-10.
 */
let express = require('express');
let router =  express.Router();

let login = require("../../app/controller/dev/sale/login")
let home = require("../../app/controller/dev/sale/home")
let rebate = require('../../app/controller/dev/sale/rebate')
let customer = require("../../app/controller/dev/sale/customer")
let bonus = require("../../app/controller/dev/sale/bonus");
let ib = require("../../app/controller/dev/sale/agency")
router.get('/', function(req, res) {
    res.redirect('/sale/login');
});

router.get("/login",login.page);
//首页
router.get("/home",home.page);

//#返佣返利信息 so
//交易返佣明细
router.get("/rebate/trade",rebate.trade.page);
router.post("/rebate/trade/list",rebate.trade.list);
//余额返利明细
router.get("/rebate/balance",rebate.balance.page);
router.post("/rebate/balance/list",rebate.balance.list);

//#提成信息 so
//提成列表
router.get("/bonus",bonus.page);
router.get("/bonus/list",bonus.list);
router.get("/bonus/info",bonus.info);

//#客户信息
//客户列表
router.get("/customer",customer.page);
router.get("/customer/list",customer.getCustomerList);
router.get("/customer/detail",customer.detail);

router.get("/customer/accountInforList",customer.getAccountInforList);
router.get("/customer/outAndInMoneyList",customer.getOutAndInMoneyList);
router.get("/customer/transforList",customer.getTransforList);
router.get("/customer/tradeList",customer.getTradeList);

//#代理信息
//代理列表
router.get("/ib",ib.page);
router.get("/ib/detail",ib.detail);
module.exports = router;