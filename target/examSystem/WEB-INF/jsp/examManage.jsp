<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/8
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考试管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script>
        layui.use(['upload', 'element', 'layer'], function(){
            var $ = layui.jquery
                ,upload = layui.upload
                ,element = layui.element
                ,layer = layui.layer;
            var inputValue;
            var files;
                //选完文件后不自动上传
            upload.render({
                elem: '#choseFile'
                ,url: '${pageContext.request.contextPath}/admin/upLoad'
                ,auto: false
                //,multiple: true
                ,accept: 'file' //普通文件
                ,exts: 'zip'
                ,size:'10240'
                ,bindAction: '#doUpload'
                ,choose:function (obj){
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入压缩包解压密码',
                        btn: ['确定','取消'], //按钮，
                        btnAlign: 'c',
                    }, function(value,index){
                        layer.close(index);
                        inputValue = value;
                        console.log(value)
                        oldFiles = obj.pushFile();
                        for (let x in oldFiles) {
                            delete oldFiles[x];
                        }
                        var files = obj.pushFile();
                        obj.preview(function (index, file, result) {
                            console.log(files[index].name);
                            $("#fileName").text('文件名称：'+files[index].name);
                            layer.msg("加载成功，请点击上传");
                        });
                    });


                }
                ,before: function(obj){
                    layer.load(); //上传loading
                    this.data={'zipPwd':inputValue};
                }
                ,done: function(res){
                    layer.msg('上传成功');
                    layer.closeAll('loading');
                    for (let x in files) {
                        console.log(files[x].name)
                        delete files[x];
                    }

                    $(location).attr("href", "${pageContext.request.contextPath}/exam/showInfo")
                    console.log(res)

                }
                ,error: function(res){
                    layer.msg('解压密码有误');
                    layer.closeAll('loading');
                    console.log(res)
                }
            });



        });
    </script>
</head>
<body>
<div class="layui-container">

    <div class="layui-row">
        <div class="layui-col-md3">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>
        <div class="layui-col-md6">
            <div class="grid-demo">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                    <legend>试卷导入</legend>
                </fieldset>
                <form class="layui-form layui-form-pane" action="" enctype="multipart/form-data" method="post">
                <div class="layui-btn-container">
                    <button type="button" class="layui-btn layui-btn-normal" id="choseFile">选择文件</button>
                    <button type="button" class="layui-btn" id="doUpload">开始上传</button>
                </div>
                    <div class="layui-form-mid layui-word-aux" id="fileName" style="color: #009688"></div>
                </form>

            </div>
        </div>
        <div class="layui-col-md3">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>

    </div>

    <div class="layui-row">
        <div class="layui-col-md3">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>
        <div class="layui-col-md6">
            <div class="grid-demo">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                    <legend>试卷信息</legend>
                </fieldset>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="grid-demo grid-demo-bg1">&nbsp;</div>
        </div>

    </div>

</div>
</body>
</html>
