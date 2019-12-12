<div style="position:absolute;top:30px;right:40px; z-index:50" id="parent">
    <select  id="langSel" class="langCSS" >
      {#  <option value="zh" >中文</option>#}
        <option value="en">English</option>
        <option value="ind">IDN</option>
    </select>
</div>
<script type="text/javascript">
//
    var urlPath = window.location.href
    var basePath = window.location.href.split("?")[0]+"?";

    if(getQueryString("no")){
        basePath=basePath+"no="+getQueryString("no")+"&"

    }
    if(lang == zh){
        $("#langSel").find("option[value='zh']").attr("selected",true);
    }else if(lang == en){
        $('#langSel').find("option[value='en']").attr("selected",true);
    }else if(lang == ind){
        $('#langSel').find("option[value='ind']").attr("selected",true);
    }else{
        $('#langSel').find("option[value='zh']").attr("selected",true);
    }
    $("#langSel").change( function(){
        var language = $("#langSel").val();
        if(language == zh){
            window.location.href = basePath + "clang=" + zh;
            addCookie(ulang, zh, twoday, cookiepath)
        }else if(language == en){
            window.location.href = basePath + "clang=" + en;
            addCookie(ulang, en, twoday, cookiepath)
        }else if(language == ind){
            window.location.href = basePath + "clang=" + ind;
            addCookie(ulang, ind, twoday, cookiepath)
        }else{
            window.location.href = basePath
        }
    });
</script>

{% block css_assets %}
{# 引入css #}
<style>
    #parent {
        background: url('yourimage') no-repeat;
        height: 30px;
        overflow: hidden;
    }

    #parent select {
        background: transparent;
        border: 1px solid #999;
        padding-left: 10px;
        height: 100%;
        width: 100px;
        color:#999

    }
</style>
{% endblock %}