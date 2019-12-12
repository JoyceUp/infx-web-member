# woniu-admin





UI框架
http://www.layui.com/
模板引擎模板引擎
https://www.jianshu.com/p/f0bffc42c1ce

API接口
http://172.7.0.204:8080/fx-api-member/swagger-ui.html#!/

原型

前台：
客户中心：https://7mct0u.axshare.com/

客户中心2: https://g5w7cp.axshare.com

销售中心：https://zkoq7w.axshare.com/


开户：https://7mct0u.axshare.com


后台：
客服：https://daxf21.axshare.com
资金岗：https://g3hil9.axshare.com
系统设置：https://1iyjqt.axshare.com
财务报表：https://93az5t.axshare.com





入金的订单状态有：      未支付：1，待处理：2，已支付：3，已完成：4
出金的订单状态有：      待处理：11，处理中：12，已忽略：13，已退回：14，取消中：15，同意取消：16，拒绝取消：17
其他订单的状态有：      待处理：101，处理中：102，已完成：103，已经同意，但是操作失败（比如：余额清零时，往MT4打款失败）：104，已拒绝：105，已取消：106


入金的渠道：  银行卡：1，微信支付：2，支付宝：3，电汇：4，线下充值：5，转账：6，余额清零：7，交易返佣：8，返利转入余额：9
出金的渠道： 银行卡：101，电汇：102，转账：103


前端接口规范
银行卡页面举例
页面(get)：url:"/member/user/bankinfo"
router.get("/user/bankinfo",user.bankInfo.page);

列表(post)：member/user/bankinfo/list
router.post("/user/bankinfo/list",user.bankInfo.list);

ID查询单个(post)：member/user/bankinfo/info
router.post("/user/bankinfo/info",user.bankInfo.info);

添加(post)：member/user/bankinfo/add
router.post("/user/bankinfo/add",user.bankInfo.add);

删除(post)：member/user/bankinfo/del
router.post("/user/bankinfo/del",user.bankInfo.del);

修改(post)：member/user/bankinfo/update
router.post("/user/bankinfo/update",user.bankInfo.update);


举例：controller中的user.js

//方法名字用驼峰
exports.workInfo = {
    page: function(req, res){
        res.render()
    },
    list: function(req, res){
        res.json()
    }
     ....
};

exports.bankInfo = {
    page: function(req, res){
        res.render()
    },
    list: function(req, res){
        res.json()
    }
     ....
};



## 搭建开发环境

统一用yarn来管理第三方依赖

1. yarn start 启动项目
2. 发现package.json有变化的时候，执行yarn install
3. 更新下来，将nodemon.default.json copy 一份，更名为 nodemon.json 系统执行依赖于nodemon.json，这样做的目的是防止配制文件互相影响。
其中文件中的配置项execMap 对应的命令需要根据node的版本做修改。如果自己电脑的node 版本为8以上则将--debug 两个都修改为--inspect。否则不用修改。
4. mocha or mocha **.js执行单元测试


## 接口约定(已确定)

接口返回格式统一为对象，格式如下：

{
    status:Number
    msg:String
    datas:{}
}

status
    200;  //  成功
    401;  // 表示用户没有权限（令牌、用户名、密码错误）。
    403;  // 表示用户得到授权（与401错误相对），但是访问是被禁止的。
    404;  // 表示用户得到授权（与401错误相对），但是访问是被禁止的。
    505;  // 服务端未知错误
    510;  // 参数验证不通过
    511;  // 传递的json格式有误
    512;  // 结果错误

自定义状态
    0; // 状态：生效
    1; // 状态：未生效