/**
 * 服务端API请求地址
 * Created by zlp on 2018-01-13.
 */
const base_url = "http://10.202.1.34:8083/infx-api-member/";    //测试服务器
// const base_url = "http://172.31.38.211:8080/infx-api-member/";   //生产

//const base_url ="http://172.7.1.155:8080/";      //张宏伟
// const base_url ="http://172.7.1.27:8080/";       //吴朋
// const base_url = "http://172.7.0.204:8080/fx-api-member/";
// const base_url = "http://172.7.1.7:8080/";     //明星
// const base_url = "http://172.7.1.178:8080/";     //宋志涛
//const base_url = "http://172.7.1.127:8080/fx-api-member/";

const version = "api/v1/";

module.exports = {
    //请求方法

    request_types: {
        GET: 'get',
        POST: 'POST',
        PUT: 'PUT',
        DELETE: 'DELETE'
    },
    //<公共接口>
    common: {
        email_unique: base_url + "common/email_unique",             //验证email唯一性 get
        send_email_verify_code: base_url + "common/verify_code",    //获取验证码到邮箱 get
        get_rate: base_url + "common/rate",                         //获取汇率 get
        upload_img: base_url + "common/images",                     //上传图片 post
        get_img: base_url + "common/images/",                       //获取图片 get
        system_setting: base_url + version + "system_setting",      //获取系统参数 get

        rate_deposit: base_url+ "common/rate_deposit",      //获取入金汇率 get
        rate_withdraw: base_url  + "common/rate_withdraw",      //获取出金汇率 get
    },
    //@会员中心
    member: {
        //登录
        login: {
            signup_email: base_url + "login/customer/login/email",                                  //客户通过邮箱登录 put
            signup_mt4: base_url + "login/customer/login/mt4",                                      //客户通过MT4登录 put
            logout: base_url + "login/customer/logout",                                             //客户登出 put
            reset_pwd_email: base_url + version + "customer/password/reset_platform",               //通过邮箱修改密码 put
            reset_pwd_mt4: base_url + version + "customer/password/reset_mt4",                      //通过mt4账号修改密码 put
            password_retrieve: base_url + "register/customer/password/retrieve",                    //通过邮箱找回密码第一步，往指定邮箱发送找回链接 get
            password_check_reset_code: base_url + "register/customer/password/check_reset_code",    //通过邮箱找回密码第二步，验证重置码是否有效 put
            password_retrieve_reset: base_url + "register/customer/password/retrieve_reset",        //通过邮箱找回密码第二步，修改密码 put
        },

        //#注册管理
        reg: {
            register:base_url +"register/customer/reg/register",         // 改版后的接口  post
            acitve:base_url + "register/customer/reg",                   //激活账号传参id    GET
            account_submit:base_url + version +"customer/account"    //大表单提交 post
            /* step1: base_url + "register/customer/reg/step1",    //注册第一步 post
             step2: base_url + "register/customer/reg/step2",    //注册第一步 post
             step3: base_url + "register/customer/reg/step3",    //注册第二步 post*/
        },
        //开设账户
        real_account:{
            list:base_url + version + "customer/account/open_account_list",   // GET
            demo:base_url + version + "customer/account/demo_account_list",   // GET
            get: base_url + version + "customer/account/open_account/",
        },
        //#我的账户
        account: {
            //获取用户开户表单信息

            //用户开户确认信息
            confirm: base_url + version + "customer/account/confirm",
            //账户列表
            account_list: base_url + version + "customer/account",              //获取账户列表 get
            account_info: base_url + version + "customer/account/",             //获取账户详情 get
            //注册附加账号
            append_account: base_url + version + "customer/account",            //二次开户 post
            account_type: base_url + version + "customer/account/option_type",  //获取可选账户 get
            //修改杠杆
            update_leverage: base_url + version + "customer/account/leverage",  //修改账户杠杆比例 put
            //账户清零
            bal_clear: base_url + version + "customer/account/bal_clear",       //账户清零 put
        },
        //#资金交易
        transaction: {
            //账户入金
            tt_idr_deposit: base_url + version + "customer/deposit/tt_idr",         //电汇idr入金 put
            tt_deposit: base_url + version + "customer/deposit/tt",                 //电汇usd入金 put

            //账户出金
            tt_idr_withdraw: base_url + version + "customer/withdraw/tt_idr",     //电汇idr出金 put
            tt_withdraw: base_url + version + "customer/withdraw/tt",               //电汇usd出金 put
            fee_withdraw: base_url + version + "customer/withdraw/fee",             //获取出金手续费 get
            cancel_withdraw: base_url + version + "customer/withdraw/cancel",       //取消出金 put

            //返利转余额 new
            return_to_balance: base_url + version + "customer/withdraw/bal_reb",           //返利转余额 put
        },

        //#资金信息
        funds: {
            //资金记录
            funds_list: base_url + version + "customer/fund",                   //获取资金列表 get
            funds_info: base_url + version + "customer/fund/",                  //获取资金详情 get

            //出入金记录
            dep_draw_list: base_url + version + "customer/fund/dep_draw",       //获取出入金列表 get
            dep_draw_info: base_url + version + "customer/fund/dep_draw/",      //获取出入金详情 get
            dep_draw_cancel: base_url + version + "customer/withdraw/cancel",   //客户取消[待审核]订单
            //转账记录
            transfer_list: base_url + version + "customer/fund/transfer",       //获取转账列表 get
            transfer_info: base_url + version + "customer/fund/transfer/",      //获取转账详情 get

            //余额清零记录
            bal_clear_list: base_url + version + "customer/fund/bal_clear",     //获取资金清零列表 get
            bal_clear_info: base_url + version + "customer/fund/bal_clear/",    //获取资金清零详情 get

            //返利转余额记录 new
            return_to_balance_record_list: base_url + version + "customer/fund/bal_reb",  //转账列表 get
            return_to_balance_record_info: base_url + version + "customer/fund/bal_reb/", //转账详情 get
        },

        //#客户信息
        user: {
            //个人信息
            basic_info: base_url + version + "customer/info/basic",             //获取用户基本信息 get
            basic_update: base_url + version + "customer/info/basic",           //更改用户基本信息 put
            identity_info: base_url + version + "customer/info/identity",       //获取用户证件信息 get
            address_info: base_url + version + "customer/info/address",         //获取用户地址信息 get
            address_update: base_url + version + "customer/info/address",       //获取交易记录列表 put

            //电汇信息
            tt_list: base_url + version + "customer/info/tt",                   //获取用户电汇信息列表 get
            tt_update: base_url + version + "customer/info/tt",                 //更新用户电汇信息 put
            tt_add: base_url + version + "customer/info/tt",                    //添加用户电汇信息 post
            tt_delete: base_url + version + "customer/info/tt/",                //删除电汇信息 delete
            tt_info: base_url + version + "customer/info/tt/",                  //获取电汇信息 get

            //投资者信息
            investor_info: base_url + version + "customer/info/investor",       //获取投资者信息 get
            investor_update: base_url + version + "customer/info/investor",     //更新投资者信息 get

        },
        //#我的客户
        client: {
            //客户信息
            client_list: base_url + version + "customer/children",                  //客户列表 get
            client_info: base_url + version + "ib/customer/info/basic",             //客户列表详情 get
            account_info: base_url + version + "ib/customer/account_list/",          //账户信息 get
            depDraw_info: base_url + version + "ib/customer/fund/dep_draw_list/",    //出入金信息 get
            transfer_info: base_url + version + "ib/customer/fund/transfer_list/",   //转账信息 get
            trade_info: base_url + version + "ib/customer/fund/trade_list/",         //交易信息 get

        },
        //#我的佣金
        rebates: {
            //交易返佣明细
            trade_list: base_url + version + "customer/rebate_commission/commission",       //返佣列表 get
            //余额返利明细
            one_day: base_url + version + "customer/rebate_commission/rebate",              //按日返利列表 get
            balance_list: base_url + version + "customer/rebate_commission/rebate_detail"   //返利列表 get
        },
        //#开户链接
        invite: {
            invite: base_url + version + "customer/invite",         //生成邀请链接 get
        }


    },
    //@销售中心
    sale: {
        //销售登录
        login: {
            signup_email: base_url + "login/sale/login/email",
            logout: base_url + "login/sales/logout",
            reset_pwd_email: base_url + version + "sales/password/reset_platform",              //通过邮箱修改密码 put
            reset_pwd_mt4: base_url + version + "sale/password/reset_mt4",                      //通过mt4账号修改密码 put
            password_retrieve: base_url + "register/sale/password/retrieve",                    //通过邮箱找回密码第一步，往指定邮箱发送找回链接 get
            password_check_reset_code: base_url + "register/sale/password/check_reset_code",    //通过邮箱找回密码第二步，验证重置码是否有效 put
            password_retrieve_reset: base_url + "register/sale/password/retrieve_reset",        //通过邮箱找回密码第二步，修改密码 put
        },
        //#用户信息
        user: {
            info: base_url + version + "sales/info",                                //获取用户基本信息 get
            bindmt: base_url + version + "sales/bind",                              //绑定mt4账号 put
        },
        //#客户信息
        customer: {
            customer_list: base_url + version + "sales/customer",                   //获取客户列表 get
            basic_info: base_url + version + "sales/customer/info/basic",           //获取客户基本信息 get
            account_list: base_url + version + "sales/customer/account",            //获取客户账户列表
            dep_draw_list: base_url + version + "sales/customer/fund/dep_draw",     //获取客户出入金列表 get
            transfer_list: base_url + version + "sales/customer/fund/transfer",     //获取客户转账列表 get
            trade_list: base_url + version + "sales/customer/fund/trade",           //获取客户交易记录列表 get
            address_info: base_url + version + "sales/customer/info/address",       //获取客户地址信息 get
            identity_info: base_url + version + "sales/customer/info/identity" ,     //获取客户证件信息 get
            commission_list:base_url + version +"sales/customer/fund/commission",     //获取客户返佣信息 get
            rebate_list:base_url + version +"sales/customer/fund/rebate",            //获取客户返利信息 get
            rebate_detail:base_url + version +"sales/customer/fund/rebate_detail"    //获取客户返利详情 get
        },
        //#代理信息
        ib: {
            ib_list: base_url + version + "sales/ib",                           //获取代理列表 get
            basic_info: base_url + version + "sales/ib/info/basic",             //获取代理基本信息
            address_info: base_url + version + "sales/ib/info/address",         //获取代理地址信息 get
            identity_info: base_url + version + "sales/ib/info/identity",       //获取代理证件信息 get
            account_list: base_url + version + "sales/ib/account",              //获取代理账户列表
            dep_draw_list: base_url + version + "sales/ib/fund/dep_draw",       //获取代理出入金列表 get
            transfer_list: base_url + version + "sales/ib/fund/transfer",       //获取代理转账列表 get
            rebate_list: base_url + version + "sales/ib/fund/rebate",           //获取代理返利列表 get
            commission_list: base_url + version + "sales/ib/fund/commission"    //获取代理返佣列表 get

        },
        //#返佣返利信息
        rebate: {
            //返佣明细
            trade_list: base_url + version + "sales/fund/commission",       //获取返佣列表 get
            trade_info: base_url + version + "sales/fund/commission/",      //获取返佣明细 get
            //返利明细
            one_day_balance_list: base_url + version + "sales/fund/rebate/oneday",         //按天返回返利列表 get
            balance_list: base_url + version + "sales/fund/rebate/detail",         //获取返利列表 get
            balance_info: base_url + version + "sales/fund/rebate/",        //获取返利明细 get
        },
        //#提成信息
        bonus: {
            //提成列表
            list: base_url + version + "sales/fund/reward/oneday",              //销售提成列表 get
            info: base_url + version + "sales/fund/reward/detail",       //销售提成明细 get
            common_sale_reward_list_ecn:base_url + version +"sales/fund/common_sale_reward/list_ecn",//代理客户交易提成
            common_sale_reward_list_common:base_url + version +"sales/fund/common_sale_reward/list_common",//代理收益提成
            department_sale_reward_list_ecn:base_url + version +"sales/fund/department_sale_reward/list_ecn",//部门客户交易提成
            department_sale_reward_list_common:base_url + version +"sales/fund/department_sale_reward/list_common"//销售收益提成
        },

        //#邀请管理
        invite: {
            invite: base_url + version + "sales/invite",    //销售邀请
        },
        //# 津贴管理
        allowwance:{
            list: base_url + version +"sales/fund/allowance/month" , //津贴列表  get
            info: base_url + version +"sales/fund/allowance/daily",   //津贴列表详情 get
        },
    },
    //@代理中心
    ib: {
        //销售登录
        login: {
            signup_email: base_url + "login/ib/login/email",
            logout: base_url + "login/ib/logout",
            reset_pwd_email: base_url + version + "ib/password/reset_platform",                //通过邮箱修改密码 put
            reset_pwd_mt4: base_url + version + "ib/password/reset_mt4",                      //通过mt4账号修改密码 put
            password_retrieve: base_url + "register/ib/password/retrieve",                    //通过邮箱找回密码第一步，往指定邮箱发送找回链接 get
            password_check_reset_code: base_url + "register/ib/password/check_reset_code",    //通过邮箱找回密码第二步，验证重置码是否有效 put
            password_retrieve_reset: base_url + "register/ib/password/retrieve_reset",        //通过邮箱找回密码第二步，修改密码 put
        },
        //#代理注册
        reg: {
            signup: base_url + "register/ib/reg/signup",            //提交登记信息 post
            signup_info: base_url + 'register/ib/reg/signup',       //通过ID获取登记信息 get
            step1: base_url + "register/ib/reg/step1",              //提交注册第一步 post
            step2: base_url + "register/ib/reg/step2",              //提交注册第二步 post
        },
        //#我的账户
        account: {
            //账户摘要
            account_list: base_url + version + "ib/account",                //获取账户列表 get
            account_info: base_url + version + "ib/account/",               //获取账户详情 get
            //创建同名账号
            append_account: base_url + version + "ib/account",              //二次开户 post
            account_type: base_url + version + "ib/account/option_type",    //获取可选账户 get
            //个人资料
            basic_info: base_url + version + "ib/info/basic",               //获取个人资料-基本信息 get
            identity_info: base_url + version + "ib/info/identity",         //获取个人资料-证件信息 get
            address_info: base_url + version + "ib/info/address",           //获取个人资料-地址信息 get
            bankcard_info: base_url + version + "ib/info/bankcard",         //获取个人资料-银行卡信息 get
            tt_info: base_url + version + "ib/info/tt",                     //获取个人资料-电汇信息 get

            basic_update: base_url + version + "ib/info/basic",             //更新个人资料-基本信息 put
            address_update: base_url + version + "ib/info/address",         //更新个人资料-地址信息 put
            bankcard_add: base_url + version + "ib/info/bankcard",          //更新个人资料-银行卡信息 post
            bankcard_update: base_url + version + "ib/info/bankcard/",      //更新个人资料-银行卡信息 put
            bankcard_delete: base_url + version + "ib/info/bankcard",       //更新个人资料-银行卡信息 delete
            tt_add: base_url + version + "ib/info/tt",                      //更新个人资料-电汇信息 post
            tt_update: base_url + version + "ib/info/tt",                   //更新个人资料-电汇信息 put

        },
        //#我的资金
        funds: {
            //出金
            bankcard_withdraw: base_url + version + "ib/withdraw/bankcard",         //银行卡出金 put
            tt_withdraw: base_url + version + "ib/withdraw/tt",                     //电汇出金 put
            fee_withdraw: base_url + version + "ib/withdraw/fee",                   //获取出金手续费 get
            cancel_withdraw: base_url + version + "ib/withdraw/cancel",             //取消出金 put
            //同名账户转账
            transfer: base_url + version + "ib/transfer",                           //转账 put
            cancel_transfer: base_url + version + "ib/transfer/cancel",             //转账取消 put
            //返利转余额
            return_to_balance: base_url + version + "ib/account/bal_reb",           //转账 put
            //资金记录
            funds_list: base_url + version + "ib/fund",                             //获取资金列表 get
            funds_info: base_url + version + "ib/fund/",                            //获取资金详情 get
            //出金记录 withdraw_record
            withdraw_record_list: base_url + version + "ib/fund/dep_draw",          //出金列表 get
            withdraw_record_info: base_url + version + "ib/fund/dep_draw/",         //出金详情 get
            //转账记录
            transfer_record_list: base_url + version + "ib/fund/transfer",          //转账列表 get
            transfer_record_info: base_url + version + "ib/fund/transfer/",         //转账详情 get
            //返利转余额记录 return_to_balance_record
            return_to_balance_record_list: base_url + version + "ib/fund/bal_reb",  //转账列表 get
            return_to_balance_record_info: base_url + version + "ib/fund/bal_reb/", //转账详情 get
        },
        //#我的客户
        client: {
            //客户信息
            client_list: base_url + version + "ib/customer/",                       //客户信息 get
            client_info: base_url + version + "ib/customer/info/basic",             //客户列表详情 get
            account_info: base_url + version + "ib/customer/account_list/",          //账户信息 get
            depDraw_info: base_url + version + "ib/customer/fund/dep_draw_list/",    //出入金信息 get
            transfer_info: base_url + version + "ib/customer/fund/transfer_list/",   //转账信息 get
            trade_info: base_url + version + "ib/customer/fund/trade_list/",         //交易信息 get

        },
        //#我的佣金
        rebates: {
            //交易返佣明细
            trade_list: base_url + version + "ib/fund/commission",          //返佣列表 get
            //余额返利明细
            one_day: base_url + version + "ib/fund/rebate/oneday",           //按日返利列表 get
            balance_list: base_url + version + "ib/fund/rebate/detail",     //返利列表 get
            balance_info: base_url + version + "ib/fund/rebate/",           //返利详情 get
        },
        //#客户交易数据   TODO： 暂时空着
        // client: {
        //历史交易
        // client_list: base_url + version + "ib/customer",                //客户信息 get
        //持仓交易
        // client_info: base_url + version + "ib/customer/info/basic",     //客户列表详情 get
        // },
        //#开户链接
        invite: {
            invite: base_url + version + "ib/invite",           //生成邀请链接 get
        }
    }
}

