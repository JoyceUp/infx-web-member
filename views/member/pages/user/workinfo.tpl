{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    {# 引入css #}

{% endblock %}


{% set myselect =  Lang.select.member.register %}

{% block js_assets %}
    {# 引入js #}

{% endblock %}



{% block content %}

    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.page_user_workinfo_title || "投资者信息" }}
                    </div>
                    <div class="main_head_text required"></div>
                </div>


                <div class="main_page_Info">


                    <div class="form">

                        <form class="layui-form" action="">

                            <div class="layui-form-item">
                                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_job || "就业情况" }}:</label>
                                <div class="layui-input-inline">
                                    <select name="job" lay-verify="job">
                                        <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                        {% for item in myselect.job %}
                                            {% if datas.job === item.value %}
                                                <option value="{{ item.value }}"
                                                        selected="selected">{{ item.label }}</option>
                                            {% else %}
                                                <option value="{{ item.value }}">{{ item.label }}</option>
                                            {% endif %}
                                        {% endfor %}
                                    </select>
                                </div>

                                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_capital_source || "资金来源" }}:</label>
                                <div class="layui-input-inline">
                                    <select name="capital_source" lay-verify="capital_source">
                                        <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                        {% for item in myselect.capital_source %}
                                            {% if datas.capital_source === item.value %}
                                                <option value="{{ item.value }}"
                                                        selected="selected">{{ item.label }}</option>
                                            {% else %}
                                                <option value="{{ item.value }}">{{ item.label }}</option>
                                            {% endif %}
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_annual_income || "年收入" }}:</label>
                                <div class="layui-input-inline">
                                    <select name="annual_income" lay-verify="annual_income">
                                        <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                        {% for item in myselect.annual_income %}
                                            {% if datas.annual_income === item.value %}
                                                <option value="{{ item.value }}"
                                                        selected="selected">{{ item.label }}</option>
                                            {% else %}
                                                <option value="{{ item.value }}">{{ item.label }}</option>
                                            {% endif %}
                                        {% endfor %}
                                    </select>
                                </div>

                                <label class="layui-form-label"><i>*</i>{{ Lang.form_label_total_asset || "总资产" }}:</label>
                                <div class="layui-input-inline">
                                    <select name="total_asset" lay-verify="total_asset">
                                        <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                        {% for item in myselect.total_asset %}
                                            {% if datas.total_asset === item.value %}
                                                <option value="{{ item.value }}"
                                                        selected="selected">{{ item.label }}</option>
                                            {% else %}
                                                <option value="{{ item.value }}">{{ item.label }}</option>
                                            {% endif %}
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item" style="">
                                <div class="layui-input-inline" style="line-height:24px;width:140px;text-align: right;">
                                    {% if datas.experience === 1 %}
                                        <input type="checkbox" name="experience" checked lay-skin="switch"
                                               lay-text="{{ Lang.btn_switch || "是|否" }}">
                                    {% else %}
                                        <input type="checkbox" name="experience" lay-skin="switch" lay-text="{{ Lang.btn_switch || "是|否" }}">
                                    {% endif %}
                                </div>
                                <div class="layui-input-block" style="margin-left: 165px">
                                    <div class="layui-form-mid">{{ Lang.form_text_experience_span || "外汇，差价合约（CFDs）以及其他金融衍生品经验 。" }}</div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-inline" style="line-height:24px;width:140px;text-align: right;">
                                    {% if datas.assess_risk === 1 %}
                                        <input type="checkbox" name="assess_risk" checked lay-skin="switch"
                                               lay-text="{{ Lang.btn_switch || "是|否" }}">
                                    {% else %}
                                        <input type="checkbox" name="assess_risk" lay-skin="switch" lay-text="{{ Lang.btn_switch || "是|否" }}">
                                    {% endif %}
                                </div>
                                <div class="layui-input-block" style="margin-left: 165px">
                                    <div class="layui-form-mid">{{ Lang.form_text_assess_risk_span || "我了解金融衍生品是我投资目标和风险投资的一部分，因此我能评估交易所涉及的风险，包括我所有投资资金的损失。" }}
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-inline" style="line-height:24px;width:140px;text-align: right;">
                                    {% if datas.professional === 1 %}
                                        <input type="checkbox" name="professional" checked lay-skin="switch"
                                               lay-text="{{ Lang.btn_switch || "是|否" }}">
                                    {% else %}
                                        <input type="checkbox" name="professional" lay-skin="switch" lay-text="{{ Lang.btn_switch || "是|否" }}">
                                    {% endif %}
                                </div>
                                <div class="layui-input-block" style="margin-left: 165px">
                                    <div class="layui-form-mid">{{ Lang.form_text_professional_span || "关于金融和投资金融衍生品我有相关学术知识/专业知识。" }}</div>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <div class="layui-input-block"  style="margin-left:0px; text-align: center" >
                                    <button class="layui-btn" lay-submit="" lay-filter="from_submit" onclick="javascript:return false;">{{ Lang.btn_save || "保存" }}</button>
                                </div>
                            </div>
                        </form>

                    </div>

                </div>


            </div>
        </div>
    </div>

    <div id="payDiv" style="display: none;z-index: 3">
        <div style="padding:60px 0 60px 0;">
            <img alt="" src="resources/img/loading.gif">
        </div>
    </div>




    <script>

        layui.use(['form'], function () {
            var form = layui.form;


            //自定义验证规则
            form.verify({

                job: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_job_not_null || "请选择就业情况" }}';
                    }
                },
                capital_source: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_capital_source_not_null || "请选择资金来源" }}';
                    }
                },
                annual_income: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_annual_income_not_null || "请选择年收入" }}';
                    }
                },
                total_asset: function (value) {
                    if (value.length === 0 || (/^\s+$/.test(value))) {
                        return '{{ Lang.validate_total_asset_not_null || "请选择总资产" }}';
                    }
                }
            });


            //监听提交
            form.on('submit(from_submit)', function (data) {
                data.field.id = window.user.user_id;
                data.field.job = parseInt(data.field.job);
                data.field.capital_source = parseInt(data.field.capital_source);
                data.field.annual_income = parseInt(data.field.annual_income);
                data.field.total_asset = parseInt(data.field.total_asset);
                data.field.experience = (data.field.experience) ? 1 : 2;
                data.field.assess_risk = (data.field.assess_risk) ? 1 : 2;
                data.field.professional = (data.field.professional) ? 1 : 2;
                // layer.alert(JSON.stringify(data.field), {
                //     title: '最终的提交信息'
                // });
                jQuery.ajax({
                    url: "/member/customer/workinfo/update",
                    type: "POST",
                    dataType: "JSON",
                    data: JSON.stringify(data.field),
                    async: true,
                    error: function (result, status) {
                        layer.msg(result.msg, {
                            icon: 2
                        });
                        return false;
                    },
                    success: function (result, status) {
                        if(result.status === 200) {
                            layer.msg("{{ Lang.msg_update_success || "修改成功" }}", {
                                icon: 1
                            });
                        }
                        else
                        {
                            layer.msg(result.msg, {
                                icon: 0
                            });
                        }
                        return false;
                    },
                    contentType: "application/json; charset=\"utf-8\""
                });
                return false
            });
        });
    </script>

{% endblock %}


