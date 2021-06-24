<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/8
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>考试管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        body {
            height: 100%;
        }
    </style>
    <script>

        layui.use(['upload', 'element', 'layer'], function () {
            var $ = layui.jquery
                , upload = layui.upload
                , element = layui.element
                , layer = layui.layer;
            var inputValue;
            var files;
            //选完文件后不自动上传
            upload.render({
                elem: '#choseFile'
                , url: '${pageContext.request.contextPath}/admin/upLoad'
                , auto: false
                //,multiple: true
                , accept: 'file' //普通文件
                , exts: 'zip'
                , size: '10240'
                , bindAction: '#doUpload'
                , choose: function (obj) {
                    layer.prompt({
                        formType: 1,
                        value: '',
                        title: '请输入压缩包解压密码',
                        btn: ['确定', '取消'], //按钮，
                        btnAlign: 'c',
                    }, function (value, index) {
                        layer.close(index);
                        inputValue = value;
                        console.log(value)
                        var oldFiles = obj.pushFile();
                        for (let x in oldFiles) {
                            delete oldFiles[x];
                        }

                        var files = obj.pushFile();
                        obj.preview(function (index, file, result) {
                            console.log(files[index].name);
                            $("#fileName").text('文件名称：' + files[index].name);
                            layer.msg("加载成功，请点击上传");
                        });
                    });


                }
                , before: function (obj) {
                    layer.load(); //上传loading
                    this.data = {'zipPwd': inputValue};

                }
                , done: function (res) {

                    layer.msg('上传成功');
                    layer.closeAll('loading');
                    for (let x in files) {
                        console.log(files[x].name)
                        delete files[x];
                    }
                    layer.msg('解析中');
                    layer.load();
                    <%--$(location).attr("href", "${pageContext.request.contextPath}/exam/showInfo")--%>
                    $.post({
                        url: "${pageContext.request.contextPath}/exam/showInfo",
                        dataType: "",
                        success: function (res) {
                            if (res == 'ok') {
                                tableInfo();
                                $("#paperInfo").css("display", "block")
                                layer.closeAll('loading');
                                layer.msg('解析成功');
                            }

                        }
                    });
                    console.log(res)

                }
                , error: function (res) {
                    layer.msg('解压密码有误');
                    layer.closeAll('loading');
                    console.log(res)
                }
            });

        });


        function tableInfo() {
            layui.use('table', function () {
                var table = layui.table;

                table.render({
                    elem: '#examInfo'
                    , page: false
                    , url: '${pageContext.request.contextPath}/exam/examInfo'
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                    , cols: [[
                        {field: 'eName', title: '考试名称', sort: true, width: "12%"}
                        , {field: 'courseName', title: '考试试卷', width: "13%"}
                        , {field: 'eTime', title: '考试时间', sort: true}
                        , {field: 'eType', title: '考试类型'}
                        , {field: 'eWork', title: '鉴定工种',}
                        , {field: 'eOrgan', title: '鉴定机构'}
                        , {field: 'eLevel', title: '鉴定等级'}
                        , {field: 'eScore', title: '及格分数', sort: true}
                        , {field: 'ePeople', title: '考试人数', sort: true}
                    ]]
                    , parseData: function (res) {
                        console.log(res)
                        return {
                            "code": res.code,
                            "msg": res.msg,
                            "data": res.data
                        };
                    }
                });
            });
        }

        $(function () {
            $("#viewPaper").click(function () {
                layer.open({
                    title: '试卷预览',
                    type: 2,
                    area: ['90%', '90%'],
                    fixed: false, //不固定
                    maxmin: true,
                    content: '${pageContext.request.contextPath}/exam/viewPaper'
                });
            })
        });

        $(function () {
            $("#viewInfo").click(function () {
                <%--window.open('${pageContext.request.contextPath}/exam/viewStu');--%>
                layer.open({
                    title: '考生预览',
                    type: 2,
                    area: ['90%', '90%'],
                    fixed: false, //不固定
                    maxmin: true,
                    content: '${pageContext.request.contextPath}/exam/viewStu'
                });
            })
        });

        $(function () {
            $("#confirmInfo").click(function () {
                $(location).attr("href", "${pageContext.request.contextPath}/exam/invigilator")
            })
        });


    </script>
</head>
<body>
<div class="layui-container">

    <div class="layui-row">
        <div class="layui-col-md1">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>
        <div class="layui-col-md10">
            <div class="grid-demo">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 80px;">
                    <legend>试卷导入</legend>
                </fieldset>
                <div class="layui-field-box">
                    <form class="layui-form layui-form-pane" action="" enctype="multipart/form-data" method="post">
                        <div class="layui-btn-container">
                            <button type="button" class="layui-btn layui-btn-normal" id="choseFile">选择文件</button>
                            <button type="button" class="layui-btn" id="doUpload">开始上传</button>
                        </div>
                        <div class="layui-form-mid layui-word-aux" id="fileName" style="color: #009688"></div>
                    </form>
                </div>
            </div>
        </div>
        <div class="layui-col-md1">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>

    </div>

    <div class="layui-row">
        <div class="layui-col-md1">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>
        <div class="layui-col-md10">
            <div class="grid-demo">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend id="info">试卷信息</legend>
                    <div class="layui-field-box" id="paperInfo" style="display:none;">
                        <table class="layui-hide" id="examInfo"></table><br>
                        <button type="button" class="layui-btn" id="viewPaper">预览试卷</button>
                        <button type="button" class="layui-btn" id="viewInfo">预览考生信息</button>
                        <button type="button" class="layui-btn" id="confirmInfo">确认考试信息</button>
                    </div>
                </fieldset>

            </div>

        </div>
        <div class="layui-col-md1">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>

    </div>

</div>
<script>
    $(function () {
        if (${sessionScope.fileLoadUrl!=null}) {
            tableInfo();
            $("#paperInfo").css("display", "block")
        }
    })

</script>
</body>
</html>
