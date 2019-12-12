/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/member/index");
var cache = require("../../../util/cache");
var money = require("../../../util/money");
var requestUtil = require("../common/requestUtil");

let templateResult = {
    datas: {},
    setting: setting
}
//#资金交易
//账户入金
exports.deposit = {
    page: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        templateResult.active = "deposit";
        let host = req.hostname;
        if (host.indexOf("172.7") > -1 || host.indexOf("localhost") > -1) {
            templateResult.payUrl = "http://p.xinanchuangying.com/mdffx-payserv/api/v1/customer/deposit/";
        } else {
            templateResult.payUrl = "http://www.xinanchuangying.com/mdffx-payserv/api/v1/customer/deposit/";
        }
        //templateResult.payUrl.wechat = "http://www.xinanchuangying.com/mdffx-payserv/api/v1/customer/deposit/bankcard";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;

            var params = {
                type: [1, 2]
            };
            request.get(`${API.member.user.tt_list}`)
                .query({msg: JSON.stringify(params)})
                .set(header)
                .end(function (_req, _res) {
                        requestUtil.formatTableData(_res).then(function (returnData) {

                            let data = returnData.datas;
                            templateResult.bank = data;

                            request.get(`${API.common.system_setting}`)
                                .set(header)
                                .end(function (_req, _res) {
                                    let data = requestUtil.resultToJson(_res);
                                    if (data.datas) {
                                        templateResult.system_setting = JSON.parse(data.datas);
                                    }
                                    console.log(templateResult);
                                    res.render("member/pages/transaction/deposit", templateResult)
                                });

                        })
                })
            return cache.getTTInfo(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1)

        })


    },
    //确认入金 type  1\idr 2\usd
    submitDeposit: function (req, res, next) {
        let {company_bank_name,company_bank_card_no,tt_id,account_id, amount_idr, amount_usd, rate, tt_path, type} = req.body;
        let header = {
            token: req.cookies.token
        };
        let params = {
            account_id: account_id,
            tt_path: tt_path,
            tt_id: tt_id,
            company_bank_name:company_bank_name,
            company_bank_card_no:company_bank_card_no
        };

        let url = '';
        switch (type) {
            case '1':
                params.amount_idr = amount_idr;
                params.amount_usd = amount_usd;
                params.rate = rate;
                url = `${API.member.transaction.tt_idr_deposit}`;
                break;
            case '2':
                params.amount = amount_usd;
                url = `${API.member.transaction.tt_deposit}`;
                break;
            default:
                break;
        }
        request.put(url)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    },
    resultPage: function (req, res, next) {
        let {user_id, status, order_no, amount} = req.query;  //status 200
        // TODO redis
        cache.depositSuccess(user_id, status);
        // templateResult.active = "deposit";
        res.render("member/pages/transaction/depositResult", templateResult)
    },
    checkDeposit: function (req, res, next) {
        let status = cache.checkDeposit(JSON.parse(req.cookies.user).user_id);
        res.json({status: status});
    }

};
//账户出金
exports.withdraw = {
    page: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };

        templateResult.active = "withdraw";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;

            console.log(data)
            //获取电汇信息
            var params = {
                type: [1, 2]
            };
            request.get(`${API.member.user.tt_list}`)
                .query({msg: JSON.stringify(params)})
                .set(header)
                .end(function (_req, _res) {
                    requestUtil.formatTableData(_res).then(function (returnData) {

                        let data = returnData.datas;

                        templateResult.bank = data;
                      /*  let tt_idr = [];
                        let tt_usd = [];
                        for (let index in data) {
                            if (data[index].currency == 1) {
                                tt_usd.push(data[index])
                            } else {
                                tt_idr.push(data[index])
                            }
                        }
                        templateResult.tt_usd = tt_usd;
                        templateResult.tt_idr = tt_idr;*/
                        //获取汇率
                        // deposit_exchangerate	入金
                        // withdraw_exchangerate	出金

                        request.get(`${API.common.system_setting}`)
                            .set(header)
                            .end(function (_req, _res) {
                                let data = requestUtil.resultToJson(_res);
                                if (data.datas) {
                                    templateResult.system_setting = JSON.parse(data.datas);
                                }
                                res.render("member/pages/transaction/withdraw", templateResult)
                            });

                       /* request.get(`${API.common.get_rate}`)
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

                            });*/

                    });
                });
        });

    },
    //确认出金 type 1\idr 2\usd
    submitWithdraw: function (req, res, next) {
        let {account_id, amount, amount_idr, rate, amount_usd, fee, remark, sub_type, tt_id} = req.body;

        let header = {
            token: req.cookies.token
        };
        let params = {
            account_id: account_id,                //账号id
            rate: rate,
            fee: money.toServer(fee),
            remark: remark,
            tt_id: tt_id                            //电汇id
        };
        let url = '';
        switch (sub_type) {
            case '1':
                url = `${API.member.transaction.tt_idr_withdraw}`;
                params.currency = 2;
                params.amount_idr = money.toServer(amount_idr);
                params.amount_usd = money.toServer(amount_usd);
                break;
            case '2':
                url = `${API.member.transaction.tt_withdraw}`;
                params.currency = 1;
                params.amount = money.toServer(amount);
                break;
            default:
                break;
        }
        console.log(params)
        request.put(url)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res))
            });
    },
    //出金手续费
    withdrawFee: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.transaction.fee_withdraw}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res))
            });
    },
    //出金取消
    cancelWithdraw: function (req, res, next) {
        let {id, type} = req.body;
        let header = {
            token: req.cookies.token
        };
        let params = {
            order_id: id,
            type: type
        };
        request.put(`${API.member.transaction.cancel_withdraw}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res))
            });
    }
};

//返利转余额
exports.returnToBalance = {
    page: function (req, res, next) {
        templateResult.active = "return_to_balance";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/transaction/returnToBalance", templateResult);
        });
    },
    //确认
    submitReturnToBalance: function (req, res, next) {
        let {account_id} = req.body;
        let header = {
            token: req.cookies.token
        };
        let params = {
            account_id: account_id
        };
        request.put(`${API.member.transaction.return_to_balance}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    },
};