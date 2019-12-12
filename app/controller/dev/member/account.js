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
};

//#w我的账户
let accountList = accountMock.AccountList();
exports.mt = {
    //账户列表
    page: function (req, res, next) {
        templateResult.active = "mtlst";
        res.render("member/pages/account/mtlst", templateResult)
    },

    //获取账户列表
    list: function (req, res, next) {
        let {page, limit, account_no, account_type, state} = req.body;

        let mockData = accountList.filter(user => {
            if (account_no && user.account_no != account_no) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (account_type && account_type != -1 && user.account_type != account_type) return false;
            return true;
        });
        mockData = mockData.filter(user => {
            if (state && state != -1 && user.state != state) return false;
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
    },
    //账户详情
    info: function (req, res, next) {
        let {id} = req.body;
        let mockData = accountList.filter(user => {
            if (id && user.id != id) return false;
            return true;
        });
        res.json({
            "status": 0,
            "msg": "",
            "datas": mockData[0]
        })
    },
    //获取账户余额
    accountBalance: function (req, res, next) {
        let {id} = req.body;
        let mockData = accountList.filter(user => {
            if (id && user.id != id) return false;
            return true;
        });
        res.json({
            "status": 0,
            "msg": "",
            "datas": mockData[0].balance
        })
    }
};
//添加注册账户
exports.append = {
    page: function (req, res, next) {
        templateResult.active = "append";
        res.render("member/pages/account/append", templateResult)
    }
};

//修改杠杆
exports.modifyLev = {
    page: function (req, res, next) {
        templateResult.active = "modify_lev";
        templateResult.account = accountList;
        res.render("member/pages/account/modifylev", templateResult)
    },
    changeLeverageAjax: function (req, res, next) {
        var str = "";
        req.on("data", function (chunk) {
            str += chunk
        })
        req.on("end", function () {
            res.json({
                "status": 0,
                "msg": ""
            })
        })
    }
};
//账户清零
exports.balanceFlush = {
    page: function (req, res, next) {
        templateResult.active = "balance_flush";
        templateResult.account = accountList;
        res.render("member/pages/account/blanceflush", templateResult)
    }
};