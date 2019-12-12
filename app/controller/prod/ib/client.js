/**
 * Created by cuiyajuan on 2018/1/17.
 * For 代理中心  我的客户
 */
var request = require("superagent");
var API = require("../support/const");
var setting = require("../../../common/cn/ib/index");
var memberSetting = require("../../../common/cn/member/index");
var requestUtil = require("../common/requestUtil");
var cache = require("../../../util/cache");

let templateResult = {
    datas: {},
    setting: setting,
    member_setting: memberSetting
};

//#我的客户
//客户信息列表
exports.customer_list = {
    page: function (req, res, next) {
        templateResult.active = "client_list";
        cache.getAccountList(JSON.parse(req.cookies.user).user_id, req.cookies.ibtoken, 2).then(function (data) {
            templateResult.account = data;
            res.render("ib/pages/client/list", templateResult)
        });
    },
    list: function (req, res, next) {
        let {page, limit, customer_name, account_no, email, mobile, ib_no, start_time, end_time, field, order} = req.body;
        let params = {
            "condition": {
                "customer_name": customer_name,
                "account_no": account_no,
                'email': email,
                'mobile': mobile,
                'ib_no': ib_no,
                customer_status: '',
                "start_time": start_time,
                "end_time": end_time
            },
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
        };
        request.get(`${API.ib.client.client_list}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });
            })
    }
};

//客户信息详情
exports.client_info = {
    page: function (req, res, next) {
        templateResult.active = "client_list";
        let {id} = req.query;
        request.get(`${API.ib.client.client_info}/${id}`)
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    templateResult.datas = JSON.parse(data.datas);
                    templateResult.datas.id = id;
                }
                res.render("ib/pages/client/info", templateResult);
            })
    },
    account_list: function (req, res, next) {               //账户信息
        let {page, limit, user_id, field, order} = req.query;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                user_id: user_id
            }
        };
        request.get(`${API.ib.client.account_info}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });
            })
    },
    dep_draw_list: function (req, res, next) {              //出入金信息
        let {page, limit, user_id, field, order} = req.query;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                user_id: user_id
            }
        };
        request.get(`${API.ib.client.depDraw_info}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });
            })
    },
    transfer_list: function (req, res, next) {              //转账信息
        let {page, limit, user_id, field, order} = req.query;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                user_id: user_id
            }
        };
        request.get(`${API.ib.client.transfer_info}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData)
                });
            })
    },
    trade_list: function (req, res, next) {                 //交易信息
        let {page, limit, user_id, field, order} = req.query;
        let params = {
            "page_no": page,
            "page_size": limit,
            order_column: field || 'gmt_create',
            order_by: order || 'desc',
            condition: {
                user_id: user_id
            }
        };
        request.get(`${API.ib.client.trade_info}`)
            .query({msg: JSON.stringify(params)})
            .set("token", req.cookies.ibtoken)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            })
    }
};
