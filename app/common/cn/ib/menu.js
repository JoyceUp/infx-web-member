module.exports = [
    {
        key: "", label: '我的账户', url: "", children: [
            {key: "account_list", label: '账户列表', url: "/ib/account/mt"}
            , {key: "account_append", label: '创建新账户', url: "/ib/account/append"}
            , {key: "account_info", label: '个人资料', url: "/ib/account/info"}

        ]
    }
    ,
    {
        key: "", label: '我的资金', url: "", children: [
            {key: "withdraw", label: '出金', url: "/ib/funds/withdraw"},
            {key: "transfer", label: '账户转账', url: "/ib/funds/transfer"},
            {key: "return_to_balance", label: '返利转余额', url: "/ib/funds/return_to_balance"},
            {key: "funds_record", label: '资金记录', url: "/ib/funds/fundsrecord"},
            {key: "withdraw_record", label: '出金记录', url: "/ib/funds/withdraw_record"},
            {key: "transfer_record", label: '转账记录', url: "/ib/funds/transfer_record"},
            {key: "return_to_balance_record", label: '返利转余额记录', url: "/ib/funds/return_to_balance_record"}
        ]
    }
    ,
    {
        key: "", label: '我的客户', url: "", children: [
            {key: "client_list", label: '客户信息', url: "/ib/client/list"}

        ]
    },
    {
        key: "rebate", label: '我的佣金', url: "", children: [
            {key: "trade", label: '交易返佣记录', url: "/ib/rebates/trade"}
            , {key: "rebate", label: '余额返利记录', url: "/ib/rebates/balance"}
        ]
    },
    //########### 一期先去掉此功能，某个客户的交易数据可以从客户的详情页去查看 #################
    /*{
        key: "transaction", label: '客户交易数据', url: "", children: [
            {key: "history", label: '历史交易', url: "/ib/transaction/history"}
            , {key: "position", label: '持仓交易', url: "/ib/transaction/position"}
        ]
    },*/
    {
        key: "", label: '开户链接', url: "/ib/invite/page", children: []
    }
]



