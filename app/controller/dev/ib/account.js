/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var Promise = require("bluebird");
var accountMock = require("../../../mock/data/accountData");
var setting = require("../../../common/cn/ib/index");

let templateResult = {
    datas: {},
    setting: setting
};

let accountList = accountMock.AccountList();

exports.page = function (req, res, next) {
    templateResult.active = "account_list";
    res.render("ib/pages/account/mtlst", templateResult)
};

exports.append = function (req, res, next) {
    templateResult.active = "account_append";
    res.render("ib/pages/account/append", templateResult)
};
