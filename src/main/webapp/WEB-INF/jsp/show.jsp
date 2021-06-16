<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/16
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>测试</title>
    <base href="<%=basePath%>">
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

    </script>
</head>
<body>

<button onclick="sendMsg()" >开始考试</button>

</body>
</html>

