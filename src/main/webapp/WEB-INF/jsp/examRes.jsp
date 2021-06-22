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
                    , {field: '', title: '准考证号', width: '10%', sort: true, align: 'center'}
                    , {field: '', title: '考生姓名', width: '30%', align: 'center'}
                    , {field: '', title: '考试科目', align: 'center'}
                    , {field: '', title: '科目名称', width: '28%', align: 'center'}
                    , {field: '', title: '工种', align: 'center'}
                    , {field: '', title: '等级', align: 'center'}
                    , {field: '', title: '成绩', align: 'center'}
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
    </script>
</head>
<body>

<div class="layui-container">
    <fieldset class="layui-elem-field" style="margin-top: 30px;">
        <legend>参考人员总成绩列表</legend>
        <div class="layui-field-box">
            <table class="layui-hide" id="resTable"></table>
        </div>
    </fieldset>

</div>


</body>
</html>
