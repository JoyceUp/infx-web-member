/**
 * Created by zlp on 2018/01/04.
 * For 资金信息
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/member/index");
var requestUtil = require("../common/requestUtil");
var cache = require("../../../util/cache");

let templateResult = {
    datas: {},
    setting: setting
};

//资金记录
exports.fundsrecord = {
    page: function (req, res, next) {
        templateResult.active = "funds_record";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/funds/fundsrecord", templateResult)
        });
    },

    list: function (_req, _res, next) {
        let {page, limit, account_no, account_type,type, start_time, end_time, field, order} = _req.body;
        let param = {
            "condition": {account_no: account_no, "start_time": start_time, "end_time": end_time, "account_type": account_type,"type":type},
            "page_size": limit,
            "page_count": 0,
            "page_no": page,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
        };
        console.log(param)
        request.get(API.member.funds.funds_list)
            .query({msg: JSON.stringify(param)})
            .set("token", _req.cookies.token)
            .end(function (req, res) {
                requestUtil.formatTableData(res).then(function (returnData) {
                    _res.json(returnData)
                })

            });
    }
};


//出入金记录
exports.deposit = {
    page: function (req, res, next) {
        templateResult.active = "funds_deposit";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/funds/deposit", templateResult)
        });
    },

    list: function (_req, _res, next) {
        let {page, limit, account_no, account_type, channel_type, status, start_time, end_time, field, order} = _req.body;

        let params = {
            "page_size": limit,
            "page_count": 0,
            "page_no": page,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition": {
                account_no: account_no,
                "start_time": start_time,
                "end_time": end_time,
                "account_type": account_type,
                "channel_type": channel_type,
                "status": status
            }
        };
        let header = {
            token: _req.cookies.token
        };
        console.log(params)
        request.get(API.member.funds.dep_draw_list)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (req, res) {
                requestUtil.formatTableData(res).then(function (returnData) {
                    _res.json(returnData)
                });
            });

    },

    info: function (_req, _res, next) {
        let {id, type} = _req.body;
        let header = {
            token: _req.cookies.token
        };
        let params = {
            type: type
        };
        request.get(API.member.funds.dep_draw_info + id)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (req, res) {
                if (res.status == 200) {
                    _res.json(requestUtil.resultToJson(res));
                }
            })

    },
    cancel: function (_req, _res, next) {
        let {id, channel_type} = _req.body;

        let header = {
            token: _req.cookies.token
        };
        let params = {
            id: id,
            type: channel_type
        };
        request.put(API.member.funds.dep_draw_cancel)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (req, res) {
                if (res.status == 200) {
                    _res.json(requestUtil.resultToJson(res));
                }
            });
    }
};

//返利转余额记录
exports.returnToBalanceRecord = {
    //返利转余额记录列表
    page: function (req, res, next) {
        templateResult.active = "return_to_balance_record";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/funds/returnToBalanceRecord", templateResult);
        });
    },
    //获取返利转余额记录列表
    list: function (req, res, next) {
        let {page, limit, account_no, start_time, end_time, field, order} = req.body;

        let header = {
            token: req.cookies.token
        };
        let params = {
            page_no: page,
            page_size: limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                account_no: account_no,
                start_time: start_time,
                end_time: end_time
            }
        };
        request.get(`${API.member.funds.return_to_balance_record_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    },
    //返利转余额记录详情
    info: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.funds.return_to_balance_record_info}/${id}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};

//余额清零记录
exports.blanceflush = {
    page: function (req, res, next) {
        templateResult.active = "funds_balance_flush";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/funds/blanceflush", templateResult)
        });
    },

    list: function (_req, _res, next) {
        let {page, limit, account_no, state, field, order, start_time, end_time} = _req.body;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition":
                {
                    "account_no": account_no, "status": state,
                    start_time: start_time,
                    end_time: end_time
                },
        };
        let header = {
            token: _req.cookies.token
        };
        request.get(API.member.funds.bal_clear_list)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (req, res) {
                requestUtil.formatTableData(res).then(function (returnData) {
                    _res.json(returnData)
                });
            });
    },

    info: function (_req, _res, next) {
        let {id} = _req.body;

        let header = {
            token: _req.cookies.token
        };
        request.get(API.member.funds.bal_clear_info + '/' + id)
            .set(header)
            .end(function (req, res) {

                _res.json(requestUtil.resultToJson(res));
            });
    }
};