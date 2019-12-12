/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var Promise = require("bluebird");

var setting = require("../../../common/cn/member/index");

let templateResult = {
    datas: {},
    setting: setting
};
exports.applay = function (req, res, next) {
    res.render("member/pages/ib/applay", result)
};

exports.submitApplay = function (req, res, next) {
    res.json({
        "status": 0,
        "msg": ""
    })
};

exports.inviteUrl = {
    page: function(_req, _res, next){
        _res.render("kh/pages/ib/createInviteUrl", templateResult);
    },
}


