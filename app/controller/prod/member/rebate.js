/**
 * Created by cuiyajuan on 2018/1/12.
 * For 代理中心  我的佣金
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/member/index");
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
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/rebate/trade", templateResult);
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
        request.get(`${API.member.rebates.trade_list}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.token)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if(returnData.statistics){
                        returnData.datas.push({statistics: 1, amount: returnData.statistics.amount_total, trading_volume: returnData.statistics.volume_total})
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
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/rebate/balance", templateResult);
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
        request.get(`${API.member.rebates.one_day}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.token)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    console.log(returnData)
                    if(returnData.statistics){
                        returnData.datas.push({statistics: 1, amount: returnData.statistics.amount_total})
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
        request.get(`${API.member.rebates.balance_list}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.token)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });
            })
    }
};
