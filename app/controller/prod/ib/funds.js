/**
 * Created by zlp on 2018/01/04.
 * For 我的资金
 */
var request = require("superagent");
var API = require("../support/const");
var requestUtil = require("../common/requestUtil");
var setting = require("../../../common/cn/ib/index");
var cache = require("../../../util/cache");
var money = require("../../../util/money");

let templateResult = {
    datas: {},
    setting: setting
};

//账户出金
exports.withdraw = {
    page: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };
        templateResult.active = "withdraw";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            //获取银行卡列表
            cache.getBankList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
                templateResult.banklist = data;
                //获取电汇信息
                cache.getTTInfo(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
                    templateResult.tt = data;
                    //获取汇率
                    // deposit_exchangerate	入金
                    // withdraw_exchangerate	出金
                    request.get(`${API.common.get_rate}`)
                        .query({msg: JSON.stringify({type: "withdraw_exchange_rate"})})
                        .end(function (_req, _res) {
                            //记录用户操作日志
                            let data = JSON.parse(_res.text);
                            if (data.status == 200) {
                                let datas = JSON.parse(data.datas);
                                // templateResult.rate = datas.rate;
                                templateResult.rate = data.datas / 10000;
                                cache.setRate(templateResult.rate, 'withdraw_exchange_rate');
                            }

                            //获取系统参数
                            request.get(`${API.common.system_setting}`)
                                .set(header)
                                .end(function (_req, _res) {
                                    let data = requestUtil.resultToJson(_res);
                                    if(data.datas){
                                        templateResult.system_setting = JSON.parse(data.datas);
                                    }
                                    res.render("ib/pages/funds/withdraw", templateResult);
                                });
                        });
                });
            });
        });
    },
    //确认出金 type 1银行卡 2电汇
    submitWithdraw: function (req, res, next) {
        let {account_id, pay_amount, rate, amount, bankcard_id, bankcard_no, fee, remark, type} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            account_id: account_id,
            pay_amount: money.toServer(pay_amount),
            rate: rate,
            amount: money.toServer(amount),
            bankcard_id: bankcard_id,
            bankcard_no: bankcard_no,
            fee: money.toServer(fee),
            remark: remark
        };
        let url = '';
        switch (type) {
            case '1':
                url = `${API.ib.funds.bankcard_withdraw}`;
                break;
            case '2':
                url = `${API.ib.funds.tt_withdraw}`;
                break;
            default:
                break;
        }
        request.put(url)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    },
    //出金手续费
    withdrawFee: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.funds.fee_withdraw}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    },
    //出金取消
    cancelWithdraw: function (req, res, next) {
        let {id, channel_type} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            id: id,
            type: channel_type
        };
        request.put(`${API.ib.funds.cancel_withdraw}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    }
};

//账户转账
exports.transfer = {
    //确认转账
    page: function (req, res, next) {
        templateResult.active = "transfer";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/funds/transfer", templateResult);
        });
    },
    //确认转账
    submitTransfer: function (req, res, next) {
        let {account_id_from, account_id_to, transfer_amount} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            from_account_id: account_id_from,
            target_account_id: account_id_to,
            amount: money.toServer(transfer_amount)
        };
        request.put(`${API.ib.funds.transfer}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    },
    //转账取消
    cancelTransfer: function (req, res, next) {
        let {id, type} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            order_id: id,
            type: type
        };
        request.put(`${API.ib.funds.cancel_transfer}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    }
};
//返利转余额
exports.returnToBalance = {
    page: function (req, res, next) {
        templateResult.active = "return_to_balance";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/funds/returnToBalance", templateResult);
        });
    },
    //确认转账
    submitReturnToBalance: function (req, res, next) {
        let {account_id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            account_id: account_id
        };
        request.put(`${API.ib.funds.return_to_balance}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    },
};

//资金记录
exports.fundsrecord = {
    page: function (req, res, next) {
        templateResult.active = "funds_record";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/funds/fundsRecord", templateResult)
        });
    },

    list: function (_req, _res, next) {
        let {page, limit, account_no, type, start_time, end_time, field, order} = _req.body;
        let params = {
            "condition": {account_no: account_no, "start_time": start_time, "end_time": end_time, "type": type},
            "page_size": limit,
            "page_count": 0,
            "page_no": page,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
        };
        request.get(API.ib.funds.funds_list)
            .query({msg: JSON.stringify(params)})
            .set("token", _req.cookies.ibtoken)
            .end(function (req, res) {
                requestUtil.formatTableData(res).then(function (returnData) {
                    _res.json(returnData)
                })

            });
    }
};
//出金记录
exports.withdrawRecord = {
    //出金记录列表
    page: function (req, res, next) {
        templateResult.active = "withdraw_record";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/funds/withdrawRecord", templateResult);
        });
    },
    //获取出金记录列表
    list: function (req, res, next) {
        let {page, limit, account_no, channel_type, state, start_time, end_time, field, order} = req.body;

        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            page_no: page,
            page_size: limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                type: channel_type,
                status: state,
                account_no: account_no,
                start_time: start_time,
                end_time: end_time
            }
        };
        request.get(`${API.ib.funds.withdraw_record_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    },
    //出金记录详情
    info: function (req, res, next) {
        let {id, channel_type} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            cause: channel_type
        };
        request.get(`${API.ib.funds.withdraw_record_info}${id}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};

//转账记录
exports.transferRecord = {
    //转账记录列表
    page: function (req, res, next) {
        templateResult.active = "transfer_record";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/funds/transferRecord", templateResult);
        });
    },
    //获取转账记录列表
    list: function (req, res, next) {
        let {page, limit, account_no_from, account_no_to, state, start_time, end_time, field, order} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            page_no: page,
            page_size: limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                account_no: account_no_from,
                target_account_no: account_no_to,
                status: state,
                start_time: start_time,
                end_time: end_time
            }
        };
        request.get(`${API.ib.funds.transfer_record_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    },
    //转账记录详情
    info: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.funds.transfer_record_info}/${id}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};

//返利转余额记录
exports.returnToBalanceRecord = {
    //返利转余额记录列表
    page: function (req, res, next) {
        templateResult.active = "return_to_balance_record";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/funds/returnToBalanceRecord", templateResult);
        });
    },
    //获取返利转余额记录列表
    list: function (req, res, next) {
        let {page, limit, account_no, start_time, end_time, field, order} = req.body;

        let header = {
            token: req.cookies.ibtoken
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
        request.get(`${API.ib.funds.return_to_balance_record_list}`)
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
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.funds.return_to_balance_record_info}/${id}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};
