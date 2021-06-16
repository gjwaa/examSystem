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
                    "limit": limit,
                    "page": (page-1)*limit
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
                            var div = '<div class="layui-inline" style="border: #eee 1px solid;margin: 20px 50px">' + '<input type="checkbox" name="" value="" lay-skin="primary"><br>'
                                + '<label>准考证号：'+res.data[i].aNumber+'</label><br>' + '<label>姓名：'+res.data[i].sName+'</label><br>'
                                + '<label>状态：</label>' + '<label>等待考试</label><br>' + '<label>成绩：</label>' + '<label>无</label>' + '</div>';
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
            new WebSocket("ws://" + host + "/ws?id="+Math.random());
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
            console.log(event.data);
            alert(event.data)
        }

        function onOpen(event) {
            console.log("握手成功");
            // webSocket.send("连接上了");
        }

        function onError(event) {
            // alert(event.data);
            alert("wrong")
        }

        function sendMsg(){
            webSocket.send("开始考试");
        }

        $(function (){
            $("#startExam").click(function (){
                sendMsg();
            });
        })

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
                        <label>考试状态：</label><br><br>
                        <label>等待倒计时：</label><br><br>
                        <label>99999</label><br><br>
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
