/**
 * Created by zlp on 2018/01/04.
 * For 我的资金
 */
var fundsMock = require("../../../mock/data/funds");
var accountMock = require("../../../mock/data/accountData");
var setting = require("../../../common/cn/ib/index");

let templateResult = {
    datas: {},
    setting: setting
}

let accountList = accountMock.AccountList();
//账户出金
exports.withdraw = {
    page: function (req, res, next) {
        templateResult.active = "withdraw";
        templateResult.account = accountList;
        res.render("ib/pages/funds/withdraw", templateResult)
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
        res.render("ib/pages/funds/transfer", templateResult)
    },
    //确认转账
    submitTransfer: function (req, res, next) {
        let dd = req.body;
        console.log(dd)
        res.json({
            "status": 0,
            "msg": ""
        })
    }
};
//返利转余额
exports.returnToBalance = {
    page: function (req, res, next) {
        templateResult.active = "return_to_balance";
        templateResult.account = accountList;
        res.render("ib/pages/funds/returnToBalance", templateResult)
    },
    //确认转账
    submitReturnToBalance: function (req, res, next) {
        let dd = req.body;
        console.log(dd)
        res.json({
            "status": 0,
            "msg": ""
        })
    }
};


//出金记录
var depositList = fundsMock.depDrawList();
exports.withdrawRecord = {
    page: function (req, res, next) {
        templateResult.active = "withdraw_record";
        res.render("ib/pages/funds/withdrawRecord", templateResult)
    },
    list: function (req, res, next) {
        let {page, limit, account_no, type, channel_type, state, start_time, end_time} = req.body;
        let mockData = depositList.filter(fund => {
            if (account_no && fund.account_no != account_no) return false;
            return true;
        });

        mockData = mockData.filter(fund => {
            if (type && fund.type != type) return false;
            return true;
        });

        mockData = mockData.filter(fund => {
            if (channel_type && fund.channel_type != channel_type) return false;
            return true;
        });

        mockData = mockData.filter(fund => {
            if (state && fund.state != state) return false;
            return true;
        });

        mockData = mockData.filter(fund => {
            if (start_time && fund.start_time < start_time) return false;
            return true;
        });

        mockData = mockData.filter(fund => {
            if (end_time && fund.end_time <= end_time) return false;
            return true;
        });
        let count = mockData.length;
        let data = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));

        res.json({
            "status": 0,
            "msg": '',
            "count": count,
            "datas": data
        });
    },

    info: function (req, res, next) {
        let {id} = req.body;
        console.log(req.body)
        let mockData = depositList.filter(dps => {
            if (id && dps.id != id) return false;
            return true;
        });

        res.json({
            "status": 0,
            "msg": "",
            "datas": mockData[0]
        });
    },
};

//转账记录
exports.transferRecord = {
    page: function (req, res, next) {
        templateResult.active = "transfer_record";
        res.render("ib/pages/funds/transferRecord", templateResult)
    },
    list: function (req, res, next) {
        let {page, limit, id, account_no_from, account_no_to, state} = req.body;
        let mockData = depositList.filter(obj => {
            if (id && obj.id != id)
                return false;
            return true;
        });

        mockData = mockData.filter(obj => {
            if (account_no_from && obj.account_no_from != account_no_from)
                return false;
            return true;
        });

        mockData = mockData.filter(obj => {
            if (account_no_to && obj.account_no_to != account_no_to)
                return false;
            return true;
        });

        mockData = mockData.filter(obj => {
            if (state && obj.state != state)
                return false;
            return true;
        });
        let count = mockData.length;
        mockData = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));

        res.json({
            'status': 0,
            'msg': '',
            'count': count,
            'datas': mockData
        });
    },

    info: function (req, res, next) {
        let {id} = req.body;
        console.log(req.body)
        let mockData = depositList.filter(obj => {
            if (id && obj.id != id)
                return false;
            return true;
        });
        res.json({
            'status': 0,
            'msg': '',
            'datas': mockData[0]
        });
    }
}

//返利转余额记录
var returnToBalanceRecordList = fundsMock.returnToBalanceRecordList();
exports.returnToBalanceRecord = {
    page: function (req, res, next) {
        templateResult.active = "return_to_balance_record";
        res.render("ib/pages/funds/returnToBalanceRecord", templateResult)
    },
    list: function (req, res, next) {
        let {page, limit, id, account_no_from, account_no_to, state} = req.body;
        let mockData = returnToBalanceRecordList.filter(obj => {
            if (id && obj.id != id)
                return false;
            return true;
        });

        mockData = mockData.filter(obj => {
            if (account_no_from && obj.account_no_from != account_no_from)
                return false;
            return true;
        });

        mockData = mockData.filter(obj => {
            if (account_no_to && obj.account_no_to != account_no_to)
                return false;
            return true;
        });

        mockData = mockData.filter(obj => {
            if (state && obj.state != state)
                return false;
            return true;
        });
        let count = mockData.length;
        mockData = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));

        res.json({
            'status': 0,
            'msg': '',
            'count': count,
            'datas': mockData
        });
    }
};
