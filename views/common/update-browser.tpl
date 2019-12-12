<!DOCTYPE HTML>

<HTML lang="zh">
<HEAD>
    <META content="IE=11.0000"
          http-equiv="X-UA-Compatible">

    <META charset="utf-8">
    <META http-equiv="X-UA-Compatible" content="IE=Edge">
    <TITLE>{{ Lang.page_update_browser_title || "请升级您的浏览器" }}</TITLE>

    <STYLE type="text/css">
        html {
            background: url(http://static.smartisanos.cn/index/img/browser-update/browser_bg_dc2161cd93.jpg) left top;
            width: 100%;
            height: 100%;
        }

        body {
            font-family: "Microsoft YaHei", 微软雅黑, "STHei", 华文黑体, "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, p {
            margin: 0;
            padding: 0;
        }

        h1, h2, h3, h4, h5, h6, b {
            font-size: 100%;
            font-weight: normal;
        }

        ol, ul {
            list-style: none;
        }

        a {
            cursor: pointer;
            text-decoration: none;
        }

        .browser-update .update-window {
            background: url(http://static.smartisanos.cn/index/img/browser-update/browser_bg_wrapper_95bf26b64e.png) no-repeat left top;
            clear: both;
            left: 50%;
            width: 484px;
            height: 613px;
            margin-left: -242px;
            margin-top: -306.5px;
            position: absolute;
            top: 49%;
        }

        #update {
          /*  display: none;*/
        }

        .browser-update h1 {
            color: #212121;
            font-size: 24px;
            line-height: 24px;
            padding: 63px 0 0 0;
            text-align: center;
        }

        .browser-update h2 {
            color: #999;
            font-size: 14px;
            line-height: 24px;
            padding: 24px 57px 15px;
        }

        .browser-update h2.store {
            padding-top: 15px;
            padding-bottom: 11px;
        }

        .browser-update h3 {
            color: #666;
            font-size: 16px;
            line-height: 16px;
            padding: 20px 0 40px 0;
        }

        .browser-update h4 {
            color: #999;
            font-size: 14px;
            line-height: 20px;
        }

        /* 升级窗口 */
        .browser-update .update-window ul {
            margin: 0 -5px;
            overflow: hidden;
            padding: 0 57px;
        }

        .browser-update .update-window li {
            background: url(http://static.smartisanos.cn/index/img/browser-update/icon_border_74dc80aa0e.png) no-repeat left top;
            *display: inline;
            float: left;
            height: 55px;
            margin: 0 5px 10px;
            position: relative;
            text-align: center;
            width: 180px;
            *zoom: 1;
        }

        .browser-update .update-window li:hover {
            background-position: 0 -62px;
        }

        .browser-update .update-window a {
            background: url(http://static.smartisanos.cn/index/img/browser-update/browser_icon_b0cd0c83fd.png) no-repeat;
            display: block;
            height: 100%;
            width: 100%;
        }

        .browser-update .ie a {
            background-position: -190px 0;
        }

        .browser-update .firefox a {
            background-position: 0 -65px;
        }

        .browser-update .store a {
            background: url(http://static.smartisanos.cn/index/img/browser-update/store_icon_723934771b.png) no-repeat;
        }

        .browser-update .jd a {
            background-position: -190px 0;
        }

        /* 注册信息 */
        .browser-update .copyright {
            position: absolute;
            bottom: 0;
            width: 100%;
            color: #b3b3b3;
            font-size: 12px;
            padding: 0 0 52px;
            text-align: center;
        }

        .browser-update .copyright h5 {
            display: inline-block;
            line-height: 30px;
            *zoom: 1;
            *display: inline;
        }

        .browser-update .copyright ul {
            display: inline-block;
            margin: 0 0 0 8px;
            line-height: 30px;
            *zoom: 1;
            *display: inline;
        }

        .browser-update .copyright li {
            display: inline-block;
            line-height: 11px;
            padding: 0 8px;
            border-left: 1px solid #d3d3d3;
            *zoom: 1;
            *display: inline;
        }

        .browser-update .copyright a {
            color: #6c96f3;
        }

        .browser-update .copyright em {
            position: absolute;
            right: 2px;
            top: 6px;
            width: 2px;
            height: 2px;
            background: #bdbdbd;
        }

        .browser-update .copyright h6 {
            line-height: 30px;
        }

        .browser-update .copyright h6 a {
            color: #bdbdbd;
        }

        .browser-update .copyright h6 span {
            position: relative;
            padding-right: 10px;
        }
    </STYLE>
    <!--[if IE 6]>
    <script>
        var DD_belatedPNG = {
            ns: "DD_belatedPNG",
            imgSize: {},
            delay: 10,
            nodesFixed: 0,
            createVmlNameSpace: function () {
                if (document.namespaces && !document.namespaces[this.ns]) {
                    document.namespaces.add(this.ns, "urn:schemas-microsoft-com:vml")
                }
            },
            createVmlStyleSheet: function () {
                var b, a;
                b = document.createElement("style");
                b.setAttribute("media", "screen");
                document.documentElement.firstChild.insertBefore(b, document.documentElement.firstChild.firstChild);
                if (b.styleSheet) {
                    b = b.styleSheet;
                    b.addRule(this.ns + "\\:*", "{behavior:url(#default#VML)}");
                    b.addRule(this.ns + "\\:shape", "position:absolute;");
                    b.addRule("img." + this.ns + "_sizeFinder", "behavior:none; border:none; position:absolute; z-index:-1; top:-10000px; visibility:hidden;");
                    this.screenStyleSheet = b;
                    a = document.createElement("style");
                    a.setAttribute("media", "print");
                    document.documentElement.firstChild.insertBefore(a, document.documentElement.firstChild.firstChild);
                    a = a.styleSheet;
                    a.addRule(this.ns + "\\:*", "{display: none !important;}");
                    a.addRule("img." + this.ns + "_sizeFinder", "{display: none !important;}")
                }
            },
            readPropertyChange: function () {
                var b, c, a;
                b = event.srcElement;
                if (!b.vmlInitiated) {
                    return
                }
                if (event.propertyName.search("background") != -1 || event.propertyName.search("border") != -1) {
                    DD_belatedPNG.applyVML(b)
                }
                if (event.propertyName == "style.display") {
                    c = (b.currentStyle.display == "none") ? "none" : "block";
                    for (a in b.vml) {
                        if (b.vml.hasOwnProperty(a)) {
                            b.vml[a].shape.style.display = c
                        }
                    }
                }
                if (event.propertyName.search("filter") != -1) {
                    DD_belatedPNG.vmlOpacity(b)
                }
            },
            vmlOpacity: function (b) {
                if (b.currentStyle.filter.search("lpha") != -1) {
                    var a = b.currentStyle.filter;
                    a = parseInt(a.substring(a.lastIndexOf("=") + 1, a.lastIndexOf(")")), 10) / 100;
                    b.vml.color.shape.style.filter = b.currentStyle.filter;
                    b.vml.image.fill.opacity = a
                }
            },
            handlePseudoHover: function (a) {
                setTimeout(function () {
                    DD_belatedPNG.applyVML(a)
                }, 1)
            },
            fix: function (a) {
                if (this.screenStyleSheet) {
                    var c, b;
                    c = a.split(",");
                    for (b = 0; b < c.length; b++) {
                        this.screenStyleSheet.addRule(c[b], "behavior:expression(DD_belatedPNG.fixPng(this))")
                    }
                }
            },
            applyVML: function (a) {
                a.runtimeStyle.cssText = "";
                this.vmlFill(a);
                this.vmlOffsets(a);
                this.vmlOpacity(a);
                if (a.isImg) {
                    this.copyImageBorders(a)
                }
            },
            attachHandlers: function (i) {
                var d, c, g, e, b, f;
                d = this;
                c = {resize: "vmlOffsets", move: "vmlOffsets"};
                if (i.nodeName == "A") {
                    e = {
                        mouseleave: "handlePseudoHover",
                        mouseenter: "handlePseudoHover",
                        focus: "handlePseudoHover",
                        blur: "handlePseudoHover"
                    };
                    for (b in e) {
                        if (e.hasOwnProperty(b)) {
                            c[b] = e[b]
                        }
                    }
                }
                for (f in c) {
                    if (c.hasOwnProperty(f)) {
                        g = function () {
                            d[c[f]](i)
                        };
                        i.attachEvent("on" + f, g)
                    }
                }
                i.attachEvent("onpropertychange", this.readPropertyChange)
            },
            giveLayout: function (a) {
                a.style.zoom = 1;
                if (a.currentStyle.position == "static") {
                    a.style.position = "relative"
                }
            },
            copyImageBorders: function (b) {
                var c, a;
                c = {borderStyle: true, borderWidth: true, borderColor: true};
                for (a in c) {
                    if (c.hasOwnProperty(a)) {
                        b.vml.color.shape.style[a] = b.currentStyle[a]
                    }
                }
            },
            vmlFill: function (e) {
                if (!e.currentStyle) {
                    return
                } else {
                    var d, f, g, b, a, c;
                    d = e.currentStyle
                }
                for (b in e.vml) {
                    if (e.vml.hasOwnProperty(b)) {
                        e.vml[b].shape.style.zIndex = d.zIndex
                    }
                }
                e.runtimeStyle.backgroundColor = "";
                e.runtimeStyle.backgroundImage = "";
                f = true;
                if (d.backgroundImage != "none" || e.isImg) {
                    if (!e.isImg) {
                        e.vmlBg = d.backgroundImage;
                        e.vmlBg = e.vmlBg.substr(5, e.vmlBg.lastIndexOf('")') - 5)
                    } else {
                        e.vmlBg = e.src
                    }
                    g = this;
                    if (!g.imgSize[e.vmlBg]) {
                        a = document.createElement("img");
                        g.imgSize[e.vmlBg] = a;
                        a.className = g.ns + "_sizeFinder";
                        a.runtimeStyle.cssText = "behavior:none; position:absolute; left:-10000px; top:-10000px; border:none; margin:0; padding:0;";
                        c = function () {
                            this.width = this.offsetWidth;
                            this.height = this.offsetHeight;
                            g.vmlOffsets(e)
                        };
                        a.attachEvent("onload", c);
                        a.src = e.vmlBg;
                        a.removeAttribute("width");
                        a.removeAttribute("height");
                        document.body.insertBefore(a, document.body.firstChild)
                    }
                    e.vml.image.fill.src = e.vmlBg;
                    f = false
                }
                e.vml.image.fill.on = !f;
                e.vml.image.fill.color = "none";
                e.vml.color.shape.style.backgroundColor = d.backgroundColor;
                e.runtimeStyle.backgroundImage = "none";
                e.runtimeStyle.backgroundColor = "transparent"
            },
            vmlOffsets: function (d) {
                var h, n, a, e, g, m, f, l, j, i, k;
                h = d.currentStyle;
                n = {
                    W: d.clientWidth + 1,
                    H: d.clientHeight + 1,
                    w: this.imgSize[d.vmlBg].width,
                    h: this.imgSize[d.vmlBg].height,
                    L: d.offsetLeft,
                    T: d.offsetTop,
                    bLW: d.clientLeft,
                    bTW: d.clientTop
                };
                a = (n.L + n.bLW == 1) ? 1 : 0;
                e = function (b, p, q, c, s, u) {
                    b.coordsize = c + "," + s;
                    b.coordorigin = u + "," + u;
                    b.path = "m0,0l" + c + ",0l" + c + "," + s + "l0," + s + " xe";
                    b.style.width = c + "px";
                    b.style.height = s + "px";
                    b.style.left = p + "px";
                    b.style.top = q + "px"
                };
                e(d.vml.color.shape, (n.L + (d.isImg ? 0 : n.bLW)), (n.T + (d.isImg ? 0 : n.bTW)), (n.W - 1), (n.H - 1), 0);
                e(d.vml.image.shape, (n.L + n.bLW), (n.T + n.bTW), (n.W), (n.H), 1);
                g = {X: 0, Y: 0};
                if (d.isImg) {
                    g.X = parseInt(h.paddingLeft, 10) + 1;
                    g.Y = parseInt(h.paddingTop, 10) + 1
                } else {
                    for (j in g) {
                        if (g.hasOwnProperty(j)) {
                            this.figurePercentage(g, n, j, h["backgroundPosition" + j])
                        }
                    }
                }
                d.vml.image.fill.position = (g.X / n.W) + "," + (g.Y / n.H);
                m = h.backgroundRepeat;
                f = {T: 1, R: n.W + a, B: n.H, L: 1 + a};
                l = {X: {b1: "L", b2: "R", d: "W"}, Y: {b1: "T", b2: "B", d: "H"}};
                if (m != "repeat" || d.isImg) {
                    i = {T: (g.Y), R: (g.X + n.w), B: (g.Y + n.h), L: (g.X)};
                    if (m.search("repeat-") != -1) {
                        k = m.split("repeat-")[1].toUpperCase();
                        i[l[k].b1] = 1;
                        i[l[k].b2] = n[l[k].d]
                    }
                    if (i.B > n.H) {
                        i.B = n.H
                    }
                    d.vml.image.shape.style.clip = "rect(" + i.T + "px " + (i.R + a) + "px " + i.B + "px " + (i.L + a) + "px)"
                } else {
                    d.vml.image.shape.style.clip = "rect(" + f.T + "px " + f.R + "px " + f.B + "px " + f.L + "px)"
                }
            },
            figurePercentage: function (d, c, f, a) {
                var b, e;
                e = true;
                b = (f == "X");
                switch (a) {
                    case"left":
                    case"top":
                        d[f] = 0;
                        break;
                    case"center":
                        d[f] = 0.5;
                        break;
                    case"right":
                    case"bottom":
                        d[f] = 1;
                        break;
                    default:
                        if (a.search("%") != -1) {
                            d[f] = parseInt(a, 10) / 100
                        } else {
                            e = false
                        }
                }
                d[f] = Math.ceil(e ? ((c[b ? "W" : "H"] * d[f]) - (c[b ? "w" : "h"] * d[f])) : parseInt(a, 10));
                if (d[f] % 2 === 0) {
                    d[f]++
                }
                return d[f]
            },
            fixPng: function (c) {
                c.style.behavior = "none";
                var g, b, f, a, d;
                if (c.nodeName == "BODY" || c.nodeName == "TD" || c.nodeName == "TR") {
                    return
                }
                c.isImg = false;
                if (c.nodeName == "IMG") {
                    if (c.src.toLowerCase().search(/\.png$/) != -1) {
                        c.isImg = true;
                        c.style.visibility = "hidden"
                    } else {
                        return
                    }
                } else {
                    if (c.currentStyle.backgroundImage.toLowerCase().search(".png") == -1) {
                        return
                    }
                }
                g = DD_belatedPNG;
                c.vml = {color: {}, image: {}};
                b = {shape: {}, fill: {}};
                for (a in c.vml) {
                    if (c.vml.hasOwnProperty(a)) {
                        for (d in b) {
                            if (b.hasOwnProperty(d)) {
                                f = g.ns + ":" + d;
                                c.vml[a][d] = document.createElement(f)
                            }
                        }
                        c.vml[a].shape.stroked = false;
                        c.vml[a].shape.appendChild(c.vml[a].fill);
                        c.parentNode.insertBefore(c.vml[a].shape, c)
                    }
                }
                c.vml.image.shape.fillcolor = "none";
                c.vml.image.fill.type = "tile";
                c.vml.color.fill.on = false;
                g.attachHandlers(c);
                g.giveLayout(c);
                g.giveLayout(c.offsetParent);
                c.vmlInitiated = true;
                g.applyVML(c)
            }
        };
        try {
            document.execCommand("BackgroundImageCache", false, true)
        } catch (r) {
        }
        DD_belatedPNG.createVmlNameSpace();
        DD_belatedPNG.createVmlStyleSheet();

        DD_belatedPNG.fix('.browser-update, .chrome, .firefox, .ie');
    </script><![endif]-->
    <SCRIPT type="text/javascript">
        // window.onload = function() {
        // 浏览器判断
        var browser = {
            ua: navigator.userAgent.toLowerCase(),
            ie: function () {
                return /msie/.test(this.ua);
            }
        };

        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/msie/) != null || ua.match(/trident/) != null) {
            var browserVersion = ua.match(/msie ([\d.]+)/) != null ? ua.match(/msie ([\d.]+)/)[1] : ua.match(/rv:([\d.]+)/)[1];
          /* alert(browserVersion)
            if (browserVersion > 8 ) {
                location.href = "/"
            }*/
        }else if(!browser.ie()){
            window.location.href = '/';
        }

    </SCRIPT>

    <META name="GENERATOR" content="MSHTML 11.00.9600.17842">
</HEAD>
<BODY>
<DIV class="browser-update" id="update">
    <DIV class="update-window">
        <H1>{{ Lang.page_update_browser_title || "请升级您的浏览器" }}</H1>
        <H2>{{ Lang.page_update_browser_msg_txt || "尊敬的用户，您现在使用的 Internet Explore 浏览器版本过低，建议您升级至 Internet Explorer 9+ 版本 或使用其他浏览器（ 如：Google Chrome 或 Mozilla Firefox ），请升级后继续使用Real Time Futures的服务。" }}<br/></H2>
        <br>
        <br>
        <br>
        <UL>
            <LI class="chrome"><A href="https://www.google.cn/intl/zh-CN/chrome/browser/"
                                  target="_blank"></A></LI>
            <LI class="ie"><A href="https://support.microsoft.com/zh-cn/help/17621/internet-explorer-downloads"
                              target="_blank"></A></LI>
            <LI class="firefox"><A href="https://www.mozilla.org/zh-CN/firefox/new/"
                                   target="_blank"></A></LI>
        </UL>

    </DIV>
    <DIV class="copyright">
        <H5>Copyright © 2018 Real Time Futures. All rights reserved.</H5>
        </DIV>
</DIV>

</BODY>
</HTML>
