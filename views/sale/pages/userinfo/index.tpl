{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}
    <style>
        .user_info div{
            margin-top: 16px;
        }
        .user_info div .second_span{
            margin-top: 100px;
        }
        .position_info div{
            margin-top: 10px;
        }

        .info-attr-name {
            width: 20%; display:inline-block;text-align:right;padding-right:10px
        }
        .position-attr-name {
             display:inline-block;text-align:right;padding-right:10px
        }
        .position-attr-name,
        .info-attr-name{
            width: 35%;
        }
        .detail_page_Info{
            padding: 30px;
        }
    </style>
{% endblock %}
{% set sale_setting = Lang.select.sale %}
{% block js_assets %}
<script>
    {#var identity_type = new Object();#}
    {#{% for at in Lang.select.sale.identity_type %}#}
        {#identity_type[{{ at.value }}] = "{{ at.label }}";#}
    {#{% endfor %}#}

    {#var gender = new Object();#}
    {#{% for at in Lang.select.sale.gender %}#}
    {#gender[{{ at.value }}] ="{{ at.label }}";#}
    {#{% endfor %}#}

    {#兼职不显示职位信息#}
    if(window.user.sales_state == 3){
        $("#departmentInfo").hide();
    }else{
        $("#departmentInfo").show();
    }


    $('#bind').on('click',function(){
        layer.open({
            type: 1,
            title:'绑定MT4账号',
            area: ["400px", "auto"],
            content: $('#detail'),

        });
    });
    $('#mt4bind').on('click',function(){
        var mt4 = $('.mt4-id').val();
        if(mt4){
            $.ajax({
                url: "/sale/bind",
                data: {account_no: mt4},
                type: "put",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success: function (data) {
                    if (data.status == 200) {
                        layer.open({
                            content:"绑定MT4账号成功！",
                            yes: function(index,layero){
                                location.reload();
                                $('.mt4-id').val("");
                            }
                        });
                    }else{
                        layer.open({
                            content: data.msg + '开户证件号或姓名不一致，不能绑定！',
                            success: function(layero, index){
                                $('.mt4-id').val("");
                            }
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }
    });
    $('#unbind').on('click',function(){
        var mt4 = $('.mt4_account_no').text();
        layer.open({
            content: '确认解除绑定MT4账号？',
            yes: function(index, layero){
                if(mt4){
                    $.ajax({
                        url: "/sale/bind",
                        data: {account_no: mt4},
                        type: "delete",
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        success: function (data) {
                            if (data.status == 200) {
                                layer.open({
                                    content: "已成功解绑！",
                                    yes: function(layero, index){
                                        location.reload();
                                    }
                                });
                            }else{
                                layer.open({
                                    content: data.msg ,
                                    success: function(layero, index){
                                        $('.mt4-id').val("");
                                    }
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        }
                    });
                }
                layer.close(index);
            }
        });

    });
</script>
{% endblock %}

{% block content %}
    {# 内容 #}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_userinfo_title || "用户信息" }}
                    </div>
                    <div class="main_head_text required">

                    </div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input" >
                            <div>
                                <p>{{ Lang.form_text_base_info || "基本信息" }}</p>
                                <div  class="layui-row">
                                    <div class="layui-col-md5 layui-col-md-offset1" style="line-height: 30px">
                                       {# <p><span class="info-attr-name">{{ Lang.form_text_sales_no || "销售编号" }}:</span><span>{{ datas.employee_no }}</span></p>#}
                                        <p><span class="info-attr-name">{{ Lang.form_placeholder_name || "姓名" }}:</span><span>{{ datas.full_name }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_identity_type || "证件类型" }}:</span><span>{{ sale_setting.identity_type[datas.identity_type] }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_mobile || "手机号码" }}:</span><span>+ {{ datas.country_code || "62" }} - {{ datas.mobile }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_date_of_birth || "出生日期" }}:</span><span>{{ datas.date_of_birth| dateOfBirth}}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_gmt_create || "创建时间" }}:</span><span>{{ datas.gmt_create }}</span></p>
                                        <p>
                                            <span class="info-attr-name">{{ Lang.form_text_MT4_acc_no || "MT4账号" }}:</span>
                                        {% if datas.mt4_account_no != "" %}
                                            <span class="mt4_account_no">{{ datas.mt4_account_no }}</span>&nbsp;&nbsp;&nbsp;<button class="layui-btn layui-btn-sm layui-btn-danger" id="unbind">解绑</button>
                                        </p>
                                        {% else %}
                                            <span><button class="layui-btn layui-btn-sm" id="bind">绑定MT4账号</button></span>
                                        </p>
                                        {% endif %}
                                    </div>

                                    <div  class="layui-col-md5 layui-col-md-offset1" style="line-height: 30px">
                                        <p><span class="info-attr-name">{{ Lang.form_text_sales_account_no || "销售账号" }}:</span><span>{{ datas.account_no }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_sex || "性别" }}:</span><span>{{ sale_setting.gender[datas.gender] }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_identity_no || "证件号码" }}:</span><span>{{ datas.identity_no| hideIdentityNo }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_email || "电子邮箱" }}:</span><span>{{ datas.email }}</span></p>
                                        <p><span class="info-attr-name">{{ Lang.form_text_gmt_modified || "更新时间" }}:</span><span>{{ datas.gmt_modified }}</span></p>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row" id="departmentInfo">
                                <p>{{ Lang.form_text_position_info || "职位信息" }}</p>
                                <div class="layui-row" style="margin-top: 20px">
                                    {% for position in datas.position %}
                                        <div class="layui-col-md5 layui-col-md-offset1" style="line-height: 30px">
                                            <p><span class="position-attr-name">{{ Lang.form_text_company || "公司" }}: </span><span>{{ position.company }}</span></p>
                                            <p><span class="position-attr-name">{{ Lang.form_text_department || "部门" }}:</span><span>{{ position.department }}</span></p>
                                            <p><span class="position-attr-name">{{ Lang.form_text_team || "组别" }}:</span><span>{{ position.team }}</span></p>
                                            <p><span class="position-attr-name">{{ Lang.form_text_position_name || "职位" }}:</span><span>{{ sale_setting.position_name[position.name] }}</span></p>
                                        </div>
                                    {% endfor %}
                                    {% if datas == null || datas.position == null %}
                                        <div class="layui-col-md5 layui-col-md-offset1" style="line-height: 30px">
                                            <p><span class="position-attr-name">{{ Lang.form_text_company || "公司" }}: </span><span>{{ position.company }}</span></p>
                                            <p><span class="position-attr-name">{{ Lang.form_text_department || "部门" }}:</span><span>{{ position.department }}</span></p>
                                            <p><span class="position-attr-name">{{ Lang.form_text_team || "组别" }}:</span><span>{{ position.team }}</span></p>
                                            <p><span class="position-attr-name">{{ Lang.form_text_position_name || "职位" }}:</span><span>{{ sale_setting.position_name[position.name] }}</span></p>
                                        </div>
                                    {% endif %}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="detail" style="display:none">
        <div class="detail_page_Info">
            <form action="">
                <input type="text" name="mt4-id" required lay-verify="required" placeholder="请输入本人的MT4账号" autocomplete="off" class="layui-input mt4-id" style="width: 264px; display: inline-block">
                <input type="button" value="绑定"  class="layui-btn" style="float: right" id="mt4bind" >
            </form>
            <span style="font-size: 12px; color: #f66f6f; line-height: 60px;"><i class="layui-icon layui-icon-notice" style="font-size: 16px; color: #f66f6f;"></i> 温馨提示：请一定确认是本人的MT4账号</span>
        </div>
    </div>
{% endblock %}

