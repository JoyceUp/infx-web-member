
var select = require("../common/cn/member/select");
/**
 * Created by Andy on 2016/11/15.
 * For 前台使用swig显示时，一些自定义的过滤器实现
 */
exports.agoData = function(publishDate){
    var publishTime = parseInt(new Date(publishDate).getTime()/1000);

    var d_minutes,d_hours,d_days;
    var timeNow = parseInt(new Date().getTime()/1000);
    var d;
    d = timeNow - publishTime;
    d_days = parseInt(d/86400);
    d_hours = parseInt(d/3600);
    d_minutes = parseInt(d/60);
    if(d<60){
        return  "刚刚";
    }
    else if(d_days>0 && d_days<4){
        return d_days+"天前";
    }else if(d_days<=0 && d_hours>0){
        return d_hours+"小时前";
    }else if(d_hours<=0 && d_minutes>0){
        return d_minutes+"分钟前";
    }else{

        // s.getFullYear()+"年";
        return (publishDate.getMonth()+1)+"月"+publishDate.getDate()+"日";
    }
}

let at = select.account.account_type;
let accoutTypeMap = new Object();
for(let i in at){
    accoutTypeMap[at[i].value] = at[i].label;
}

exports.open_rate = function(input){
    return rateMap[input];
}
exports.accountType = function (input) {
    return accoutTypeMap[input];
};

exports.leverage = function (input) {
    return leverageMap[input];
};


let states = select.account.state;
let statesMap = new Object();
for(let i in states){
    statesMap[states[i].value] = states[i].label;
}
exports.accountStatus = function (input) {
    return statesMap[input];
};

//获取银行卡后四位
exports.bankNoLast = function (input) {
    return input.substr(-4);
};
//身份证脱敏
exports.hideIdentityNo = function (input, type) {
    var frontLen = 3;
    if(type == 2){
        frontLen = 0;
    }
    var endLen = 4;
    var len = input.length - frontLen - endLen;
    var xing = '';
    for (var i = 0; i < len; i++) {
        xing += '*';
    }
    return input.substring(0, frontLen) + xing + input.substring(input.length - endLen);
};
//银行卡脱敏
exports.hideBankCardNo = function (input) {
    var frontLen = 4, endLen = 4;
    var len = input.length - frontLen - endLen;
    var xing = '';
    for (var i = 0; i < len; i++) {
        xing += '*';
    }
    return input.substring(0, frontLen) + xing + input.substring(input.length - endLen);
};


exports.identityType = function (input) {
    return select.register.identity_type_map[input].label;
};

exports.dateOfBirth = function(input){
    return input.substring(0,10);
};

exports.toThousands = function(input){
    // input.toString().length == 1 数据库存的就是0
    if(input == '0' && input.toString().length == 1){
        result = '0';
    }else{
        var num = (input || 0).toString(), result = '';
        while (num.length > 3) {
            result = ',' + num.slice(-3) + result;
            num = num.slice(0, num.length - 3);
        }
        if (num) {
            result = num + result;
        }

        if (result == 0) {
            result = '';
        }
    }
    return result;
}