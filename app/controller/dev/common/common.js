/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var multer = require('multer');
var bodyParser = require('body-parser');
var request = require('superagent')
    , fs = require('fs');

let result = {
    common: {}
};

//短信验证码
exports.sendSMS = function (req, res, next) {
    console.log(req.query);
    res.json({
        "status": 0,
        "msg": ""
    })
};

//邮箱验证码
exports.sendMail = function (req, res, next) {
    console.log(req.query);
    res.json({
        "status": 0,
        "msg": ""
    })
};

//上传文件
exports.upload = function (_req, _res, next) {

    if (_req.file) {
        _res.send('文件上传成功');
        request.post('http://172.5.0.90:8080/api/v1/common/images')
            .field('roleType', '1')
            .field('roleId', '1685ddf37b704f9c9aea8e256bfec19b')
            .attach('uploadFileName', _req.file.path)
            .end(function (req, res) {
                console.log(req, res.text)
            });
    }
};

//获取图形验证码
exports.captcha = {
    get: function (req, res, next) {
        console.log(req.query);
        res.json({
            "status": 0,
            "msg": ""
        })
    },
    check: function (req, res, next) {
        console.log(req.query);
        res.json({
            "status": 0,
            "msg": ""
        })
    }
};
