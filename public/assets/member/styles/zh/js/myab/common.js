
	
$(function(){
	
	$('.btn').on('click',function(){
		
		//$(this).css({'color':'#fff'});
		
	});

	$('.label-tit li').on('click',function(){

		$(this).addClass('act').siblings().removeClass('act');
		var index=$(this).index();
		$('.con-fund').eq(index).addClass('con-show').siblings().removeClass('con-show');
		$('.tab-item').eq(index).addClass('item-show').siblings().removeClass('item-show');
	});
	
	

	//弹框
	
	//账户余额返利
	$('.zhye').on('click',function(){
		
		$('.yefl-box').show();
		$('.zhezhao').show();
		
	});
	
	$('.ye-close').on('click',function(){
		
		$('.yefl-box').hide();
		$('.zhezhao').hide();
		
	});
	
	//交易返利
	
	$('.jy').on('click',function(){
		
		$('.jyfl-box').show();
		$('.zhezhao').show();
		
	});
	
	$('.jy-close').on('click',function(){
		
		$('.jyfl-box').hide();
		$('.zhezhao').hide();
		
	});
	
	//层级返利
	
	$('.cj').on('click',function(){
		
		$('.cjfl-box').show();
		$('.zhezhao').show();
		
	});
	
	$('.cj-close').on('click',function(){
		
		$('.cjfl-box').hide();
		$('.zhezhao').hide();
		
	});
	
	//修改杠杆弹框
	
	$('.btn-gg').on('click',function(){
		
		$('.revisegg-box').show();
		$('.zhezhao').show();
		
	});
	
	$('.btn-close1').on('click',function(){
		
		$('.revisegg-box').hide();
		$('.zhezhao').hide();
		
	});
	
	//开通账号弹框
	
	$('.btn-open').on('click',function(){
		
		$('.alert-open').show();
		$('.zhezhao').show();
		
	});
	
	$('.btn-close2').on('click',function(){
		
		$('.alert-open').hide();
		$('.zhezhao').hide();
		
	});
	
	
	//提款成功弹框
	
	$('.btn-tixian').on('click',function(){
		
		$('.tixian-box').show();
		$('.zhezhao').show();
		
	});
	
	$('.btn-close3').on('click',function(){
		
		$('.tixian-box').hide();
		$('.zhezhao').hide();
		
	});
	
	
	$('.nav2').on('click',function(){
		
		$(this).children('.menu3').slideToggle(200);
		$('.nav2 span').toggleClass('open');
		
	})
	
	$('.menu2 li').on('click',function(){
		
		$(this).addClass('act1').siblings().removeClass('act1');
		
	});
	
	//删除银行卡 弹窗
	
	$('.btn-del').on('click',function(){
		
		$('.del-card').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-card').hide();
		$('.zhezhao').hide();
		
	});
	
	
	//绑定新手机 弹窗
	
	$('.btn-radd').on('click',function(){
		
		$('.del-radd').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-radd').hide();
		$('.zhezhao').hide();
		
	});
	
	//手机号码修改 弹窗
	
	$('.btn-revj').on('click',function(){
		
		$('.del-revj').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-revj').hide();
		$('.zhezhao').hide();
		
	});
	
	//删除手机号 弹窗
	
	$('.btn-del2').on('click',function(){
		
		$('.del-tel').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-tel').hide();
		$('.zhezhao').hide();
		
	});
	
	//绑定新邮箱 弹窗
	
	$('.btn-mail01').on('click',function(){
		
		$('.del-mail01').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-mail01').hide();
		$('.zhezhao').hide();
		
	});
	
	//邮箱修改 弹窗
	
	$('.btn-mail02').on('click',function(){
		
		$('.del-mail02').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-mail02').hide();
		$('.zhezhao').hide();
		
	});
	
	//删除邮箱 弹窗
	
	$('.btn-mail03').on('click',function(){
		
		$('.del-mail03').show();
		$('.zhezhao').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-mail03').hide();
		$('.zhezhao').hide();
		
	});
	
		//消息提醒   弹窗
	
	$('.btn-del').on('click',function(){
		
		$('.del-card').show();
		$('.warn-zhe').show();
		
	})
	
	$('.btn-close').on('click',function(){
		
		$('.del-card').hide();
		$('.warn-zhe').hide();
		
	});
	
	
	
	
	
	/*20170922yangxia*/
	
	
	//顶部  中文菜单切换
	
	$('.top-menu li.lan span').on('click',function(){
		
		$(this).siblings('div').slideToggle(200);
		$(this).children('i').toggleClass('on');
		
	});
	
	$('.login-right .lan-con span').on('click',function(){
		
		$(this).siblings('div').slideToggle(200);
		$(this).children('i').toggleClass('up');
		
	});
	
	
	//顶部二维码显示
	
	$('.top-menu li.app-download span').hover(function(){
		
		$(this).siblings('div').slideDown(200);
		
	},function(){
		
		$(this).siblings('div').slideUp(200);
		
	});
	
	//重置密码 steps
	
	function step1(){
		
		$('.steps li.num1').on('click',function(){
    		
    		$('.progress-bar1').removeClass('progress2');
    		$('.progress-bar1').removeClass('progress3');
    		
    	});
    	
    	$('.steps li.num2').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress2').removeClass('progress3');
    		
    	});
    	
    	$('.steps li.num3').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress3').removeClass('progress2');
    		
    	});
    	
    	$('.steps li.num11').on('click',function(){
    		
    		$('.progress-bar2').removeClass('progress2');
    		$('.progress-bar2').removeClass('progress3');
    		
    	});
    	
    	$('.steps li.num22').on('click',function(){
    		
    		$('.progress-bar2').addClass('progress2').removeClass('progress3');
    		
    	});
    	
    	$('.steps li.num33').on('click',function(){
    		
    		$('.progress-bar2').addClass('progress3').removeClass('progress2');
    		
    	});
    	
    	$('.next1').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress2').removeClass('progress3');
    		$('.num2').addClass('active').siblings().removeClass('active');
    		
    	});
    	
    	$('.next2').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress3').removeClass('progress2');
    		$('.num3').addClass('active').siblings().removeClass('active');
    		
    	});
    	
    	$('.prev1').on('click',function(){
    		
    		$('.progress-bar1').removeClass('progress2');
    		$('.num1').addClass('active').siblings().removeClass('active');
    		
    	});
    	
    	$('.next11').on('click',function(){
    		
    		$('.progress-bar2').addClass('progress2').removeClass('progress3');
    		$('.num22').addClass('active').siblings().removeClass('active');
    		
    	});
    	
    	$('.next22').on('click',function(){
    		
    		$('.progress-bar2').addClass('progress3').removeClass('progress2');
    		$('.num33').addClass('active').siblings().removeClass('active');
    		
    	});
    	
    	$('.prev11').on('click',function(){
    		
    		$('.progress-bar2').removeClass('progress2');
    		$('.num11').addClass('active').siblings().removeClass('active');
    		
    	});
    	
    	
		
	};
	
	step1();
	
	// 开通稳盈账号 steps
	
	function step2(){
    	
    	$('.steps li.num-a1').on('click',function(){
    		
    		$('.progress-bar1').removeClass('progress22');
    		$('.progress-bar1').removeClass('progress33');
    		$('.progress-bar1').removeClass('progress44');
    		
    	});
    	
    	$('.steps li.num-a2').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress22').removeClass('progress33');
    		$('.progress-bar1').addClass('progress22').removeClass('progress44');
    		
    	});
    	
    	$('.steps li.num-a3').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress33').removeClass('progress44');
    		
    	});
    	
    	$('.steps li.num-a4').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress44').removeClass('progress33');
    		
    	});
    	
    	$('.nt1').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress22').removeClass('progress33');
    		$('.num-a2').addClass('active');
    		$('.num-a1').removeClass('active');
    		
    	});
    	
    	$('.nt2').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress33').removeClass('progress44');
    		$('.num-a3').addClass('active');
    		$('.num-a2').removeClass('active');
    		
    	});
    	
    	$('.nt3').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress44').removeClass('progress33');
    		$('.num-a4').addClass('active');
    		$('.num-a3').removeClass('active');
    		
    	});
    	
    	$('.pr2').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress11').removeClass('progress22');
    		$('.num-a1').addClass('active');
    		$('.num-a2').removeClass('active');
    		
    	});
    	
    	$('.pr3').on('click',function(){
    		
    		$('.progress-bar1').addClass('progress22').removeClass('progress33');
    		$('.num-a2').addClass('active');
    		$('.num-a3').removeClass('active');
    		
    	});
    	
	};
	
	step2();
	
	
	
	
	
	
	
	
	
	
	
	
})
	
