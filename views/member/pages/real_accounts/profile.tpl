{% extends '../../common/layouts/layout.tpl' %}

{% block css_assets %}
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
{% endblock %}
{% block content %}
    <style>
        a:hover{text-decoration:none;}
        ol, ul {
            margin-bottom: 0px!important;
        }
        .row_content{
            width:40%;
        }

        .user_data .form-group input:disabled{
            background-color: #eee;
        }
        span.form-input-tips{
            float: right;
            width: 13px;
        }
        #person_info label.col-md-4.col-sm-12{
            line-height: 14px;
            padding-top: 8px;
        }
        .currency{
            margin-left: 20px;
            font-weight: 600;
        }
        .first{
            margin-left:51px
        }
        .first h4{
            font-weight: bold;
            font-size:18px;
        }
       .first ul{
            float:left;
             width:40%;
        }
       .first li{
            float:left;
            height:15px;
             width:300px;
            display:inline;
           padding-top:10px;
           margin:10px 0px 50px 50px;
        }
    </style>
    <div class="main_content">
        <div id="select_account_type" {% if profiles.id.length > 0 %} style="display:none"{% else %} style="display:block"{% endif %}>
            <form class="layui-form">
                <div id="fund">
                    <div class="main_head">
                        <div class="main_head_unit">
                            {{ Lang.page_real_account_type_title || "选择账户类型" }}
                        </div>
                    </div>
                    <div class="main_page_Info">
                        <div class="row_content" style="padding:25px 0 30px;">
                            <label for="account_type">
                                <strong class="text-danger">*</strong>
                                {{ Lang.table_source_account_type||"账户类型" }}
                            </label>
                            <div>
                                <select lay-verType="tips"  name="account_type" class="form-control" lay-filter="account_type" lay-verify="account_type">
                                    <option value="">{{ Lang.form_select||"请选择" }}</option>
                                    {% for st in Lang.select.member.register.open_account_type %}
                                        <option value="{{ st.value }}" {% if profiles.account_type == st.value %} selected {% endif %}>{{ st.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                        <div class="row_content" style="padding:25px 0 30px;">
                            <label for="rate">
                                <strong class="text-danger">*</strong>
                                {{ Lang.form_label_rate||"汇率" }}
                            </label>
                            <div class="row_input">
                                <select lay-verType="tips"  name="rate" class="form-control" lay-verify="rate">
                                    <option value="">{{ Lang.form_select||"请选择" }}</option>
                                    {% for st in Lang.select.member.register.open_rate %}

                                        <option value="{{ st.value }}" {% if profiles.account_rate_type == st.value %} selected {% endif %}>{{ st.label }}</option>

                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                        <div class="row_content" style="padding:25px 0 30px;">
                            <label for="leverage">
                                <strong class="text-danger">*</strong>
                                {{ Lang.table_leverage_1||"杠杆" }}
                            </label>
                            <div>
                                <select lay-verType="tips"  name="leverage" class="form-control" lay-verify="leverage">
                                    <option value="">{{ Lang.form_select||"请选择" }}</option>
                                    {% for st in Lang.select.member.register.leverage %}
                                        <option value="{{ st.value }}" {% if profiles.account_leverage == st.value %} selected {% elseif st.value=='100'%}selected{% else %}disabled{% endif %}>{{ st.label }}</option>
                                    {% endfor %}
                                </select>
                            </div>
                         </div>
                        <div class="row_content" style="margin-top: 30px">
                            <button class="layui-btn" lay-submit="" lay-filter="first-step"
                                    onclick="return false;" >{{ Lang.btn_next || "下一步" }}</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div id="person_info" {% if profiles.id.length > 0 %} style="display:block"{% else %} style="display:none"{% endif %} >
                <div class="main_head">
                    {% if active == 'userinfo'  %}
                    {% else %}
                    <div class="first">
                        <h4>{{ Lang.table_source_account_type||"账户类型" }}</h4>
                        <ul>
                            <li>Account Type</li>
                            <li>Exchange Rate</li>
                            <li>Leverage</li>
                        </ul>
                        {% if profiles.id.length > 0 %}
                        <ul>
                            <li>{{ Lang.select.member.register.open_account_type_map[profiles.account_type] }} </li>
                            <li>{{ Lang.select.member.register.open_rate_map[profiles.account_rate_type]}}</li>
                            <li>{{ Lang.select.member.register.leverage_map[profiles.account_leverage]}}</li>
                        </ul>
                        {% else %}
                            <ul>
                                <li id="review_country_type"></li>
                                <li id="review_rate"></li>
                                <li id = review_leverage></li>
                            </ul>

                        {% endif %}
                    </div>
                    {% endif %}
                    <div class="real_accounts user_data">
                        <div class="row">
                            <form class="layui-form">
                                <div class="col-md-12">
                                    <div class="panel-body">
                                        <div class="col-md-12 col-sm-12">
                                            <h4>{{ Lang.form_user_info||"个人资料" }}</h4>
                                            <hr>
                                            <div class="col-md-6 col-sm-12">
                                                <input lay-verType="tips"  type="hidden" id="account_type" value="{{ profiles.account_type}}" name="account_type" class="form-control">
                                                <input lay-verType="tips"  type="hidden" id="account_rate_type" value="{{ profiles.account_rate_type}}" name="account_rate_type" class="form-control">
                                                <input lay-verType="tips"  type="hidden" id="account_leverage" value="{{ profiles.account_leverage}}" name="account_leverage" class="form-control">
                                                <input lay-verType="tips"  type="hidden" name="id" value="{{ profiles.id }}" class="form-control">

                                                <div class="form-group clearfix">
                                                    <label for="full_name" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_name ||"全名" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="full_name"
                                                               class="form-control"
                                                               maxlength="64"
                                                               type="text"
                                                               lay-verify="full_name"
                                                               id="full_name"
                                                               onkeyup="fillOthersName(this.id)"
                                                               value="{{ profiles.open_account_info.full_name }}"
                                                               >
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="gender" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_gender||"性别" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <select lay-verType="tips"  name="gender" class="form-control" lay-verify="gender">
                                                            {% for st in Lang.select.member.register.gender %}
                                                                <option value="{{ st.value }}"
                                                                        {% if profiles.open_account_info.gender == st.value %}selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="place" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_UserBirthPlace||"出生地点" }}
                                                        </label>
                                                    <div class="col-md-4 col-sm-6">
                                                        <input lay-verType="tips"  name="place"
                                                               class="form-control"
                                                               value="{{ profiles.open_account_info.place }}"
                                                               maxlength="64" type="text" lay-verify="place"/>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="birthday" class="col-md-4 col-sm-8">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_birth_date||"出生日期" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-6">
                                                        <input lay-verType="tips"  id="birth_date"
                                                               lay-verify="birth_date"
                                                               name="birthday"
                                                               class="layui-input"
                                                               value="{{ profiles.open_account_info.birthday | dateOfBirth}}"
                                                               type="text">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="birthday" class="col-md-4 col-sm-8">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_country_name||"国籍" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-6">
                                                        <input lay-verType="tips"  id="nationality"
                                                               lay-verify="require"
                                                               msg="{{ Lang.nationality_not_null||"国籍是必填项" }}"
                                                               name="nationality"
                                                               class="layui-input"
                                                               value="{{ profiles.open_account_info.nationality}}"
                                                               type="text">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="identity_type" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_text_identity_type||"证件类型" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4">
                                                        <select lay-verType="tips"  name="identity_type"
                                                                class="layui-input"
                                                                lay-verify="require"
                                                                msg="{{ Lang.identity_type_not_null||"证件类型是必填项" }}">
                                                            {% for st in Lang.select.member.register.identity_type %}
                                                                <option value="{{ st.value }}"
                                                                        {% if profiles.open_account_info.identity_type == st.value %}selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="identity_number" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_identity_number ||"证件号码" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  name="identity_number"
                                                               class="form-control"
                                                               maxlength="64" type="text"
                                                               value="{{ profiles.open_account_info.identity_number }}"
                                                               lay-verify="identity_number">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="UserInvestmentExperience" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_investment_experience||"投资经验" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                        <select lay-verType="tips"  name="investment_experience_select"
                                                                id="investment_experience_select"
                                                                class="form-control"
                                                                lay-verify="require"
                                                                msg="{{ Lang.investment_experience_select||"请选择是否有投资经验" }}"
                                                                lay-filter="investment_experience_select">
                                                            {% for st in Lang.select.member.register.experience %}
                                                                <option value="{{ st.value }}"
                                                               {% if profiles.open_account_info.investment_experience==st.value%}selected{% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  name="investment_experience_desc"
                                                               class="layui-input"
                                                               maxlength="64" type="text"
                                                               id="investment_experience_desc"
                                                        {% if profiles.open_account_info.investment_experience==2%}disabled{% endif %}
                                                               value ="{{ profiles.open_account_info.investment_experience_desc }}"
                                                               lay-verify="investment_experience_desc">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="UserAccountPurpose"
                                                           class="col-md-4 col-sm-12">{{ Lang.form_user_account_purpose||"开户目的" }}
                                                        <strong class="text-danger">*</strong></label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                        <select lay-verType="tips"  name="purpose_of_account_opening"
                                                                id="purpose_of_account_opening"
                                                                lay-filter="purpose_of_account_opening"
                                                                class="form-control">
                                                            {% for st in Lang.select.member.register.purpose_of_account_opening %}
                                                                <option value="{{ st.value }}"
                                                                        {% if profiles.open_account_info.purpose_of_account_opening == st.value %}selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  name="purpose_of_account_opening_other"
                                                               id="purpose_of_account_opening_other"
                                                               {% if profiles.open_account_info.purpose_of_account_opening_other.length == 0 %}
                                                               disabled
                                                               {% endif %}
                                                               maxlength="64"
                                                               type="text"
                                                               class="form-control"
                                                               value="{{ profiles.open_account_info.purpose_of_account_opening_other }}"
                                                               lay-verify="purpose_of_account_opening_other">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="personal_tax_number_select" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_npwp_flag||"个人税号" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  name="personal_tax_number"
                                                               class="form-control"
                                                               maxlength="20" type="text"
                                                               id="personal_tax_number"
                                                               value="{{profiles.open_account_info.personal_tax_number  }}"
                                                               lay-verify="personal_tax_number">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="UserMaritalStatus" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_marital_status||"婚姻状况" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <select lay-verType="tips"  class="form-control"
                                                                lay-filter="marital_status_select"
                                                                name="marital_status_select"
                                                                id="marital_status_select"
                                                                msg="{{ Lang.marital_status_select||"请选择婚姻状况" }}"
                                                                lay-verify="require">
                                                            {% for st in Lang.select.member.register.marital_status %}
                                                                <option value="{{ st.value }}"
                                                                        {% if profiles.open_account_info.marital_status == st.value  %} selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="spouse_name"
                                                           class="col-md-4 col-sm-12">{{ Lang.form_user_spouse||"丈夫/妻子的名字" }}</label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="spouse_name"
                                                               class="form-control"
                                                               id="spouse_name"
                                                               {% if profiles.open_account_info.spouse_name.length == 0 %}
                                                               disabled
                                                               {% endif %}
                                                               maxlength="64" type="text"
                                                               value="{{ profiles.open_account_info.spouse_name }}"
                                                               lay-verify="spouse_name">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12">
                                                <div class="form-group clearfix">
                                                    <label for="mother_maiden_name"
                                                           class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_mother||"母亲的名字" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="mother_maiden_name"
                                                               class="form-control text-danger"
                                                               maxlength="64"
                                                               type="text"
                                                               value="{{ profiles.open_account_info.mother_maiden_name }}"
                                                               msg="{{ Lang.mother_maiden_name||"请输入母亲的名字" }}"
                                                               lay-verify="require">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix ">
                                                    <label for="home_address" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_emergency_contact_address||"家庭住址" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <textarea name="home_address"
                                                                  class="form-control"
                                                                  rows="3" cols="30"
                                                                  msg="{{ Lang.home_address||"请输入家庭住址" }}"
                                                                  lay-verify="require">{{ profiles.open_account_info.home_address }}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="UserZipCode" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_emergency_contact_zip_code||"邮编" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="postal_code"
                                                               class="form-control"
                                                               maxlength="7"
                                                               type="text"
                                                               value="{{profiles.open_account_info.postal_code  }}"
                                                               lay-verify="postal_code">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="house_ownership" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_home_ownership||"房屋所有权房屋状况" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                        <select lay-verType="tips"  name="house_ownership"
                                                                id="house_ownership"
                                                                class="form-control"
                                                                lay-filter="house_ownership">
                                                            {% for st in Lang.select.member.register.house_ownership %}
                                                                <option value="{{ st.value }}"
                                                                {% if profiles.open_account_info.house_ownership == st.value%} selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  name="house_ownership_other"
                                                               class="form-control"
                                                               {% if profiles.open_account_info.house_ownership_other.length == 0  %}
                                                               disabled="disabled"
                                                               {% endif %}
                                                               value="{{profiles.open_account_info.house_ownership_other}}"
                                                               maxlength="64" type="text"
                                                               lay-verify="house_ownership_other"
                                                               id="house_ownership_other">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="house_facsimile_number" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_bank_phone_number||"电话号码" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                            <select lay-verType="tips"  id="house_number_country_code"
                                                                    name="house_number_country_code"
                                                                    lay-verify="house_number_country_code"
                                                                    class="form-control"
                                                                    lay-search="" >
                                                                {% if profiles.open_account_info.house_number_country_code.length > 0 %}
                                                                <option value="{{profiles.open_account_info.house_number_country_code}}"></option>
                                                                {% else %}
                                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                                {% endif %}
                                                            </select>
                                                        </div>
                                                        <label class="col-md-4 col-sm-12"></label>
                                                        <div class="col-md-4 col-sm-8">
                                                                <input lay-verType="tips"  type="text"
                                                                       name="house_facsimile_number"
                                                                       lay-verify="house_facsimile_number"
                                                                       value="{{profiles.open_account_info.house_facsimile_number}}"
                                                                       class="layui-input">
                                                        </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="mobile_number" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_handphone_number||"手机号码" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                            <select lay-verType="tips"  id="mobile_country_code"
                                                                    name="mobile_country_code"
                                                                    lay-verify="mobile_country_code"
                                                                    class="form-control"
                                                                    lay-search="" >
                                                                {% if  profiles.open_account_info.mobile_country_code.length > 0 %}
                                                                <option value="{{profiles.open_account_info.mobile_country_code}}"></option>
                                                                {% else %}
                                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }} </option>
                                                                {% endif %}

                                                            </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  type="text"
                                                               name="mobile_number"
                                                               lay-verify="mobile_number"
                                                               value="{{profiles.open_account_info.mobile_number}}"
                                                               class="layui-input">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <p>&nbsp;</p>
                                        <div class="col-md-12 col-sm-12">
                                            <hr>
                                            <div class="col-md-8 col-sm-8">{{ Lang.form_have_family_in }}
                                            </div>
                                                <div class="col-md-4 col-sm-4">
                                                    <label class="radio-inline">
                                                        <input lay-verType="tips"  type="radio"
                                                               name="have_family_in"
                                                               id="UserHaveFamilyIn0"
                                                               value="0"
                                                               {% if profiles.open_account_info.have_family_in == 0 %}checked="checked"{% endif %}>
                                                        {{ Lang.btn_no||"No" }}
                                                      </label>
                                                    <label class="radio-inline">
                                                        <input lay-verType="tips"  type="radio"
                                                               name="have_family_in"
                                                               id="UserHaveFamilyIn1"
                                                               value="1"
                                                               {% if profiles.open_account_info.have_family_in == 1 %}checked="checked"{% endif %}>
                                                        {{ Lang.btn_yes||"Yes" }}
                                                    </label>
                                                </div>

                                            <div class="col-md-8 col-sm-8">{{ Lang.form_have_family_in2 }}</div>
                                            <div class="col-md-4 col-sm-4">

                                                <label class="radio-inline">
                                                    <input lay-verType="tips"  type="radio" name="bankruptcy" id="UserBankruptcy0"  value="0"
                                                           {% if profiles.open_account_info.bankruptcy == 0 %}checked="checked"{% endif %}>{{ Lang.btn_no||"No" }}
                                                </label>
                                                <label class="radio-inline">
                                                    <input lay-verType="tips"  type="radio" name="bankruptcy" id="UserBankruptcy1" value="1"
                                                           {% if profiles.open_account_info.bankruptcy == 1 %}checked="checked"{% endif %}>{{ Lang.btn_yes||"Yes" }}
                                                </label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="col-md-12 col-sm-12">
                                            <h4>{{ Lang.form_user_emergency_contact_info||"各方在紧急情况下联系" }}</h4>
                                            <hr>
                                            <div class="col-md-6 col-sm-12">
                                                <input lay-verType="tips"  type="hidden" name="UserEmergencyContact_id" class="form-control" id="UserEmergencyContactId">
                                                <div class="form-group clearfix">
                                                    <label for="ec_full_name" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_name||"姓名" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="ec_full_name"
                                                               class="form-control"
                                                               maxlength="64"
                                                               type="text"
                                                               value="{{profiles.open_account_info.emergency_contact.full_name}}"
                                                               msg="{{ Lang.ec_full_name||"请输入紧急联系人的姓名" }}"
                                                               lay-verify="require">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="ec_phone_number"
                                                           class="col-md-4 col-sm-12">{{ Lang.form_user_bank_phone_number ||"电话号码" }}
                                                        <strong class="text-danger">*</strong></label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                            <select lay-verType="tips"  id="ec_country_code"
                                                                    name="ec_country_code"
                                                                    lay-verify="ec_country_code"
                                                                    class="select_country_code"
                                                                    lay-search="" >
                                                                {% if  profiles.open_account_info.emergency_contact.country_code.length > 0%}
                                                                <option value="{{profiles.open_account_info.emergency_contact.country_code}}"></option>
                                                               {% else %}
                                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                                {% endif %}
                                                            </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  type="text"
                                                               name="ec_phone_number"
                                                               lay-verify="ec_phone_number"
                                                               value="{{profiles.open_account_info.emergency_contact.phone_number}}"
                                                               class="layui-input">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="relation_ship"
                                                           class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_emergency_contact_relationship||"关系" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="relation_ship"
                                                               class="form-control"
                                                               maxlength="64"
                                                               type="text"
                                                               value="{{profiles.open_account_info.emergency_contact.relation_ship}}"
                                                               msg="{{ Lang.ec_relation_ship||"请输入与紧急联系人的关系" }}"
                                                               lay-verify="require">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12">
                                                <div class="form-group clearfix">
                                                    <label for="ec_home_address" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_emergency_contact_address||"家庭住址" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <textarea name="ec_home_address"
                                                                  class="form-control text-danger"
                                                                  rows="3" cols="30"
                                                                  msg="{{ Lang.ec_home_address||"请输入紧急联系人的家庭住址" }}"
                                                                  lay-verify="require">{{profiles.open_account_info.emergency_contact.home_address}}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="ec_postal_code" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_emergency_contact_zip_code||"邮编" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="ec_postal_code"
                                                               class="form-control valid"
                                                               maxlength="7" type="text"
                                                               value="{{profiles.open_account_info.emergency_contact.postal_code}}"
                                                               lay-verify="ec_postal_code">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <p>&nbsp;</p>
                                        <div class="col-md-12 col-sm-12">
                                            <h4>{{ Lang.form_user_work_info||"职位信息" }}</h4>
                                            <hr>

                                            <div class="col-md-6 col-sm-12">
                                                <div class="form-group clearfix">
                                                    <label for="occupation"  class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_work_work||"职业" }}
                                                        </label>
                                                    <div class="col-md-4 col-sm-6 mar-b-15">
                                                        <select lay-verType="tips"  name="occupation"
                                                                class="form-control"
                                                                lay-filter="occupation"
                                                                id="occupation">
                                                            {% for st in Lang.select.member.register.occupation %}
                                                                <option value="{{ st.value }}"
                                                                {% if profiles.open_account_info.open_account_job.occupation == st.value %}selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-6">
                                                        <input lay-verType="tips"  name="occupation_other"
                                                               id="occupation_other"
                                                               class="form-control"
                                                            {% if profiles.open_account_info.open_account_job.occupation_other.length == 0 %}
                                                                disabled="disabled"
                                                            {% endif %}
                                                               maxlength="64"
                                                               type="text"
                                                               value="{{profiles.open_account_info.open_account_job.occupation_other}}"
                                                               lay-verify="occupation_other">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="name_of_company" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_company_name||"公司名称" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="name_of_company"
                                                               id="name_of_company"
                                                               class="form-control valid"
                                                               maxlength="64"
                                                               value="{{profiles.open_account_info.open_account_job.name_of_company}}"
                                                               type="text">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="business_field" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_line_of_business||"业务领域" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="business_field"
                                                               class="form-control"
                                                               maxlength="64"
                                                               value="{{profiles.open_account_info.open_account_job.business_field}}"
                                                               type="text" >
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="title" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_position||"职位" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="title"
                                                               class="form-control"
                                                               maxlength="64"
                                                               value="{{profiles.open_account_info.open_account_job.title}}"
                                                               type="text">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix" >
                                                    <label for="length_of_services" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_working_period||"服务时长" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4">
                                                        <input lay-verType="tips"  name="length_of_services"
                                                               class="form-control"
                                                               type="text"
                                                               value="{{profiles.open_account_info.open_account_job.length_of_services}}"
                                                               lay-verify="length_of_services">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="length_of_services_in_previous_office" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_ex_working_period||"以前办公室服务的长度" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4">
                                                        <input lay-verType="tips"  name="length_of_services_in_previous_office"
                                                               class="form-control"
                                                               type="text"
                                                               value="{{profiles.open_account_info.open_account_job.length_of_services_in_previous_office}}"
                                                               lay-verify="length_of_services_in_previous_office">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12">
                                                <div class="form-group clearfix">
                                                    <label for="company_address"  class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_office_address||"公司地址" }}
                                                    </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <textarea name="company_address"
                                                                  class="form-control"
                                                                  rows="3"
                                                                  cols="30">{{profiles.open_account_info.open_account_job.company_address}}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="postal_code" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_zip_code||"邮编" }}
                                                       </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="job_postal_code"
                                                               class="form-control valid"
                                                               maxlength="7"
                                                               type="text"
                                                               value="{{profiles.open_account_info.open_account_job.postal_code}}"
                                                               lay-verify="job_postal_code">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="office_phone_number" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_phone_number||"办公室电话" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                        <select lay-verType="tips"
                                                                id="job_phone_country_code"
                                                                name="job_phone_country_code"
                                                                lay-verify="job_phone_country_code"
                                                                class="select_country_code"
                                                                lay-search="" >
                                                            {% if profiles.open_account_info.open_account_job.phone_country_code.length > 0 %}
                                                                <option value="{{profiles.open_account_info.open_account_job.phone_country_code}}"></option>
                                                            {% else %}
                                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            {% endif %}
                                                        </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  type="text"
                                                               name="office_phone_number"
                                                               id="office_phone_number"
                                                               {% if profiles.open_account_info.open_account_job.occupation == 2||
                                                                   profiles.open_account_info.open_account_job.occupation == 5%}disabled="disabled"{% endif %}
                                                               lay-verify="office_phone_number"
                                                               value="{{profiles.open_account_info.open_account_job.office_phone_number}}"
                                                               class="layui-input">
                                                    </div>
                                                </div>

                                                <div class="form-group clearfix">
                                                    <label for="office_fax_number" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_work_fax_number||"传真号码" }}
                                                    </label>
                                                    <div class="col-md-4 col-sm-4 mar-b-15">
                                                        <select lay-verType="tips"  id="job_fax_country_code"
                                                                name="job_fax_country_code"
                                                                lay-verify="job_fax_country_code"
                                                                class="select_country_code"
                                                                lay-search="" >
                                                            {% if profiles.open_account_info.open_account_job.fax_country_code.length > 0 %}
                                                                <option value="{{profiles.open_account_info.open_account_job.fax_country_code}}"></option>
                                                            {% else %}
                                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                            {% endif %}
                                                        </select>
                                                    </div>
                                                    <label class="col-md-4 col-sm-12"></label>
                                                    <div class="col-md-4 col-sm-8">
                                                        <input lay-verType="tips"  type="text"
                                                               name="office_fax_number"
                                                               id="office_fax_number"
                                                               {% if profiles.open_account_info.open_account_job.occupation == 2||
                                                                   profiles.open_account_info.open_account_job.occupation == 5%}disabled{% endif %}
                                                               lay-verify="office_fax_number"
                                                               value="{{profiles.open_account_info.open_account_job.office_fax_number}}"
                                                               class="layui-input">
                                                    </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <p>&nbsp;</p>
                                        <div class="col-md-12 col-sm-12">
                                            <h4>{{ Lang.form_user_list_asset_info||"财富榜" }}</h4>
                                            <hr>
                                            <div class="col-md-6 col-sm-12">
                                                <div class="form-group clearfix">
                                                    <label for="annual" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_list_of_asset_income_per_year_id||"年收入" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <select lay-verType="tips"  name="annual"
                                                                class="form-control valid"
                                                                msg="{{ Lang.annual||"请选择年收入范围" }}"
                                                                lay-verify="require">
                                                            {% for st in Lang.select.member.register.annual_income %}
                                                                <option value="{{ st.value }}"
                                                                {% if profiles.open_account_info.open_account_wealth_list.annual == st.value  %}selected {% endif %}
                                                                >{{ st.label }}</option>
                                                            {% endfor %}
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12"></div>
                                            <div class="col-md-12 col-sm-12"></div>

                                            <div class="col-md-6 col-sm-12">
                                                <div class="form-group clearfix">
                                                    <label for="location_of_house" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_list_of_asset_home_location||"房子位置" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="location_of_house"
                                                               class="form-control"
                                                               maxlength="64"
                                                               type="text"
                                                               value="{{ profiles.open_account_info.open_account_wealth_list.location_of_house }}"
                                                                msg="{{ Lang.location_of_house||"请输入房产地址" }}"
                                                               lay-verify="require">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix ">
                                                    <label for="house_tax_value"
                                                           class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_list_of_asset_value_svto||"房屋税价值" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="house_tax_value"
                                                               class="form-control"
                                                              maxlength="23"
                                                               type="text"
                                                               id="house_tax_value"
                                                               onkeyup="toThousands(this.id)"
                                                               value="{{ profiles.open_account_info.open_account_wealth_list.house_tax_value|toThousands }}"
                                                               lay-verify="house_tax_value">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="time_deposit" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_list_of_asset_bank_deposits||"定期存款" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="time_deposit"
                                                               class="form-control"
                                                               maxlength="23"
                                                               type="text"
                                                               id="time_deposit"
                                                               onkeyup="toThousands(this.id)"
                                                               value="{{ profiles.open_account_info.open_account_wealth_list.time_deposit|toThousands }}"
                                                               lay-verify="time_deposit">
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="total" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_user_list_of_asset_total||"合计" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="total"
                                                               id="total"
                                                               class="form-control"
                                                               maxlength="23"
                                                               type="text"
                                                               onkeyup="toThousands(this.id)"
                                                               value="{{ profiles.open_account_info.open_account_wealth_list.total|toThousands }}"
                                                               lay-verify="total"
                                                                lay-filter="total"
                                                        >
                                                    </div>
                                                </div>
                                                <div class="form-group clearfix">
                                                    <label for="wealth_others" class="col-md-4 col-sm-12">
                                                        {{ Lang.form_user_list_of_asset_other||"其他" }}
                                                        </label>
                                                    <div class="col-md-8 col-sm-12">
                                                        <input lay-verType="tips"  name="wealth_others"
                                                               class="form-control"
                                                               maxlength="23"
                                                               type="text"
                                                               id="wealth_others"
                                                               onkeyup="toThousands(this.id)"
                                                               value="{{ profiles.open_account_info.open_account_wealth_list.others|toThousands }}"
                                                               lay-verify="wealth_others">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <p>&nbsp;</p>
                                        <div class="col-md-12 col-sm-12">
                                        <div style="height: 12px;line-height: 12px">
                                            <h4>{{ Lang.form_user_bank_info||"银行信息" }} </h4>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="currency">IDR</div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group clearfix">
                                                        <label for="bank1_name" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_name||"银行名称" }}</label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank1_name"
                                                                   class="form-control"
                                                                   maxlength="64"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[0].bank_name }}"
                                                                   msg="{{ Lang.validate_bank_name_not_null_please||"请输入银行名称" }}"
                                                                   lay-verify="require">
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="bank1_branch" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_branch||"分支" }}
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank1_branch"
                                                                   class="form-control"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[0].branch }}"
                                                                   msg="{{ Lang.validate_branch_name_not_null_please||"请填写支行名称" }}"
                                                                   lay-verify="require">
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="bank1_phone_name"  class="col-md-4 col-sm-12">
                                                            {{ Lang.form_user_bank_phone_number||"电话号码" }}
                                                        </label>
                                                        <div class="col-md-4 col-sm-4 mar-b-15">
                                                                <select lay-verType="tips"  id="bank1_phone_country_code"
                                                                        name="bank1_phone_country_code"
                                                                        lay-verify="bank1_phone_country_code"
                                                                        class="select_country_code"
                                                                        lay-search="" >
                                                                    {% if profiles.open_account_info.open_account_bank[0].country_code.length > 0 %}
                                                                    <option value="{{ profiles.open_account_info.open_account_bank[0].country_code }}"></option>
                                                                    {% else %}
                                                                    <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                                    {% endif %}
                                                                </select>
                                                        </div>
                                                        <label class="col-md-4 col-sm-12"></label>
                                                        <div class="col-md-4 col-sm-8">
                                                            <input lay-verType="tips"  type="text"
                                                                   name="bank1_phone_name"
                                                                   lay-verify="bank1_phone_name"
                                                                   class="layui-input"
                                                                   value="{{ profiles.open_account_info.open_account_bank[0].phone_name }}" >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group clearfix">
                                                        <label for="bank1_account_number" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_account_number||"帐号" }}
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank1_account_number"
                                                                   class="form-control"
                                                                   maxlength="64"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[0].account_number }}"
                                                                   lay-verify="bank1_account_number" >
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="UserBank0AccountNumber" class="col-md-4 col-sm-12">
                                                            Swift Code
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank1_swift_code"
                                                                   class="form-control"
                                                                   maxlength="64"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[0].branch_swift_code }}"
                                                                   lay-verify="bank1_swift_code" >
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label class="col-md-4 col-sm-12 control-label">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_account_name||"帐户名称" }}
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <p class="form-control-static account-name" id="AccountName1">{{  profiles.open_account_info.full_name}}</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="bank1_account_type" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_account_type||"帐户类型" }}
                                                        </label>
                                                        <div class="col-md-4 col-sm-4 mar-b-15">
                                                            <select lay-verType="tips"  name="bank1_account_type"
                                                                    class="form-control"
                                                                    id = "bank1_account_type_select"
                                                                    lay-verify = "bank1_account_type_select"
                                                                    lay-filter = "bank1_account_type_select">
                                                                <option value="-1" selected>{{ Lang.page_real_account_type_title }}</option>
                                                                {% for st in Lang.select.member.register.bank_account_type %}
                                                                    <option value="{{ st.value }}"
                                                                   {% if  profiles.open_account_info.open_account_bank[0].account_type == st.value %}selected{% endif %}
                                                                    >{{ st.label }}</option>
                                                                {% endfor %}
                                                            </select>
                                                        </div>
                                                        <label class="col-md-4 col-sm-12"></label>
                                                        <div class="form-group clearfix">
                                                            <div class="col-md-4 col-sm-6">
                                                                <input lay-verType="tips"  name="bank1_account_other"
                                                                       class="form-control"
                                                                       {% if profiles.open_account_info.open_account_bank[0].account_other.length ==0 %}
                                                                           disabled="disabled"
                                                                       {% endif %}
                                                                       maxlength="64"
                                                                       type="text"
                                                                       style="width:271px"
                                                                       value="{{ profiles.open_account_info.open_account_bank[0].account_other }}"
                                                                       id="bank1_account_other"
                                                                       lay-verify="bank1_account_other">
                                                            </div>
                                                        </div>
                                                    </div>
                                                <div class="col-md-12 text-right"></div>
                                            </div>
                                            </div>
                                            <div id="appendBank">
                                                {% if profiles.open_account_info.open_account_bank[1].bank_name.length > 0%}
                                                <span id="add_btn" style="float:right;display:none">
                                                    <a href="javascript:void(0)" onclick="appendBank(1)" class="layui-btn">Add</a>
                                                </span>
                                                <span id="delete_btn" style="float:right;" >
                                                    <a href="javascript:void(0)" onclick="appendBank(2)" class="layui-btn layui-btn-primary">delete</a>
                                                </span>
                                                {% else %}
                                                    <span id="add_btn" style="float:right;">
                                                    <a href="javascript:void(0)" onclick="appendBank(1)" class="layui-btn">Add</a>
                                                </span>
                                                    <span id="delete_btn" style="float:right;display: none" >
                                                    <a href="javascript:void(0)" onclick="appendBank(2)" class="layui-btn layui-btn-primary">delete</a>
                                                </span>
                                                {% endif %}
                                                <hr>
                                            </div>
                                            <div id="nextBankBlock"
                                                 {% if profiles.open_account_info.open_account_bank[1].bank_name.length > 0%}
                                                 style="display:block"
                                                {% else %}
                                                    style="display:none"
                                                {% endif %}
                                            >
                                            <div class="row">
                                                <div class="currency">USD</div>
                                                <input lay-verType="tips"  type="hidden"
                                                       id="newBankStatus"
                                                        {% if profiles.open_account_info.open_account_bank[1].bank_name.length > 0%}
                                                       value="delete"
                                                       {% else %}
                                                        value="add"
                                                       {% endif %}
                                                />
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group clearfix">
                                                        <label for="bank2_name" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_name||"银行名称" }}</label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank2_name"
                                                                   id="bank2_name"
                                                                   class="form-control"
                                                                   maxlength="64"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[1].bank_name}}"
                                                                   lay-verify="bank2_name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="bank2_branch" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_branch||"分支" }}
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank2_branch"
                                                                   id="bank2_branch"
                                                                   class="form-control"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[1].branch }}"
                                                                   lay-verify="bank2_branch">
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="bank2_phone_name" class="col-md-4 col-sm-12">

                                                            {{ Lang.form_user_bank_phone_number||"电话号码" }}
                                                        </label>
                                                        <div class="col-md-4 col-sm-4 mar-b-15">
                                                            <select lay-verType="tips"  id="bank2_phone_country_code"
                                                                    name="bank2_phone_country_code"
                                                                    lay-verify="bank2_phone_country_code"
                                                                    class="select_country_code"
                                                                    lay-search="" >
                                                                {% if profiles.open_account_info.open_account_bank[1].country_code.length > 0 %}
                                                                <option value="{{ profiles.open_account_info.open_account_bank[1].country_code }}"></option>
                                                                {% else %}
                                                                <option value="">{{ Lang.form_select_invite_type || "请选择" }}</option>
                                                                {% endif %}
                                                            </select>
                                                        </div>
                                                        <label class="col-md-4 col-sm-12"></label>
                                                        <div class="col-md-4 col-sm-8">
                                                            <input lay-verType="tips"  type="text"
                                                                   name="bank2_phone_name"
                                                                   id="bank2_phone_name"
                                                                   lay-verify="bank2_phone_name"
                                                                   class="layui-input"
                                                                   value="{{ profiles.open_account_info.open_account_bank[1].phone_name }}" >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-12">
                                                    <div class="form-group clearfix">
                                                        <label for="bank2_account_number" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_account_number||"帐号" }}
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank2_account_number"
                                                                   id="bank2_account_number"
                                                                   class="form-control"
                                                                   maxlength="64"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[1].account_number }}"
                                                                   lay-verify="bank2_account_number" >
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="UserBank0AccountNumber" class="col-md-4 col-sm-12">
                                                            Swift Code
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <input lay-verType="tips"  name="bank2_swift_code"
                                                                   id="bank2_swift_code"
                                                                   class="form-control"
                                                                   maxlength="64"
                                                                   type="text"
                                                                   value="{{ profiles.open_account_info.open_account_bank[1].branch_swift_code }}"
                                                                   lay-verify="bank2_swift_code" >
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label class="col-md-4 col-sm-12 control-label">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_account_name||"帐户名称" }}
                                                        </label>
                                                        <div class="col-md-8 col-sm-12">
                                                            <p class="form-control-static account-name" id="AccountName2">{{  profiles.open_account_info.full_name}}</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group clearfix">
                                                        <label for="bank2_account_type" class="col-md-4 col-sm-12">
                                                            <strong class="text-danger">*</strong>
                                                            {{ Lang.form_user_bank_account_type||"帐户类型" }}
                                                        </label>
                                                        <div class="col-md-4 col-sm-4 mar-b-15">
                                                            <select lay-verType="tips"  name="bank2_account_type"
                                                                    class="form-control"
                                                                    lay-filter="bank2_account_type_select"
                                                                    lay-verify="bank2_account_type_select"
                                                                    id="bank2_account_type_select">
                                                                <option value="-1" selected>{{ Lang.page_real_account_type_title }}</option>
                                                                {% for st in Lang.select.member.register.bank_account_type %}
                                                                <option value="{{ st.value }}"
                                                                       {% if  profiles.open_account_info.open_account_bank[1].account_type == st.value %}selected{% endif %}
                                                                >{{ st.label }}</option>
                                                                {% endfor %}
                                                            </select>
                                                        </div>
                                                        <label class="col-md-4 col-sm-12"></label>
                                                        <div class="form-group clearfix">
                                                            <div class="col-md-4 col-sm-6">
                                                                <input lay-verType="tips"  name="bank2_account_other"
                                                                       id ="bank2_account_other"
                                                                       class="form-control"
                                                                       {% if profiles.open_account_info.open_account_bank[1].account_other.length ==0 %}
                                                                           disabled="disabled"
                                                                       {% endif %}
                                                                       maxlength="64"
                                                                       type="text"
                                                                       style="width:271px"
                                                                       value="{{ profiles.open_account_info.open_account_bank[1].account_other }}"
                                                                       lay-verify="bank2_account_other">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 text-right">
                                                </div>
                                                </div>

                                            </div>
                                            </div>
                                        </div>
                                      <p>&nbsp;</p>
                                        <div class="col-md-12 col-sm-12" style="background-color: #fff">
                                            <h4>{{ Lang.form_photos_title||"延长的文件" }}</h4>
                                            <hr>
                                            <div class="col-md-6 col-sm-12">
                                                <div class="step-2-formulir-items">
                                                    <label  for="RealAccountAttachmentFotoName" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_recent_photo||"最近的照片" }}
                                                    </label>
                                                    <div class="layui-input-block">
                                                        <input   type="hidden"
                                                               id="card_path"
                                                               value="{{ profiles.open_account_info.recent_photos_path }}"
                                                               name="recent_photos_path"
                                                               lay-verify="recent_photos_path"
                                                               msg="{{ Lang.validate_identity1_path_not_null || "证件正面照片必须上传" }}"/>
                                                        <div class="layui-upload">
                                                            <div class="layui-upload-list" style="margin: 0 ; display: table">
                                                                <button type="button" class="layui-btn" lay-filter="identity1_img1" id="btn_upload"
                                                                        onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                                                </button>
                                                                <img class="layui-upload-img"
                                                                     src="/assets/member/images/pic.png"
                                                                     id="img_upload"
                                                                     onload="javascript:getImages(this,'{{ profiles.open_account_info.recent_photos_path }}')"
                                                                     style="width:150px; height: 150px; margin: 15px 0 50px 0;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="step-2-formulir-items">
                                                    <label for="RealAccountAttachmentIdentityName" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>Ktp/Sim/Passport
                                                    </label>
                                                        <div class="layui-input-block">
                                                            <input   type="hidden"
                                                                   name="identity_photos_path"
                                                                   lay-verify="identity_photos_path"
                                                                   value="{{ profiles.open_account_info.identity_photos_path }}"
                                                                   msg="{{ Lang.validate_identity1_path_not_null || "证件正面照片必须上传" }}"/>
                                                            <div class="layui-upload">
                                                                <div class="layui-upload-list" style="margin: 0 ; display: table">
                                                                    <button type="button" class="layui-btn" lay-filter="identity1_img1" id="btn_upload3"
                                                                            onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                                                    </button>
                                                                    <img class="layui-upload-img"
                                                                         id="img_upload3"
                                                                         src="/assets/member/images/pic.png"
                                                                         onload="javascript:getImages(this,'{{ profiles.open_account_info.identity_photos_path }}')"
                                                                         style="width:150px; height: 150px; margin: 15px 0 50px 0;"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                </div>
                                                <div class="step-2-formulir-items">
                                                    <label for="RealAccountAttachmentCaCcName" class="col-md-4 col-sm-12">
                                                        <strong class="text-danger">*</strong>
                                                        {{ Lang.form_account_others||"银行账户对账单（最近3个月）/信用卡账单/电力/电话账户" }}
                                                    </label>
                                                    <div class="layui-input-block">
                                                        <input   type="hidden"
                                                               name="bill_photo_path"
                                                               lay-verify="bill_photo_path"
                                                               value="{{ profiles.open_account_info.bill_photo_path }}"
                                                               msg="{{ Lang.form_bill_photo || "银行账户对账单照片必须上传" }}"/>
                                                        <div class="layui-upload" style="margin: 0 ; display: table">
                                                            <div class="layui-upload-list">
                                                                <button type="button" class="layui-btn" lay-filter="identity1_img4" id="btn_upload5"
                                                                        onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                                                </button>
                                                                <img class="layui-upload-img"
                                                                     id="img_upload5"
                                                                     src="/assets/member/images/pic.png"
                                                                     onload="javascript:getImages(this,'{{ profiles.open_account_info.bill_photo_path }}')"
                                                                     style="width:150px; height: 150px; margin: 15px 0 50px 0;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-12">
                                                <div class="step-2-formulir-items">
                                                    <label for="RealAccountAttachmentEpBillsName"
                                                           class="col-md-4 col-sm-12">
                                                       {{ Lang.form_document||"附加文本" }}
                                                    </label>
                                                    <div class="layui-input-block">
                                                        <input   type="hidden"
                                                               id="card_path2"
                                                               name="recent_photos_path2"
                                                               value="{{profiles.open_account_info.recent_photos_path2  }}"
                                                               msg="{{ Lang.validate_identity1_path_not_null || "证件反面照片上传" }}"/>
                                                        <div class="layui-upload">
                                                            <div class="layui-upload-list" style="margin: 0 ; display: table">
                                                                <button type="button" class="layui-btn" lay-filter="identity1_img1" id="btn_upload2"
                                                                        onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                                                </button>
                                                                <img class="layui-upload-img"
                                                                     id="img_upload2"
                                                                     src="/assets/member/images/pic.png"
                                                                     onload="javascript:getImages(this,'{{ profiles.open_account_info.recent_photos_path2 }}')"
                                                                     style="width:150px; height: 150px; margin: 15px 0 50px 0;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="step-2-formulir-items">
                                                    <label for="RealAccountAttachmentKkName"
                                                           class="col-md-4 col-sm-12">
                                                        {{ Lang.form_document||"附加文本" }}
                                                    </label>
                                                    <div class="layui-input-block">
                                                        <input   type="hidden"
                                                               name="identity_photos_path2"
                                                               value="{{ profiles.open_account_info.identity_photos_path2 }}"/>
                                                        <div class="layui-upload">
                                                            <div class="layui-upload-list" style="margin: 0; display: table">
                                                                <button type="button" class="layui-btn" lay-filter="identity1_img1" id="btn_upload4"
                                                                        onclick="return false;">{{ Lang.btn_uploadImg || "上传图片" }}
                                                                </button>
                                                                <img class="layui-upload-img"
                                                                     id="img_upload4"
                                                                     src="/assets/member/images/pic.png"
                                                                     onload="javascript:getImages(this,'{{ profiles.open_account_info.identity_photos_path2 }}')"
                                                                     style="width:150px; height: 150px; margin: 15px 0 50px 0;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-sm-12">
                                                <p class="help-block">
                                                    {{ Lang.form_photos_required||"JPG或PNG图像文件类型，每个文件最大为2M。" }}
                                                </p>
                                            </div>
                                        </div>
                                </div>
                                <div class="panel-footer">
                                    <div style="margin:0px 395px">
                                        {% if !active %}

                                        {% if  profiles.state == 1 %}
                                            <a href="/member/real_accounts/list"
                                               class="layui-btn layui-btn-primary">{{ Lang.button_back||"返回" }}</a>
                                            <a class="layui-btn" lay-submit="" lay-filter="register-submit" id="reg_submit"
                                                   >{{ Lang.button_save||"保存并继续" }}</a>
                                        {%else %}
                                            <a href="/member/real_accounts/profile"
                                               class="layui-btn layui-btn-primary layui-btn-disabled">{{ Lang.button_back||"返回" }}</a>
                                            <button class="layui-btn layui-btn-disabled" lay-submit="" lay-filter="register-submit"
                                                    onclick="return false;">{{ Lang.button_save||"保存并继续" }}</button>
                                        {% endif %}
                                        {%else %}
                                            <script>
                                                $(":input").attr("disabled", "disabled");
                                            </script>
                                        {% endif %}
                                    </div>
                                </div>
                                </div>
                            </form>
                        </div>
                    </div>


                </div>
            </div>
    </div>

