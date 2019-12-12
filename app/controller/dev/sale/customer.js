/**
 * Created by 翟凤禄 on 2018/1/11.
 * For 销售系统
 */
var setting = require("../../../common/cn/sale/index");
var userMock = require("../../../mock/data/user");
let templateResult = {

    datas: {},
    setting: setting
};


exports.page = function (req, res, next) {
    templateResult.active = "customer";
    res.render("sale/pages/customer/list",templateResult)
};
//客户记录
var customerList = userMock.customerList();
exports.getCustomerList =function (req,res,next) {
    let {page, name, email, mt4, start_time, end_time,limit} = req.query;

    console.log(page,limit);
    let mockData = customerList.filter(fund => {
        if (name && fund.name != name) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (mt4 && fund.mt4 != mt4) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (email && fund.email != email) return false;
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
}

//客户详情
exports.detail = function (req, res, next) {
    res.render("sale/pages/customer/detail",templateResult)
};
exports.getAccountInforList =function (req,res,next) {
    let {page, name, email, mt4, start_time, end_time,limit} = req.query;

    console.log(page,limit);
    let mockData = customerList.filter(fund => {
        if (name && fund.name != name) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (mt4 && fund.mt4 != mt4) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (email && fund.email != email) return false;
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
}

exports.getOutAndInMoneyList =function (req,res,next) {
    let {page, name, email, mt4, start_time, end_time,limit} = req.query;

    console.log(page,limit);
    let mockData = customerList.filter(fund => {
        if (name && fund.name != name) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (mt4 && fund.mt4 != mt4) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (email && fund.email != email) return false;
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
}
exports.getTransforList =function (req,res,next) {
    let {page, name, email, mt4, start_time, end_time,limit} = req.query;

    console.log(page,limit);
    let mockData = customerList.filter(fund => {
        if (name && fund.name != name) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (mt4 && fund.mt4 != mt4) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (email && fund.email != email) return false;
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
}
exports.getTradeList =function (req,res,next) {
    let {page, name, email, mt4, start_time, end_time,limit} = req.query;

    console.log(page,limit);
    let mockData = customerList.filter(fund => {
        if (name && fund.name != name) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (mt4 && fund.mt4 != mt4) return false;
        return true;
    });
    mockData = mockData.filter(fund => {
        if (email && fund.email != email) return false;
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
}