/**
 * Created by 翟凤禄 on 2018/1/13.
 * For 销售系统
 */
var setting = require("../../../common/cn/sale/index");
let templateResult = {

    datas: {},
    setting: setting
};


exports.page = function (req, res, next) {
    templateResult.active = "ib";
    res.render("sale/pages/ib/index",templateResult)
};
exports.detail = function (req, res, next) {
    res.render("sale/pages/ib/detail",templateResult)
}