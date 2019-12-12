/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var API = require("../support/const");
var request = require('superagent')
    , fs = require('fs')
    , svgCaptcha = require('svg-captcha');

let result = {
    common: {}
};
exports.updateBrowser = function (req, res, next) {
    res.render("common/update-browser", result)
};
//短信验证码
exports.sendSMS = function (req, res, next) {
    res.json({
        "status": 0,
        "msg": ""
    })
};

//邮箱唯一验证
exports.emailUnique = function (req, res, next) {
    let params = {
        email: req.body.email
    };
    request.get(`${API.common.email_unique}`)
        .query({msg: JSON.stringify(params)})
        .end(function (_req, _res) {
            //记录用户操作日志
            res.json(JSON.parse(_res.text));
        });
};

//邮箱验证码
exports.sendMail = function (req, res, next) {
    let params = {
        email: req.body.email
    };
    request.get(`${API.common.send_email_verify_code}`)
        .query({msg: JSON.stringify(params)})
        .end(function (_req, _res) {
            //记录用户操作日志
            if (_res) {
                res.json(JSON.parse(_res.text));
            }
        });
};

//获取汇率
exports.getRate = function (req, res, next) {
    let params = {
        rate_type: req.body.rate_type
    };
    // deposit_exchangerate	入金
    // withdraw_exchangerate	出金
    request.get(`${API.common.get_rate}`)
        .query({msg: JSON.stringify(params)})
        .end(function (_req, _res) {
            //记录用户操作日志
            res.json(JSON.parse(_res.text));
        });
};
/*var gm = require('gm')
    ,   fs = require('fs')
    ,   imageMagick = gm.subClass({ imageMagick : true });*/
//上传文件
exports.upload = function (req, res, next) {
  /*  res.header('Content-Type', 'text/plain');
    var path = req.file.path;	//获取用户上传过来的文件的当前路径
    imageMagick(path).resize(300, 100).autoOrient().write(path, function(){});
    imageMagick(path)// 原图路径
        .resize(300, 100)
        .autoOrient()
        .write(path, function (e) {// 输出的图片路径
            if(e) {
                console.log(e.message)
            }else {
                console.log('done')
            }
        })
*/

    if (req.file) {
        let {role_type, role_id} = req.body;

        request.post(`${API.common.upload_img}`)
            .field('roleType', role_type)
            .field('roleId', role_id)
            .attach('uploadFileName', req.file.path)
            .end(function (_req, _res) {
                if (_res.status == 200) {
                    fs.unlink(req.file.path, function () {
                        res.json(JSON.parse(_res.text))
                    });
                }


            });
    }
};

//获取图形验证码
exports.captcha = {
    get: function (req, res, option) {
        const captcha = svgCaptcha.create({fontSize: 50, width: 150, height: 38});

        req.session.captcha = captcha.text;
        res.setHeader('Content-Type', 'image/svg+xml');
        res.write(String(captcha.data));
        res.end();
    },
    check: function (req, res, next) {
        let code = req.body.code
        let result = {
            status: 200,
            msg: "success"
        };
        if (req.session.captcha) {
            if (code.toLowerCase() != req.session.captcha.toLowerCase()) {
                result.status = 0
                result.msg = "验证码错误"
            }
        }

        res.json(result)
    }
};


//获取图片地址
exports.images = function (req, res) {

    request.get(`${API.common.get_img}${req.body.id}`)
        .end(function (_req, _res) {
           res.send(_res.text);
        });

};


exports.showImages = function (req, res) {
    let id = req.params.id
    request.get(`${API.common.get_img}${id}`)
        .end(function (_req, _res) {

            let imgsrc = _res.text
            if(imgsrc){
                request(imgsrc).pipe(res)
            }
        });

};


exports.rate_deposit = function (req, res) {
    let header = {
        token: req.body.token
    };


    request.get(API.common.rate_deposit)
        .query({msg: JSON.stringify(req.body)})
        .set(header)
        .end(function (_req, _res) {

            res.json(JSON.parse(_res.text))
        });

};

exports.rate_withdraw = function (req, res) {
    let header = {
        token: req.body.token
    };
    request.get(`${API.common.rate_withdraw}`)
        .query({msg: JSON.stringify(req.body)})
        .set(header)
        .end(function (_req, _res) {
            res.json(JSON.parse(_res.text))
        });

};



