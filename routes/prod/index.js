module.exports = function (app){

   // app.use('/ib', require('./ib'));         //代理中心
    app.use('/member', require('./member'));    //会员中心
    app.use('/sale', require('./sale'));        //销售中心
    app.use('/common', require('./common'));    //公共接口
    app.use('/browser', require('./common'));    //公共接口

    app.use('/', function (req, res) {
        res.redirect('/member/login');
    });

};