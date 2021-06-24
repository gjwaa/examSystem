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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <style>
        #content {
            color: #fff;
        }
        a:visited {
            color: #fff;
            text-decoration: none;
        }
        a:hover {
            color: #000;
            text-decoration: none;
        }

    </style>
    <script>
        $(function () {
            $("#help").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/admin/help")
            });

            $("#newPaper").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/admin/newPaper")
            });

            var t = null;
            timer = setTimeout(time, 1000);

            function time() {
                clearTimeout(t);
                dt = new Date();
                var y = dt.getFullYear();
                var mt = dt.getMonth() + 1;
                var day = dt.getDate();
                var h = dt.getHours();//获取时
                var m = dt.getMinutes();//获取分
                var s = dt.getSeconds();//获取秒
                $("#currentDate").html("当前时间：" + y + "年" + mt + "月" + day + "日" + "-" + h + "时" + m + "分" + s + "秒");
                timer = setTimeout(time, 1000);
            }


        })


    </script>

</head>
<body>


<div style="background-color: rgba(7,47,72,0.89);height: 100%;width:100%;float: left">

    <div class="layui-container">
        <div style="text-align: center;margin-top: 13%" id="content">
            <h1 style="font-size: 40px">厦门市职业技能鉴定中心--鉴定站考试管理系统欢迎您！</h1><br><br>
            <label style="font-size: 28px">${sessionScope.get("adminLoginInfo")}&nbsp;&nbsp;</label>
            <a href="${pageContext.request.contextPath}/admin/loginOut" style="font-size: 20px">&nbsp;&nbsp;点击注销</a><br><br>
            <p id="currentDate" style="font-size: 20px"></p><br>
            <button class="layui-btn layui-btn-lg" id="newPaper">新建试卷</button>
            <button class="layui-btn layui-btn-lg" id="help">帮助</button>

        </div>
    </div>
</div>

</body>
</html>
