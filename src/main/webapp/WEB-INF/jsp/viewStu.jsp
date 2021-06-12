<%--
  Created by IntelliJ IDEA.
  User: GJW
  Date: 2021/6/12
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考生预览</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/html" id="stuId">
        {{d.LAY_TABLE_INDEX+1}}
    </script>
    <script>

        layui.use('table', function () {
            var table = layui.table;
            table.render({
                elem: '#viewStu'
                ,page: true
                ,limit:3
                ,limits:[2,3,5]
                ,method:'post'
                , url: '${pageContext.request.contextPath}/exam/stuInfo'
                , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                , cols: [[
                    {title: '序号', templet: '#stuId',width:'6%',align:'center'}
                    , {field: 'sName', title: '姓名',width:'10%', sort: true,align:'center'}
                    , {field: 'IDCard', title: '身份证号',templet:function (Student) {
                            return Student.iDCard;
                        },width:'30%',align:'center'}
                    , {field: 'aNumber', title: '准考证号',align:'center'}
                    , {field: 'examInfo', title: '考试名称',templet:function (ExamInfo) {
                            return ExamInfo.examInfo.eName;
                        },width:'28%',align:'center'}
                    , {field: 'eLevel', title: '鉴定等级',templet: function (ExamInfo){
                            return ExamInfo.examInfo.eLevel;
                        },align:'center'}
                ]]
                , parseData: function (res) {
                    console.log(res.data)
                    return {
                        "code": res.code,
                        "msg": res.msg,
                        "count":res.count,
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
        <legend>考生预览</legend>
        <div class="layui-field-box">
            <table class="layui-hide" id="viewStu"></table>
        </div>
    </fieldset>

</div>

</body>
</html>
