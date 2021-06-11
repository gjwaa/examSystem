<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/11
  Time: 9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>预览试卷</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>

</head>
<body>

<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md6">
            <div class="grid-demo grid-demo-bg1">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>${sessionScope.get("examInfo").getEName()}</legend>
                    <div class="layui-field-box">
                        <label>科目代码：${sessionScope.get("examInfo").getCourseID()}</label>
                        <label>科目名称：${sessionScope.get("examInfo").getCourseName()}</label>
                        <label>准考证号：null</label>
                        <label>考生姓名：null</label>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 10px;">
                    <div class="layui-field-box">
                        <label>${sessionScope.get("multipleInfo")}</label><br><br>
                        <c:forEach items="${sessionScope.singleOptList}" var="singleOpt" varStatus="i">
                            <label>${singleOpt.getQNum()}</label>
                            <label>${singleOpt.getQTitle()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;A.${singleOpt.getQOptA()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;B.${singleOpt.getQOptB()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;C.${singleOpt.getQOptC()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;D.${singleOpt.getQOptD()}</label><br>
                            <div class="layui-input-block">
                                <input class="" type="radio" name="${i.index+1}">&nbsp;A&nbsp;</input>
                                <input type="radio" name="${i.index+1}">&nbsp;B&nbsp;</input>
                                <input type="radio" name="${i.index+1}">&nbsp;C&nbsp;</input>
                                <input type="radio" name="${i.index+1}">&nbsp;D&nbsp;</input>
                            </div>
                        </c:forEach>
                    </div>
                </fieldset>
                <label>${sessionScope.get("singleInfo")}</label>
            </div>
        </div>

        <div class="layui-col-md6">
            <div class="grid-demo" style="background-color: black">
                &nbsp;
            </div>
        </div>

    </div>



</div>



</body>
</html>
