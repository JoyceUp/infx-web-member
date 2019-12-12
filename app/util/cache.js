/**
 *
 * @Description
 * @Author songzhitao
 * @Created
 *
 */
var request = require("superagent");
var API = require("../controller/prod/support/const");
var requestUtil = require("../controller/prod/common/requestUtil");

let accountCache = new Object();
module.exports = {
    getAccountList: function(user_id, token, type){

        let that = this;
        return new Promise(function (resolve, reject) {
            let accountList = accountCache['account_list_' + user_id];
            if(accountList){
                resolve(accountList);
            }else{
                if(type == 1){

                    that.initAccountList(user_id, token, function (data) {
                        resolve(data);
                    });
                }else{
                    that.initIbAccountList(user_id, token, function (data) {
                        resolve(data);
                    });
                }
            }
        });
    },
    setAccountList: function (user_id, account_list) {
        accountCache['account_list_' + user_id] = account_list;
    },
    initAccountList: function (user_id, token, cb) {
        let header = {
            token: token
        };
        let params = {
            page_no : 0,
            page_size: 100
        };
        let that = this;
        request.get(`${API.member.account.account_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    if(returnData.status == 200){
                        that.setAccountList(user_id, returnData.datas);
                        cb(returnData.datas);
                    }else{
                        cb(returnData);
                    }
                });

            });
    },
    initIbAccountList: function (user_id, token, cb) {
        let header = {
            token: token
        };
        let params = {
            page_no : 0,
            page_size: 100
        };
        let that = this;
        request.get(`${API.ib.account.account_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    if(returnData.status == 200){
                        that.setAccountList(user_id, returnData.datas);
                        cb(returnData.datas);
                    }else{
                        cb(returnData)
                    }
                });

            });
    },
    setRate: function (rate, type) {
        accountCache['rate_' + type] = rate;
    },
    getRate: function (type) {
        return accountCache['rate_' + type] ? accountCache['rate'] : 6.8;
    },
    getBankList: function(user_id, token, type){
        let that = this;
        return new Promise(function (resolve, reject) {
            let bankList = accountCache['bank_list_' + user_id];
            if(bankList){
                resolve(bankList);
            }else{
                if(type == 1){
                    that.initBankList(user_id, token, function (data) {
                        resolve(data);
                    });
                }else{
                    that.initIbBankList(user_id, token, function (data) {
                        resolve(data);
                    });
                }
            }
        });
    },
    setBankList: function (user_id, bank_list) {
        accountCache['bank_list_' + user_id] = bank_list;
    },
    initBankList: function (user_id, token, cb) {
        let header = {
            token: token
        };
        let params = {
            page_no : 0,
            page_size: 100
        };
        let that = this;
        request.get(`${API.member.user.bankcard_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    if(returnData.status == 200){
                        that.setBankList(user_id, returnData.datas);
                        cb(returnData.datas);
                    }else{
                        cb(returnData);
                    }
                });

            });
    },
    initIbBankList: function (user_id, token, cb) {
        let header = {
            token: token
        };
        let params = {
            page_no : 0,
            page_size: 100
        };
        let that = this;
        request.get(`${API.ib.account.bankcard_info}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    if(returnData.status == 200){
                        that.setBankList(user_id, returnData.datas);
                        cb(returnData.datas);
                    }else{
                        cb(returnData);
                    }
                });

            });
    },
    getTTInfo: function(user_id, token, type){
        let that = this;
        return new Promise(function (resolve, reject) {
            let tt_info = accountCache['tt_' + user_id];
            if(tt_info){
                resolve(tt_info);
            }else{
                if(type == 1){
                    that.initTTInfo(user_id, token, function (data) {
                        resolve(data);
                    });
                }else{
                    that.initIbTTInfo(user_id, token, function (data) {
                        resolve(data);
                    });
                }
            }
        });
    },
    setTTInfo: function (user_id, tt) {
        accountCache['tt_' + user_id] = tt;
    },
    initTTInfo: function (user_id, token, cb) {
        let header = {
            token: token
        };
        let that = this;
        var params = {
            type: [1, 2]
        };
        request.get(`${API.member.user.tt_list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function (returnData) {
                    if(returnData.status == 200){
                        that.setTTInfo(user_id, returnData.datas);
                        cb(JSON.parse(returnData.datas));
                    }else{
                        cb(returnData);
                    }
                });
            });
    },
    initIbTTInfo: function (user_id, token, cb) {
        let header = {
            token: token
        };
        let that = this;
        request.get(`${API.ib.account.tt_info}`)
            .set(header)
            .end(function (_req, _res) {
                let data = JSON.parse(_res.text);
                if(data.status == 200){
                    that.setTTInfo(user_id, JSON.parse(data.datas));
                    cb(JSON.parse(data.datas));
                }else{
                    cb(data);
                }
            });
    },

    depositSuccess(user_id, status){
        accountCache['deposit_' + user_id] = status;
    },
    checkDeposit(user_id){
        let status = accountCache['deposit_' + user_id];
        return status ? status : 201;
    }
};
