$(function() {
    var time;
    var showDiv = document.getElementById("showDiv");
    var btn = document.getElementById("click");
    var h = 23;
    var m = 59;
    var s = 59;

//没有点击开始按钮的时候"showDiv"显示24:00:00,并且btn显示“开始”
    function init() {
        showDiv.innerHTML = "24:00:00";
        btn.value = "开始";
    }

//如果点击开始之后btn显示"开始"

    btn.onclick = function () {
        if (btn.value == "开始") {
            btn.value = "暂停";
            time = setInterval("run()", 1000);
        } else {
            btn.value = "开始";
            clearInterval(time);
        }
    }

//进行倒计时显示
    function run() {
        --s;
        if (s < 0) {
            --m;
            s = 59;
        }
        if (m < 0) {
            --h;
            m = 59
        }
        if (h < 0) {
            s = 0;
            m = 0;
        }
        showDiv.innerHTML = h + ":" + m + ":" + s;
    }
})