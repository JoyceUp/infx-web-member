/**
 * Created by cuiyajuan on 2018/1/12.
 * For 代理中心  我的佣金
 */

var setting = require("../../../common/cn/ib/index");
var mock = require("../../../mock/data/rebate");

let templateResult = {
    datas: {},
    setting: setting
};

let items = mock.Rebates();
/*+++++++++++++++++++++++++++++++++++++++++++++   我的佣金   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
exports.balance = function (req, res, next) {
    //templateResult.items = items;
    res.render("ib/pages/rebate/balance", templateResult)
};
exports.balance_datas = function (req, res, next) {
    let {page, limit, source_account_user_name, account_no, start_time, end_time} = req.query;
    let mockData = items.filter(item => {
        if( ib_no && item.ib_no!=ib_no)return false;
        if( account_no && item.account_no!=account_no)return false;
        if( source_account_user_name && item.full_name!=source_account_user_name)return false;
        if(!(CompareDate(item.commission_time,start_time) && CompareDate(end_time,item.commission_time)))return false;
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
};

exports.trade = function (req, res, next) {
    res.render("ib/pages/rebate/trade", templateResult)
};
exports.trade_datas = function (req, res, next) {
    let {page, limit, ib_no, account_no, state, start_time, end_time} = req.query;
    let mockData = items.filter(item => {
        if( ib_no && item.ib_no!=ib_no)return false;
        if( account_no && item.account_no!=account_no)return false;
        if(!(CompareDate(item.commission_time,start_time) && CompareDate(end_time,item.commission_time)))return false;
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
};

/*+++++++++++++++++++++++++++++++++++++++++++++   客户交易数据   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
exports.history = function (req, res, next) {
    res.render("ib/pages/transaction/history", templateResult)
};
exports.history_datas = function (req, res, next) {
    let {page, limit, source_account_user_name, account_no, start_time, end_time} = req.query;

    let mockData = items.filter(item => {
        if( account_no && item.account_no!=account_no)return false;
        if( source_account_user_name && item.full_name!=source_account_user_name)return false;
        if(!(CompareDate(item.close_time,start_time) && CompareDate(end_time,item.close_time)))return false;
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
};
exports.position = function (req, res, next) {
    res.render("ib/pages/transaction/position", templateResult)
};
exports.position_datas = function (req, res, next) {
    let {page, limit, account_no, source_account_user_name, start_time, end_time} = req.query;
    let mockData = items.filter(item => {
        if( account_no && item.account_no!=account_no)return false;
        if( source_account_user_name && item.full_name!=source_account_user_name)return false;
        if(!(CompareDate(item.commission_time,start_time) && CompareDate(end_time,item.commission_time)))return false;
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
};

/** * 比较时间 */
function CompareDate(d1,d2)
{
    if(d1 != undefined && d2 != undefined && d1 != '' && d2 != ''){
        return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
    }
    return true;
}