{% endblock %}
<script type="text/javascript" src="/assets/vendors/layui/country_code.js"></script>
{% block js_assets %}
    <script>
        //=================================================================
        var select_account_type_map = new Object();
        {% for st in Lang.select.member.register.open_account_type %}
         select_account_type_map[{{ st.value }}] = "{{ st.label }}"
        {% endfor %}

        var rate_map = new Object();
        {% for st in Lang.select.member.register.open_rate %}
        rate_map[{{ st.value }}] = "{{ st.label }}"
        {% endfor %}

        var leverage_map = new Object();
        {% for st in Lang.select.member.register.leverage %}
        leverage_map[{{ st.value }}] = "{{ st.label }}"
        {% endfor %}
       //================================================================
        // select框 初始化国家代码
        $(function () {
            setCountryCode('house_number_country_code');
            setCountryCode('mobile_country_code');
            setCountryCode('ec_country_code');
            setCountryCode('job_phone_country_code');
            setCountryCode('job_fax_country_code');
            setCountryCode('bank1_phone_country_code');
            setCountryCode('bank2_phone_country_code');
        });
        function setCountryCode(id) {
            var proHtml = '';
            var val = $("#"+id).val();
            var cArr=[]
            for (var i = 0; i < country_code.length; i++) {
                cArr = country_code[i].split("-")
                if(val == cArr[2]){
                    proHtml += '<option value="' + cArr[2] + '" selected>' + cArr[0] + '(+' + cArr[2] + ')' + '</option>';
                }else {
                    proHtml += '<option value="' + cArr[2] + '">' + cArr[0] + '(+' + cArr[2] + ')' + '</option>';
                }
            }
            $("#"+id).append(proHtml);
        }

        function appendBank(id){
            if(id == 1){
                $("#nextBankBlock").show();
                $("#delete_btn").show();
                $("#add_btn").hide();
                $("#newBankStatus").val('delete');
            }else{
                $("#nextBankBlock").hide();
                $("#delete_btn").hide();
                $("#bank2_name").val('');
                $("#bank2_branch").val('');
                $("#bank2_phone_country_code").attr("disabled","disabled");
                $("#bank2_phone_name").val('');
                $("#bank2_account_number").val('');
                $("#bank2_swift_code").val('');
                $("#bank2_account_type_select").val('');
                $("#bank2_account_other").val('');
                $("#add_btn").show();
                $("#newBankStatus").val('add');
            }
        }


        //================================================================================
        //数字千位符格式化
        function toThousands(Id) {
            var value = $("#"+Id).val();
            value = value.toString().replace(/,/g,'');
            var num = (value || 0).toString(), result = '';
            while (num.length > 3) {
                result = ',' + num.slice(-3) + result;
                num = num.slice(0, num.length - 3);
            }
            if (num) {
                result = num + result;
            }
            if(value ==''){
                result ='';
            }
            $("#" + Id).val(result);
        }

    //填写姓名时，自动填充银行账户名称
    function fillOthersName(Id) {
        var value = $("#"+Id).val();
        $("#AccountName1").html(value);
        $("#AccountName2").html(value);
    }

    layui.use(['form', 'layedit', 'laydate','upload'], function () {
            var form = layui.form
                , layer = layui.layer
            //日期
            var laydate = layui.laydate;
            laydate.render({
                elem: '#birth_date',
                type: 'date',
                lang: laylang
            });

            form.on('submit(first-step)',function (data){
                var account_type = data.field.account_type;
                var rate = data.field.rate;
                var leverage = data.field.leverage;

                $("#review_country_type").html(select_account_type_map[account_type]);
                $("#review_rate").html(rate_map[rate]);
                $("#review_leverage").html(leverage_map[leverage]);
               $("#account_type").val(account_type);
               $("#account_rate_type").val(rate);
               $("#account_leverage").val(leverage);
               $("#select_account_type").hide();
               $("#person_info").show();
                return false;
            });


            form.verify({
                require:function(value,item){
                  if(!value){
                      return $(item).attr("msg");
                  }
                },
                account_type:function(value){
                  if(value.trim().length == 0){
                      return "{{ Lang.form_msg_account_type||"请选择账户类型" }}"
                  }
                },
                rate:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_select_rate||"请选择汇率" }}"
                    }
                },
                leverage:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_select_leverage||"请选择杠杆" }}"
                    }
                },
                full_name: function (value) {
                    if (value.trim().length == 0) {
                        return '{{ Lang.validate_full_name_not_null || "请输入全名" }}';
                    }

                    if(value.length > 0){
                        $("#AccountName1").html(value);
                        $("#AccountName2").html(value);
                    }
                },
                place: function (value) {
                    if (value.trim().length == 0) {
                        return '{{ Lang.validate_place || "出生地点必填项" }}'
                    }
                },
                house_ownership_other:function(value){
                    var select = $("#house_ownership").val();
                    if(select == 3 && value.trim().length == 0){
                        $("#house_ownership_other").focus();
                        return '{{ Lang.validate_house_ownership ||"请填写 House Ownership" }}'
                    }
                },
                birth_date: function (value) {
                    if (value.trim().length == 0) {
                        return '{{ Lang.validate_birthday_not_null||"出生日期必填项" }}'
                    }
                },

                identity_number: function (value) {
                    if (value.trim().length == 0) {
                        return '{{ Lang.validate_identity_no_not_null||"证件号码不能为空" }}'
                    }

                    if(value.trim().length > 0 && !/^[A-Za-z0-9]+$/.test(value)){
                        return "{{ Lang.validate_identity_style ||"证件号码必须是数字/字母/数组字母组合"}}"
                    }
                },
                postal_code:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_zip_code_not_null ||"请输入邮政编码" }}"
                    }

                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_zip_format_number||"邮政编码必须是数字" }}"
                    }
                },
                mobile_number:function(value){
                  if(value.trim().length == 0){
                      return '{{ Lang.validate_mobile_numble||"手机号码为必填项" }}';
                  }
                },
                investment_experience_desc: function (value) {
                    var select = $("#investment_experience_select").val();
                    if (select == 1) {
                        if(value.trim().length == 0){
                            return "{{ Lang.validate_investment_experience||"投资经验为必填项" }}"
                        }
                    }
                },
                purpose_of_account_opening_other: function(value){
                    var select = $("#purpose_of_account_opening").val();
                    if(select == 3){
                        if(value.trim().length == 0) {
                            return "{{ Lang.validate_user_account_purpose||"请输入开户目的" }}";
                        }
                    }
                },
                occupation_other:function (value){
                    var occupation = $("#occupation").val();
                    if(occupation == 6 ){
                        if(value.trim().length == 0){
                            return "{{ Lang.validate_occupation||"职业为必填项" }}"
                        }
                    }
                },
                job_postal_code:function(value){
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_zip_format_number||"邮政编码必须是数字" }}"
                    }
                },
                //----------职业信息 下的号码校验-------
                office_phone_number:function (value){
                   if(value.trim().length > 0 && !numberReg.test(value)){
                       return "{{Lang.validate_phone_is_number||"电话号码必须是数字"  }}";
                   }
                },

                office_fax_number:function(value){
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_user_work_facsimile_is_number||"办公传真号码必须是数字" }}";
                    }

                },
                personal_tax_number: function(value){
                    if(value.trim().length > 0 && !numLetterReg.test(value)){
                        return "{{ Lang.validate_tax_number_regular||"个人税号仅支持数字、字母、二者组合" }}"
                    }

                },
                ec_postal_code:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_zip_code_not_null ||"请输入邮政编码" }}"
                    }

                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_zip_format_number||"邮政编码必须是数字" }}"
                    }
                },
                ec_country_code:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_country_code_not_null ||"请选择country_code" }}"
                    }
                },
                ec_phone_number:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_bank_mobile_not_null ||"电话号码不能为空" }}"
                    }

                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_phone_is_number||"电话号码必须是数字" }}"
                    }
                },
                spouse_name:function(value){
                  var select = $("#marital_status_select").val();
                  if(select == 1){
                      if(value.trim().length == 0){
                          return "{{ Lang.validate_spouse_name ||"配偶的名字为必填项" }}"
                      }
                  }
                },

                bank1_phone_name:function(value){
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_bank_mobile_is_number||"手机号必须是数字" }}"
                    }
                },
                bank1_account_number:function(value){
                    if(value.trim().length == 0) {
                        return "{{ Lang.validate_card_no_not_null||"请填写银行卡号" }}"

                    }else if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_card_no_only_number||"银行卡号只能输入数字" }}"
                    }else{

                    }
                },
                bank1_swift_code:function(value){
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        return "{{ Lang.validate_bank_name_account_swift_number||"Swift Code 必须是数字" }}"
                    }
                },
                bank1_account_type_select:function(value){
                  if(value == -1){
                      return "{{ Lang.validate_account_type_not_chose||"请选择账户类型" }}"
                  }
                },

                bank1_account_other: function(value){
                    var select = $("#bank1_account_type_select").val();
                    if(select == 2 && value.trim().length == 0){
                        return "{{ Lang.validate_other_account_type||"请输入其他账户类型" }}"
                    }
                },

                length_of_services_in_previous_office : function(value){
                    if(value > 100){
                        return '{{ Lang.validate_previous_services_years_max||"工作年限不能大于100" }}';
                    }
                    if(value.trim().length > 0 && !/^([0-9][0-9]?|100)(\.[0-9])?$/.test(value)){
                        $("input[name=length_of_services_in_previous_office]").focus();
                        return '{{ Lang.validate_previous_services_years||"上一份工作年限必须是数字,可以包含一位小数" }}';
                    }
                },
                length_of_services : function(value){
                    if(value > 100){
                        return '{{ Lang.validate_previous_services_years_max||"工作年限不能大于100" }}';
                    }

                    if(value.trim().length > 0 && !/^([0-9][0-9]?|100)(\.[0-9])?$/.test(value)){
                        $("input[name=length_of_services]").focus();
                        return '{{ Lang.validate_services_years||"工作年限必须是数字,可以包含一位小数" }}';
                    }
                },
                mobile_country_code:function(value){
                    value = $("#mobile_country_code").val();
                  if(value.trim().length == 0){
                      return "{{ Lang.validate_country_code_not_null||"请填写Country code" }}"
                  }
                },
                house_number_country_code: function(value){
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        $("input[name=house_number_country_code]").focus();
                        return '{{ Lang.validate_country_code||"Country code必须是数字" }}';
                    }
                },
                house_facsimile_number: function(value){
                    if(value.trim().length > 0 && !numberReg.test(value)){
                        $("input[name=house_facsimile_number]").focus();
                        return '{{ Lang.validate_phone_is_number||"电话号码必须是数字" }}';
                    }
                },

                //-----bank info -- USD 点击 Add按钮，则全部都必填
                bank2_name:function(value){
                    if(bankStatus()){
                        if(value.trim().length == 0) {
                            return "{{ Lang.validate_bank_name_not_null_please||"请填写银行名称" }}"
                        }
                    }
                },
                bank2_branch:function(value){
                    if(bankStatus()){
                        if( value.trim().length == 0) {
                            return "{{ Lang.validate_branch_name_not_null_please||"请填写支行名称" }}"
                        }
                    }
                },
                bank2_account_number:function(value){
                    if(bankStatus()){
                        if(value.trim().length == 0) {
                            return "{{ Lang.validate_card_no_not_null||"请填写银行卡号" }}"

                        }else if(value.trim().length > 0 && !numberReg.test(value)){
                            return "{{ Lang.validate_card_no_only_number||"银行卡号只能输入数字" }}"
                        }else{

                        }
                    }
                },
                bank2_phone_country_code:function(value){
                    if(bankStatus()){
                       if(value.trim().length > 0 && !numberReg.test(value)){
                            return "{{ Lang.validate_country_code||"Country code必须是数字" }}"
                        }
                    }
                },
                bank2_phone_name:function(value){
                    if(bankStatus()){
                         if(value.trim().length > 0 && !numberReg.test(value)){
                            return "{{ Lang.validate_bank_mobile_is_number||"手机号必须是数字" }}"
                        }
                    }
                },
                bank2_swift_code:function(value){
                    if(bankStatus()){
                        if(value.trim().length > 0 && !numberReg.test(value)){
                            return "{{ Lang.validate_bank_name_account_swift_number||"Swift Code 必须是数字" }}"
                        }
                    }
                },
                bank2_account_type_select:function(value){
                    if(bankStatus()){
                        if(value == -1) {
                            return "{{ Lang.validate_account_type_not_chose||"请选择账户类型" }}"
                        }
                    }
                },

                bank2_account_other: function(value){
                    var select = $("#bank2_account_type_select").val();
                    if(select == 2 && value.trim().length == 0){
                        return "{{ Lang.validate_other_account_type||"请输入其他帐户类型" }}"
                    }
                },
