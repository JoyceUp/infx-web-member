/**
 * Created by zlp on 2018/01/04.
 * For 资金信息
 */
var Promise = require("bluebird");
var fundsMock = require("../../../mock/data/funds");
var setting = require("../../../common/cn/member/index");

let templateResult = {
    datas: {},
    setting: setting
};

//资金记录
var fundsList = fundsMock.fundsList();
exports.fundsrecord = {
    page:function (req, res, next) {
        templateResult.active = "fundsrecord";
        res.render("member/pages/funds/fundsrecord", templateResult)
    },

     list:function (req, res, next) {
    let {page, limit, account_no, type, start_time, end_time} = req.body;
    let mockData = fundsList.filter(fund => {
        if( account_no && fund.account_no!=account_no)return false;
       return true;
        });

    mockData = mockData.filter(fund => {
        if(type && fund.type != type) return false;
    return true;
});

    mockData = mockData.filter(fund => {
        if(start_time && fund.start_time < start_time)return false;
       return true;
});

    mockData = mockData.filter(fund => {
        if(end_time && fund.end_time <= end_time) return false;
    return true;
});

    let count = mockData.length;
    let data = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));


    res.json({
        "status": 0,
        "msg": '',
        "count": count,
        "datas": data
    });

}
};


//出入金记录
var depositList = fundsMock.depDrawList();
exports.deposit = {
    page:function (req, res, next) {
        templateResult.active = "funds_deposit";
        res.render("member/pages/funds/deposit", templateResult)
    },
    list: function(req,res,next){
    let {page, limit, account_no, type, channel_type,state,start_time, end_time} = req.body;
    let mockData = depositList.filter(fund => {
        if( account_no && fund.account_no!=account_no)return false;
    return true;
});

    mockData = mockData.filter(fund => {
        if(type && fund.type != type) return false;
    return true;
});

    mockData = mockData.filter(fund => {
        if(channel_type && fund.channel_type != channel_type) return false;
    return true;
});

    mockData = mockData.filter(fund => {
        if(state && fund.state != state) return false;
    return true;
});

    mockData = mockData.filter(fund => {
        if(start_time && fund.start_time < start_time)return false;
    return true;
});

    mockData = mockData.filter(fund => {
        if(end_time && fund.end_time <= end_time) return false;
    return true;
});
    let count = mockData.length;
    let data = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1));

    res.json({
        "status": 0,
        "msg": '',
        "count": count,
        "datas": data
    });
},

    info : function(req,res,next){
    let {id} = req.body;
    let mockData = depositList.filter(dps =>{
        if(id&&dps.id != id) return false;
        return true;
    });

    res.json({
        "status":0,
        "msg":"",
        "datas":mockData[0]
    });
},
};

//转账记录
exports.transfer = {
    page: function (req, res, next) {
        templateResult.active = "funds_transfer";
        res.render("member/pages/funds/transfer", templateResult)
    },
    list: function (req, res, next) {
        let {page, limit, id, account_no_from, account_no_to, state} = req.body;
        let mockData = depositList.filter(obj => {
            if(id && obj.id != id
    )
        return false;
        return true;
    })
        ;

        mockData = mockData.filter(obj => {
            if(account_no_from && obj.account_no_from != account_no_from
    )
        return false;
        return true;
    })
        ;

        mockData = mockData.filter(obj => {
            if(account_no_to && obj.account_no_to != account_no_to
    )
        return false;
        return true;
    })
        ;

        mockData = mockData.filter(obj => {
            if(state && obj.state != state
    )
        return false;
        return true;
    })
        ;
        let count = mockData.length;
        mockData = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1)
    )
        ;

        res.json({
            'status': 0,
            'msg': '',
            'count': count,
            'datas': mockData
        });
    },

    info: function (req, res, next) {
        let {id} = req.body;
        let mockData = depositList.filter(obj => {
            if(id && obj.id != id
    )
        return false;
        return true;
    })
        ;

        res.json({
            'status': 0,
            'msg': '',
            'datas': mockData[0]
        });
    }
}

//余额清零记录
exports.blanceflush = {
    page: function (req, res, next) {
        templateResult.active = "funds_blanceflush";
        res.render("member/pages/funds/blanceflush", templateResult)
    },

    list: function (req, res, next) {
        let {page, limit, account_no, state} = req.body;
        let mockData = depositList.filter(fund => {
            if(account_no && fund.account_no != account_no
    )
        return false;
        return true;
    })
        ;

        mockData = mockData.filter(fund => {
            if(state && fund.state != state
    )
        return false;
        return true;
    })
        ;

        ;
        let count = mockData.length;
        let data = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1)
    )
        ;

        res.json({
            "status": 0,
            "msg": '',
            "count": count,
            "datas": data
        });
    },

    info: function (req, res, next) {
        let {id} = req.body;
        let mockData = depositList.filter(dps => {
            if(id && dps.id != id
    )
        return false;
        return true;
    })
        ;

        res.json({
            "status": 0,
            "msg": "",
            "datas": mockData[0]
        });
    }
}
//交易记录
var tlist = fundsMock.transactionList();
exports.transaction = {
    page: function (req, res, next) {
        templateResult.active = "funds_transaction";
        res.render("member/pages/funds/transaction", templateResult)
    },

    list: function (req, res, next) {
        let {page, limit, id, account_no_from, account_no_to, state} = req.body;
        let mockData = depositList.filter(obj => {
            if(id && obj.id != id
    )
        return false;
        return true;
    });

        mockData = mockData.filter(obj => {
            if(account_no_from && obj.account_no_from != account_no_from
    )
        return false;
        return true;
    });

        mockData = mockData.filter(obj => {
            if(account_no_to && obj.account_no_to != account_no_to
    )
        return false;
        return true;
    })
        ;

        mockData = mockData.filter(obj => {
            if(state && obj.state != state
    )
        return false;
        return true;
    })
        ;
        let count = mockData.length;
        mockData = mockData.filter((u, index) => index < limit * page && index >= limit * (page - 1)
    )
        ;

        res.json({
            'status': 0,
            'msg': '',
            'count': count,
            'datas': mockData
        });
    },

    info: function(req,res,next){
        let{page,limit} = req.body;
        let　mockData = tlist.filter(obj =>{
            if(id && obj.id != id) return false;
        return true;
    });

        let count = mockData.length;
        mockData = mockData.filter((u,index)=> index < page * limit && index >= limit *(page - 1));

        res.json({
            'status':0,
            'msg':'',
            'count':count,
            'datas':mockData
        });
    }
}