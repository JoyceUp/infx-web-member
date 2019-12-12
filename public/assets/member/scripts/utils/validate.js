//var emailReg = /^[a-zA-Z0-9]+([._\\-]*[a-zA-Z0-9])*@([a-zA-Z0-9]+[-a-zA-Z0-9]*[a-zA-Z0-9]+.){1,63}[a-zA-Z0-9]+$/;
var emailReg =/^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
var mtReg = /^[0-9]{6,12}$/;
var mobileReg = /^1[3|4|5|6|7|8|9][0-9]{9}$/;
var passwordReg=/^(?![^a-zA-Z]+$)(?!\D+$)(?![_]*$).{6,18}$/;   //|(?![^a-zA-Z]+$)(?!\D+$).{6,18}
// var passwordErrorMsg = "{{ Lang.validate_password_format_error }}密码格式错误，6-18位数字字母组合，可包含下划线";
var errorNum = 0;
var captchaNum = 2;
var numberReg =/^[0-9]*$/;
var numLetterReg=/^[A-Za-z0-9]+$/;

/*
根据〖中华人民共和国国家标准 GB 11643-1999〗中有关公民身份号码的规定，公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
    地址码表示编码对象常住户口所在县(市、旗、区)的行政区划代码。
    出生日期码表示编码对象出生的年、月、日，其中年份用四位数字表示，年、月、日之间不用分隔符。
    顺序码表示同一地址码所标识的区域范围内，对同年、月、日出生的人员编定的顺序号。顺序码的奇数分给男性，偶数分给女性。
    校验码是根据前面十七位数字码，按照ISO 7064:1983.MOD 11-2校验码计算出来的检验码。

出生日期计算方法。
    15位的身份证编码首先把出生年扩展为4位，简单的就是增加一个19或18,这样就包含了所有1800-1999年出生的人;
    2000年后出生的肯定都是18位的了没有这个烦恼，至于1800年前出生的,那啥那时应该还没身份证号这个东东，⊙﹏⊙b汗...
下面是正则表达式:
 出生日期1800-2099  (18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])
 身份证正则表达式 /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i
 15位校验规则 6位地址编码+6位出生日期+3位顺序号
 18位校验规则 6位地址编码+8位出生日期+3位顺序号+1位校验位

 校验位规则     公式:∑(ai×Wi)(mod 11)……………………………………(1)
                公式(1)中：
                i----表示号码字符从由至左包括校验码在内的位置序号；
                ai----表示第i位置上的号码字符值；
                Wi----示第i位置上的加权因子，其数值依据公式Wi=2^(n-1）(mod 11)计算得出。
                i 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
                Wi 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2 1

*/
//身份证号合法性验证
//支持15位和18位身份证号
//支持地址编码、出生日期、校验位验证
function isIdentity(type, value) {
    console.log(type,value)
    var identityType = type;
    if (identityType == 1) {
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        var tip = "";
        var pass= true;

        if(!value || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$/.test(value)){
            return validate_is_identity_err;//身份证号格式错误
        }else if(!city[value.substr(0,2)]){
            return validate_is_identity_zip;//地址编码错误
        }else if(value.substr(0, 6) == 330381) {
            return validate_is_identity_no_reg;//该证件地区禁止注册
        } else if(!checkBirthday(value)) {
            return validate_is_identity_no_age;//18岁以下用户禁止注册
        }else{
            //18位身份证需要验证最后一位校验位
            if(value.length == 18){
                value = value.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parityX = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = value[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var lastX = parityX[sum % 11];
                if(lastX != value[17].toUpperCase()){
                    return validate_is_identity_fail;//身份证校验失败
                }
            }
        }
    } else {
        if (value.trim().length == 0) {
            return validate_is_identity_null;//证件号码不能为空
        }
        var re = new RegExp("(^([PSE]{1}\\d{7}|[GS]{1}\\d{8}|[a-zA-Z0-9]{5,17})$)");//E字打头的后面不知道要跟几位,因私护照是八个数字加一个字母,因公护照是七个数字加一个字母
        var card = value.toUpperCase();
        if(!re.test(card)){
            return validate_is_identity_passport_err;//请输入正确的护照号
        }
    }

    return true;
}

//验证身份证的年龄
function checkBirthday(obj) {

    var len = obj.length;
    //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
    if (len == '15') {
        var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
        var arr_data = obj.match(re_fifteen);
        var year = arr_data[2];
        var month = arr_data[3];
        var day = arr_data[4];
        var birthday = new Date('19' + year + '/' + month + '/' + day);


        return verifyBirthday('19' + year, month, day, birthday);
    }
    //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
    if (len == '18') {
        var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|[Xx])$/;
        var arr_data = obj.match(re_eighteen);
        var year = arr_data[2];
        var month = arr_data[3];
        var day = arr_data[4];
        var birthday = new Date(year + '/' + month + '/' + day);


        return verifyBirthday(year, month, day, birthday);
    }
    // return false;
    return true
}

function verifyBirthday(year, month, day, birthday) {

    var now = new Date();
    var now_year = now.getFullYear();

    //年月日是否合理
    if (birthday.getFullYear() == year && (birthday.getMonth() + 1) == month && birthday.getDate() == day) {
        //判断年份的范围（年龄小于18岁（等于18岁可以注册）也不允许注册，提示“18岁以下用户禁止注册)
        var time = now_year - year;
        if (time >= 18) {
            return true;
        }
        return false;
    }
    return false;
}

function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

$(function () {
    $("#captcha-item").hide()
})

//验证码


function setCaptcha(path) {
    if (errorNum < captchaNum) {
        errorNum++
    } else {
        errorNum++
        $("#captcha-item img").click();
        $("#captcha-item").show();
        addCookie("captcha_show", 1, 0, path);
    }
}

function checkCaptcha(formData) {
    $.ajax({
        type: "post",
        url: "/common/captcha/check",
        data: {code: formData.captcha},
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.status != 200) {
                setCaptcha()
                layer.msg(validate_captcha_err, {icon: 2, time: 500})//验证码错误
            } else {
                signup(formData)
            }
        }
    });
}

/**
 *         * 检查字符串是否为合法手机号码         * @param {String} 字符串
 *         * @return {bool} 是否为合法手机号码         
 */
function isPhone(aPhone) {
    var bValidate = RegExp(
        /^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$/)
        .test(aPhone);
    if (bValidate) {
        return true;
    } else
        return false;
}