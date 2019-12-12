/**
 * Created by zlp on 2018/01/04.
 * For 销售登陆页面
 */
var Promise = require("bluebird");
var request = require("superagent");
var API = require("../support/const")
let result = {
    lang: 'cn',
    common: {
        "dialogtitle": "用户登录",
        "attention": '<p style="padding-top: 10px;">如果您不慎丢失了您的用户名或者密码，请致电我们的客服热线400-002-8180或者发送邮件至service@rtfgroups.com寻求帮助。</p>\n' +
        '\t\t<p>如果您选择发送邮件要求重置密码，请将标题设定为：“找回密码”+您的用户名，如果丢失用户名，请将标题设定为：“找回用户名”+您的注册邮件地址。</p>\n' +
        '\t\t<p>如果使用电话的方式，请在接通后提供能证明您身份的凭证。</p>',

        "attentioncontent": '<p style="color: #ad6214;">\n' +
        '\t\t\t<span>请注意：</span>对于使用邮件的方式，我们只接受您使用注册时所填写的邮箱所发送的邮件，如果您使用其他邮件发送请求，为了保证您的账户安全性，我们将不会对请求进行处理。\n' +
        '\t\t</p>'
    }
}
exports.login = function (req, res, next) {
    res.render("ib/pages/login/login", result)
};
exports.signup = function (_req, _res, next) {

    let {password, username} = _req.body;
    let params = {
        email: username,
        password: password
    };
    request.put(API.ib.login.signup_email)
        .query({msg: JSON.stringify(params)})
        .end(function (req, res) {
            let datas = JSON.parse(res.text).datas;
            _req.session.ib = JSON.parse(datas);
            _res.json(JSON.parse(res.text))
        });
};
exports.logout = function (req, res, next) {
    let params = {
        token: req.cookies.ibtoken
    };
    let header = {
        token: req.cookies.ibtoken
    };
    request.put(API.ib.login.logout)
        .set(header)
        .query({msg: JSON.stringify(params)})
        .end(function (_req, _res) {
            delete req.session.ib;
            res.json(JSON.parse(_res.text))
        });
};

exports.resetPwd = function (req, res, next) {

    let {new_password, password, username} = req.body;
    let params = {
        email: username,
        new_password: new_password,
        password: password
    }
    let header = {
        token: req.cookies.ibtoken
    };
    request.put(API.ib.login.reset_pwd_email)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            res.json(JSON.parse(_res.text))
        });
};

//找回密码
exports.retrieve = {

    page: function (req, res) {
        res.render("ib/pages/login/retrieve", result)
    },
    sendMail: function (req, res) {
        let {email} = req.body;
        let params = {
            email: email
        };
        request.get(API.ib.login.password_retrieve)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            })
    },
    resetPage: function (req, res) {
        let params = {
            reset_code: req.query.code
        };
        result.reset_code = params.reset_code;
        //检查code，验证重置码是否有效
        request.put(API.ib.login.password_check_reset_code)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                var data = JSON.parse(_res.text);
                if (data.status != 200) {
                    result.msg = "该链接已失效，请重新发送邮箱。";
                    result.msgt = data.msg;
                }
                res.render("ib/pages/login/retrieve_reset", result);
            });
    },
    reset: function (req, res) {
        let {reset_code, password} = req.body;
        let params = {
            reset_code: reset_code,
            new_password: password
        }
        request.put(API.ib.login.password_retrieve_reset)
            .query({msg: JSON.stringify(params)})
            .end(function (_req, _res) {
                res.json(JSON.parse(_res.text))
            });
    }
};