{% extends '../../common/layouts/layout.tpl' %}






{% block content %}



    <div class="main_content">
        <div class="main_content_holder">
            <div id="fund">
                <div class="main_head">
                    <div class="main_head_unit">
                        {{ Lang.form_user_all_show || "用户总览" }}
                    </div>
                    <div class="main_head_text required"></div>
                </div>
                <div class="main_page_Info">
                    <div class="form">
                        <div class="form_input ">
                            <div class="sale_home">

                                <div class="sale_home_item">
                                    <h3>{{ Lang.form_my_customer_num || "我的客户总数：" }}<i>100 </i> {{ Lang.form_person || "人" }} </h3>
                                    <table>
                                        <tr>
                                            <th>{{ Lang.form_current_month_customer_new || "本月新增客户数" }}</th>
                                            <th>{{ Lang.form_current_month_customer_deposit || "本月新增客户入金" }}</th>
                                            <th>{{ Lang.form_current_month_customer_withdraw || "本月新增客户出金" }}</th>
                                            <th>{{ Lang.form_current_month_customer_transaction || "本月新增客户交易量" }}</th>
                                        </tr>
                                        <tr>
                                            <td>1{{ Lang.form_person || "人" }}</td>
                                            <td>$10000</td>
                                            <td>$900</td>
                                            <td>1{{ Lang.form_hand || "手" }}</td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="sale_home_item">
                                    <h3>{{ Lang.form_my_ib_num || "我的代理总数" }}<i>100 </i> {{ Lang.form_person || "人" }} </h3>
                                    <table>
                                        <tr>
                                            <th width="33%">{{ Lang.form_current_month_ib_new || "本月新增代理数" }}</th>
                                            <th width="33%">{{ Lang.form_current_month_ib_deposit || "本月新增代理入金" }}</th>
                                            <th width="33%">{{ Lang.form_current_month_ib_withdraw || "本月新增代理出金" }}</th>

                                        </tr>
                                        <tr>
                                            <td>1{{ Lang.form_person || "人" }}</td>
                                            <td>$10000</td>
                                            <td>$900</td>

                                        </tr>
                                    </table>
                                </div>

                                <div class="sale_home_item">
                                    <h3>{{ Lang.form_my_rebate_num || "我的返佣返利总数" }}<i>$100 </i>  </h3>
                                    <table>
                                        <tr>
                                            <th width="33%">{{ Lang.form_current_month_rebate_new || "本月新增返佣返利" }}</th>
                                            <th width="33%">{{ Lang.form_customer_balance_rebate || "客户余额返利" }}</th>
                                            <th width="33%">{{ Lang.form_customer_transaction_rebate || "客户交易返佣" }}</th>
                                        </tr>
                                        <tr>
                                            <td>$800</td>
                                            <td>$100</td>
                                            <td>$900</td>

                                        </tr>
                                    </table>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


{% endblock %}











{% block js_assets %}
    <script>
        //Demo
        layui.use(['form'], function () {

            var form = layui.form;
            //自定义验证规则
            form.verify({
                titles: function (value) {
                    if (value.length < 5) {
                        return '{{ Lang.validate_title_format_error || "标题至少得5个字符啊" }}';
                    }
                }
            });
            //监听提交
            form.on('submit(formDemo1)', function (data) {
                layer.msg(JSON.stringify(data.field));
                return false;
            });

        });
    </script>

{% endblock %}