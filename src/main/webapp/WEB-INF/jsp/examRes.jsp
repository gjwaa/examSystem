<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/22
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>考试结果</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script>
        layui.use('table', function () {
            var table = layui.table;
            table.render({
                elem: '#resTable'
                , page: true
                , limit: 5
                , limits: [2, 3, 5]
                , method: 'post'
                , url: '${pageContext.request.contextPath}/exam/examRes/${sessionScope.examInfo.EID}'//restful
                , cellMinWidth: 80
                , cols: [[
                    {field: 'aNumber', title: '准考证号', sort: true, align: 'center'}
                    , {field: 'sName', title: '考生姓名', align: 'center'}
                    , {
                        field: 'eName', title: '考试科目', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.eName;
                        }
                    }
                    , {
                        field: 'courseName', title: '科目名称', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.courseName;
                        }
                    }
                    , {
                        field: 'eWork', title: '工种', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.eWork;
                        }
                    }
                    , {
                        field: 'eLevel', title: '等级', align: 'center', templet: function (ExamInfo) {
                            return ExamInfo.examInfo.eLevel;
                        }
                    }
                    , {
                        field: 'stuGrade', title: '成绩', align: 'center', templet: function (Grade) {
                            return Grade.grade.stuGrade;
                        }
                    }
                    , {
                        field: 'state', title: '状态', align: 'center', templet: function (Grade) {
                            return Grade.grade.state;
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

        $(function (){
            $("#outPut").click(function (){
                $(location).attr("href","${pageContext.request.contextPath}/exam/outPut/${sessionScope.examInfo.EID}")
            })
        })



    </script>
</head>
<body>

<div class="layui-container">
    <fieldset class="layui-elem-field" style="margin-top: 30px;">
        <legend>参考人员总成绩列表</legend>
        <div class="layui-field-box">
            <table class="layui-hide" id="resTable"></table>
            <div style="text-align: center"><button class="layui-btn" id="outPut">导出成绩</button></div>
        </div>
    </fieldset>

</div>


</body>
</html>
