<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/16
  Time: 9:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>信息核实</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script>

        layui.use('table', function () {
            var table = layui.table;
            table.render({
                elem: '#checkInfoTable'
                , page: false
                , method: 'post'
                , url: '${pageContext.request.contextPath}/stuExam/infoTable'
                , cellMinWidth: 80
                , cols: [[
                    {field: 'aNumber', title: '准考证号', sort: true, align: 'center'}
                    , {field: 'sName', title: '考生姓名', align: 'center'}
                    , {
                        field: 'IDCard', title: '身份证号', align: 'center', templet: function (Student) {
                            return Student.iDCard;
                        }
                    }
                    , {
                        field: 'courseID', title: '考试科目代码', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.courseID;
                        }
                    }
                    , {
                        field: 'courseName', title: '考试科目名称', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.courseName;
                        }
                    }
                    , {
                        field: 'eWork', title: '考试工种', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.eWork;
                        }
                    }
                    , {
                        field: 'eLevel', title: '考试等级', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.eLevel;
                        }
                    }
                ]]
                , parseData: function (res) {
                    console.log(res.data)
                    return {
                        "code": res.code,
                        "msg": res.msg,
                        "count": res.count,
                        "data": res.data
                    };
                }
            });
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
            // alert(event.data)
            if (event.data == 'startExam') {
                $("#examBtn").attr("class", "layui-btn").removeAttr("disabled");
                $("#examBtn").text("进入考试")
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

        $(function () {
            $.post({
                url: '${pageContext.request.contextPath}/stuExam/checkState',
                dataType: 'text',
                success: function (res) {
                    if (res == 'start') {
                        $("#examBtn").attr("class", "layui-btn").removeAttr("disabled");

                        $("#examBtn").text("进入考试")
                    }

                }
            });

            $("#examBtn").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/exam/paper")
            });


        })

        $("#examBtn").attr("disable", true);
    </script>

</head>
<body>

<div class="layui-container">
    <fieldset class="layui-elem-field" style="margin-top: 30px;">
        <legend>信息核实</legend>
        <div class="layui-field-box">
            <table class="layui-hide" id="checkInfoTable"></table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field" style="margin-top: 30px;">
        <legend>考前须知</legend>
        <div class="layui-field-box">
            <label>。。。</label>
        </div>
    </fieldset>
    <div style="text-align: center">

        <button class="layui-btn layui-btn-disabled" id="examBtn" disabled="disabled">等待考试</button>

    </div>


</div>


</body>
</html>
