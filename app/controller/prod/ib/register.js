/**
 *2018-01-12 created by yuyz
 * For 代理注册
 */
var Promise = require("bluebird");
var API = require("../support/const");
var request = require("superagent");
var setting = require("../../../common/cn/ib/index");

let templateResult = {
    datas: {},
    setting: setting
};

/* Created by zlp on 2018/01/15.
* For IB注册
*/
exports.ibReg = {
    page: function (req, res, next) {
        let id = req.query.id
        if (id) {
            request.get(API.ib.reg.signup_info + '/' + id)
                .end(function (_req, _res) {
                    let data = JSON.parse(_res.text);
                    if(data.status == 200){
                        templateResult.datas = JSON.parse(data.datas);
                        templateResult.datas.id = id;
                        res.render("kh/pages/ib/register", templateResult);
                    }else{
                        templateResult.datas = data;
                        res.render("kh/pages/ib/inviteCodeError", templateResult);
                    }
                })
        }else{
            res.render("kh/pages/ib/register", templateResult);
        }
    },
    submitStep1: function (_req, _res, next) {
        request.post(API.ib.reg.step1)
            .query({msg: JSON.stringify(_req.body)})
            .end(function (req, res) {
                _res.json(JSON.parse(res.text));
            });
    },

    submitStep2: function (_req, _res, next) {
        request.post(API.ib.reg.step2)
            .query({msg: JSON.stringify(_req.body)})
            .end(function (req, res) {
                _res.json(JSON.parse(res.text));
            });
    }
}

/* Created by zlp on 2018/01/15.
* For IB登记
*/
exports.enter = {
    page: function (req, res) {
        let no = req.query.no;
        templateResult.no = no;
        res.render("kh/pages/enter/index", templateResult)
    },

    submit: function (req, res) {
        let {gender, email, family_name, given_name, verify_code, identity_type, identity_no, invite_code} = req.body
        let params = {
            "gender": gender,
            "email": email,
            "family_name": family_name,
            "given_name": given_name,
            "verify_code": verify_code,
            "identity_type": identity_type,
            "identity_no": identity_no,
            "invite_code": invite_code
        }

        request.post(API.ib.reg.signup)
            .query({msg: JSON.stringify(req.body)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            })
    }
}

