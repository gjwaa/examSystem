<%--
  Created by IntelliJ IDEA.
  User: GJW
  Date: 2021/6/12
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>监考管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        body{
            width: 100%;
            height: 100%;
        }
    </style>
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
                        <button type="button" class="layui-btn" id="cheat">作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;弊</button>
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
                    <legend>监考中</legend>
                    <div class="layui-field-box">
                        <label>考试类型：</label>
                        <label>考试时间：</label>
                        <label>9999分钟</label>
                        <label>考试人数：</label>
                        <label>鉴定级别：</label>
                        <label>鉴定工种：</label>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>考生列表</legend>
                    <div class="layui-field-box">
                        <div class="layui-inline" style="border: #00FF00 3px solid;margin-left: 50px">
                            <label>准考证号</label><br>
                            <label>准考证号</label><br>
                            <label>准考证号</label><br>
                            <label>准考证号</label>
                        </div>
                        <div class="layui-inline" style="border: #eee 1px solid;margin-left: 50px">
                            <input type="checkbox" name="" value="123" lay-skin="primary">
                            <label>准考证号</label><br>
                            <label>准考证号</label><br>
                            <label>准考证号</label><br>
                            <label>准考证号</label>
                        </div>



                    </div>
                </fieldset>
            </div>
        </div>
    </div>

</div>


</body>
</html>
