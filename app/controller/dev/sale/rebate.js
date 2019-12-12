/**
 * Created by zlp on 2018/1/11.
 * For 销售系统
 */

var setting = require("../../../common/cn/sale/index");
var rebateMock = require("../../../mock/data/rebate");

let templateResult = {
    datas: {},
    setting: setting
};

let tradeList = rebateMock.TradeList();
//交易返佣明细
exports.trade = {
    page: function (req, res, next) {
        templateResult.active = "trade";
        res.render("sale/pages/rebate/trade",templateResult)
    },
    list: function (req, res, next) {
        let {page, limit, start_time, end_time, name, account_no} = req.body;

        let mockData = tradeList.filter(user => {
            if (start_time && new Date(user.change_time).getTime() < new Date(start_time).getTime()) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (end_time && new Date(user.change_time).getTime() > new Date(end_time).getTime()) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (name && user.name.indexOf(name) == -1) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (account_no && user.account_no != account_no) return false;
            return true;
        });

        let count = mockData.length;
        let data = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));
        res.json({
            "status": 0,
            "msg": "",
            "count": count,
            "datas": data
        })
    }
};
//余额返利明细
let balanceList = rebateMock.BalanceList();
exports.balance = {
    page: function (req, res, next) {
        templateResult.active = "balance";
        res.render("sale/pages/rebate/balance",templateResult)
    },

    list: function (req, res, next) {
        let {page, limit, start_time, end_time, name, account_no} = req.body;

        let mockData = balanceList.filter(user => {
            if (start_time && new Date(user.change_time).getTime() < new Date(start_time).getTime()) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (end_time && new Date(user.change_time).getTime() > new Date(end_time).getTime()) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (name && user.name.indexOf(name) == -1) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (account_no && user.account_no != account_no) return false;
            return true;
        });

        let count = mockData.length;
        let data = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));
        res.json({
            "status": 0,
            "msg": "",
            "count": count,
            "datas": data
        })
    }
};