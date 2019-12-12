/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var request = require("superagent");
var API = require("../support/const");

var requestUtil = require("../common/requestUtil");

let templateResult = {

};

//#真实账户，基本信息
exports.profile = {
    listPage:function (req, res, next) {
        templateResult.active="realAccounts"
        res.render("member/pages/real_accounts/real_accounts_list", templateResult);
        },
    list:function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let {limit , page} = req.body
        let params = {
            "page_size": limit,
            "page_no": page,
        };
        request.get(`${API.member.real_account.list}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    res.json(returnData);
                    console.log(returnData)
                });
            });
    },
    demo_list:function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let {limit , page} = req.body
        let params = {
            "page_size": limit,
            "page_no": page,

        };
        request.get(`${API.member.real_account.demo}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                requestUtil.formatTableData(_res).then(function(returnData){
                    res.json(returnData);
                });
            });
    },


    page: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        templateResult = {};
        let id = req.query.id;
        let params = {
            id:id
        };
        let mobile = JSON.parse(req.cookies.user).mobile;
        let country_code = JSON.parse(req.cookies.user).countryCode;
        //首次进入页面数据初始化
        let initDatas = {
            "id": id,
            state:'1',
            "customer_id":'',
            "account_type":'',
            "account_rate_type":'',
            "account_leverage":'',
            "open_account_info": {
                "full_name":'',
                "place":'',
                "birthday":'',
                "nationality":'',
                "identity_type": '',
                "identity_number": '',
                "investment_experience": '',
                "purpose_of_account_opening": '',
                "purpose_of_account_opening_other": '',
                "personal_tax_number": '',
                "gender":'',
                "have_family_in":'',
                "bankruptcy":'',
                "marital_status": '',
                "spouse_name": '',
                "mother_maiden_name": '',
                "home_address": '',
                "postal_code": '',
                "house_ownership": '',
                "house_ownership_other": '',
                "house_facsimile_number": '',
                "house_number_country_code":'',
                "mobile_number": mobile,
                "mobile_country_code":country_code,
                "recent_photos_path": '',
                "recent_photos_path2": '',
                "identity_photos_path": '',
                "identity_photos_path2": '',
                "bill_photo_path": '',
                "emergency_contact": {
                    "full_name": '',
                    "country_code":'',
                    "phone_number": '',
                    "relation_ship": '',
                    "home_address": '',
                    "postal_code": ''
                },
                "open_account_job": {
                    "occupation": '',
                    "occupation_other": '',
                    "name_of_company": '',
                    "business_field": '',
                    "title": '',
                    "length_of_services": '',
                    "length_of_services_in_previous_office": '',
                    "company_address": '',
                    "postal_code": '',
                    "office_phone_number": '',
                    "phone_country_code": '',
                    "office_fax_number": '',
                    "fax_country_code": ''
                },
                "open_account_wealth_list": {
                    "annual": '',
                    "location_of_house": '',
                    "house_tax_value": '',
                    "time_deposit": '',
                    "total": '',
                    "others": ''
                },
                "open_account_bank": [
                    {
                        "currency":"2",
                        "branch_swift_code":'',
                        "bank_name": '',
                        "branch": '',
                        "phone_name": '',
                        "country_code":'',
                        "account_number": '',
                        "account_name":'',
                        "account_type": '-1',
                        "account_other": ''
                    },{
                        "currency":"1",
                        "branch_swift_code":'',
                        "bank_name":'',
                        "branch": '',
                        "phone_name": '',
                        "country_code":'',
                        "account_number": '',
                        "account_name": '',
                        "account_type": '-1',
                        "account_other": ''

                    }]
            }
        };
        if(id != null && id.length > 0) {
            request.get(`${API.member.real_account.get + id}`)
                .query({msg: JSON.stringify(params)})
                .set(header)
                .end(function (_req, _res) {
                    if(_res == undefined){
                        templateResult.profiles = initDatas
                    }else {
                        let userInfo = JSON.parse(_res.text);
                        let userDatas = JSON.parse(userInfo.datas);
                        if (userDatas != null) {
                            templateResult.profiles = userDatas
                            res.render("member/pages/real_accounts/profile", templateResult)
                            console.log(templateResult.profiles)
                        }
                    }
                });
        }else{
            templateResult.profiles = initDatas;
            res.render("member/pages/real_accounts/profile", templateResult)
        }

    },

    userInfoPage: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };

        templateResult = {};
        //首次进入页面数据初始化
        let initDatas = {
            "id": "",
            state:'1',
            "customer_id":'',
            "account_type":'',
            "account_rate_type":'',
            "account_leverage":'',
            "open_account_info": {
                "full_name":'',
                "place":'',
                "birthday":'',
                "nationality":'',
                "identity_type": '',
                "identity_number": '',
                "investment_experience": '',
                "investment_experience_desc": '',
                "purpose_of_account_opening": '',
                "purpose_of_account_opening_other": '',
                "personal_tax_number": '',
                "gender":'',
                "have_family_in":'',
                "bankruptcy":'',
                "marital_status": '',
                "spouse_name": '',
                "mother_maiden_name": '',
                "home_address": '',
                "postal_code": '',
                "house_ownership": '',
                "house_ownership_other": '',
                "house_facsimile_number": '',
                "house_number_country_code":'',
                "mobile_number": "",
                "mobile_country_code":"",
                "recent_photos_path": '',
                "recent_photos_path2": '',
                "identity_photos_path": '',
                "identity_photos_path2": '',
                "bill_photo_path": '',
                "emergency_contact": {
                    "full_name": '',
                    "country_code":'',
                    "phone_number": '',
                    "relation_ship": '',
                    "home_address": '',
                    "postal_code": ''
                },
                "open_account_job": {
                    "occupation": '',
                    "occupation_other": '',
                    "name_of_company": '',
                    "business_field": '',
                    "title": '',
                    "length_of_services": '',
                    "length_of_services_in_previous_office": '',
                    "company_address": '',
                    "postal_code": '',
                    "office_phone_number": '',
                    "phone_country_code": '',
                    "office_fax_number": '',
                    "fax_country_code": ''
                },
                "open_account_wealth_list": {
                    "annual": '',
                    "location_of_house": '',
                    "house_tax_value": 0,
                    "time_deposit": 0,
                    "total": 0,
                    "others": 0
                },
                "open_account_bank": [
                    {
                        "currency":"2",
                        "branch_swift_code":'',
                        "bank_name": '',
                        "branch": '',
                        "phone_name": '',
                        "country_code":'',
                        "account_number": '',
                        "account_name":'',
                        "account_type": '',
                        "account_other": ''
                    },{
                        "currency":"1",
                        "branch_swift_code":'',
                        "bank_name":'',
                        "branch": '',
                        "phone_name": '',
                        "country_code":'',
                        "account_number": '',
                        "account_name": '',
                        "account_type": '',
                        "account_other": ''

                    }]
            }
        };
        request.get(`${API.member.user.basic_info}`)
        .query({msg: JSON.stringify()})
        .set(header)
        .end(function (_req, _res) {
            let userInfo = JSON.parse(_res.text);
            let userDatas = JSON.parse(userInfo.datas);
            if (userDatas != null) {
                templateResult.profiles = userDatas;
                templateResult.active = 'userinfo';
                res.render("member/pages/real_accounts/profile", templateResult);
                console.log(templateResult.profiles )
            }
        });

    }
}



