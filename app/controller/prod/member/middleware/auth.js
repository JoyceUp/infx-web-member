/**
 * Created by zlp on 2018-1-24.
 */
var Promise = require("bluebird");
var API = require("../../support/const");
const base_url = "";
exports.auth = function(req, res, next) {
     if(!req.session.member && req.originalUrl.indexOf("login") < 0 && req.originalUrl.indexOf("register") < 0&& req.originalUrl.indexOf("signup") < 0 && req.headers.host.indexOf("localhost") < 0){
       // if(!req.session.member && req.originalUrl.indexOf("login") < 0 && req.originalUrl.indexOf("register") < 0&& req.originalUrl.indexOf("signup") < 0){

        req.session.ourl = req.originalUrl
        res.redirect('/member/login');
    }else{
         let host =req.hostname
         // if(host.indexOf("middleforex")>0 || host.indexOf("119.254.166.217")>0){
         if(host.indexOf("localhost")>0 || host.indexOf("119.254.166.217")>0){
             if( base_url != "http://10.202.0.32:8070/fx-api-member/"){
           //      base_url = "http://10.202.0.32:8070/fx-api-member/"
             }

         }

        next();
    }

};

