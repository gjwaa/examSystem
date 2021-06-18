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
    <title>考试</title>

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
    <script>
        $(function () {


            $.post({
                url: '${pageContext.request.contextPath}/exam/question',
                data: {
                    eID:${sessionScope.get("stuCheckInfo").getEID()}
                },
                dataType: 'json',
                success: function (res) {

                }
            });

            var host = window.location.host;
            var webSocket =
                new WebSocket("ws://" + host + "/ws?id=" + Math.random());
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
                if (receiveMsg.info == 'showTime') {
                    // console.log(receiveMsg.timeData)
                    $("#restTime").text(receiveMsg.timeData)
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

        })
    </script>
</head>
<body>

<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md6">
            <div class="grid-demo grid-demo-bg1">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>${sessionScope.get("qExamInfo").getEName()}</legend>
                    <div class="layui-field-box">
                        <label>科目代码：${sessionScope.get("qExamInfo").getCourseID()}</label>
                        <label>科目名称：${sessionScope.get("qExamInfo").getCourseName()}</label>
                        <label>准考证号：${sessionScope.get("stuCheckInfo").getANumber()}</label>
                        <label>考生姓名：${sessionScope.get("stuCheckInfo").getSName()}</label>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 10px;">
                    <div class="layui-field-box">
                        <label>${sessionScope.get("multipleTip")}</label><br><br>
                        <c:forEach items="${sessionScope.multiples}" var="mutipleOpt" varStatus="i">
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
                        <label>${sessionScope.get("singleTip")}</label><br><br>
                        <c:forEach items="${sessionScope.singles}" var="singleOpt" varStatus="i">
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
                        <label id="restTime">剩余时间：2:00:00</label><br>
                        <label>题目导航栏</label><br>
                        <div class="layui-form">
                            <table class="layui-table">
                                <tbody>
                                <tr>
                                    <c:forEach items="${sessionScope.get('all')}" var="question" varStatus="i">
                                        <td id="${i.index+1}">${i.index+1}</td>
                                    </c:forEach>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <label>共${sessionScope.get('all').size()}题</label><br>
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
