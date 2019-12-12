/**
 * Created by zlp on 2018/1/11.
 * For 销售系统
 */

var setting = require("../../../common/cn/sale/index");
var bonusMock = require("../../../mock/data/bonus");

let templateResult = {
    datas: {},
    setting: setting
};

//提成列表
exports.page = function (req, res, next) {
    templateResult.active = "bonus";
    res.render("sale/pages/bonus/index",templateResult)
};

let bonusList = bonusMock.BonusList();
exports.list = function (req, res, next) {
    let {page, limit, start_time, end_time} = req.query;

    let mockData = bonusList.filter(user => {
        if (start_time && new Date(user.change_time).getTime() < new Date(start_time).getTime()) return false;
        return true;
    });
    mockData = mockData.filter(user => {
        if (end_time && new Date(user.change_time).getTime() > new Date(end_time).getTime()) return false;
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
};

let bonusInfoList = bonusMock.BonusInfoList();
exports.info = function (req, res, next) {
    let {page, limit, id} = req.query;
    console.log(req.query)

    let count = bonusInfoList.length;
    let data = bonusInfoList.filter((u, index) => index < limit * page && index >= limit * (page - 1));
    res.json({
        "status": 0,
        "msg": "",
        "count": count,
        "datas": data
    })
};

