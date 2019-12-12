/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var request = require("superagent");
var API = require("../support/const");
var requestUtil = require("../common/requestUtil");
var setting = require("../../../common/cn/ib/index");
var cache = require("../../../util/cache");
var banks = require("../../../common/cn/common/banks");
let templateResult = {
    datas: {},
    setting: setting,
    banks: banks
};

//#我的账户
exports.mt = {
    //账户列表
    page: function (req, res, next) {
        templateResult.active = "account_list";
        res.render("ib/pages/account/mtlst", templateResult)
    },
    //获取账户列表
    list: function (req, res, next) {
        let {page, limit} = req.body;

        let params = {
            page_no: page,
            page_size: limit
        };
        let header = {
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.account.account_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if (returnData.status == 200) {
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
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.account.account_info}/${id}`)
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    },
    //获取账户余额
    accountBalance: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.account.account_info}${id}`)
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if (data.status == 200) {
                    let datas = JSON.parse(data.datas);
                    res.json({
                        status: data.status,
                        msg: data.msg,
                        datas: {
                            balance: datas ? datas.balance : 0
                        }
                    });
                } else {
                    res.json(JSON.parse(_res.text));
                }

            });
    },
    //获取账户返利
    accountRebate: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.account.account_info}${id}`)
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
//添加注册账户
exports.append = {
    page: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };
        //获取可用账户类型
        request.get(`${API.ib.account.account_type}`)
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if (data.status == 200) {
                    try {
                        let datas = JSON.parse(data.datas);
                        let account_type = [];
                   /*     for (let i in datas.items) {
                            account_type.push(setting.select.register.account_type_map[datas.items[i]]);
                        }
                        templateResult.account_type = account_type;*/
                    } catch (e) {
                        console.log('error', e)
                    }
                }
                templateResult.active = "account_append";
                res.render("ib/pages/account/append", templateResult)
            });

    },
    submit: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            account_type: req.body.account_type
        };
        request.post(`${API.ib.account.append_account}`)
            .set(header)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};
//个人资料
exports.userinfo = {
    page: function (req, res, next) {

        let preferred = req.query.preferred;

        let header = {
            token: req.cookies.ibtoken
        };


        let data = {};

        function render() {
            templateResult.active = 'account_info';
            templateResult.datas = data;
            templateResult.preferred = preferred;
            res.render("ib/pages/account/userinfo", templateResult);
        }

        function getBasic() {
            request.get(`${API.ib.account.basic_info}`)
                .set(header)
                .end(function (_req, _res) {
                    if(_res && _res.text){
                        let datas = JSON.parse(_res.text).datas
                        data.basic = JSON.parse(datas);
                    }

                    //截取日期仍 yyyy-MM-dd HH:mm:ss => yyyy-MM-dd
                    if(data.basic.date_of_birth)
                    {
                        data.basic.date_of_birth = data.basic.date_of_birth.substring(0, 10);
                    }


                    getAddress();
                });
        }

        /*function getIdentity() {
            request.get(`${API.ib.account.identity_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.identity = JSON.parse(JSON.parse(_res.text).datas);
                    getAddress();
                });
        }*/

        function getAddress() {
            request.get(`${API.ib.account.address_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.address = JSON.parse(JSON.parse(_res.text).datas);
                    getBankcard();
                });
        }
        function getBankcard() {

            request.get(`${API.ib.account.bankcard_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.bankcard = JSON.parse(JSON.parse(_res.text).datas);
                    data.banksInfo = JSON.stringify(banks);
                    //console.log(setting.select.userinfo.banks)
                    //console.log(banks)
                    getTelinfo();
                });
        }
        function getTelinfo() {
            request.get(`${API.ib.account.tt_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.tt = JSON.parse(JSON.parse(_res.text).datas);
                    render();
                });
        }
        getBasic();
    },
    update: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };

        request.put(`${API.ib.account.basic_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
};

//个人资料-地址信息
exports.address = {
    update: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };
        request.put(`${API.ib.account.address_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }

};
//个人资料-银行信息
exports.bankInfo = {
    page: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };

        //let query = {page_no: 1,page_size:10};

        request.get(`${API.ib.account.bankcard_list}`)
        //.query({msg: JSON.stringify(query)})
            .set(header)
            .end(function (_req, _res) {
                let result = JSON.parse(JSON.parse(_res.text).datas);
                templateResult.active = 'bankinfo';
                templateResult.datas = result;
                //设置缓存
                cache.setBankList(JSON.parse(req.cookies.user).user_id, result.items);
                templateResult.banksInfo = JSON.stringify(setting.select.customer.banks);

                res.render("member/pages/user/bankinfo", templateResult);
            });

    },
    list: function (req, res) {
    },
    info: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };

        request.get(`${API.ib.account.bankcard_info}/${id}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });

    },
    add: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };

        request.post(`${API.ib.account.bankcard_add}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    cache.initIbBankList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, function(d){});
                }
                res.json(data);
            });
    },
    del: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        request.del(`${API.ib.account.bankcard_delete}/${id}`)
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    cache.initIbBankList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, function(d){});
                }
                res.json(data);
            });

    },
    update: function (req, res, next) {
        let {id} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        request.put(`${API.ib.account.bankcard_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    cache.initIbBankList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, function(d){});
                }
                res.json(data);
            });
    }
};
//个人资料-电汇信息
exports.telInfo = {

    page: function (req, res, next) {


        let header = {
            token: req.cookies.ibtoken
        };
        request.get(`${API.ib.account.tt_info}`)
            .set(header)
            .end(function (_req, _res) {

                let result = JSON.parse(JSON.parse(_res.text).datas);

                templateResult.active = 'telinfo';
                templateResult.datas = result;
                res.render("member/pages/user/telinfo", templateResult)

            });


    },
    list: function (req, res) {
    },
    info: function (req, res) {
    },
    add: function (req, res, next) {
        let header = {
            token: req.cookies.ibtoken
        };
        request.post(`${API.ib.account.tt_add}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    },
    del: function (req, res) {
    },
    update: function (req, res, next) {

        let header = {
            token: req.cookies.ibtoken
        };

        request.put(`${API.ib.account.tt_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    cache.initIbTTInfo(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, function(d){});
                }
                res.json(data);
            });
    }

};

//开户链接
exports.invite = {
    page: function (req, res, next) {
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            templateResult.active = 'createInviteUrl';
            res.render("ib/pages/invite/createInviteUrl", templateResult)
        });
    },
    info: function (req, res, next) {
        let {account_type} = req.body;
        let header = {
            token: req.cookies.ibtoken
        };
        let params = {
            account_type: account_type
        };
        request.get(API.ib.invite.invite)
            .set(header)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text));
            });
    }
}