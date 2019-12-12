/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var Promise = require("bluebird");
var accountMock = require("../../../mock/data/accountData");
var setting = require("../../../common/cn/member/index");

let templateResult = {
    datas: {},
    setting: setting
}
let accountList = accountMock.AccountList();
exports.deposit =  {
    page: function (req, res, next) {
        templateResult.active = "deposit";
        templateResult.account = accountList;
        res.render("member/pages/transaction/deposit", templateResult)
    },
    //确认入金 type 1银行卡 2电汇 3微信
    submitDeposit: function (req, res, next) {
        let {account_no, money, type} = req.body;
        var str = "";
        req.on("data", function (chunk) {
            str += chunk
        });

        req.on("end", function () {
            res.json({
                "status": 0,
                "msg": ""
            })
        })
    }
};
//账户出金
exports.withdraw = {
    page: function (req, res, next) {
        templateResult.active = "withdraw";
        templateResult.account = accountList;
        res.render("member/pages/transaction/withdraw", templateResult)
    },
    //确认出金 type 1银行卡 2电汇
    submitWithdraw: function (req, res, next) {
        let {account_no, money, type} = req.body;
        res.json({
            "status": 0,
            "msg": ""
        })
    }
};

//账户转账
exports.transfer = {
    page: function (req, res, next) {
        templateResult.active = "transfer";
        templateResult.account = accountList;
        res.render("member/pages/transaction/transfer", templateResult)
    },
    //确认转账
    submitTransfer: function (req, res, next) {
        let dd = req.body;
        res.json({
            "status": 0,
            "msg": ""
        })
    }
};