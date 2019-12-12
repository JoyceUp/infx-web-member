/**
 * Created by zlp on 2018/1/11.
 * For 销售系统
 */
var request = require("superagent");
var API = require("../support/const")
var setting = require("../../../common/cn/sale/index");
var requestUtil = require("../common/requestUtil");

let templateResult = {
    datas: {},
    setting: setting
};

//#首页
exports.home = {
    page:function (req, res, next) {
        res.render("sale/pages/home/index",templateResult)
         }
    };



//#代理信息
//代理列表
exports.ib = {

    page: function (req, res, next) {
        templateResult.active = "ib";
        res.render("sale/pages/ib/list", templateResult)
    },
    list: function (req, res, next) {
        let {limit, page, customer_name,email,account_no, field, order} = req.body;
        let sales_id = JSON.parse(req.cookies.user).user_id;
        if(customer_name){
            customer_name = customer_name.trim();
        };
        if(account_no){
            account_no = account_no.trim();
        };

        if(email){
            email = email.trim();
        };
        let params = {
            "condition": {"customer_name": customer_name,"email":email, "account_no": account_no},
            "page_size": limit,
            "page_count": 0,
            "page_no": page,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
        };
        let header = {
            token: req.cookies.saletoken
        };
        request.get(API.sale.ib.ib_list)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                if (_res.status == 200) {
                    requestUtil.formatTableData(_res).then(function (returnData) {
                        res.json(returnData)
                    })
                }
            });
    },
    info: function (req, res, next) {
       // let ibid = req.body.ibid;
        let id = req.query.ibid;
        let header = {
            token:req.cookies.saletoken
        };
        let params = {
            ib_id : id
        }
        if(id) {
            request.get(API.sale.ib.basic_info)
                .query({msg:JSON.stringify(params)})
                .set(header)
                .end(function (_req, _res) {
                    if (_res.status == 200) {
                        templateResult.datas.info = JSON.parse(JSON.parse(_res.text).datas);

                        //获取客户地址
                        request.get(API.sale.ib.address_info)
                            .query({msg:JSON.stringify(params)})
                            .set(header)
                            .end(function (_req1, _res1) {
                                templateResult.datas.address = JSON.parse(JSON.parse(_res1.text).datas);
                                //获取客户证件信息
                                request.get(API.sale.ib.identity_info)
                                    .query({msg:JSON.stringify(params)})
                                    .set(header)
                                    .end(function(_req2,_res2){
                                        templateResult.datas.identity = JSON.parse(JSON.parse(_res2.text).datas);
                                        res.render("sale/pages/ib/info", templateResult)
                                    });
                            });
                    }
                });
        }
    }
};

//代理详情页
exports.ib_info = {
    //账户信息
    account_list:function(req, res, next) {
        let{page,limit, field, order} = req.body;
        let id = req.body.ibid;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition":{"ib_id":id}
        };

        let header = {
            token:req.cookies.saletoken
        };
        request.get(API.sale.ib.account_list)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function (_req,_res) {
                if(_res.status == 200) {
                    requestUtil.formatTableData(_res).then(function (returnData) {
                        res.json(returnData)
                    });
                }
            });
    },
    //出金信息
    deposit_list: function (req, res, next) {
        let {page,limit, field, order} = req.body;
        let id = req.body.ibid;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition":
                {"ib_id": id,"type": 1}//type 出入金=0,出金=1,入金=2
        };

        let header = {
            token:req.cookies.saletoken
        };
        request.get(API.sale.ib.dep_draw_list)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function (_req,_res) {
                if(_res.status == 200) {
                    requestUtil.formatTableData(_res).then(function (returnData) {
                        res.json(returnData)
                    });
                }
            });

    },
    //取消申请
    cancel:function(req, res, next){
        let{id} = req.body;
        let params = {
            id : id
        };
        let header = {
            token:req.cookies.saletoken
        };
        request.get(API.sale.ib.cancel)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function(_req,_res){
                if(_res.status == 200){
                    res.json(JSON.parse(_res.text));
                }
            });
    },
    //转账信息
    transfer_list: function (req, res, next) {
        let {page,limit, field, order} = req.body;
        let id = req.body.ibid;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition":{"ib_id": id}
        };

        let header = {
            token:req.cookies.saletoken
        };
        request.get(API.sale.ib.transfer_list)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function (_req,_res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    res.json(returnData)
                });
            });
    },
    //返利列表
    rebate_list: function (req, res, next) {
        let {page,limit, field, order} = req.body;
        let id = req.body.ibid;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition":
                {"ib_id": id}
        };

        let header = {
            token:req.cookies.saletoken
        };
        request.get(API.sale.ib.rebate_list)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function (_req,_res) {
                if(_res.status == 200) {
                    requestUtil.formatTableData(_res).then(function (returnData) {
                        res.json(returnData)
                    });
                }
            });

    },
    //返佣列表
    commission_list: function (req, res, next) {
        let {page,limit, field, order} = req.body;
        let id = req.body.ibid;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            "condition":
                {"ib_id": id}
        };

        let header = {
            token:req.cookies.saletoken
        };
        request.get(API.sale.ib.commission_list)
            .query({msg:JSON.stringify(params)})
            .set(header)
            .end(function (_req,_res) {
                if(_res.status == 200) {
                    requestUtil.formatTableData(_res).then(function (returnData) {
                        res.json(returnData)
                    });
                }
            });

    }
}

    //#邀请链接
    exports.invite = {
        page:function(req,res,next){
            templateResult.active = "invitation";
            res.render("sale/pages/invitation/index",templateResult);
        },
         info:function(req,res,next){

             let header = {
                 token: req.cookies.saletoken
             };
             let type = req.body.type;
             let params = {
                 type:type
             }
             request.get(API.sale.invite.invite)
                 .query({msg:JSON.stringify(params)})
                 .set(header)
                 .end(function (_req, _res) {
                     if(_res.status == 200) {
                         res.json(JSON.parse(_res.text));
                     }
                 });
      }
    }
