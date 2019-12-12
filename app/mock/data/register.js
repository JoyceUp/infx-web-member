//import Mock from 'mockjs';
var Mock = require('mockjs')

exports.Regs=function(){
    const Regs = [];

    for (let i = 0; i < 86; i++) {
        Regs.push(Mock.mock({
            'id|+1': 1,   //1开始，递增
            email: Mock.mock('@EMAIL()'), //随机生成一个邮箱,
            family_name: Mock.mock('@cfirst'),
            given_name: Mock.mock('@clast()'),
            //birth: Mock.Random.date(),
            verify_code:Mock.mock('@zip'),
            invite_code:Mock.mock('@zip'),
            gender: Mock.Random.integer(0, 1)//随机生成一个整数，0/1 ，根据这个来给“男” “女”
        }));
    }
    return Regs
}

