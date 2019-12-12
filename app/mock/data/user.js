//import Mock from 'mockjs';
var Mock = require('mockjs')

exports.LoginUsers = function(){
  return{
          id: "11223344",
          user_name: 'admin',
          password: '123456',
          nickname: 'nickname',
          avatar: '/assets/images/user.png',
          name: 'admin'
      }

}


exports.Users=function(){
    const Users = [];

    for (let i = 0; i < 86; i++) {
        Users.push(Mock.mock({
            id: Mock.Random.guid(),
            name: Mock.Random.cname(),
            addr: Mock.mock('@county(true)'),
            'age|18-60': 1,
            birth: Mock.Random.date(),
            sex: Mock.Random.integer(0, 1)
        }));
    }
    return Users
}


exports.adminUsers=function(){
    const adminUsers = [];
    for (let i = 0; i < 86; i++) {
        adminUsers.push(Mock.mock({
            id: Mock.Random.guid(),
            role_id: '',
            password: '',
            user_name: Mock.Random.name(),
            nickname: Mock.Random.cname(),
            status: Mock.Random.integer(0, 1)
        }));
    }
    adminUsers.push(this.LoginUsers())
    return adminUsers
}

exports.onlineAdminUsers=function(){
    const onlineAdminUsers = [];
    for (let i = 0; i < 86; i++) {
        onlineAdminUsers.push(Mock.mock({
            id: Mock.Random.guid(),
            nickname: Mock.Random.cname(),
            user_name: Mock.Random.name(),
        }));
    }
    return onlineAdminUsers
}

exports.systemLog=function(){
    const systemLog = [];
    for (let i = 0; i < 86; i++) {
        systemLog.push(Mock.mock({
            user_id: Mock.Random.guid(),
            user_name: Mock.Random.name(),
            login_ip: Mock.Random.ip(),
            type : Mock.Random.integer(0,8),
            opreation : Mock.Random.cparagraph(2),
            create_time : Mock.Random.date('yyyy-MM-dd')
        }));
    }
    return systemLog
}



exports.systemParam=function(){
    const systemParam = [];
    for (let i = 0; i < 86; i++) {
        systemParam.push(Mock.mock({
            id: Mock.Random.guid(),
            key: Mock.Random.cname(),
            value: Mock.Random.cname(),
            type : Mock.Random.integer(0,1),
            status : Mock.Random.integer(0,1),
            mark : Mock.Random.cparagraph(2),
            create_time : Mock.Random.date('yyyy-MM-dd')
        }));
    }
    return systemParam
}


exports.roleData=function(){
    const roleData = [];
    for (let i = 0; i < 5; i++) {
        roleData.push(Mock.mock({
            id: Mock.Random.guid(),
            role: Mock.Random.name(),
            desc: Mock.Random.cname(),
            status : Mock.Random.integer(0,1),
            resources:[],
            create_time : Mock.Random.date('yyyy-MM-dd')
        }));
    }
    return roleData
}


exports.resourceData = function () {
    const resourceData = [];
    for (let i = 0; i < 3; i++) {
        let status = Mock.Random.integer(0, 1);
        resourceData.push(Mock.mock({
            id: Mock.Random.guid(),
            name: Mock.Random.cname(),
            uri: Mock.Random.domain(),
            request_types: 'GET',
            type: Mock.Random.integer(0, 1),
            status: status,
            lev: 1,
            parent_id: '',
            children: function () {
                const childrenData = [];
                for (let j = 0; j < Mock.Random.integer(3, 5, 7, 9); j++) {
                    status = Mock.Random.integer(0, 1);
                    childrenData.push(Mock.mock({
                        id: Mock.Random.guid(),
                        name: Mock.Random.cname(),
                        uri: Mock.Random.domain(),
                        request_types: 'GET',
                        type: Mock.Random.integer(0, 1),
                        status: status,
                        lev: 2,
                        parent_id: '',
                        children: function () {
                            const childrenData = [];
                            for (let j = 0; j < Mock.Random.integer(3, 5, 7, 9); j++) {
                                status = Mock.Random.integer(0, 1);
                                childrenData.push(Mock.mock({
                                    id: Mock.Random.guid(),
                                    name: Mock.Random.cname(),
                                    uri: Mock.Random.domain(),
                                    request_types: 'GET',
                                    type: Mock.Random.integer(0, 1),
                                    status: status,
                                    lev: 3,
                                    parent_id: '',
                                    children: [],
                                    code: 20000 + (j * 10),
                                    permission: "get",
                                    create_time: Mock.Random.date('yyyy-MM-dd')
                                }));
                            }
                            return childrenData
                        },
                        code: 20000 + (j * 10),
                        permission: "get",
                        create_time: Mock.Random.date('yyyy-MM-dd')
                    }));
                }
                return childrenData
            },
            code: 10000 + (i * 10),
            permission: "get",
            create_time: Mock.Random.date('yyyy-MM-dd')
        }));
    }
    return resourceData
}

exports.customerList=function(){
    const customer = [];

    for (let i = 0; i < 66; i++) {
        customer.push(Mock.mock({
            date: Mock.Random.date('yyyy-MM-dd'),
            name: Mock.Random.name(),
            phone: '/^1[0-9]{10}$/',
            email: Mock.Random.email(),
            account_money: Mock.Random.integer(100, 1000),
            all_inMoney: Mock.Random.integer(100, 1000),
            all_outMoney: Mock.Random.integer(100, 1000),
            earn:Mock.Random.integer(100, 1000),
            number:Mock.Random.integer(0, 100)
        }));
    }
    return customer
}
