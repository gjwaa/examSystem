<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script>
        $(function () {
            $("#manage").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/admin/toLogin")
            });
            $("#exam").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/stuExam/login")
            });
        });

    </script>
</head>

<body>
<div style="height: 100%;width: 100%;background-color: rgba(7,47,72,0.89);float: left">

    <div style="text-align: center;margin-top: 20%">
        <h1 style="font-size: 58px;color: #fff">考试系统</h1><br><br><br><br>
        <button id="manage" class="layui-btn layui-btn-lg">管理端</button>
        <button id="exam" class="layui-btn layui-btn-lg">考试端</button>
    </div>
</div>


</body>
</html>

