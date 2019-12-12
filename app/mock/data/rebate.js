//import Mock from 'mockjs';
var Mock = require('mockjs')

exports.Rebates = function() {
    const Rebates = [];
    for (let i = 0; i < 86; i++) {
        Rebates.push(Mock.mock({
            'id|+1': i + 1,                   //1开始，递增      (代理)
            'ib_no|+1': i + 1,                //1开始，递增      (代理)
            order_no: '4971' + i,             //交易账号
            trading_account: '80882' + i,                 //交易账号
            full_name: Mock.Random.cname(),             //姓名
            'trading_symbol|1': ['EURUSD', 'USDJPY'],    //交易品种
            'trading_volume|1-100.2': 1,                //交易量
            'commission_amount|1-100.2': 1,             //返佣金额
            commission_time: Mock.Random.date(),        //返佣时间
            account_no: i + 1,                             //MT4账户、账号
            state: Mock.Random.integer(1, 2),           //状态


            /*--------------------------余额返利----------------------------------*/

            source_account_user_name: Mock.Random.cname(),        //客户姓名
            'balance|1-10000.2': 1,                 //账户余额
            'account_balance_rate|1-100.2': 1,     //账户余额返利率
            'account_balance|0-1.2': 1,             //账户余额返利
            rebate_time: Mock.Random.date(),        //返佣日期


            /*----------------------------------------历史交易-----------------------------------------*/

            open_time: Mock.Random.datetime('yyyy-MM-dd HH-mm-ss'),    //开仓时间
            type: Mock.Random.integer(1, 2),    //交易类型
            symbol: Mock.Random.integer(1, 2),    //交易品种
            'volume|0-100.2': 1,    //交易量
            'open_price|0-100.2': 1,    //开仓价格
            'close_price|0-100.2': 1,    //平仓价格
            close_time: Mock.Random.datetime('yyyy-MM-dd HH:mm:ss'),    //平仓时间
            'sl|0-100.2': 1,    //手续费
            'tp|0-1.2': 1,    //隔夜利息
            'fee|0-100.2': 1,    //手续费
            'swaps|0-1.2': 1,    //隔夜利息
            'profit|0-100.2': 1,    //交易盈亏

            /*-------------------------------------------------我的客户----------------------------------------------------*/

            customer_name: Mock.Random.cname(),          //姓名
            deposit: Mock.Random.integer(0, 200),        //入金
            withdraw: Mock.Random.integer(0, 200),       //出金
            deposit_net: Mock.Random.integer(-10, 200),  //净入金
            ib: Mock.mock('@zip'),                       //IB
            email: Mock.mock('@EMAIL()'),                //随机生成一个邮箱,
            mobile: /^1[385][1-9]\d{11}/,                 //手机号
            gmt_create: Mock.Random.date(),              //注册时间

        }));
    }
    return Rebates;
};

exports.Clients = function() {
    const Clients = [];
    for (let i = 0; i < 32; i++) {
        Clients.push(Mock.mock({
            'id|+1': i + 1,                   //1开始，递增
            'ib_no|+1': i + 1,                //1开始，递增      代理账户
            customer_name: Mock.Random.cname(),          //姓名
            deposit: Mock.Random.integer(0, 200),        //入金
            withdraw: Mock.Random.integer(0, 200),       //出金
            deposit_net: Mock.Random.integer(-10, 200),  //净入金
            ib: Mock.mock('@zip'),                       //IB
            email: Mock.mock('@EMAIL()'),                //随机生成一个邮箱,
            mobile: /^1[385][1-9]\d{11}/,                 //手机号
            gmt_create: Mock.Random.date(),              //注册时间

        }));
    }
    return Clients;
};

