/**
 * Created by sozt on 2018/1/11.
 * For 销售系统
 */

var request = require("superagent");
var API = require("../support/const");
var requestUtil = require("../common/requestUtil");
var setting = require("../../../common/cn/sale/index");

let templateResult = {
    datas: {},
    setting: setting
};

//交易返佣明细
exports.trade = {
    //交易返佣明细列表
    page: function (req, res, next) {
        templateResult.active = "trade";
        res.render("sale/pages/rebate/trade",templateResult)
    },
    //获取返佣明细列表
    list: function (req, res, next) {
        let {page, limit, source_account_full_name, source_account_no, start_time, end_time, field, order} = req.body;
        let sales_id = JSON.parse(req.cookies.user).user_id;
        let params = {
            page_no: page,
            page_size: limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                sales_id: sales_id,
                source_account_no: source_account_no,
                source_account_full_name: source_account_full_name,
                start_time: start_time,
                end_time: end_time
            }
        };
        let header = {
            token: req.cookies.saletoken
        };
        request.get(API.sale.rebate.trade_list)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                if(_res.status == 200) {
                    requestUtil.formatTableData(_res).then(function (returnData) {
                        if(returnData.statistics){
                            returnData.datas.push({statistics: 1, trading_volume: returnData.statistics.total_volume, commission_amount: returnData.statistics.total_amount})
                        }
                        res.json(returnData);

                    });
                }
            });
    },
    //交易返佣明细详情
    info: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.saletoken
        };
        request.get(`${API.sale.rebate.trade_info}/${id}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};
//返利明细
exports.balance = {
    //返利明细列表页面
    page: function (req, res, next) {
        templateResult.active = "balance";
        res.render("sale/pages/rebate/balance",templateResult)
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
        let header = {
            token: req.cookies.saletoken
        };
        request.get(`${API.sale.rebate.one_day_balance_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if(returnData.statistics){
                        returnData.datas.push({statistics: 1, daily_amount: returnData.statistics.total_amount})
                    }
                    res.json(returnData)
                });
            })
    },
    //获取返利明细列表
    list: function (req, res, next) {
        let {page, limit, start_time, end_time, name, account_no} = req.body;
        let sales_id = JSON.parse(req.cookies.user).user_id;
        let params = {
            page_no : page,
            page_size:limit,
            condition: {
                account_no: account_no,
                sales_id: sales_id,
                customer_name: name,
                start_time: start_time,
                end_time: end_time
            }
        };
        let header = {
            token: req.cookies.saletoken
        };
        request.get(API.sale.rebate.balance_list)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    res.json(returnData);
                });
            });
    },
    //交易返佣明细详情
    info: function (req, res, next) {
        let {page, limit,start_time} = req.body;
        let header = {
            token: req.cookies.saletoken
        };
        let params ={
            page_size:10,
            page_no:1,
            condition:{start_time:start_time}
        }
        request.get(API.sale.rebate.balance_info)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    res.json(returnData);
                });
            });
    }
};