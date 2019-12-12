
{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
	{# 引入css #}
{% endblock %}

{% block js_assets %}
    <script type="text/javascript">
        //账户类型 id-value
        var accountTypeMap = new Object();
        {% for at in Lang.select.member.account.account_type %}
        accountTypeMap[{{ at.value }}] = "{{ at.label }}";
        {% endfor %}
        // 账户下拉框
        var accountHtml = '<option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>';
        {% for ac in account %}
            {% if ac.state != 51 and ac.account_type != 9 %}
            accountHtml += '<option value="{{ ac.id }}" leverage="{{ ac.leverage }}" selected>{{ ac.account_no }}-'+accountTypeMap[{{ ac.account_type }}]+'</option>';
            {% endif %}
        {% endfor %}
        $('select[name="account_id"]').html(accountHtml);

        layui.use(['form'], function () {
            var form = layui.form
                , layer = layui.layer;

            form.verify({
                NotBlank: function(value, item){ //value：表单的值、item：表单的DOM对象
                    if(!value){
                        return $(item).attr("msg");
                    }
                }
            });
            form.on('select(account_select)', function (data) {
                var chs = data.elem.children;
                for(var i in chs){
                    if(chs[i] && chs[i].selected){
                        $("#leverage").val($(chs[i]).attr("leverage"));
                        form.render();      //重新渲染form组建
                        break;
                    }else{
                        $("#leverage").val("");
                    }
                }
            });

            var submit_f = false;
            //监听提交
            form.on('submit(sub_btn)', function (data) {
                if(submit_f){
                    return false;
                }
                submit_f = true;
                $.ajax({
                    url: "/member/account/change_leverage_ajax",
                    async: true,
                    data: data.field,
                    type: "post",
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    success: function (data) {
                        submit_f = false;
                        if (data.status == 200) {
                            layer.alert("{{ Lang.alert_update_lev_success || "杠杆修改成功" }}！", {
                                title: '{{ Lang.page_msg_h3 || "提示：" }}'
                            });
                        }else{
                            layer.alert(data.msg, {
                                title: '{{ Lang.page_text_info || "信息：" }}'
                            });
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
                return false;
            });

        });
    </script>
{% endblock %}

{% block content %}
    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">

                <div class="main_head">
                    <div class="main_head_unit">
                       {{ Lang.page_account_modify_lev_title || "修改杠杆" }}
                    </div>
                    <div class="main_head_text required">
                    </div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input">
                            <form class="layui-form form w400" action="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"><i>*</i>{{ Lang.form_placeholder_account_no || "账号" }}</label>
                                    <div class="layui-input-block">
                                        <select style="width: 240px" name="account_id" lay-filter="account_select" lay-verify="NotBlank" msg="{{ Lang.validate_account_not_chose || "请选择账号" }}">
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label"><i>*</i>{{ Lang.table_leverage || "杠杆比例" }}</label>
                                    <div class="layui-input-block">
                                        <select style="width: 240px" name="leverage" id="leverage" lay-verify="NotBlank" msg="{{ Lang.validate_account_leverage_not_chose || "请选杠杆比例" }}">
                                            <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                            <!--<option value="50">1:50</option>-->
                                            <option value="100">1:100</option>
                                            <option value="200">1:200</option>
                                            <option value="400">1:400</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-form-item mt50">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit="" lay-filter="sub_btn" onclick="javascript:return false;">{{ Lang.btn_sub || "提交" }}</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}
