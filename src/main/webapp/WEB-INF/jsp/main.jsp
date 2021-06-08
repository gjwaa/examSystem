<%--
  Created by IntelliJ IDEA.
  User: GJW
  Date: 2021/6/6
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>

    <script>
        $(function () {
            $("#help").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/admin/help")
            }),
            $("#newPaper").click(function () {
                    $(location).attr("href", "${pageContext.request.contextPath}/admin/newPaper")
            })


        })
    </script>
    <script>

    </script>
</head>
<body>

<h2>${sessionScope.get("adminLoginInfo")}</h2>
<a href="${pageContext.request.contextPath}/admin/loginOut">注销</a>

<div class="layui-container">
    <h2>xx市职业技能鉴定中心--鉴定站考试管理系统欢迎您！</h2>
    <button class="layui-btn layui-btn-primary layui-border-green" id="newPaper">新建试卷</button>
    <button class="layui-btn layui-btn-primary layui-border-green" id="help">帮助</button>
    <label>当前时间：xxx</label>
</div>


</body>
</html>
