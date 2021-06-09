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
    <title>登录页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script>
        $(function () {
            $("#verifyImg").click(function () {
                $("#verifyImg").attr("src", "${pageContext.request.contextPath}/admin/verify?" + Math.random());
            })

            $("#acc").blur(function () {
                $.post({
                    url: "${pageContext.request.contextPath}/admin/checkAcc",
                    data: {
                        "acc": $("#acc").val()
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data == "accPass") {
                            $("#tips").text("账号正确")
                        } else if (data == "accUnPass") {
                            $("#tips").text("账号不存在")
                        }
                    }
                })
            })

            $("#pwd").blur(function () {
                $.post({
                    url: "${pageContext.request.contextPath}/admin/checkPwd",
                    data: {
                        "pwd": $("#pwd").val()
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data == "pwdPass") {
                            $("#tips").text("密码正确")
                        } else if (data == "pwdUnPass") {
                            $("#tips").text("密码错误")
                        }
                    }
                })
            })

            $("#verify").blur(function () {
                $.post({
                    url: "${pageContext.request.contextPath}/admin/checkVerify",
                    data: {
                        "verify": $("#verify").val()
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data == "verifyPass") {
                            $("#tips").text("验证码正确")
                        } else if (data == "verifyUnPass") {
                            $("#tips").text("验证码错误")
                        }
                    }
                })
            })

        })
    </script>
</head>

<body>
<div style="width: 100%;height: 100%;z-index: -1;background: url('${pageContext.request.contextPath}/images/bk.png') no-repeat;background-size: 100% 100%">
    <div class="layui-row">
        <div class="layui-col-md12" style="width: 100%;height: 30%"> </div>
    </div>
    <div class="layui-container">
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="grid-demo grid-demo-bg1">&nbsp;</div>
            </div>
            <div class="layui-col-md4" style="background: rgba(255,255,255,0.5);border-radius: 20px">
                <div class="grid-demo">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                        <legend>考试后台登录系统</legend>
                    </fieldset>
                    <div class="layui-container">
                        <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/admin/login"
                              method="post">
                            <div class="layui-form-item">
                                <label class="layui-form-label">账号</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="acc" name="acc" lay-verify="required" placeholder="请输入账号"
                                           autocomplete="off" class="layui-input"
                                           onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" style="ime-mode:inactive"
                                           required>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="pwd" name="pwd" placeholder="请输入密码" autocomplete="off"
                                           class="layui-input" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"
                                           style="ime-mode:inactive" required>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">验证码</label>
                                <div class="layui-input-inline">
                                    <div class="layui-inline" style="width: 40%; height: 35px;">
                                        <input id="verify" name="clientVerify" class="layui-input" style="width: 85px"
                                               type="text" placeholder="验证码" autocomplete="off"
                                               onkeyup="value=value.replace(/[^\w\.\/]/ig,'')" style="ime-mode:inactive"
                                               required/>
                                    </div>
                                    <img style="cursor:hand" src="${pageContext.request.contextPath}/admin/verify" id="verifyImg"/>

                                </div>
                            </div>
                            <div class="layui-form-mid layui-word-aux" id="tips" style="color: #009688">提示：请输入信息</div>


                            <div class="layui-form-item">
                                <div class="layui-container" style="width: 85%";>
                                <input type="submit" id="login" class="layui-btn layui-btn-primary layui-border-green"
                                       value="登录">
                                <input type="reset" class="layui-btn layui-btn-primary layui-border-green" value="重置">
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="grid-demo grid-demo-bg1">&nbsp;</div>
            </div>
        </div>
    </div>

</div>

</body>
</html>


