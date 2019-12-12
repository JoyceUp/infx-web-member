
module.exports = {
    toServer: function (amount) {
        var m=0,s1=amount.toString(),s2="100".toString();
        try{m+=s1.split(".")[1].length}catch(e){}
        try{m+=s2.split(".")[1].length}catch(e){}
        return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
    }
};
