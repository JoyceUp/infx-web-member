/**
 * Created by zlp on 2018/01/04.
 * For 销售登陆页面
 */
var Promise = require("bluebird");
var request = require("superagent");
var API = require("../support/const");

let result = {};
exports.login = function (req, res, next) {
    res.render("sale/pages/login/login", result)
};
exports.signup = function (_req, _res, next) {

    let {password, username} = _req.body
    if(username){
        username = username.trim();
    }
    let params = {
        email: username,
        password: password
    }

    request.put(API.sale.login.signup_email)
        .query({msg: JSON.stringify(params)})
        .end(function (req, res) {
            if (res.status == 200) {
                let datas = JSON.parse(res.text).datas;
                _req.session.sale = JSON.parse(datas);
                console.log( JSON.parse(datas));

                _res.json(JSON.parse(res.text))
            } else {
                _res.json(res)
            }

        });
};
exports.logout = function (req, res, next) {
    let params = {
        token: req.cookies.saletoken
    }
    let header = {
        token: req.cookies.saletoken
    };
    request.put(API.sale.login.logout)
        .set(header)
        .query({msg: JSON.stringify(params)})
        .end(function (_req, _res) {
            delete req.session.sale
            res.json(JSON.parse(_res.text))
        });
}

exports.resetPwd = function (req, res, next) {

    let {new_password, password, username} = req.body
    let params = {
        email: username,
        new_password: new_password,
        password: password
    }
    let header = {
        token: req.cookies.saletoken
    };
    request.put(API.sale.login.reset_pwd_email)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            res.json(JSON.parse(_res.text))
        });
};

//找回密码
exports.retrieve = {

    page: function (req, res) {
        res.render("sale/pages/login/retrieve", result)
    },
    sendMail: function (req, res) {
        let {email} = req.body;
        let params = {
            email: email
        };
        request.get(API.sale.login.password_retrieve)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            })
    },
    resetPage: function (req, res) {
        let params = {
            reset_code: req.query.reset_code || 0
        };
        result.reset_code = params.reset_code;
        //检查code，验证重置码是否有效
        request.put(API.sale.login.password_check_reset_code)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                var data = JSON.parse(_res.text);
                if (data.status != 200) {
                    result.msg = "该链接已失效，请重新发送邮箱。";
                }
                res.render("member/pages/login/retrieve_reset", result);
            });
    },
    reset: function (req, res) {
        let {reset_code, password} = req.body;
        let params = {
            reset_code: reset_code,
            new_password: password
        }
        request.put(API.sale.login.password_retrieve_reset)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    }
};