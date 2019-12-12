/**
 * Created by Administrator on 2016/5/27.
 */
$(function(){
    //头部菜单
    $(".header-list").click(function(){
        $(".warp-nav").slideDown("slow");
    });
    $(".close").click(function(){
        $(".warp-nav").slideUp("slow");
    });

    //头部语言
    $('.header-language').mouseover(function(){
        $('.language-title').addClass('none');
        $('.language').removeClass('none');
    }).mouseleave(function(){
        $('.language-title').removeClass('none');
        $('.language').addClass('none');
    });

    $('.language span').click(function(){
        $('.language span').removeClass('language-cur').eq($(this).index()).addClass('language-cur');
        $('.language-title').html($(this).html());
    });

});
