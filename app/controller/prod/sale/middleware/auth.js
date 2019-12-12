/**
 * Created by zlp on 2018-1-24.
 */
var Promise = require("bluebird");


exports.auth = function(req, res, next) {

    if(!req.session.sale && req.originalUrl.indexOf("login") < 0 && req.originalUrl.indexOf("register") < 0&& req.originalUrl.indexOf("signup") < 0 && req.headers.host.indexOf("localhost") < 0){

        req.session.ourl = req.originalUrl
        res.redirect('/sale/login');
    }else{

        next();
    }

};

