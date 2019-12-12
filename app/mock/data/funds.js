//import Mock from 'mockjs';
var Mock = require('mockjs')

exports.fundsList=function(){
    const Funds = [];

    for (let i = 0; i < 66; i++) {
        Funds.push(Mock.mock({
            id: Mock.Random.guid(),
            account_no: Mock.Random.integer(80000000, 90000000),
            balance: Mock.Random.integer(1000, 3000),
            type: Mock.Random.integer(1, 9),
            state: Mock.Random.integer(0, 1),
            gmt_create: Mock.Random.date(),
            change_time: Mock.Random.date()
        }));
    }
    return Funds
}


exports.depDrawList=function(){
    const Funds = [];

    for (let i = 0; i < 66; i++) {
        Funds.push(Mock.mock({
            id: Mock.Random.guid(),
            account_no: Mock.Random.integer(80000000, 90000000),
            account_no_to: Mock.Random.integer(80000000, 90000000),
            account_no_from: Mock.Random.integer(80000000, 90000000),
            amount: Mock.Random.integer(1000, 3000),
            type: Mock.Random.integer(1, 9),
            channel_type:Mock.Random.integer(1, 9),
            state: Mock.Random.integer(0, 1),
            gmt_create: Mock.Random.date(),
            change_time: Mock.Random.date()
        }));
    }
    return Funds
}


exports.transactionList = function(){
    const funds =[];
    for(let i =0 ; i < 66; i++){
        funds.push(Mock.mock({
            id: Mock.Random.guid(),
            account_no: Mock.Random.integer(80000000, 90000000),
            type:Mock.Random.integer(1, 9),
            symbol:Mock.Random.integer(1, 9),
            volume:Mock.Random.integer(1.00,10.00),
            open_price:Mock.Random.integer(1.00,10.00),
            close_price:Mock.Random.integer(1.00,10.00),
            profit:Mock.Random.integer(1.00,10.00),
            open_time:Mock.Random.date(),
            close_time:Mock.Random.date(),
            swaps:Mock.Random.integer(1.00,10.00),//隔夜利息
            fee:Mock.Random.integer(1.00,10.00),
            sl:Mock.Random.integer(1, 9),
            tp:Mock.Random.integer(1, 9),
            status:Mock.Random.integer(1,9)

        }));
    }
}



exports.returnToBalanceRecordList=function(){
    const Funds = [];

    for (let i = 0; i < 66; i++) {
        Funds.push(Mock.mock({
            id: Mock.Random.guid(),
            account_no: Mock.Random.integer(80000000, 90000000),
            account_no_to: Mock.Random.integer(80000000, 90000000),
            account_no_from: Mock.Random.integer(80000000, 90000000),
            amount: Mock.Random.integer(1000, 3000),
            type: Mock.Random.integer(1, 9),
            channel_type:Mock.Random.integer(1, 9),
            state: Mock.Random.integer(0, 1),
            gmt_create: Mock.Random.date(),
            change_time: Mock.Random.date()
        }));
    }
    return Funds
}