//账号信息
exports.AccountInfo = function() {
    const AccountInfo = [];
    for (let i = 0; i < 32; i++) {
        AccountInfo.push(Mock.mock({
            'account_no|+1': i + 1,                     //1开始，递增      MT4账号
            account_type: Mock.Random.integer(1, 2),    //账户类型
            leverage: Mock.Random.integer(0, 200),      //杠杆
            balance: Mock.Random.integer(-10, 200),     //余额
            ib: Mock.mock('@zip'),                      //所属IB
            state: Mock.Random.integer(1, 2),           //状态
            gmt_create: Mock.Random.date(),             //创建日期

        }));
    }
    return AccountInfo;
};
//出入金信息
exports.DepDrawInfo = function() {
    const DepDrawInfo = [];
    for (let i = 0; i < 32; i++) {
        DepDrawInfo.push(Mock.mock({
            'account_no|+1': i + 1,                     //1开始，递增      MT4账号
            account_type: Mock.Random.integer(1, 2),    //出入金类型
            order_no: Mock.Random.integer(1, 2)+i,      //订单编号
            apply_money: Mock.Random.integer(0, 200),   //申请金额
            channel_type: Mock.Random.integer(1, 2),    //渠道方式
            account_no: Mock.mock('@zip'),              //MT4账号
            status: Mock.Random.integer(1, 2),          //订单状态
            remark: Mock.Random.cname(),                //处理备注
            gmt_create: Mock.Random.date(),             //创建日期

        }));
    }
    return DepDrawInfo;
};
//转账信息
exports.TransferInfo = function() {
    const TransferInfo = [];
    for (let i = 0; i < 32; i++) {
        TransferInfo.push(Mock.mock({
            // 'account_no|+1': i + 1,                     //1开始，递增      MT4账号
            //account_type: Mock.Random.integer(1, 2),    //出入金类型
            order_no: Mock.Random.integer(1, 2)+i,      //订单编号
            amount: Mock.Random.integer(0, 200),        //转账金额
            //channel_type: Mock.Random.integer(1, 2),    //渠道方式
            account_no_from: Mock.mock('@zip'),             //转出账号
            account_no_to: Mock.mock('@zip'),              //转入账号
            state: Mock.Random.integer(1, 2),          //状态
            remark: Mock.Random.cname(),                //处理备注
            gmt_create: Mock.Random.date(),             //创建日期

        }));
    }
    return TransferInfo;
};
//交易信息
exports.TradeInfo = function() {
    const TradeInfo = [];
    for (let i = 0; i < 32; i++) {
        TradeInfo.push(Mock.mock({
            'account_no|+1': i + 1,                     //1开始，递增      MT4账号
            order_no: Mock.Random.integer(1, 2)+i,      //订单编号
            status: Mock.Random.integer(1, 2),          //状态
            open_time: Mock.Random.datetime('yyyy-MM-dd HH-mm-ss'),    //开仓时间
            type: Mock.Random.integer(1, 2),    //交易类型
            symbol: Mock.Random.integer(1, 2),    //交易品种
            'volume|0-100.2': 1,    //交易量
            'open_price|0-100.2': 1,    //开仓价格
            'close_price|0-100.2': 1,    //平仓价格
            close_time: Mock.Random.datetime('yyyy-MM-dd HH:mm:ss'),    //平仓时间
            'sl|0-100.2': 1,    //手续费
            'tp|0-1.2': 1,    //隔夜利息
            'fee|0-100.2': 1,    //手续费
            'swaps|0-1.2': 1,    //隔夜利息
            'profit|0-100.2': 1,    //交易盈亏

        }));
    }
    return TradeInfo;
};

const tradeList = [];
exports.TradeList=function(){
    if(tradeList.length == 0){
        for (let i = 0; i < 6; i++) {
            tradeList.push(Mock.mock({
                id: Mock.Random.guid(),
                balance: Mock.Random.integer(1000, 2000),
                account_no: Mock.Random.integer(8000000, 9000000),
                name: Mock.Random.cname(),
                return_money: Mock.Random.integer(10, 50),
                change_time: Mock.Random.date()
            }));
        }
    }
    return tradeList
}

const balanceList = [];
exports.BalanceList=function(){
    if(balanceList.length == 0){
        for (let i = 0; i < 6; i++) {
            balanceList.push(Mock.mock({
                id: Mock.Random.guid(),
                balance: Mock.Random.integer(1000, 2000),
                account_no: Mock.Random.integer(8000000, 9000000),
                name: Mock.Random.cname(),
                return_money: Mock.Random.integer(10, 50),
                change_time: Mock.Random.date()
            }));
        }
    }
    return balanceList
}

