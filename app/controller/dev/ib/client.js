/**
 * Created by cuiyajuan on 2018/1/12.
 * For 代理中心  我的客户
 */

var setting = require("../../../common/cn/ib/index");
var mock = require("../../../mock/data/rebate");

let templateResult = {
    datas: {},
    setting: setting
};

let items = mock.Clients();
//#我的客户
//客户信息列表
exports.page = function (req, res, next) {
    //templateResult.items = items;
    res.render("ib/pages/client/list", templateResult)
};
exports.client_list = function (req, res, next) {
    let {page, limit, customer_name, account_no, email, mobile, ib_no, start_time, end_time} = req.query;
    let mockData = items.filter(item => {
        if( ib_no && item.ib_no != ib_no)return false;
        if( email && item.email != email)return false;
        if( mobile && item.mobile != mobile)return false;
        if( account_no && item.account_no!=account_no)return false;
        if( customer_name && item.customer_name!=customer_name)return false;
        if(!(CompareDate(item.gmt_create,start_time) && CompareDate(end_time,item.gmt_create)))return false;
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

//客户信息详情
let AccountInfo = mock.AccountInfo();
let DepDrawInfo = mock.DepDrawInfo();
let TransferInfo = mock.TransferInfo();
let TradeInfo = mock.TradeInfo();
exports.client_info = {
    page: function (req, res, next) {
        let {id} = req.query;
        let mockData = items.filter(item => {
            if( id && item.id != id)return false;
            return true;
        });
        templateResult.datas = mockData[0];
        res.render("ib/pages/client/info", templateResult);
    },
    account_list: function (req, res, next) {               //账户信息
        let {page, limit} = req.query;
        let count = AccountInfo.length;
        let data = AccountInfo.filter((u, index) => index < limit * page && index >= limit * (page - 1));
        res.json({
            "status": 0,
            "msg": '',
            "count": count,
            "datas": data
        });
    },
    dep_draw_list: function (req, res, next) {              //出入金信息
        let {page, limit} = req.query;
        let count = DepDrawInfo.length;
        let data = DepDrawInfo.filter((u, index) => index < limit * page && index >= limit * (page - 1));
        res.json({
            "status": 0,
            "msg": '',
            "count": count,
            "datas": data
        });
    },
    transfer_list: function (req, res, next) {              //转账信息
        let {page, limit} = req.query;
        let count = TransferInfo.length;
        let data = TransferInfo.filter((u, index) => index < limit * page && index >= limit * (page - 1));
        res.json({
            "status": 0,
            "msg": '',
            "count": count,
            "datas": data
        });
    },
    trade_list: function (req, res, next) {                 //交易信息
        let {page, limit} = req.query;
        let count = TradeInfo.length;
        let data = TradeInfo.filter((u, index) => index < limit * page && index >= limit * (page - 1));
        res.json({
            "status": 0,
            "msg": '',
            "count": count,
            "datas": data
        });
    }
};



/** * 比较时间 */
function CompareDate(d1,d2)
{
    if(d1 != undefined && d2 != undefined && d1 != '' && d2 != ''){
        return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
    }
    return true;
}