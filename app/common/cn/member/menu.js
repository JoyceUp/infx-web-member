module.exports = [
    {
        key: "", label: '我的账户', url: "", children: [
            {key: "mtlst", label: '账户列表', url: "/member/account/mt"}
            , {key: "append", label: '创建新账户', url: "/member/account/append"}
            , {key: "modify_lev", label: '修改杠杆', url: "/member/account/modify_lev"}
            , {key: "balance_flush", label: '余额清零', url: "/member/account/balance_flush"}
        ]
    }
    ,
    {
        key: "", label: '资金交易', url: "", children: [
            {key: "deposit", label: '账户入金', url: "/member/transaction/deposit"}
            , {key: "withdraw", label: '账户出金', url: "/member/transaction/withdraw"}
            , {key: "transfer", label: '账户转账', url: "/member/transaction/transfer"}
        ]
    }
    ,
    {
        key: "", label: '资金信息', url: "", children: [
            {key: "funds_record", label: '资金记录', url: "/member/funds/fundsrecord"}
            , {key: "funds_deposit", label: '出入金记录', url: "/member/funds/deposit"}
            , {key: "funds_transfer", label: '转账记录', url: "/member/funds/transfer"}
            , {key: "funds_balance_flush", label: '余额清零记录', url: "/member/funds/blanceflush"}
            // , {key: "funds_transaction", label: '交易记录', url: "/member/funds/transaction"}
        ]
    }
    ,
    {
        key: "", label: '客户信息', url: "", children: [
            {key: "userinfo", label: '个人信息', url: "/member/user/userinfo"}
            , {key: "bankinfo", label: '银行信息', url: "/member/user/bankinfo"}
            , {key: "telinfo", label: '电汇信息', url: "/member/user/telinfo"}
            , {key: "workinfo", label: '投资者信息', url: "/member/user/workinfo"}
        ]
    }
   /* ,
    {
        key: "", label: '代理登记', url: "/member/ib/applay", children: []
    }*/
]



