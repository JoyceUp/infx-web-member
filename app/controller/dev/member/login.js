/**
 * Created by zlp on 2018/01/04.
 * For 登陆页面
 */
var Promise = require("bluebird");
var express = require('express');
let result = {
    lang:'cn',
    common:{
        "dialogtitle":"用户登录",
        "attention": '<p style="padding-top: 10px;">如果您不慎丢失了您的用户名或者密码，请致电我们的客服热线400-002-8180或者发送邮件至service@rtfgroups.com寻求帮助。</p>\n' +
        '\t\t<p>如果您选择发送邮件要求重置密码，请将标题设定为：“找回密码”+您的用户名，如果丢失用户名，请将标题设定为：“找回用户名”+您的注册邮件地址。</p>\n' +
        '\t\t<p>如果使用电话的方式，请在接通后提供能证明您身份的凭证。</p>' ,

        "attentioncontent":'<p style="color: #ad6214;">\n' +
        '\t\t\t<span>请注意：</span>对于使用邮件的方式，我们只接受您使用注册时所填写的邮箱所发送的邮件，如果您使用其他邮件发送请求，为了保证您的账户安全性，我们将不会对请求进行处理。\n' +
        '\t\t</p>'
    }
}
exports.login=function(req,res,next){
    res.render("member/pages/login/login",result)
};
exports.signup = function(req,res,next){


    let result = {
        "status":200,
        "msg":'',
        "datas":''
    }

    res.json(result)

};
exports.logout = function(req,res,next){
    res.redirect('login');
}

