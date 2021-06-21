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
            queryAll(1, 2);
        });

        function queryAll(page, limit) {
            $.post({
                url: "${pageContext.request.contextPath}/exam/stuInfo",
                async: false,
                dataType: 'json',
                data: {
                    // "limit": limit,
                    // "page": (page - 1) * limit
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
                            var div = '<div class="layui-inline" style="border: #eee 1px solid;margin: 20px 50px" id="">' + '<input type="checkbox" name="" value="" lay-skin="primary"><br>'
                                + '<label>准考证号：' + res.data[i].aNumber + '</label><br>' + '<label>姓名：' + res.data[i].sName + '</label><br>'
                                + '<label>状态：</label>' + '<label id="' + res.data[i].sID + '">' + '等待登录</label><br>' + '<label>成绩：</label>' + '<label>无</label>' + '</div>';
                            $("#stuList").append(div);

                        }
                    })
                }
            });
        }
    </script>
    <script>

        var host = window.location.host;
        var webSocket =
            new WebSocket("ws://" + host + "/ws?id=admin");
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

        function onMessage(event) {
            var receiveMsg = JSON.parse(event.data)
            if (receiveMsg.info == 'stuExamIng') {
                $("#" + receiveMsg.data).html("考试中")
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

        function startExam() {
            var msg = {
                info: "startExam",
                data: ""
            };
            webSocket.send(JSON.stringify(msg));
        }

        $(function () {

            $.post({
                url: "${pageContext.request.contextPath}/exam/checkStuState",
                dataType: "json",
                success: function (res) {
                    console.log(res)
                    for (let x in res) {
                        $("#" + res[x].sID).html(res[x].state);
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
                    //如果已经开始状态，禁按钮...未做
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
                            startExam();
                            $("#stateLabel").text('考试状态：考试中');
                            getTime();
                        }
                    }
                });
            }

            $("#startExam").click(function () {
                startFun();
                $("#startExam").attr("class", "layui-btn layui-btn-disabled").attr("disabled", "disabled");
                $("#pauseExam").attr("class", "layui-btn").removeAttr("disabled");
            });

            function getTime() {
                $.post({
                    url: "${pageContext.request.contextPath}/exam/getRestTime",
                    data: {
                        eID: "${sessionScope.get("examInfo").getEID()}"
                    },
                    dataType: "text",
                    success: function (res) {
                        countDown(res)
                    }
                });
            };

            var timer = null;

            function countDown(times) {
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
                    setRestTime(hour * 60 * 60 + minute * 60 + second);
                    var show = hour + "小时：" + minute + "分钟：" + second + "秒"
                    var wsMsg = {
                        info: "showTime",
                        timeData: show
                    }
                    webSocket.send(JSON.stringify(wsMsg));
                    $("#timeDown").text(show)
                    times--;
                }, 1000);
                if (times <= 0) {
                    clearInterval(timer);
                }
            };


            function setRestTime(time) {
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
                $("#pauseExam").attr("class", "layui-btn layui-btn-disabled").attr("disabled", "disabled");
                $("#startExam").attr("class", "layui-btn").removeAttr("disabled");
                $.post({
                    url: "${pageContext.request.contextPath}/exam/pauseExam",
                    dataType: "text",
                    success: function (res) {
                        if (res == 'pause') {
                            clearInterval(timer);
                            $("#stateLabel").text('考试状态：暂停考试');
                            var pauseMsg = {
                                info: "pauseExam",
                                data: "all"
                            }
                            webSocket.send(JSON.stringify(pauseMsg));
                        }
                    }
                });
            });


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
                        <label>等待倒计时：</label><br><br>
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
