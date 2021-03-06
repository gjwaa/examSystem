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
    <style>
        #fieldFix {
            position: fixed;
            z-index: 100;
            width: 25%;
        }
    </style>
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
                        <c:forEach items="${sessionScope.multipleOptList}" var="mutipleOpt" varStatus="i">
                            <label>${mutipleOpt.getQNum()}</label>
                            <label>${mutipleOpt.getQTitle()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;A.${mutipleOpt.getQOptA()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;B.${mutipleOpt.getQOptB()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;C.${mutipleOpt.getQOptC()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;D.${mutipleOpt.getQOptD()}</label><br>
                            <div class="layui-input-block">
                                <input type="checkbox" name="${i.index+1}" lay-skin="primary">&nbsp;A&nbsp;</input>
                                <input type="checkbox" name="${i.index+1}" lay-skin="primary">&nbsp;B&nbsp;</input>
                                <input type="checkbox" name="${i.index+1}" lay-skin="primary">&nbsp;C&nbsp;</input>
                                <input type="checkbox" name="${i.index+1}" lay-skin="primary">&nbsp;D&nbsp;</input>
                            </div>
                        </c:forEach>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 10px;">
                    <div class="layui-field-box">
                        <label>${sessionScope.get("singleInfo")}</label><br><br>
                        <c:forEach items="${sessionScope.singleOptList}" var="singleOpt" varStatus="i">
                            <label>${singleOpt.getQNum()}</label>
                            <label>${singleOpt.getQTitle()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;A.${singleOpt.getQOptA()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;B.${singleOpt.getQOptB()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;C.${singleOpt.getQOptC()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;D.${singleOpt.getQOptD()}</label><br>
                            <div class="layui-input-block">
                                <input type="radio" name="${i.index+1}">&nbsp;A&nbsp;</input>
                                <input type="radio" name="${i.index+1}">&nbsp;B&nbsp;</input>
                                <input type="radio" name="${i.index+1}">&nbsp;C&nbsp;</input>
                                <input type="radio" name="${i.index+1}">&nbsp;D&nbsp;</input>
                            </div>
                        </c:forEach>
                    </div>
                </fieldset>


            </div>
        </div>

        <div class="layui-col-md6">
            <div class="grid-demo" id="fieldFix">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>注意事项</legend>
                    <div class="layui-field-box">
                        <label>1、本试卷依据2005年颁布的《数控二手车》国家职业标准命制，考试时间120分钟</label><br>
                        <label>2、本试卷依据2005年颁布的《数控二手车》国家职业标准命制，考试时间120分钟</label><br>
                        <label>3、本试卷依据2005年颁布的《数控二手车》国家职业标准命制，考试时间120分钟</label><br>
                        <label>剩余时间：2:00:00</label><br>
                        <label>题目导航栏</label><br>
                        <div class="layui-form">
                            <table class="layui-table">
                                <tbody>
                                <c:forEach items="${sessionScope.get('allQuestion')}" var="question" varStatus="i">
                                    <td>${question.getQNum()}</td>
                                    <c:if test="${(i.index+1)%5==0}">
                                        <tr></tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <label>共${sessionScope.get('allQuestion').size()}题</label><br>
                        <label>已答？题</label><br>
                        <label>还剩？题</label><br>
                        <button class="layui-btn layui-btn-disabled layui-btn-primary layui-border-green">交卷</button>
                    </div>
                </fieldset>
            </div>
        </div>

    </div>


</div>


</body>
</html>
