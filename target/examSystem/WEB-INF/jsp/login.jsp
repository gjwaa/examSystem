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
    <title>登录页面</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/user/login" method="post">
        账号：<input type="text" name="acc"/>
        密码：<input type="text" name="pwd"/>
        登录：<input type="submit" value="登录"/>
    </form>
</body>
</html>
