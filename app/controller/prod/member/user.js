/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/member/index");
var banks = require("../../../common/cn/common/banks");
var cache = require("../../../util/cache");
var requestUtil = require("../common/requestUtil");

let templateResult = {
    datas: {},
    setting: setting,
    banks:JSON.stringify(banks),
    banks_option:banks
};
//个人信息
exports.userInfo = {

    page: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };

        let data = {};

        function render() {
            templateResult.active = 'userinfo';
            templateResult.datas = data;
            res.render("member/pages/user/info", templateResult);
        }

        function getBasic() {
            request.get(`${API.member.user.basic_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.basic = JSON.parse(JSON.parse(_res.text).datas);
                    getIdentity();
                });
        }

        function getIdentity() {
            request.get(`${API.member.user.identity_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.identity = JSON.parse(JSON.parse(_res.text).datas);
                    getAddress();
                });
        }

        function getAddress() {
            request.get(`${API.member.user.address_info}`)
                .set(header)
                .end(function (_req, _res) {
                    data.address = JSON.parse(JSON.parse(_res.text).datas);
                    render();
                });
        }

        getBasic();
    },

    update: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };

        request.put(`${API.member.user.basic_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    },
    update_identity: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        request.put(`${API.member.user.identity_info}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    }

};
//地址信息
exports.address = {
    update: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };

        request.put(`${API.member.user.address_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    }

};

//电汇信息
exports.telInfo = {
    page: function (req, res, next) {
        templateResult.active = 'telinfo';
        res.render("member/pages/user/telinfo", templateResult)
    },
    list: function (req, res) {
        let header = {
            token: req.cookies.token
        };
        var params = {
            type: [1, 2]
        };
        request.get(`${API.member.user.tt_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if(returnData.status == 200){
                        cache.setTTInfo(JSON.parse(req.cookies.user).user_id, returnData.datas);
                    }
                    res.json(returnData);
                });
            });
    },
    info: function (req, res) {
        let header = {
            token: req.cookies.token
        };
        let {id} = req.body;
        request.get(`${API.member.user.tt_info}/${id}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                res.json(data);
            });
    },
    add: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let { branch_swift_code,card_no,bank_name,add_card_user_name,branch_name,bank_type_other,bank_type } = req.body;
        let params = {
            "bank_name":bank_name,
            "card_no":card_no,
            "card_user_name":add_card_user_name,
            "currency":1,
            "branch_swift_code":branch_swift_code,
            "branch_name":branch_name,
            "bank_type_other":bank_type_other,
            "bank_type":bank_type,
            "city":"beij",
            "country":"CH",
            "province":"beij",
        };
        console.log(params)
        request.post(`${API.member.user.tt_add}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    },
    del: function (req, res) {
        let header = {
            token: req.cookies.token
        };
        let {id} = req.body;
        request.del(API.member.user.tt_delete + id)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                res.json(data);
            });
    },
    update: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let { id,branch_swift_code,card_no,bank_name,add_card_user_name,branch_name,bank_type_other,bank_type,add_card_currency } = req.body;
        let params = {
            "id":id,
            "bank_name":bank_name,
            "card_no":card_no,
            "card_user_name":add_card_user_name,
            "currency":add_card_currency,
            "branch_swift_code":branch_swift_code,
            "branch_name":branch_name,
            "bank_type_other":bank_type_other,
            "bank_type":bank_type,
            "city":"beij",
            "country":"CH",
            "province":"beij",
        }
        console.log(params)
        request.put(`${API.member.user.tt_update}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                res.json(data);
            });
    }

};
//投资者信息
exports.workInfo = {
    page: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.user.investor_info}`)
            .set(header)
            .end(function (_req, _res) {
                let result = JSON.parse(JSON.parse(_res.text).datas);

                templateResult.active = 'workinfo';
                templateResult.datas = result;
                res.render("member/pages/user/workinfo", templateResult);
            });
    },
    list: function (req, res) {
    },
    info: function (req, res) {
    },
    add: function (req, res) {
    },
    del: function (req, res) {
    },
    update: function (req, res, next) {

        let header = {
            token: req.cookies.token
        };

        request.put(`${API.member.user.investor_update}`)
            .query({msg: JSON.stringify(req.body)})
            .set(header)
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res));
            });
    }

};





