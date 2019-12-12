/**
 * Created by Administrator on 2016/5/27.
 */
$(function(){
    if(navigator .userAgent.indexOf("MSIE")> 0 && navigator.userAgent.indexOf("MSIE 9.0")>0){
        $('.section3 .section-img1,.section3 .section-img2').css({
            'left':'-20px',
            '-webkit-transform':'scale(1)',
            '-moz-transform':'scale(1)',
            '-ms-transform':'scale(1)',
            'transform':'scale(1)'});
        $('.section4 .sect4-img').css({
            '-webkit-transform':'scale(1)',
            '-moz-transform':'scale(1)',
            '-ms-transform':'scale(1)',
            'transform':'scale(1)',
            'background-size':'100%'});
        $('.section5 .sect5-img').css({'top':'0px'});


    }
    $('#dowebok').fullpage({
        verticalCentered: false,    //是否垂直居中
        sectionsColor:['#fff','#fff','#f1f1f1','#131b1e','#f1f1f1','#020210','#3b3d40'],     // 设置section的背景颜色
//            anchors:['pag1','pag2','pag3','pag4'],
        controlArrows: false,   //幻灯片的左右箭头
        slidesNavigation: true,
        //autoScrolling: true,   //false是按浏览器滚动条方式滚动
        //scrollBar: true,        //右侧滚动条
//            paddingTop:'80px',      //设置每一个section顶部和底的padding, paddingtop/paddingBottom
        fixedElements: '.header',   //设置的完素固定不动
        //continuousVertical: true,  //是否循环滚动
        animateAnchor:true,     //锚链接是否可以控制滚动动画
        loopHorizontal:true,
        slidesNavPosition: 'top',
        //scrollOverflow: true,
        css3: true,
        afterLoad: function(link,index){
            if(navigator .userAgent.indexOf("MSIE")> 0 && navigator.userAgent. indexOf ("MSIE 9.0")>0){
                return;
            }else{
                switch (index){
                    case 3:
                        move('.section3 .section-img1').scale(1).set('left','-20px').duration('1s').end();
                        move('.section3 .section-img2').scale(1).set('left','-20px').delay('.2s').duration('1s').end();
                        break;
                    case 4:
                        move('.section4 .sect4-img').scale(1).set('left','0px').ease('in-out').end();
                        break;
                    case 5:
                        move('.section5 .sect5-img').set('top','0px').ease('in-out').end();
                        break;
                    default :
                        break;
                }
            }

        },
        onLeave: function(index,nextIndex,direction){
            if(navigator .userAgent.indexOf("MSIE")> 0 && navigator.userAgent. indexOf ("MSIE 9.0")>0){
                return;
            }else{
                switch (index){
                    case 3:
                        move('.section3 .section-img1').scale(0.7).set('left','-900px').duration('1s').end();
                        move('.section3 .section-img2').scale(0.7).set('left','-1500px').delay('.2s').duration('1s').end();
                        break;
                    case 4:
                        move('.section4 .sect4-img').scale(1.1).ease('in-out').end();
                        break;
                    case 5:
                        move('.section5 .sect5-img').set('top','-20px').ease('in-out').end();
                        break;
                    default :
                        break;
                }
            }
        }

    });

    setInterval(function(){
        $.fn.fullpage.moveSlideRight();
    }, 4000);

    //banner
    /*$("#banner").kinMaxShow({
        height: $('#banner').height()-60,
        button:{
            showIndex:false,
            normal:{background:'url(images/banner-button.png) no-repeat -14px 0',border:'0',left:'46%',bottom:'5%'},
            focus:{background:'url(images/banner-button.png) no-repeat 0 0',border:'0'}
        }
    });*/
});
$(window).resize(function(){
    location.reload();
});