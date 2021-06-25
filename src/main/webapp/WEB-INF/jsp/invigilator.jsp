<%--
  Created by IntelliJ IDEA.
  User: GJW
  Date: 2021/6/12
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>监考管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        body {
            width: 100%;
            height: 100%;
        }
    </style>

    <script>
        $(function () {
            queryAll(1, 6);
        });

        function queryAll(page, limit) {
            $.post({
                url: "${pageContext.request.contextPath}/exam/stuInfo",
                async: false,
                dataType: 'json',
                data: {
                    "page": page,
                    "limit": limit
                },
                success: function (data) {
                    console.log(data)
                    var res = data;
                    stuNum = res.data.length;
                    count = res.count;
                    layui.use('laypage', function () {
                        var laypage = layui.laypage;
                        laypage.render({
                            elem: 'page' //注意，这里的 test1 是 ID，不用加 # 号
                            , count: count //数据总数，从服务端得到
                            , limit: limit                     //每页显示条数
                            , curr: page //获取起始页
                            //跳转页码时调用
                            , jump: function (obj, first) { //obj为当前页的属性和方法，第一次加载first为true
                                //非首次加载 do something
                                if (!first) {
                                    //调用加载函数加载数据
                                    queryAll(obj.curr, obj.limit);
                                }
                            }
                        });
                        $("#stuList").children().remove();
                        for (let i = 0; i < stuNum; i++) {
                            var div = '<div class="layui-inline" style="border: #eee 1px solid;margin: 20px 50px" id="">' + '<input type="checkbox" name="' + 'stuCheckBox' + '"value="' + res.data[i].sID + '"lay-skin="primary"><br>'
                                + '<label>准考证号：' + res.data[i].aNumber + '</label><br>' + '<label>姓名：' + res.data[i].sName + '</label><br>'
                                + '<label>状态：</label>' + '<label class="examState" id="' + res.data[i].sID + '">' + '等待登录</label><br>' + '<label>成绩：</label>' + '<label name="' + res.data[i].sID + '">无</label>' + '</div>';
                            $("#stuList").append(div);
                        }
                        if ($("#allSelect").is(":checked")) {
                            $("input[name='stuCheckBox']").attr("checked", "true");
                        }
                    })
                }
            });
        }
    </script>
    <script>

        var host = window.location.host;
        var webSocket =
            new WebSocket("ws://" + host + "/examSystem/ws?id=admin");
        var hum = null;
        var s_json = null;
        webSocket.onerror = function (event) {
            onError(event);
        };
        webSocket.onopen = function (event) {
            onOpen(event);
        };
        webSocket.onmessage = function (event) {
            onMessage(event);
        };
        webSocket.onclose = function (event) {
            onClose(event);
        };

        function onMessage(event) {
            var receiveMsg = JSON.parse(event.data)
            console.log(event.data)
            if (receiveMsg.info == 'stuExamIng') {
                $("#" + receiveMsg.data).html("考试中");
            }
            if (receiveMsg.info == 'isHandPaper') {
                $("#" + receiveMsg.data).html(receiveMsg.state);
                $("[name='" + receiveMsg.data + "']").html(receiveMsg.point);
            }

        }

        function onOpen(event) {
            console.log("握手成功");
            // webSocket.send("连接上了");
        }

        function onError(event) {
            // alert(event.data);
            alert("wrong")
        }

        function onClose(event) {
            var msg = {
                info: "close",
                data: ""
            };
            webSocket.send(JSON.stringify(msg));

        }

        function startExam() {
            var msg = {
                info: "startExam",
                data: ""
            };
            // webSocket.send(JSON.stringify(msg));
            try {
                webSocket.send(JSON.stringify(msg));
            } catch(err) {
                var tryTime = 0;
                // 重试10次，每次之间间隔3秒
                if (tryTime < 1) {
                    var t1 = setTimeout(function () {
                        tryTime++;
                        webSocket.send(JSON.stringify(msg));
                    }, 3*1000);
                } else {
                    console.error("重连失败.");
                }
            }

        }

        var allSID = '';
        $(function () {
            $.post({
                url: "${pageContext.request.contextPath}/exam/checkStuState",
                dataType: "json",
                success: function (res) {
                    console.log(res)
                    for (let x in res) {
                        $("#" + res[x].sID).html(res[x].state);
                        $("[name='" + res[x].sID + "']").html(res[x].stuGrade);
                        allSID += res[x].sID + ','
                    }
                }
            });


            $.post({
                url: "${pageContext.request.contextPath}/exam/checkExamState",
                data: {
                    eID: "${sessionScope.get("examInfo").getEID()}"
                },
                dataType: "text",
                success: function (res) {
                    if (res == '考试中') {
                        $("#startExam").attr("class", "layui-btn layui-btn-disabled").attr("disabled", "disabled");
                        startFun();
                    } else if (res == '暂停考试') {
                        $("#pauseExam").attr("class", "layui-btn layui-btn-disabled").attr("disabled", "disabled");
                        $.post({
                            url: "${pageContext.request.contextPath}/exam/getRestTime",
                            data: {
                                eID: "${sessionScope.get("examInfo").getEID()}"
                            },
                            dataType: "text",
                            success: function (times) {
                                // alert(times)
                                var hour = 0,
                                    minute = 0,
                                    second = 0;
                                if (times > 0) {
                                    hour = Math.floor(times / (60 * 60));
                                    minute = Math.floor(times / 60) - (hour * 60);
                                    second = Math.floor(times) - (hour * 60 * 60) - (minute * 60);
                                }
                                if (hour <= 9) hour = '0' + hour;
                                if (minute <= 9) minute = '0' + minute;
                                if (second <= 9) second = '0' + second;
                                $("#timeDown").text(hour + "小时：" + minute + "分钟：" + second + "秒")
                            }
                        });
                    }
                    $("#stateLabel").text('考试状态：' + res);

                }
            });

            function startFun() {
                $.post({
                    url: "${pageContext.request.contextPath}/exam/startExam",
                    dataType: "text",
                    success: function (res) {
                        if (res == 'start') {
                            startExam();//socket
                            $("#stateLabel").text('考试状态：考试中');
                            getTime();
                        }
                    }
                });
            }

            //开始考试
            $("#startExam").click(function () {
                layer.confirm('是否开始考试', {
                    btn: ['是', '否'] //按钮
                }, function () {
                    startFun();
                    $("#startExam").attr("class", "layui-btn layui-btn-disabled").attr("disabled", "disabled");
                    $("#pauseExam").attr("class", "layui-btn").removeAttr("disabled");
                    layer.msg('考试已开始', {icon: 1});
                });
            });

            function getTime() {
                $.post({
                    url: "${pageContext.request.contextPath}/exam/getRestTime",
                    data: {
                        eID: "${sessionScope.get("examInfo").getEID()}"
                    },
                    dataType: "text",
                    success: function (res) {
                        // alert('getTime:' + res);
                        countDown(res);
                    }
                });
            };

            var timer = null;

            function countDown(times) {
                // alert("countDown:" + times)
                timer = setInterval(function () {
                    var hour = 0,
                        minute = 0,
                        second = 0;
                    if (times > 0) {
                        hour = Math.floor(times / (60 * 60));
                        minute = Math.floor(times / 60) - (hour * 60);
                        second = Math.floor(times) - (hour * 60 * 60) - (minute * 60);
                    }
                    if (hour <= 9) hour = '0' + hour;
                    if (minute <= 9) minute = '0' + minute;
                    if (second <= 9) second = '0' + second;
                    var h = hour * 60 * 60;
                    var m = minute * 60;
                    var s = second;
                    // console.log(h + ":" + m + ":" + s)
                    setRestTime(parseInt(h) + parseInt(m) + parseInt(s));
                    var show = hour + "小时：" + minute + "分钟：" + second + "秒"
                    var wsMsg = {
                        info: "showTime",
                        timeData: show
                    }
                    webSocket.send(JSON.stringify(wsMsg));
                    $("#timeDown").text(show)
                    if (times <= 0) {
                        clearInterval(timer);
                        layer.msg("时间到，已强制提交所有试卷");
                        $("stateLabel").text("考试状态：考试结束")
                        var msg = {
                            info: "over",
                            data: ""
                        }
                        webSocket.send(JSON.stringify(msg));
                        changeOver();
                    }
                    times--;
                }, 1000);

            };

            function changeOver() {
                $.post({
                    url: "${pageContext.request.contextPath}/exam/setOver",
                    data: {
                        eID: "${sessionScope.get("examInfo").getEID()}"
                    },
                    dataType: "text",
                    success: function (res) {
                        console.log(res)
                    }
                });
            }

            function setRestTime(time) {
                if (time > 8000) {
                    alert(time);
                    alert("问题在这！");
                }
                $.post({
                    url: "${pageContext.request.contextPath}/exam/setRestTime",
                    data: {
                        restTime: time,
                        eID: "${sessionScope.get("examInfo").getEID()}"
                    },
                    dataType: "text",
                    success: function (res) {
                        console.log(res)
                    }
                });
            }


            $("#pauseExam").click(function () {
                layer.confirm('是否暂停考试', {
                    btn: ['是', '否'] //按钮
                }, function () {
                    $("#pauseExam").attr("class", "layui-btn layui-btn-disabled").attr("disabled", "disabled");
                    $("#startExam").attr("class", "layui-btn").removeAttr("disabled");
                    $.post({
                        url: "${pageContext.request.contextPath}/exam/pauseExam",
                        dataType: "text",
                        success: function (res) {
                            if (res == 'pause') {
                                clearInterval(timer);
                                $("#stateLabel").text('考试状态：暂停考试');
                                $(".examState").text("暂停考试")
                                var pauseMsg = {
                                    info: "pauseExam",
                                    data: "all"
                                }
                                webSocket.send(JSON.stringify(pauseMsg));
                            }
                        }
                    });
                    layer.msg('考试已暂停', {icon: 1});
                });

            });

            $("#compulsorySubmit").click(function () {
                layer.confirm('是否强制交卷', {
                    btn: ['是', '否'] //按钮
                }, function () {
                    if ($("input[type='checkbox']:checked").length != 0) {
                        var msg = {
                            info: "compulsorySubmit",
                            data: ""
                        };
                        selectStu(msg)
                        layer.msg('已强制交卷', {icon: 1});
                    } else {
                        layer.msg('请选择要提交的考生', {icon: 2});
                    }
                });

            });

            $("#cheat").click(function () {
                layer.confirm('是否提交作弊', {
                    btn: ['是', '否'] //按钮
                }, function () {
                    if ($("input[type='checkbox']:checked").length != 0) {
                        var msg = {
                            info: "cheatSubmit",
                            data: ""
                        };
                        selectStu(msg)
                        layer.msg('已提交作弊', {icon: 1});
                    } else {
                        layer.msg('请选择要提交作弊的考生', {icon: 2});
                    }
                });
            });

            $("#violation").click(function () {
                layer.confirm('是否提交违纪', {
                    btn: ['是', '否'] //按钮
                }, function () {
                    if ($("input[type='checkbox']:checked").length != 0) {
                        var msg = {
                            info: "violation",
                            data: ""
                        };
                        selectStu(msg)
                        layer.msg('已提交违纪', {icon: 1});
                    } else {
                        layer.msg('请选择要提交违纪的考生', {icon: 2});
                    }
                });
            });

            $("#exportRes").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/exam/examResPaper");
            });

            function selectStu(msg) {
                $("input[type='checkbox']:checked").each(function () {
                    msg.data += $(this).val() + ','
                });
                webSocket.send(JSON.stringify(msg));
                if ($("#allSelect").is(":checked")) {
                    msg.data = allSID;
                    webSocket.send(JSON.stringify(msg));
                }
            };

            $("#allSelect").click(function () {
                $("input[name='stuCheckBox']").attr("checked", this.checked);
            })


        });


    </script>
