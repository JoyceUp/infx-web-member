/**
 *2018-01-12 created by yuyz
 * For 代理注册
 */
var Promise = require("bluebird");
var setting = require("../../../common/cn/ib/index");
let templateResult ={
    datas:{},
    setting:setting
};

exports.ibReg = {
    page:function(req,res,next) {
        res.render("kh/pages/ib/register", templateResult);
    },
    //邮箱唯一性验证
    emailUnique: function(req,res,next){

    },
    verifyCode: function(req,res,next){

    },
    submitStep1: function(req,res,next){

    },

    submitStep2: function(req,res,next){

    }
}