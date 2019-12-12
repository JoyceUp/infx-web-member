var request = require("superagent");
var API = require("../support/const");
var requestUtil = require("../common/requestUtil");
var setting = require("../../../common/cn/sale/index");

let templateResult = {
    datas: {},
    setting: setting
};

//津贴管理页面
exports.page = function (req, res, next) {
    templateResult.active = "benefit";
    res.render("sale/pages/benefit/index", templateResult)
};
//津贴列表
exports.list = function (req, res, next) {
    let {page, limit, date} = req.body;
    let header = {
        token: req.cookies.saletoken
    };
    if(date){
        date = date +"-01 00:00:00 ";
    }else{
        date = dateFtt("yyyy-MM-dd hh:mm:ss",new Date());
    }
    let params = {
        page_size: page,
        page_no: limit,
        condition: {
            start_time: date
        }
    };
    request.get(API.sale.allowwance.list)
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

//获取每月津贴明细
exports.info = function (req, res, next) {
    let {page, limit, start_time} = req.body;
    if(start_time) {
        start_time = start_time + "-01 00:00:00";
    }
    let params = {
        page_no: page,
        page_size: limit,
        condition: {
            start_time: start_time
        }
    };
    let header = {
        token: req.cookies.saletoken
    };
    request.get(API.sale.allowwance.info)
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
};



function dateFtt(fmt,date)
{ //author: meizz
    var o = {
        "M+" : date.getMonth()+1,                 //月份
        "d+" : date.getDate(),                    //日
        "h+" : date.getHours(),                   //小时
        "m+" : date.getMinutes(),                 //分
        "s+" : date.getSeconds(),                 //秒
        "q+" : Math.floor((date.getMonth()+3)/3), //季度
        "S"  : date.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}