//----------------------bank-info USD 校验结束-----------------------
                total:function(value){
                    if(value.trim().length ==0){
                        return "{{ Lang.validate_wealth_total||"请输入财产总额" }}"
                    }
                    value =value.replace(/,/g,'');
                    if(value.trim().length > 0 && !/^\+?[0-9][0-9]*$/.test(value)){
                        return "{{ Lang.validate_wealth_total_regular||"财产总额必须是正整数或0" }}"
                    }
                    if(value.trim().length > 23){
                        return "{{ Lang.validate_money_regular||"财产金额不能超过18位"}}";
                    }
                },
                wealth_others:function(value){
                    value =value.replace(/,/g,'');
                    if(value.trim().length > 0 && !/^\+?[0-9][0-9]*$/.test(value)){
                        return "{{ Lang.validate_wealth_other_regular||"其他财产金额必须是正整数或0" }}"
                    }
                    if(value.trim().length > 23){
                        return "{{ Lang.validate_money_regular||"财产金额不能超过18位"}}";
                    }
                },
                house_tax_value:function(value){
                    if(value.trim().length ==0){
                        return "{{ Lang.validate_house_tax_value||"请输入房产价值税" }}"
                    }
                    value =value.replace(/,/g,'');
                    if(value.trim().length > 0 && !/^[0-9]*$/.test(value)){
                        return "{{ Lang.validate_house_tax_value_regular||"房产价值税必须是正整数或0" }}"
                    }

                    if(value.trim().length > 23){
                        return "{{ Lang.validate_money_regular||"财产金额不能超过18位"}}";
                    }
                },
                time_deposit:function(value){

                    if(value.trim().length ==0){
                        return "{{ Lang.validate_time_deposit||'请输入定期存款额' }}"
                    }
                    value =value.replace(/,/g,'');
                    if(value.trim().length > 0 && !/^[0-9]*$/.test(value)){
                        return "{{ Lang.validate_time_deposit_regular||"定期存款额必须是正整数或0" }}"
                    }
                    if(value.trim().length > 23){
                        return "{{ Lang.validate_money_regular||"财产金额不能超过18位"}}";
                    }

                },
                recent_photos_path:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_recent_photo||"请上传最近的照片" }}";
                    }
                },
                identity_photos_path:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_identity_photo||"请上传证件照" }}";
                    }
                },
                bill_photo_path:function(value){
                    if(value.trim().length == 0){
                        return "{{ Lang.validate_bill_photo||"请上传银行账户对账单" }}";
                    }
                }

            });
        function bankStatus(){
            var status = $("#newBankStatus").val();
            if(status == 'delete'){
                return true;
            }
            return false;
        }
            //===============================下拉表联动 start==================
            //投资经验
            form.on("select(investment_experience_select)", function (data) {
                // data.value 是所选中的值
                if (data.value == 1) {
                    $("#investment_experience_desc").removeAttr("disabled");
                }
                if (data.value == 2) {
                    $("#investment_experience_desc").val('');
                    $("#investment_experience_desc").attr("disabled", "disabled");
                }

            });


            //房屋所有权房屋状况
            form.on("select(house_ownership)", function (data) {
                // data.value 是所选中的值
                if (data.value == 3) {
                    $("#house_ownership_other").removeAttr("disabled");
                } else {
                    $("#house_ownership_other").val('');
                    $("#house_ownership_other").attr("disabled", "disabled");
                }

            });
            //开户目的
            form.on("select(purpose_of_account_opening)", function (data) {
                // data.value 是所选中的值
                if (data.value == 3) {
                    $("#purpose_of_account_opening_other").removeAttr("disabled");
                } else {
                    $("#purpose_of_account_opening_other").val('');
                    $("#purpose_of_account_opening_other").attr("disabled", "disabled");
                }

            });
             //婚姻状况
            form.on("select(marital_status_select)", function (data) {
                // data.value 是所选中的值
                if (data.value == 1) {
                    $("#spouse_name").removeAttr("disabled");
                } else {
                    $("#spouse_name").val('');
                    $("#spouse_name").attr("disabled", "disabled");
                }

            });
            //职业
            form.on("select(occupation)", function (data) {
                // data.value 是所选中的值
                if (data.value == 6) {
                    $("#occupation_other").removeAttr("disabled");
                    $("#office_phone_number").removeAttr("disabled");
                    $("#office_fax_number").removeAttr("disabled");
                    $("#job_fax_country_code").removeAttr("layui-select-disabled");
                    $("#job_phone_country_code").removeAttr("layui-select-disabled");
                } else if(data.value == 2 || data.value == 5){

                    $("#office_phone_number").attr("disabled","disabled");
                    $("#job_phone_country_code").attr("disabled","disabled");
                    $("#office_fax_number").attr("disabled","disabled");
                    $("#job_fax_country_code").attr("disabled","disabled");
                    $("#office_phone_number").val('');
                    $("#job_phone_country_code").val('');
                    $("#office_fax_number").val('');
                    $("#job_fax_country_code").val('');

                }else{
                    $("#office_fax_number").removeAttr("disabled");
                    $("#office_phone_number").removeAttr("disabled");
                    $("#job_fax_country_code").removeAttr("layui-select-disabled");
                    $("#job_phone_country_code").removeAttr("layui-select-disabled");
                    $("#occupation_other").val('');
                    $("#occupation_other").attr("disabled", "disabled");
                }



            });

            //财富信息 - 银行账户类型
            form.on("select(bank1_account_type_select)", function (data) {
                // data.value 是所选中的值
                if (data.value == 2) {
                    $("#bank1_account_other").removeAttr("disabled");
                } else {
                    $("#bank1_account_other").val('');
                    $("#bank1_account_other").attr("disabled", "disabled");
                }

            });
            form.on("select(bank2_account_type_select)", function (data) {
                // data.value 是所选中的值
                if (data.value == 2) {
                    $("#bank2_account_other").removeAttr("disabled");
                } else {
                    $("#bank2_account_other").val('');
                    $("#bank2_account_other").attr("disabled", "disabled");
                }

            });
            //===============================下拉表联动 end==================
            //大表单提交
            form.on('submit(register-submit)', function (data) {
                $("#reg_submit").attr("disabled",true);
                $("#reg_submit").css({"pointer-events":"none","background":"#bbb"});
              var house_tax_value = (data.field.house_tax_value).replace(/,/g,'');
              var time_deposit = (data.field.time_deposit).replace(/,/g,'');
              var total=(data.field.total).replace(/,/g,'');
              var others= (data.field.wealth_others).replace(/,/g,'');
                var datas = {
                    "id":data.field.id,
                    "customer_id": window.user.user_id,
                    "account_type": data.field.account_type,
                    "account_rate_type":data.field.account_rate_type,
                    "account_leverage":data.field.account_leverage,
                    "open_account_info": {
                        "full_name": data.field.full_name,
                        "place": data.field.place,
                        "birthday":data.field.birthday+" 01:01:01",
                        "nationality":data.field.nationality,
                        "identity_type": data.field.identity_type,
                        "identity_number": data.field.identity_number,
                        "investment_experience": data.field.investment_experience_select,
                        "investment_experience_desc": data.field.investment_experience_desc,
                        "purpose_of_account_opening": data.field.purpose_of_account_opening,
                        "purpose_of_account_opening_other": data.field.purpose_of_account_opening_other,
                        "personal_tax_number": data.field.personal_tax_number,
                        "gender": data.field.gender,
                        "have_family_in":data.field.have_family_in,
                        "bankruptcy":data.field.bankruptcy,
                        "marital_status": data.field.marital_status_select,
                        "spouse_name": data.field.spouse_name,
                        "mother_maiden_name": data.field.mother_maiden_name,
                        "home_address": data.field.home_address,
                        "postal_code": data.field.postal_code,
                        "house_ownership": data.field.house_ownership,
                        "house_ownership_other": data.field.house_ownership_other,
                        "house_facsimile_number": data.field.house_facsimile_number,
                        "house_number_country_code":data.field.house_number_country_code,
                        "mobile_number": data.field.mobile_number,
                        "mobile_country_code":data.field.mobile_country_code,
                        "recent_photos_path": data.field.recent_photos_path,
                        "recent_photos_path2": data.field.recent_photos_path2,
                        "identity_photos_path": data.field.identity_photos_path,
                        "identity_photos_path2": data.field.identity_photos_path2,
                        "bill_photo_path": data.field.bill_photo_path,
                        "emergency_contact": {
                            "full_name": data.field.ec_full_name,
                            "country_code":data.field.ec_country_code,
                            "phone_number": data.field.ec_phone_number,
                            "relation_ship": data.field.relation_ship,
                            "home_address": data.field.ec_home_address,
                            "postal_code": data.field.ec_postal_code
                        },
                        "open_account_job": {
                            "occupation": data.field.occupation,
                            "occupation_other": data.field.occupation_other,
                            "name_of_company": data.field.name_of_company,
                            "business_field": data.field.business_field,
                            "title": data.field.title,
                            "length_of_services": data.field.length_of_services,
                            "length_of_services_in_previous_office": data.field.length_of_services_in_previous_office,
                            "company_address": data.field.company_address,
                            "postal_code": data.field.job_postal_code,
                            "office_phone_number": data.field.office_phone_number,
                            "phone_country_code": data.field.job_phone_country_code,
                            "office_fax_number": data.field.office_fax_number,
                            "fax_country_code": data.field.job_fax_country_code
                        },
                        "open_account_wealth_list": {
                            "annual": data.field.annual,
                            "location_of_house": data.field.location_of_house,
                            "house_tax_value": simpleData(house_tax_value),
                            "time_deposit":  simpleData(time_deposit),
                            "total": simpleData(total),
                            "others": simpleData(others)
                        },
                        "open_account_bank": [
                            {
                                "currency":"2",
                                "branch_swift_code":data.field.bank1_swift_code,
                                "bank_name": data.field.bank1_name,
                                "branch": data.field.bank1_branch,
                                "phone_name": data.field.bank1_phone_name,
                                "country_code":data.field.bank1_phone_country_code,
                                "account_number": data.field.bank1_account_number,
                                "account_name": data.field.full_name,
                                "account_type": data.field.bank1_account_type,
                                "account_other": data.field.bank1_account_other
                            },{
                                "currency":"1",
                                "branch_swift_code":data.field.bank2_swift_code,
                                "bank_name": data.field.bank2_name,
                                "branch": data.field.bank2_branch,
                                "phone_name": data.field.bank2_phone_name,
                                "country_code":data.field.bank2_phone_country_code,
                                "account_number": data.field.bank2_account_number,
                                "account_name": data.field.full_name,
                                "account_type": data.field.bank2_account_type,
                                "account_other": data.field.bank2_account_other

                            }]
                        }
                };

                $.ajax({
                    url: '/member/submit/real_account',
                    async: false,
                    data: {data:JSON.stringify(datas)},
                    type: 'POST',
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    success: function (data) {
                        closeLoading();
                        $("#reg_submit").removeClass("layui-btn-disabled");
                        var no=data.datas
                        if (data.status == 200) {
                           window.location.href="/member/real_accounts/step?no=" + no
                        }
                    }
                });

                return false;
            });
        });

        //去掉数字前面的0
        function simpleData(input){
            if(input.length > 0) {
                input = input.replace(/\b(0+)/gi, "");
            }
            return input;
        }
        function imagesLoad(elem,path,show_path,user_id){
            //上传照片
            var upload = layui.upload;
            //执行实例
            var recent_photos_path = $('input[name="'+path+'"]');
            var uploadInstA = upload.render({
                elem: '#'+elem //绑定元素
                , url: '/common/upload/' //上传接口
                , data: {role_type: 1, role_id: user_id}
                , exts: 'png|jpg|jpeg' //只允许上传png|jpg
                , accept: 'images' //允许上传的文件类型
                , size: IsPC() ? 2048 : 0 //最大允许上传的文件大小
                , auto: false
                , choose: function (obj) {
                    loading();
                    if (!IsPC()) {
                        obj.preview(function (index, file, result) {
                            var data = {role_type: 1, role_id:user_id}
                            resizeImageUpload(file, data, recent_photos_path)
                        })
                    } else {
                        uploadInstA.upload()
                    }
                    obj.preview(function (index, file, result) {
                        $('#'+ show_path).attr('src', result); //图片链接（base64）
                        $('#'+ show_path).show()
                        //$('input[name="identity2_path"]').val(result);
                    });
                }
                , before: function (obj) {
                    //预读本地文件示例，不支持ie8
                }
                , done: function (res) {
                    jQuery("#" + show_path).val(res.datas);
                    uploadSucc(res, recent_photos_path)
                }
                , error: function () {
                    closeLoading();
                    //演示失败状态，并实现重传
                    var txt_upload = $('#txt_upload');
                    txt_upload.html('<span style="color: #FF5722;">{{ Lang.msg_upload_error || "上传失败" }}</span> <a class="layui-btn layui-btn-mini demo-reload">{{ Lang.msg_retry || "重试" }}</a>');
                    txt_upload.find('.demo-reload').on('click', function () {
                        uploadInstA.upload();
                    });
                }
            });
        }

        layui.use(['upload'], function () {
            var user_id = window.user.user_id;
            imagesLoad('btn_upload','recent_photos_path','img_upload',user_id);
            imagesLoad('btn_upload2','recent_photos_path2','img_upload2',user_id);
            imagesLoad('btn_upload3','identity_photos_path','img_upload3',user_id);
            imagesLoad('btn_upload4','identity_photos_path2','img_upload4',user_id);
            imagesLoad('btn_upload5','bill_photo_path','img_upload5',user_id);
        });
    </script>
{% endblock %}
