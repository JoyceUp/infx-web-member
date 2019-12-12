/**
 * Created by zlp on 2017-12-10.
 */



let express = require('express');
let router = express.Router();

let common = require("../../app/controller/dev/common/common");
let upload = require("../../app/controller/dev/common/fileupload");

//发送手机验证码
router.get("/send_sms", common.sendSMS);

//发送邮箱验证码
router.get("/send_mail", common.sendMail);

//上传文件
router.post("/upload", upload.single('file'), common.upload);

//获取图形验证码
router.get("/captcha/get", common.captcha.get);
//校验图形验证码
router.get("/captcha/check", common.captcha.check);

module.exports = router;