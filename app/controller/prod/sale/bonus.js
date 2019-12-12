/**
 * Created by sozt on 2018/1/11.
 * For 销售系统
 */

var request = require("superagent");
var API = require("../support/const");
var requestUtil = require("../common/requestUtil");
var setting = require("../../../common/cn/sale/index");
var bonusMock = require("../../../mock/data/bonus");

let templateResult = {
    datas: {},
    setting: setting
};

//提成列表
exports.page = function (req, res, next) {
    templateResult.active = "bonus";
    res.render("sale/pages/bonus/index", templateResult)
};

//获取每天提成列表
exports.info = function (req, res, next) {
    let {page, limit, start_time} = req.body;
    let params = {
        page_no: page,
        page_size: limit,
        condition: {
            date: start_time
        }
    };
    let header = {
        token: req.cookies.saletoken
    };
    request.get(API.sale.bonus.info)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            requestUtil.formatTableData(_res).then(function (returnData) {
                if(returnData.statistics){
                    returnData.datas.push({statistics: 1, sum_reward_amount_by_cause: returnData.statistics.sum_reward_amount_by_cause, sum_reward_amount_by_cause2: returnData.statistics.sum_reward_amount_by_cause2,sum_reward_amount:returnData.statistics.sum_reward_amount})
                }
                console.log(returnData);
                    res.json(returnData);
            });
        });
};


//提成列表
exports.list = function (req, res, next) {
    let {page, limit, start_time, end_time} = req.body;
    let header = {
        token: req.cookies.saletoken
    };
    let params = {
        page_size: 10,
        page_no: 1,
        condition: {
            start_time: start_time,
            end_time: end_time
        }
    };
    request.get(API.sale.bonus.list)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (_req, _res) {
            requestUtil.formatTableData(_res).then(function (returnData) {
                if(returnData.statistics){
                    returnData.datas.push({statistics: 1, sum_reward_amount_by_cause: returnData.statistics.sum_reward_amount_by_cause, sum_reward_amount_by_cause2: returnData.statistics.sum_reward_amount_by_cause2,sum_reward_amount:returnData.statistics.sum_reward_amount})
                }
                res.json(returnData);
            });
        });
}

//销售提成明细
exports.common_sale_reward = {
    //代理客户交易提成
    list_ecn:function(req,res,next){
        let {page, limit,gmt_create} = req.body;
        let header = {
            token: req.cookies.saletoken
        };
        let role_id = JSON.parse(req.cookies.user).user_id;
        let params = {
            page_size: page,
            page_no: limit,
            "condition":{"gmt_create":gmt_create,"owner_id": role_id}
        };
        request.get(API.sale.bonus.common_sale_reward_list_ecn)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    },
    //代理收益提成
    list_common:function(req,res,next){
        let {page, limit,gmt_create} = req.body;
        let header = {
            token: req.cookies.saletoken
        };
        let role_id = JSON.parse(req.cookies.user).user_id;
        let params = {
            page_size: page,
            page_no: limit,
            "condition":{"gmt_create":gmt_create,"role_id": role_id}
        };
        request.get(API.sale.bonus.common_sale_reward_list_common)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    }
}


//销售总监 提成明细
exports.department_sale_reward = {
    //部门客户交易提成
    list_ecn:function(req,res,next){
        let {page, limit,gmt_create} = req.body;
        let header = {
            token: req.cookies.saletoken
        };
        let role_id = JSON.parse(req.cookies.user).user_id;
        let params = {
            page_size: page,
            page_no: limit,
            "condition":{"gmt_create":gmt_create,"role_id": role_id}
        };
        request.get(API.sale.bonus.department_sale_reward_list_ecn)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    },
    //销售收益提成
    list_common:function(req,res,next){
        let {page, limit,gmt_create} = req.body;
        let header = {
            token: req.cookies.saletoken
        };
        let role_id = JSON.parse(req.cookies.user).user_id;
        let params = {
            page_size: page,
            page_no: limit,
            "condition":{"gmt_create":gmt_create,"owner_id": role_id}
        };
        request.get(API.sale.bonus.department_sale_reward_list_common)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    res.json(returnData);
                });
            });
    }
}