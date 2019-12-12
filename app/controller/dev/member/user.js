/**
 * Created by zlp on 2018/01/04.
 * For 我的账户
 */
var setting = require("../../../common/cn/member/index");

let customer_datas = {
    basic: {
        family_name: "郑",
        given_name: "林平",
        gender: 1,
        date_of_birth: "1980-11-11",
        email: "zlp@163.com",
        mobile: "13141516171"
    },
    identity: {
        identity_type: "身份证",
        identity_no: "131415161718191101",
        front: "",
        back: ""
    },
    address: {
        id: "",
        country: "中国",
        province: "北京",
        city: "北京",
        address: "丰台区总部基地16区18号楼",
        zip_code: "100141",
        path: ""
    }
}
let cards = [{
    id: "1",
    bank_name: "招商银行",
    branch_name: "招商银行北京支行",
    //logo:"/assets/member/styles/zh/img/user/bank-logo/logo-zs.png",
    type: "信用卡",
    card_no: "6225123456789101",
    country: "中国",
    province: "北京市",
    city: "北京市",
    primary: false
}, {
    id: "2",
    bank_name: "民生银行",
    branch_name: "民生银行北京支行",
    //logo:"/assets/member/styles/zh/img/user/bank-logo/logo-ms.png",
    type: "储蓄卡",
    card_no: "6222910112345678",
    country: "中国",
    province: "河北省",
    city: "石家庄市",
    primary: true
}]
let tel_info = {
    id: "ID",
    country: "电汇提现银行国家",
    branch_name: "电汇提现银行开户行",
    card_no: "电汇提现银行卡号",
    card_user_name: "电汇提现银行账户名",
    branch_address: "电汇提现银行地址",
    province: "电汇提现银行省份",
    city: "电汇提现银行城市",
    branch_swift_code: "电汇国际汇款代码"
}
let investor = {
    id: "1",
    job: 2,
    capital_source: 1,
    annual_income: 2,
    total_asset: 1,
    experience: 1,
    assess_risk: 1,
    professional: 1
}
let templateResult = {
    datas: {},
    setting: setting
};
exports.userInfo = {

    page: function (req, res) {
        let data = {};
        function init(){
            return new Promise(function(resolve, reject){
                data.basic = customer_datas.basic;
                resolve();
            });
        };
        init().then(function(){
            data.identity = customer_datas.identity;
        }).then(function(){
            data.address = customer_datas.address;
        }).then(function(){
            templateResult.active = 'userinfo';
            templateResult.datas = data;
            res.render("member/pages/user/info", templateResult);
        });

    },

    update: function (req, res) {
        res.json({status: 200, msg: "个人信息-基本信息-成功"});
    }

};

exports.address = {
    update: function (req, res) {
        res.json({status: 200, msg: "个人信息-居住信息-成功"});
    }

};

exports.bankInfo = {

    page: function (req, res) {
        templateResult.active = 'bankinfo';
        templateResult.datas = cards;
        res.render("member/pages/user/bankinfo", templateResult)
    },
    list: function (req, res) {
    },
    info: function (req, res) {
        let {id} = req.body;
        let data = {};
        for (let i = 0; i < cards.length; i++) {
            if (cards[i].id === id) {
                data = cards[i];
                break;
            }
        }
        res.json({status: 200, msg: "个人信息-银行-成功", datas: data});
    },
    add: function (req, res) {
        let {country, province, city, bank_name, branch_name, card_no} = req.body;
        let existed = false;
        for(let i = 0; i< cards.length;i++)
        {
            if(cards[i].card_no === card_no)
            {
                existed = true;
                break;
            }

        }
        if(existed)
        {
            res.json({status: 201, msg: "个人信息-银行-请勿添加已有的银行卡"});
        }
        else {
            let now = new Date();
            let id = (now.getDay().toString() + now.getHours().toString() + now.getMinutes().toString() + now.getSeconds().toString());
            let card = {
                country: country,
                province: province,
                city: city,
                bank_name: bank_name,
                branch_name: branch_name,
                card_no: card_no,
                id: id
            };
            cards.push(card);
            res.json({status: 200, msg: "个人信息-银行-成功"});
        }
    },
    del: function (req, res) {

        let { id } = req.body;
        let index = -1;
        for(let i = 0; i< cards.length;i++)
        {
            if(cards[i].id === id)
            {
                index = i;
                break;
            }
        }


        if(index > -1)
        {
            cards.splice(index, 1);
            res.json({status: 200, msg: "个人信息-银行-删除成功"});}
        else
        {
            res.json({status: 201, msg: "个人信息-银行-删除失败"});

        }
    },
    update: function (req, res) {

        let { id, country, province, city, bank_name, branch_name, card_no } = req.body;
        let index = -1;
        for(let i = 0; i< cards.length;i++)
        {
            if(cards[i].id === id)
            {
                index = i;
                break;
            }
        }


        if(index > -1)
        {
            let card = cards[index];

            card.country = country;
            card.province = province;
            card.city = city;
            card.bank_name = bank_name;
            card.branch_name = branch_name;
            card.card_no = card_no;

            res.json({status: 200, msg: "个人信息-银行-修改成功"});
        }
        else
        {
            res.json({status: 201, msg: "个人信息-银行-修改失败"});

        }
    }

};

exports.telInfo = {

    page: function (req, res) {
        templateResult.active = 'telinfo';
        templateResult.datas = tel_info;
        res.render("member/pages/user/telinfo", templateResult)
    },
    list: function (req, res) {
    },
    info: function (req, res) {
    },
    add: function (req, res) {
        res.json({status: 200, msg: "个人信息-电汇信息-成功"});
    },
    del: function (req, res) {
    },
    update: function (req, res) {
        res.json({status: 200, msg: "个人信息-电汇信息-成功"});
    }

};

exports.workInfo = {

    page: function (req, res) {
        templateResult.active = 'workinfo';
        templateResult.datas = investor;
        res.render("member/pages/user/workinfo", templateResult);
    },
    list: function (req, res) {
    },
    info: function (req, res) {
    },
    add: function (req, res) {
    },
    del: function (req, res) {
    },
    update: function (req, res) {
        res.json({status: 200, msg: "投资者信息-成功"});
    }

};





