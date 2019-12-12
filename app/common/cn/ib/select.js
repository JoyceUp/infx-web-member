module.exports = {
    register: {
        gender: [       //性别
            {value: 1, label: '先生'},
            {value: 2, label: '女士'}
        ],
        identity_type: [    //证件类型
            {value: 1, label: '身份证'},
            {value: 3, label: '护照'}
        ],
        account_type: [    //账户类型
            {value: 1, label: '标准账户'},
            // {value: 2, label: 'STP账户'},
           /* {value: 3, label: 'ECN账户'},*/
            // {value: 4, label: '赠金账户'},
            // {value: 9, label: '其他账户'},
            // {value: 10, label: '销售的账户'}
        ],
        account_type_map: {
            1: {value: 1, label: '标准账户'},
            // 2: {value: 2, label: 'STP账户'},
           /* 3: {value: 3, label: 'ECN账户'},*/
            // 4: {value: 4, label: '赠金账户'},
            // 9: {value: 9, label: '其他账户'},
            // 10: {value: 10, label: '销售的账户'}
        },
        state: [
            {value: 1, label: '正常'},
            {value: 50, label: '只读'},
            {value: 51, label: '禁用'},
        ]

    },
    funds: {
        /*代理系统 - 资金记录*/
        //资金类型
        funds_type: [
            {value: 6, label: '转账-转入'},
            {value: 8, label: '交易返佣'},
            {value: 9, label: '返利转入余额'},
            {value: 10, label: '入金-出金退回'},
            {value: 101, label: '出金-银行卡'},
            {value: 102, label: '出金-电汇'},
            {value: 103, label: '转账-转出'},
            {value: 301, label: '返利转入余额'}   //出金-返利转出到余额
        ],
        //出金记录-资金类型
        withdraw_funds_type: [
            {value: 101, label: '出金-银行卡'},
            {value: 102, label: '出金-电汇'},
        ],
        //出金渠道类型
        out_channel_type: [
            {value: 101, label: '出金-银行卡'},
            {value: 102, label: '出金-电汇'},
            {value: 103, label: '出金-转账'}
        ],
        //订单状态
        order_state:[
            /*{value: 2, label: '待审核'},
            {value: 3, label: '待到账确认'},
            {value: 4, label: '待系统处理'},
            {value: 5, label: '待银行打款'},
            {value: 6, label: '待系统返利打款'},
            {value: 7, label: '待读取余额'},
            {value: 101, label: '系统处理失败'},
            {value: 102, label: '读取余额失败'},*/
            {value: 1000, label: '处理中'},
            {value: 201, label: '已忽略'},
            {value: 202, label: '已退回'},
            {value: 203, label: '已取消'},
            {value: 204, label: '已完成'}
        ],
        //订单状态
        transfer_order_state:[
            {value: 1000, label: '处理中'},
            {value: 201, label: '已忽略'},
            {value: 203, label: '已取消'},
            {value: 204, label: '已完成'}
        ]
    },

    transaction: {
        type: [       //交易类型
            {value: 1, label: '买入'},
            {value: 2, label: '卖出'},
        ],
        symbol: [        //交易品种
            {value: 1, label: 'xauusd'},
            {value: 2, label: 'audusd'}
        ]
    },
    userinfo: {
        address: {
            countries: [
                ["CN", "中国"],
                ["AO", "安哥拉"],
                ["AF", "阿富汗"],
                ["AL", "阿尔巴尼亚"],
                ["DZ", "阿尔及利亚"],
                ["AD", "安道尔共和国"],
                ["AI", "安圭拉岛"],
                ["AG", "安提瓜和巴布达"],
                ["AR", "阿根廷"],
                ["AM", "亚美尼亚"],
                ["AU", "澳大利亚"],
                ["AT", "奥地利"],
                ["AZ", "阿塞拜疆"],
                ["BS", "巴哈马"],
                ["BH", "巴林"],
                ["BD", "孟加拉国"],
                ["BB", "巴巴多斯"],
                ["BY", "白俄罗斯"],
                ["BE", "比利时"],
                ["BZ", "伯利兹"],
                ["BJ", "贝宁"],
                ["BM", "百慕大群岛"],
                ["BO", "玻利维亚"],
                ["BW", "博茨瓦纳"],
                ["BR", "巴西"],
                ["BN", "文莱"],
                ["BG", "保加利亚"],
                ["BF", "布基纳法索"],
                ["MM", "缅甸"],
                ["BI", "布隆迪"],
                ["CM", "喀麦隆"],
                ["CA", "加拿大"],
                ["CF", "中非共和国"],
                ["TD", "乍得"],
                ["CL", "智利"],
                ["CO", "哥伦比亚"],
                ["CG", "刚果"],
                ["CK", "库克群岛"],
                ["CR", "哥斯达黎加"],
                ["CU", "古巴"],
                ["CY", "塞浦路斯"],
                ["CZ", "捷克"],
                ["DK", "丹麦"],
                ["DJ", "吉布提"],
                ["DO", "多米尼加共和国"],
                ["EC", "厄瓜多尔"],
                ["EG", "埃及"],
                ["SV", "萨尔瓦多"],
                ["EE", "爱沙尼亚"],
                ["ET", "埃塞俄比亚"],
                ["FJ", "斐济"],
                ["FI", "芬兰"],
                ["FR", "法国"],
                ["GF", "法属圭亚那"],
                ["GA", "加蓬"],
                ["GM", "冈比亚"],
                ["GE", "格鲁吉亚"],
                ["DE", "德国"],
                ["GH", "加纳"],
                ["GI", "直布罗陀"],
                ["GR", "希腊"],
                ["GD", "格林纳达"],
                ["GU", "关岛"],
                ["GT", "危地马拉"],
                ["GN", "几内亚"],
                ["GY", "圭亚那"],
                ["HT", "海地"],
                ["HN", "洪都拉斯"],
                ["HK", "香港"],
                ["HU", "匈牙利"],
                ["IS", "冰岛"],
                ["IN", "印度"],
                ["ID", "印度尼西亚"],
                ["IR", "伊朗"],
                ["IQ", "伊拉克"],
                ["IE", "爱尔兰"],
                ["IL", "以色列"],
                ["IT", "意大利"],
                ["JM", "牙买加"],
                ["JP", "日本"],
                ["JO", "约旦"],
                ["KH", "柬埔寨"],
                ["KZ", "哈萨克斯坦"],
                ["KE", "肯尼亚"],
                ["KR", "韩国"],
                ["KW", "科威特"],
                ["KG", "吉尔吉斯坦"],
                ["LA", "老挝"],
                ["LV", "拉脱维亚"],
                ["LB", "黎巴嫩"],
                ["LS", "莱索托"],
                ["LR", "利比里亚"],
                ["LY", "利比亚"],
                ["LI", "列支敦士登"],
                ["LT", "立陶宛"],
                ["LU", "卢森堡"],
                ["MO", "澳门"],
                ["MG", "马达加斯加"],
                ["MW", "马拉维"],
                ["MY", "马来西亚"],
                ["MV", "马尔代夫"],
                ["ML", "马里"],
                ["MT", "马耳他"],
                ["MU", "毛里求斯"],
                ["MX", "墨西哥"],
                ["MD", "摩尔多瓦"],
                ["MC", "摩纳哥"],
                ["MN", "蒙古"],
                ["MS", "蒙特塞拉特岛"],
                ["MA", "摩洛哥"],
                ["MZ", "莫桑比克"],
                ["NA", "纳米比亚"],
                ["NR", "瑙鲁"],
                ["NP", "尼泊尔"],
                ["NL", "荷兰"],
                ["NZ", "新西兰"],
                ["NI", "尼加拉瓜"],
                ["NE", "尼日尔"],
                ["NG", "尼日利亚"],
                ["KP", "朝鲜"],
                ["NO", "挪威"],
                ["OM", "阿曼"],
                ["PK", "巴基斯坦"],
                ["PA", "巴拿马"],
                ["PG", "巴布亚新几内亚"],
                ["PY", "巴拉圭"],
                ["PE", "秘鲁"],
                ["PH", "菲律宾"],
                ["PL", "波兰"],
                ["PF", "法属玻利尼西亚"],
                ["PT", "葡萄牙"],
                ["PR", "波多黎各"],
                ["QA", "卡塔尔"],
                ["RO", "罗马尼亚"],
                ["RU", "俄罗斯"],
                ["LC", "圣卢西亚"],
                ["VC", "圣文森特岛"],
                ["SM", "圣马力诺"],
                ["ST", "圣多美和普林西比"],
                ["SA", "沙特阿拉伯"],
                ["SN", "塞内加尔"],
                ["SC", "塞舌尔"],
                ["SL", "塞拉利昂"],
                ["SG", "新加坡"],
                ["SK", "斯洛伐克"],
                ["SI", "斯洛文尼亚"],
                ["SB", "所罗门群岛"],
                ["SO", "索马里"],
                ["ZA", "南非"],
                ["ES", "西班牙"],
                ["LK", "斯里兰卡"],
                ["SD", "苏丹"],
                ["SR", "苏里南"],
                ["SZ", "斯威士兰"],
                ["SE", "瑞典"],
                ["CH", "瑞士"],
                ["SY", "叙利亚"],
                ["TW", "台湾省"],
                ["TJ", "塔吉克斯坦"],
                ["TZ", "坦桑尼亚"],
                ["TH", "泰国"],
                ["TG", "多哥"],
                ["TO", "汤加"],
                ["TT", "特立尼达和多巴哥"],
                ["TN", "突尼斯"],
                ["TR", "土耳其"],
                ["TM", "土库曼斯坦"],
                ["UG", "乌干达"],
                ["UA", "乌克兰"],
                ["AE", "阿拉伯联合酋长国"],
                ["GB", "英国"],
                ["US", "美国"],
                ["UY", "乌拉圭"],
                ["UZ", "乌兹别克斯坦"],
                ["VE", "委内瑞拉"],
                ["VN", "越南"],
                ["YE", "也门"],
                ["YU", "南斯拉夫"],
                ["ZW", "津巴布韦"],
                ["ZR", "扎伊尔"],
                ["ZM", "赞比亚"]
            ]
        },
        banks: {
            cn: {
                "北京银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-bj.png"
                },
                "光大银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-gd.png"
                },
                "广发银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-gf.png"
                },
                "工商银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-gs.png"
                },
                "华夏银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-hx.png"
                },
                "建设银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-js.png"
                },
                "交通银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-jt.png"
                },
                "民生银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-ms.png"
                },
                "农业银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-ny.png"
                },
                "平安银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-pa.png"
                },
                "浦发银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-pf.png"
                },
                "兴业银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-xy.png"
                },
                "邮政银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-yz.png"
                },
                "中国银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-zg.png"
                },
                "招商银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-zs.png"
                },
                "中信银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/logo-zx.png"
                },
                "上海银行": {
                    logo: "/assets/member/styles/zh/img/user/bank-logo/sh.png"
                }
            },
            other: {
                logo: ""
            }
        }
    }
}
