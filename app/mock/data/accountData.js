//import Mock from 'mockjs';
var Mock = require('mockjs')

const Accounts = [];
exports.AccountList=function(){
    if(Accounts.length == 0){
        for (let i = 0; i < 6; i++) {
            Accounts.push(Mock.mock({
                id: Mock.Random.guid(),
                account_no: Mock.Random.integer(80000000, 90000000),
                balance: Mock.Random.integer(1000, 3000),
                account_type: Mock.Random.integer(1, 4),
                state: Mock.Random.integer(0, 1),
                leverage: '1:400',
                gmt_create: Mock.Random.date(),
                change_time: Mock.Random.date()
            }));
        }
    }
    return Accounts
}
