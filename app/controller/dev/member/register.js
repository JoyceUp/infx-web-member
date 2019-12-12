/**
 * Created by 崔亚娟 on 2018/01/10.
 * For 注册
 */

var select = require("../../../common/cn/member/select");
var regsMock = require("../../../mock/data/register");

let result = {
    title:"真实账户开立",
    select: select.register
};

var regs = regsMock.Regs();
exports.page = function (req, res, next) {
    res.render("kh/pages/register", result)
};

exports.step1 = function (req, res, next) {
    res.render("kh/pages/register", result)
};
/*验证邮箱唯一性*/
exports.email_unique = function (req, res, next) {
    let result = {
        status:200,
        msg:'success'
    }
    let email = req.query.email

    //console.log(regs)
    let regsMock = regs.filter(reg => {
        if (email && reg.email == email) {
            result.status = 201
            result.msg = "电子邮箱已存在"
            return false;
        }
        return true;
    })

    res.json(result);
    //res.render("kh/pages/register", result)
};
/*获取验证码*/
exports.verify_code = function (req, res, next) {
    let result = {
        status:200,
        msg:'验证码为：123456'
    }
    let email = req.query.email
    //此处系统往该邮箱发送一封邮箱验证的邮件(邮件内容单独说明），并提示““验证码已发送，请及时查收”。

    res.json(result);
};


exports.step2 = function (req, res, next) {
    res.render("kh/pages/register", result)
};
/*验证证件号码唯一性*/
exports.identityNo_unique = function (req, res, next) {
    let result = {
        status:200,
        msg:'success'
    }
    let identity_no = req.query.identity_no

    //需要校验号码的唯一性，若与客户表重复，则提示“证件号码已存在”，若属于外汇黑名单，则提示“该证件禁止注册”。
    let regsMock = regs.filter(reg => {
        if (identity_no && reg.identity_no == identity_no) {
            result.status = 201
            result.msg = "证件号码已存在"
            return false;
        }else if(identity_no.indexOf('xv') != -1){
            result.status = 202
            result.msg = "该证件禁止注册"
            return false;
        }
        return true;
    })

    res.json(result);
};
/*判断手机号是否在黑名单*/
exports.mobile_unique = function (req, res, next) {
    let result = {
        status:200,
        msg:'success'
    }
    let mobile = req.query.mobile

    //需要判断是否在黑名单，若在，则提示”该手机号禁止注册
    let regsMock = regs.filter(reg => {
        if(mobile.indexOf('134') != -1){
            result.status = 202
            result.msg = "该手机号禁止注册"
            return false;
        }
        return true;
    })

    res.json(result);
};
exports.step3 = function (req, res, next) {
    res.render("kh/pages/register", result)
};

exports.images = function(req, res, next){
    let result = {
        status:200,
        msg:'succ'
    }
    let {email} = res.body
    //检查email是否存在
    //如果存在
    if(email == "存在"){
        result.status = 201
        result.msg = "邮箱村子"
        res.json(result)
    }else{
        res.json(result)
    }

}