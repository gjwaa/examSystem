<%--
  Created by IntelliJ IDEA.
  User: GJW
  Date: 2021/6/13
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script>
        var selText;
        $(function () {
            $.post({
                url: '${pageContext.request.contextPath}/stuExam/getEName',
                data: {"getEName":'#'},
                dataType: 'json',
                success: function (res) {
                    console.log(res)
                    for (let i = 0; i < res.data.length; i++) {
                        $('#eNameSel').append(new Option(res.data[i], i + 1));// 下拉菜单里添加元素
                    }
                    layui.form.render('select');
                }
            });

            layui.use('form', function() {
                var form = layui.form;
                form.on('select(eNameSel)', function (data) {
                     selText = data.elem.selectedOptions[0].text;
                });
            });

            $("#IDCard").blur(function (){
                var isIDCard = checkIDCard($("#IDCard").val())
                if(isIDCard){
                    $("#tips").text("身份证号输入正确")
                }else {
                    $("#tips").text("身份证号输入有误")
                }
            });

            $("#sName").blur(function (){
                var isName = checkName($("#sName").val())
                if(isName){
                    $("#tips").text("名字输入正确")
                }else {
                    $("#tips").text("名字输入有误")
                }
            });

            function checkIDCard(str) {
                var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                return reg.test(str);
            };

            function checkName(str){
                var reg = /^[\u4e00-\u9fa5]{2,4}$/;
                return reg.test(str);
            };

            $("#login").click(function (){
                $.post({
                    url:'${pageContext.request.contextPath}/stuExam/stuLogin',
                    data:{
                        "eName":selText,
                        "aNumber":$("#aNUmber").val(),
                        "IDCard":$("#IDCard").val(),
                        "sName":$("#sName").val(),
                    },
                    dataType: 'text',
                    success:function (res){
                        if (res=='loginPass')
                        $(location).attr("href","${pageContext.request.contextPath}/stuExam/waitExam")
                    }
                })
            });

        })
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;z-index: -1;background: url('${pageContext.request.contextPath}/images/bk.png') no-repeat;background-size: 100% 100%">
    <div class="layui-row">
        <div class="layui-col-md12" style="width: 100%;height: 30%"></div>
    </div>
    <div class="layui-container">
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="grid-demo grid-demo-bg1">&nbsp;</div>
            </div>
            <div class="layui-col-md4" style="background: rgba(255,255,255,0.5);border-radius: 20px">
                <div class="grid-demo">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                        <legend>学生考试系统</legend>
                    </fieldset>
                    <div class="layui-container" style="width: 100%">
                        <form class="layui-form layui-form-pane" action="" method="post" >
                            <div class="layui-form-item">
                                <label class="layui-form-label">考试名称：</label>
                                <div class="layui-input-inline">
                                    <select name="" id="eNameSel" lay-filter="eNameSel" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">准考证号：</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="aNUmber" name="aNUmber" placeholder="请输入准考证号"
                                           autocomplete="off"
                                           class="layui-input" oninput="value=value.replace(/[\W]/g,'')"
                                           style="ime-mode:inactive" required>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">身份证号：</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="IDCard" name="IDCard" placeholder="请输入身份证号"
                                           autocomplete="off"
                                           class="layui-input" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"
                                           style="ime-mode:inactive" required>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label">姓名：</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="sName" name="eName" placeholder="请输入姓名" autocomplete="off"
                                           class="layui-input" style="ime-mode:inactive" required>
                                </div>
                            </div>

                            <div class="layui-form-mid layui-word-aux" id="tips" style="color: #009688">提示：请输入信息</div>

                            <div class="layui-form-item">
                                <div class="layui-container" style="width: 85%" ;>
                                    <input type="button" id="login"
                                           class="layui-btn layui-btn-primary layui-border-green" value="登录">
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
