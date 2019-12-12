/**
 * Created by zlp on 2017-12-10.
 */
let express = require('express');
let router =  express.Router();
let auth = require("../../app/controller/prod/sale/middleware/auth");
let login = require("../../app/controller/prod/sale/login");
let sale = require("../../app/controller/prod/sale/home");
let rebate = require('../../app/controller/prod/sale/rebate');
let customer = require("../../app/controller/prod/sale/customer");
let userinfo = require("../../app/controller/prod/sale/userinfo");
let bonus = require("../../app/controller/prod/sale/bonus");
let benefit = require("../../app/controller/prod/sale/benefit");

router.get(['/customer/*','/ib/*','/bonus/*','/userinfo/*','/rebate/*','/client/*','/invite/*'],auth.auth)


router.get('/', function(req, res) {
    res.redirect('/sale/login');
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

//首页
router.get("/home",sale.home.page);

//#用户信息
//用户信息
router.get("/userinfo",userinfo.page);
router.post("/userinfo",userinfo.getUserInfo);
router.put("/bind",userinfo.bindmt);
router.delete("/bind",userinfo.unbindmt);

//#客户信息
//客户列表
router.get("/customer",customer.customers.page);
router.post("/customer/list",customer.customers.list);
router.get("/customer/info",customer.customers.info);

//客户详情页面
router.post("/customer/account/list",customer.customer_info.account_list);
router.post("/customer/deposit/list",customer.customer_info.deposit_list);
router.post("/customer/withdraw/cancel",customer.customer_info.cancel);
router.post("/customer/commission/list",customer.customer_info.commission);
router.post("/customer/rebate/list",customer.customer_info.rebate);
router.post("/customer/rebate/detail",customer.customer_info.rebate_detail);



//#返佣返利信息 so
//交易返佣记录
router.get("/rebate/trade",rebate.trade.page);
router.post("/rebate/trade/list",rebate.trade.list);
//余额返利记录
router.get("/rebate/balance",rebate.balance.page);
router.post("/rebates/balance/oneday", rebate.balance.oneday);
router.post("/rebates/balance/list", rebate.balance.list);
router.post("/rebates/balance/info", rebate.balance.info);
//#提成信息 so
//提成列表
router.get("/bonus",bonus.page);
router.post("/bonus/list",bonus.list);
router.post("/bonus/info",bonus.info);
router.post("/bonus/common_sale_reward/list_ecn",bonus.common_sale_reward.list_ecn);
router.post("/bonus/common_sale_reward/list_common",bonus.common_sale_reward.list_common);
router.post("/bonus/department_sale_reward/list_ecn",bonus.department_sale_reward.list_ecn);
router.post("/bonus/department_sale_reward/list_common",bonus.department_sale_reward.list_common);

//#津贴管理
router.get("/benefit",benefit.page);
router.post("/benefit/list",benefit.list);
router.post("/benefit/info",benefit.info);

//#邀请管理
router.get("/invite/page",sale.invite.page); //开户页面
router.post("/invite/info",sale.invite.info); //生成推广链接
module.exports = router;