//#真实账户，8步法务确认
exports.step = {

    page: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let id = req.query.no;

        let params = {
            id:id
        };

        request.get(`${API.member.real_account.get + id}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                let userInfo = JSON.parse(_res.text);
                let userDatas = JSON.parse(userInfo.datas);
                templateResult.userDatas=userDatas;
               if( templateResult.userDatas.state == 4){
                    for(var i = 0; i < templateResult.userDatas.open_state_log.length; i++ ){
                        if(templateResult.userDatas.open_state_log[i].state == 4){
                            templateResult.userDatas.open_state_log = templateResult.userDatas.open_state_log[i]
                        }
                    }
                }else{
                   userDatas.open_state_log = {
                       state: 2,
                       remark: "-",
                       position:  "-",
                       gmt_create:  "-",
                       gmt_modified:  "-",
                       operator_id:  "-",
                       operator_name:  "-",
                       operator_address:  "-"
                   }
               }
               console.log(userDatas)
                templateResult.accounts_status= -1
                res.render("member/pages/real_accounts/step", templateResult)
                templateResult.accounts_status= 0
            });



    },
    //获取用户信息
    open_real_account: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let {id} = req.body;
        let params = {
            id:id,
        };
        request.get(`${API.member.real_account.get + id}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                let userInfo = JSON.parse(_res.text);
                let userDatas = JSON.parse(userInfo.datas);
                res.json(userDatas);
            });
    },
    //获取用户信息
    userInfoPage: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        request.get(`${API.member.user.basic_info}`)
            .query({msg: JSON.stringify()})
            .set(header)
            .end(function (_req, _res) {
                let userInfo = JSON.parse(_res.text);
                let userDatas = JSON.parse(userInfo.datas);
                templateResult.active = 'userinfo';
                templateResult.userDatas = userDatas;
                console.log(userDatas)
                res.render("member/pages/user/info", templateResult);
            });
    },
    //用户确认开户
    confirm: function (req, res, next) {
        let header = {
            token: req.cookies.token
        };
        let {id,programme,court,branch} = req.body;
        let params = {
            "id":id,
            "programme":programme,
            "court":court,
            "branch":branch
        };
        request.put(`${API.member.account.confirm}`)
            .query({msg: JSON.stringify(params)})
            .set(header)
            .end(function (_req, _res) {
                let userInfo = JSON.parse(_res.text);
                let userDatas = JSON.parse(userInfo.datas);
                res.json(userInfo);
            });
    },
}