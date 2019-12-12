var request = require("superagent");
var API = require("../controller/prod/support/const")

const log_type = {
    login: {type: 0, label: "登录"},
    loginOut: {type: 1, label: "退出"},
    add: {type: 2, label: "新增"},
    edit: {type: 3, label: "修改"},
    del: {type: 4, label: "删除"},
    setRole: {type: 5, label: "授权"},
    getList: {type: 6, label: "查询列表"},
    getId: {type: 7, label: "查询ID详情"},
    offline: {type: 8, label: "下线"},

};

exports.save_user_log = function (_params, req) {
    let header = {
        token: req.cookies.token
    };


    let json_str = req.cookies.user.replace(new RegExp(/(%7B)/g), "{").replace(new RegExp(/(%7D)/g), "}")
        .replace(new RegExp(/(%22)/g), "\"").replace(new RegExp(/(%3A)/g), ":").replace(new RegExp(/(%2C)/g), ",");

    let user = JSON.parse(json_str);
    let params = {
        "user_id": user.id,
        "nickname": user.nickname,
        "user_name": user.user_name,
        "type": log_type[_params.type].type,
        "operation": "[" + log_type[_params.type].label + "]" + _params.msg
    };
    request.post(`${API.auth.operation}`)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (req, res) {
            console.log("----------记录用户操作日志----------"+res.text);
        })
}


exports.save_user_login = function (_params, req) {
    let header = {
        token: req.cookies.token
    };

    let params = {
        "user_id": _params.id,
        "nickname": _params.nickname,
        "user_name": _params.user_name,
        "type": log_type[_params.type].type,
        "operation": "[" + log_type[_params.type].label + "]" + _params.msg
    };
    request.post(`${API.auth.operation}`)
        .query({msg: JSON.stringify(params)})
        .set(header)
        .end(function (req, res) {
            console.log("----------记录用户操作日志----------"+res.text);
        })
}
