/**
 * Created by cuiyajuan on 2018/1/12.
 * For 代理中心  我的佣金
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/ib/index");
var requestUtil = require("../common/requestUtil");
var mock = require("../../../mock/data/rebate");
var cache = require("../../../util/cache");

let templateResult = {
    datas: {},
    setting: setting
};

let items = mock.Rebates();
/*+++++++++++++++++++++++++++++++++++++++++++++   我的佣金   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
//交易返佣记录
exports.trade = {
    page: function (req, res, next) {
        templateResult.active = "trade";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/rebate/trade", templateResult);
        });
    },
    list: function (req, res, next) {
        let {page, limit, source_account_full_name, account_no, source_account_no, start_time, end_time, field, order} = req.body;
        let params = {
            "page_size": limit,
            "page_no": page,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition": {
                "start_time": start_time,
                "end_time": end_time,
                "source_account_full_name": source_account_full_name,
                "account_no": account_no,
                "source_account_no": source_account_no
            }
        };
        request.get(`${API.ib.rebates.trade_list}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if(returnData.statistics){
                        returnData.datas.push({statistics: 1, commission_amount: returnData.statistics.total_amount, trading_volume: returnData.statistics.total_volume})
                    }
                    res.json(returnData)
                });
            })
    }
};

//余额返利记录
exports.balance = {
    page: function (req, res, next) {
        templateResult.active = "rebate";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/rebate/balance", templateResult);
        });
    },
    oneday: function (req, res, next) {
        let {page, limit, ib_no, account_no, state, start_time, end_time, field, order} = req.body;
        let params = {
            "page_size": limit,
            "page_no": page,
            order_column: field || 'rebate_date',
            order_by: order || 'desc',
            "condition": {
                "start_time": start_time,
                "end_time": end_time,
                "ib_no": ib_no,
                "account_no": account_no,
                "state": state
            }
        };
        request.get(`${API.ib.rebates.one_day}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if(returnData.statistics){
                        returnData.datas.push({statistics: 1, daily_amount: returnData.statistics.total_amount})
                    }
                    res.json(returnData)
                });
            })
    },
    list: function (req, res, next) {
        let {page, limit, ib_no, account_no, state, start_time, end_time, field, order} = req.body;
        let params = {
            "page_size": limit || 10,
            "page_no": page || 1,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition": {
                "start_time": start_time,
                "end_time": end_time,
                "ib_no": ib_no,
                "account_no": account_no,
                "state": state
            }
        };
        request.get(`${API.ib.rebates.balance_list}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });
            })
    },
    info: function (req, res, next) {
        let {id} = req.body;
        request.get(`${API.ib.rebates.balance_info}${id}`)
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
                /*requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });*/
            })
    }
};


/*+++++++++++++++++++++++++++++++++++++++++++++   客户交易数据   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
exports.history = function (req, res, next) {
    templateResult.active = "history";
    res.render("ib/pages/transaction/history", templateResult)
};
exports.history_datas = function (req, res, next) {
    let {page, limit, source_account_user_name, account_no, start_time, end_time} = req.query;

    let mockData = items.filter(item => {
        if (account_no && item.account_no != account_no) return false;
        if (source_account_user_name && item.full_name != source_account_user_name) return false;
        if (!(CompareDate(item.close_time, start_time) && CompareDate(end_time, item.close_time))) return false;
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
    templateResult.active = "position";
    res.render("ib/pages/transaction/position", templateResult)
};
exports.position_datas = function (req, res, next) {
    let {page, limit, account_no, source_account_user_name, start_time, end_time} = req.query;
    let mockData = items.filter(item => {
        if (account_no && item.account_no != account_no) return false;
        if (source_account_user_name && item.full_name != source_account_user_name) return false;
        if (!(CompareDate(item.commission_time, start_time) && CompareDate(end_time, item.commission_time))) return false;
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
function CompareDate(d1, d2) {
    if (d1 != undefined && d2 != undefined && d1 != '' && d2 != '') {
        return ((new Date(d1.replace(/-/g, "\/"))) > (new Date(d2.replace(/-/g, "\/"))));
    }
    return true;
}