/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var request = require("superagent");
var API = require("../support/const");
var requestUtil = require("../common/requestUtil");
var cache = require("../../../util/cache");
var setting = require("../../../common/cn/member/index");

let templateResult = {
    datas: {},
    setting: setting
};

//#我的账户
exports.mt = {
    //账户列表
    page: function (req, res, next) {
        templateResult.active = "mtlst";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/account/mtlst", templateResult)
        });
    },


    //获取账户列表
    list: function (req, res, next) {
        let {page, limit, account_no, account_type, state} = req.body;

        let header = {
            token: req.cookies.token
        };
        let params = {
            page_no : page,
            page_size: limit,
            condition: {
                account_no: account_no,
                account_type: account_type,
                status: state
            }
        };
        request.get(`${API.member.account.account_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
               requestUtil.formatTableData(_res).then(function(returnData){
                   if(returnData.status == 200){
                       cache.setAccountList(JSON.parse(req.cookies.user).user_id, returnData.datas);
                   }
                   res.json(returnData);
               });
            });
    },
    //账户详情
    info: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.account.account_info}${id}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    },
    //获取账户余额
    accountBalance: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.account.account_info}${id}`)
            .set(header)
            .end(function (_req, _res) {
                if(!_res || !_res.text){
                    return res.json({status: -201, msg: "服务器异常"});
                }
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    let datas = JSON.parse(data.datas);
                    res.json({
                        status: data.status,
                        msg: data.msg,
                        datas: {
                            balance: datas ? datas.balance : 0
                        }
                    });
                }else{
                    res.json(requestUtil.resultToJson(_res));
                }

            });
    },
    //获取账户返利
    accountRebate: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.account.account_info}${id}`)
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if (data.status == 200) {
                    let datas = JSON.parse(data.datas);
                    res.json({
                        status: data.status,
                        msg: data.msg,
                        datas: {
                            rebate: datas ? datas.rebate : 0
                        }
                    });
                } else {
                    res.json(JSON.parse(_res.text));
                }

            });
    }
};

//修改杠杆
exports.modifyLev = {
    page: function (req, res, next) {
        templateResult.active = "modify_lev";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/account/modifylev", templateResult)
        });
    },
    changeLeverageAjax: function (req, res, next) {
        let {leverage, account_id} = req.body;
        let header = {
            token: req.cookies.token
        };
        let params = {
            leverage: leverage,
            account_id: account_id
        };
        request.put(`${API.member.account.update_leverage}`)
            .set(header)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    }
};
//账户清零
exports.balanceFlush = {
    page: function (req, res, next) {
        templateResult.active = "balance_flush";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            res.render("member/pages/account/blanceflush", templateResult)
        });
    },
    submit: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let params = {
            account_id: req.body.account_id
        };
        request.put(`${API.member.account.bal_clear}`)
            .set(header)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    }
};

//开户链接
exports.invite = {
    page: function (req, res, next) {
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.token, 1).then(function (data) {
            templateResult.account = data;
            templateResult.active = 'createInviteUrl';
            res.render("member/pages/invite/createInviteUrl", templateResult)
        });
    },
    info: function (req, res, next) {
        let {account_type} = req.body;
        let header = {
            token: req.cookies.token
        };
        let params = {
            account_type: account_type
        };
        request.get(API.member.invite.invite)
            .set(header)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
}