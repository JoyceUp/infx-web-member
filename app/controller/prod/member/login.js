/**
 * Created by zlp on 2018/01/04.
 * For 登陆页面
 */
var Promise = require("bluebird");
var express = require('express');
var request = require("superagent");
var API = require("../support/const")
var requestUtil = require("../common/requestUtil");

let result = {};
exports.login = function (req, res, next) {
    res.render("member/pages/login/login", result)
};
exports.signup = function (_req, _res, next) {
    let {password, username} = _req.body;
    let params = {
        account_no: "",
        email: "",
        password: password
    };

    let login_url = "";
    if (username.indexOf("@") > 0) {
        params.email = username;
        signup_url = API.member.login.signup_email;
    } else {
        params.account_no = username;
        signup_url = API.member.login.signup_mt4;
    }
    request.put(signup_url)
        .query({msg: JSON.stringify(params)})
        .end(function (req, res) {
            if(res && res.text){
                let datas = JSON.parse(res.text).datas;
                if(datas){
                    _req.session.member = JSON.parse(datas);
                }
                _res.json(requestUtil.resultToJson(res));
            }else{
                _res.json({status: -1})
            }
        });
};

exports.logout = function (req, res, next) {
    let params = {
        token: req.cookies.token
    };
    request.put(API.member.login.logout)
        .query({msg: JSON.stringify(params)})
        .end(function (_req, _res) {
            delete req.session.member;
            res.json(requestUtil.resultToJson(_res))
        });
};

exports.resetPwd = function (req, res, next) {

    let {new_password, password, username} = req.body;
    let params = {
        account_no: "",
        email: "",
        new_password: new_password,
        password: password
    };
    let header = {
        token: req.cookies.token
    };
    let reset_url = "";
    if (username.indexOf("@") > 0) {
        params.email = username;
        reset_url = API.member.login.reset_pwd_email
    } else {
        params.account_no = username;
        reset_url = API.member.login.reset_pwd_mt4
    }

    request.put(reset_url)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            res.json(requestUtil.resultToJson(_res))
        });
};

//找回密码
exports.retrieve = {

    page: function (req, res) {
        res.render("member/pages/login/retrieve", result)
    },
    sendMail: function (req, res) {
        let {email} = req.body;
        let params = {
            email: email
        };
        request.get(API.member.login.password_retrieve)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res))
            })
    },
    resetPage: function (req, res) {
        let params = {
            reset_code: req.query.code
        };
        result.reset_code = params.reset_code;
        //检查code，验证重置码是否有效
        request.put(API.member.login.password_check_reset_code)
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
        };
        request.put(API.member.login.password_retrieve_reset)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(requestUtil.resultToJson(_res))
            });
    }
};