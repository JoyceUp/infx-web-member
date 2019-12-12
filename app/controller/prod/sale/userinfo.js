/**
 * Created by 宋志涛 on 2018/1/17.
 * For 用户信息
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/sale/index");
let templateResult = {
    datas: {},
    setting: setting
};

exports.page = function (req, res, next) {
    templateResult.active = "userinfo";
    let header = {
        token: req.cookies.saletoken
    };
    let sales_id = JSON.parse(req.cookies.user).user_id;
    let params = {
        id: sales_id
    }
    request.get(API.sale.user.info)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            let data = JSON.parse(_res.text);
            if (data.status == 200) {
                let datas = JSON.parse(data.datas);
                templateResult.datas = datas;
            }

            console.log(templateResult.datas)
            res.render("sale/pages/userinfo/index", templateResult);
        });
};


exports.getUserInfo = function (req, res, next) {

    let header = {
        token: req.cookies.saletoken
    };
    let sales_id = JSON.parse(req.cookies.user).user_id;
    let params = {
        id: sales_id
    }
    request.get(API.sale.user.info)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            let data = JSON.parse(_res.text);
            res.json(data)
        });
};
exports.bindmt = function (req, res, next) {

    let header = {
        token: req.cookies.saletoken
    };
    let { account_no } = req.body;
    let params = {
        account_no: account_no
    };
    request.put(API.sale.user.bindmt)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            let data = JSON.parse(_res.text);
            res.json(data)
        });
};
exports.unbindmt = function (req, res, next) {

    let header = {
        token: req.cookies.saletoken
    };
    let { account_no } = req.body;
    let params = {
        account_no: account_no
    };
    request.delete(API.sale.user.bindmt)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            let data = JSON.parse(_res.text);
            res.json(data)
        });
};