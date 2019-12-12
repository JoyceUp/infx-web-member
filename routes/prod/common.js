/**
 * Created by zlp on 2017-12-10.
 */



let express = require('express');
let router = express.Router();

let common = require("../../app/controller/prod/common/common");
let upload = require("../../app/controller/prod/common/fileupload");

router.get("/update", common.updateBrowser);

//发送手机验证码
router.post("/send_sms", common.sendSMS);

//发送邮箱验证码
router.post("/send_mail", common.sendMail);
router.post("/unique_mail", common.emailUnique);

//获取汇率
router.post("/rate", common.getRate);

//上传文件
router.post("/upload", upload.single('file'), common.upload);

//获取图形验证码
router.get("/captcha/get", common.captcha.get);

//校验图形验证码
router.post("/captcha/check", common.captcha.check);

//获取图片地址
router.post("/images", common.images);
router.get("/images/:id", common.showImages);

router.post("/rate_deposit", common.rate_deposit);
router.post("/rate_withdraw", common.rate_withdraw);



module.exports = router;