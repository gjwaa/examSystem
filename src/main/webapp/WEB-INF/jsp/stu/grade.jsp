<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/23
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考试成绩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>

</head>
<body>
<div class="layui-container">
    <fieldset class="layui-elem-field" style="margin-top: 30px;">
        <legend>考试成绩</legend>
        <div class="layui-field-box">
            <div class="layui-form">
                <table class="layui-table">
                    <tbody>
                    <tr>
                        <td>准考证号：</td>
                        <td>考生姓名：</td>
                    </tr>
                    <tr>
                        <td>考试科目：</td>
                        <td>科目名称：</td>
                    </tr>
                    <tr>
                        <td>考试工种：</td>
                        <td>等级：</td>
                    </tr>
                    <tr>
                        <td>科目成绩：</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </fieldset>

</div>
</body>
</html>
