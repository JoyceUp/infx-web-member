//import Mock from 'mockjs';
var Mock = require('mockjs')

const bonusList = [];
exports.BonusList=function(){
    if(bonusList.length == 0){
        for (let i = 0; i < 6; i++) {
            bonusList.push(Mock.mock({
                id: Mock.Random.guid(),
                amount: Mock.Random.integer(1, 10),
                total_amount: Mock.Random.integer(1000, 2000),
                change_time: Mock.Random.date()
            }));
        }
    }
    return bonusList
}

const bonusInfoList = [];
exports.BonusInfoList=function(){
    if(bonusInfoList.length == 0){
        for (let i = 0; i < 6; i++) {
            bonusInfoList.push(Mock.mock({
                id: Mock.Random.guid(),
                name: Mock.Random.cname(),
                company: "公司" + i,
                department: "部门" + i,
                team: "组别" + i,
                position: "职位" + i,
                amount: Mock.Random.integer(1000, 2000),
                change_time: Mock.Random.date()
            }));
        }
    }
    return bonusInfoList
}
