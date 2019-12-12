/*
 * 模拟网页中所有的下拉列表select
 */
function selectModeld() {
//	debugger;
    var $box = $('div.model-select-box');
    var $option = $('ul.model-select-option', $box);
    var $txt = $('div.model-select-img', $box);
    var choose=$("#chooseUser").val();
    var speed = 100;
    
   
     /*
     * 单击图标，显示当前下拉列表的下拉列表框
     * 并隐藏页面中其他下拉列表
     */
    $txt.click(function(e) {
    	if(null==choose||""==choose||undefined==choose){
    		return;
    	}
    	
        $option.not($(this).siblings('ul.model-select-option')).slideUp(speed, function() {
            int($(this));
        });
        $(this).siblings('ul.model-select-option').slideToggle(speed, function() {
            int($(this));
        });
        return false;
    });
    /*
     * 为每个下拉列表框中的选项设置默认选中标识 data-selected
     * 点击下拉列表框中的选项时，将选项的 data-option 属性的属性值赋给下拉列表的 data-value 属性，并改变默认选中标识 data-selected
     * 为选项添加 mouseover 事件
     */
    $option.find('li')
        .each(function(index, element) {
            if ($(this).hasClass('seleced')) {
                $(this).addClass('data-selected');
            }
        })
        .mousedown(function() {
            //赋值操作
            $(this).parent().siblings('div.model-select-text').text($(this).text())
                .attr('data-value', $(this).attr('data-option'));
            //为input赋值
            $option.slideUp(speed, function() {
                int($(this));
            });
            $(this).addClass('seleced data-selected').siblings('li').removeClass('seleced data-selected');
            
            $("#chooseUser").val($(this).text());
            $('#pageNum').val(0);
//    		document.recordFrom.submit();
    		
            return false;
        })
        .mouseover(function() {
            $(this).addClass('seleced').siblings('li').removeClass('seleced');
        });
    //点击文档，隐藏所有下拉
    $(document).click(function(e) {
        $option.slideUp(speed, function() {
            int($(this));
        });
    });
    //初始化默认选择
    function int(obj) {
        obj.find('li.data-selected').addClass('seleced').siblings('li').removeClass('seleced');
    }
}

//翻页
function go(pageNum){
//	debugger
	$('#pageNum').val(pageNum);
	var p_status=$("#order_status").val();
	var p_type=$("#order_type").val();
	$("#typeval").val(p_type);
	$("#statusval").val(p_status);
	$('#recordFrom').submit();
}
var str;
$(document).ready(function(){
	
	selectModeld();
	$("#btn_submit").click(function(){
//		debugger
		var p_no=$("#pageNum").val();
		var p_status=$("#order_status").val();
		var p_type=$("#order_type").val();
		$("#typeval").val(p_type);
		$("#statusval").val(p_status);
		$('#pageNum').val(0);
		$('#recordFrom').submit();
	});
});

function changegold(id,_this){
	if(confirm(fundsLangres.canceltransferapply_apply)){
		var data ={idval:id};
		$.ajax({
			url :"funds/changetransferapply.html", 
			async :false,
			data:data,
			dataType:"json",
			success:function(data){
				if(null != data.MSG && "" != data.MSG && undefined != data.MSG){
					alert(data.MSG);
				}
				location.reload();
			},
			error:function(jqXHR, textStatus, errorThrown){location.reload();}
		});
	}
}