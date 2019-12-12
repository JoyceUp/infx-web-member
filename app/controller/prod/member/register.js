/**
 * Created by cuiyajuan on 2018/01/10.
 * For 注册
 */

var request = require("superagent");
var API = require("../support/const");
var select = require("../../../common/cn/member/select");
var requestUtil = require("../common/requestUtil");

let result = {

    select: select.register
};

exports.page = function (req, res, next) {
    let no = req.query.no;
    result.no = no;
    res.render("kh/pages/register", result)
};

exports.step1 = function (_req, _res, _next) {
    console.log(API.member.reg.register);
    console.log(JSON.stringify(_req.body))
    request.post(`${API.member.reg.register}`)
        .query({msg:JSON.stringify(_req.body)})
        //.set(header)
        .end(function (req,res){
            console.log(res.text)
            _res.json(requestUtil.resultToJson(res));
        });
};

exports.acitvePage = function (req, res, next) {
    let id = req.query.id;

    request.get(`${API.member.reg.acitve}/` + id)

        .end(function (_req, _res) {
            console.log(_res.text)
            let activeResult={}
            activeResult.res = JSON.parse(_res.text)
            res.render("kh/pages/active",activeResult)
        });
}



    //提交大表单
    exports.real_account = function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        console.log(req.body)
         console.log(API.member.reg.account_submit)
          request.post(API.member.reg.account_submit)
              .query({msg: req.body.data})
               .set("token", req.cookies.token)
              .end(function(_req,_res){
               if(_res.text){
                   res.json(requestUtil.resultToJson(_res));
               };

          })

    };


    /*验证邮箱唯一性*/
    exports.email_unique = function (_req, _res, _next) {
        request.get(`${API.common.email_unique}`)
            .query({msg: JSON.stringify(_req.query)})
            .end(function (req, res) {
                if (res.text) {
                   _res.json(requestUtil.resultToJson(res));
                }

            });
    };
    /*获取验证码*/
    exports.verify_code = function (_req, _res, _next) {
        request.get(`${API.common.send_email_verify_code}`)
            .query({msg: JSON.stringify(_req.query)})
            .end(function (req, res) {
                if (res.text) {
                    _res.json(requestUtil.resultToJson(res));
                }

            });
    };

    exports.step2 = function (_req, _res, _next) {
        request.post(`${API.member.reg.step2}`)
            .query({msg: JSON.stringify(_req.body)})
            .end(function (req, res) {
                _res.json(requestUtil.resultToJson(res));
            });
    };
    exports.step3 = function (_req, _res, _next) {
        request.post(`${API.member.reg.step3}`)
            .query({msg: JSON.stringify(_req.body)})
            .end(function (req, res) {
                _res.json(requestUtil.resultToJson(res));
            });
    };

