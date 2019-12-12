/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var Promise = require("bluebird");

let result = {
    common: {}
}
exports.applay = function (req, res, next) {
    res.render("member/pages/ib/applay", result)
};

exports.submitApplay = function (req, res, next) {
    res.json({
        "status": 0,
        "msg": ""
    })
};


