module.exports = [
   /* {
        key: "home", label: '首页', url: "/sale/home", children: []
    }
    ,*/

    {
        key: "", label: '客户信息', url: "", children: [
            {key: "customer", label: '客户列表', url: "/sale/customer"}
        ]
    }
    ,
    {
        key: "rebate", label: '返佣返利信息', url: "", children: [
            {key: "trade", label: '交易返佣记录', url: "/sale/rebate/trade"}
            , {key: "balance", label: '余额返利记录', url: "/sale/rebate/balance"}
        ]
    },
    {
        key: "", label: '提成信息', url: "", children: [
            {key: "bonus", label: '提成列表', url: "/sale/bonus"}
        ]
    },
    {
        key: "benefit", label: '管理津贴', url: "/sale/benefit", children: []
    },
    {
        key: "userinfo", label: '用户信息', url: "/sale/userinfo", children: []
    }
    ,
    {
        key: "invitation", label: '邀请管理', url: "/sale/invite/page", children: []
    }

]