</head>
<body>

<div class="layui-container">


    <div class="layui-row">
        <div class="layui-col-md2">
            <div class="grid-demo grid-demo-bg1">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>监考操作</legend>
                    <div class="layui-field-box">
                        <label id="stateLabel">考试状态：</label><br><br>
                        <label>考试倒计时：</label><br><br>
                        <label id="timeDown"></label><br><br>
                        <button type="button" class="layui-btn" id="startExam">开始考试</button>
                        <br><br>
                        <button type="button" class="layui-btn" id="compulsorySubmit">强制交卷</button>
                        <br><br>
                        <button type="button" class="layui-btn" id="cheat">
                            作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;弊
                        </button>
                        <br><br>
                        <button type="button" class="layui-btn" id="violation">违&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;纪</button>
                        <br><br>
                        <button type="button" class="layui-btn" id="pauseExam">暂停考试</button>
                        <br><br>
                        <button type="button" class="layui-btn" id="exportRes">导出成绩</button>
                    </div>
                </fieldset>
            </div>
        </div>
        <div class="layui-col-md10">
            <div class="grid-demo">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>监考中——本场考试名称：${sessionScope.get("examInfo").getEName()}</legend>
                    <div class="layui-field-box">
                        <label>考试类型：${sessionScope.get("examInfo").getEType()}&nbsp;</label>
                        <label>考试时间：</label>
                        <label>${sessionScope.get("examInfo").getETime()}&nbsp;</label>
                        <label>考试人数：${sessionScope.get("examInfo").getEPeople()}&nbsp;</label>
                        <label>鉴定级别：${sessionScope.get("examInfo").getELevel()}&nbsp;</label>
                        <label>鉴定工种：${sessionScope.get("examInfo").getEWork()}&nbsp;</label>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>考生列表</legend>
                    <div class="layui-field-box">
                        <input type="checkbox" id="allSelect">全选</input>
                        <div id="stuList" class="layui-inline" style="border: #eee 1px solid;margin: 20px 50px"></div>
                        <div id="page"></div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

</div>


</body>
</html>
