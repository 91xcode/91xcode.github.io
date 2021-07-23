/*
 *Progcessed By JSDec in 0.02s
 *JSDec - JSDec.js.org
 */
null == navigator.userAgent.match(/iPad|iPhone|Android|iPod/i) && "https:" == window.location.protocol && (window.location.href = "http://" + window.location.host + window.location.pathname);
var jxUrl = "/dplayer.html?url=";
function play(n) {
    var t, e = ".m3u8",
    o = function n(t, e) {
        return t === e
    },
    i = "yka",
    r = "播放窗口",
    c = function n(t, e) {
        return t + e
    },
    d = function n(t, e) {
        return t + e
    },
    a = "43%",
    s = function n(t, e) {
        return e < t
    },
    l = function n(t, e) {
        return e < t
    },
    u = "http://183.207.249.9",
    p = "http://223.110.245.167",
    h = function n(t, e) {
        return t !== e
    },
    f = "LEc",
    m = "AtH",
    v = "该频道目前只支持手机端播放",
    w = function n(t, e) {
        return e < t
    },
    y = "http://183.207.249.35",
    x = function n(t, e) {
        return e < t
    },
    j = function n(t, e) {
        return t + e
    },
    C = function n(t, e) {
        return t + e
    },
    g = function n(t, e) {
        return t(e)
    };
    if (function n(t, e) {
        return t == e
    } (n.toLowerCase().indexOf(e), -1)) o("wDK", i) ? layer.open({
        title: r,
        type: 2,
        area: [c(document.body.clientWidth, "px"), "43%"],
        shadeClose: !0,
        content: d(jxUrl, encodeURIComponent(n))
    }) : (t = '<video class="video-js vjs-default-skin" controls preload="none" autoplay><source src="', t += n, t += '"></video>', layer.open({
        type: 1,
        title: r,
        area: [d(document.body.clientWidth, "px"), a],
        shadeClose: !0,
        content: t,
        success: function(n, t) {
            var e = "height",
            o = "100%",
            i = "width"; (function n(t, e) {
                return t(e)
            })($, ".video-js").css(e, o),
            $(".video-js").css(i, o)
        }
    }));
    else if (null != navigator.userAgent.match(/iPad|iPhone|Android|iPod/i)) layer.open({
        title: r,
        type: 2,
        area: [d(document.body.clientWidth, "px"), "43%"],
        shadeClose: !0,
        content: d(jxUrl, encodeURIComponent(n))
    });
    else {
        if (s(n.indexOf("http://121.31.30.90:8085"), -1) || l(n.indexOf(u), -1) || -1 < n.indexOf(p)) {
            if (h(f, m)) return void layer.msg(v);
            window.location.href = d("http://" + window.location.host, window.location.pathname)
        }
        if (w(n.indexOf("http://stream.mastvnet.com"), -1) || -1 < n.indexOf(y) || x(n.indexOf("http://zhibo.hkstv.tv"), -1)) return void layer.msg(v);
        layer.open({
            title: "播放窗口",
            type: 2,
            maxmin: !0,
            area: [j(document.body.clientWidth, "px"), "43%"],
            shadeClose: !0,
            content: C(jxUrl, g(encodeURIComponent, n))
        })
    }
}
"undefined" != typeof encode_version && "sojson.v5" === encode_version || window.alert("不能删除sojson.v5"),
encode_version = "sojson.v5";
