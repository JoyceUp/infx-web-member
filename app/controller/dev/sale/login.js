/**
 * Created by zlp on 2018/1/11.
 * For 销售系统
 */

var setting = require("../../../common/cn/sale/index");

let templateResult = {
    datas: {},
    setting: setting
};


exports.page = function (req, res, next) {
    res.render("sale/pages/login/login")
};
