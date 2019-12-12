<div id="sidebar">
    <ul class="side_nav">
        {% for me in Lang.menu %}
            <li class="active on hot"><!--当前子级选中状态class="active"-->
                {% if me.children.length == 0 %}
                    <a class="n4" href="{{ me.url }}">{{ me.label }}</a>
                {% else %}
                    <div class="jt"><img src="/assets/member/images/img/nav04.png"></div>
                    <a class="n{{ loop.index }}" href="javascript:void(0);">{{ me.label }}</a>
                    <ul>
                        {% for ch in me.children %}
                            <li {% if active == ch.key %} class="active" {% endif %}>
                                <a href="{{ ch.url }}">{{ ch.label }}</a>
                            </li>
                        {% endfor %}
                    </ul>
                {% endif %}
            </li>
        {% endfor %}
    </ul>
</div>

<script>

    $(function () {

        $(".active a").click(function () {
            $(this).next("ul").slideToggle();
            $(this).parent().toggleClass("on");
        });


    });


</script>