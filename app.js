require('colors');
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var redis   = require("redis");
var redisStore = require('connect-redis')(session);
var compress = require('compression');
var helmet = require('helmet');
var i18n=require("i18n-express"); // <-- require the module

var swig = require('swig');
var swig_filter = require('./app/common/swig_filter');


var app = express();
// view engine setup
swig.setFilter('agodate', swig_filter.agoData);
swig.setFilter('accountType', swig_filter.accountType);
swig.setFilter('accountStatus', swig_filter.accountStatus);
swig.setFilter('bankNoLast', swig_filter.bankNoLast);
swig.setFilter('hideIdentityNo', swig_filter.hideIdentityNo);
swig.setFilter('identityType', swig_filter.identityType);
swig.setFilter('dateOfBirth', swig_filter.dateOfBirth);
swig.setFilter('hideBankCardNo', swig_filter.hideBankCardNo);
swig.setFilter('toThousands',swig_filter.toThousands);



app.set('views', path.join(__dirname, 'views'));
//use swig
app.set('view engine', 'tpl');
app.engine('tpl', swig.renderFile);


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(session({
    secret: 'recommand 128 bytes random string',
    resave: true, //每次请求，是不是重新设置一个超时时间，也就是只要活跃就始终有效
    saveUninitialized: true, //每次请求，重新设置cookie
    cookie: { maxAge: 0.9 * 60 * 60 * 1000 }
}));

app.use(compress());
app.use(helmet());
app.use(express.static(path.join(__dirname, 'public')));
// error handlers


app.use(i18n({
    translationsPath: path.join(__dirname, 'public/i18n'), // <--- use here. Specify translations files path.
    siteLangs: ["en","ind"],
    defaultLang:"en",
    textsVarName: 'Lang'
}));

//测试环境
//require('./routes/dev/index')(app);
//正式环境
require('./routes/prod/index')(app);



app.use(function(req, res, next) {
    res.render('common/404');
});

app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('common/error', {
        message: err.message,
        error: {}
    });
});





module.exports = app;
