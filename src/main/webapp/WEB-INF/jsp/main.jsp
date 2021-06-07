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
</head>
<body>

<h1>这里是首页</h1>
<h2>${sessionScope.get("adminLoginInfo")}</h2>

<form action="${pageContext.request.contextPath}/file/upLoad" enctype="multipart/form-data" method="post">

    <input type="file" name="file"/>
    <input type="submit" value="上传">


</form>


<a href="${pageContext.request.contextPath}/admin/loginOut">注销</a>


</body>
</html>
