<%--
  Created by IntelliJ IDEA.
  User: Gjw
  Date: 2021/6/11
  Time: 9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>考试</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        #fieldFix {
            position: fixed;
            z-index: 100;
            width: 25%;
        }
    </style>

    <script>
        $(function () {

            $.post({
                url: '${pageContext.request.contextPath}/exam/checkExamState',
                data: {
                    eID:${sessionScope.get("stuCheckInfo").getEID()}
                },
                dataType: 'text',
                success: function (res) {
                    console.log(res)
                    if (res == '暂停考试') {
                        $("#handPaper").attr("class", "layui-btn layui-btn-disabled").attr("disabled", true)
                        $("input[type='checkbox']").attr("disabled", true);
                        $("input[type='radio']").attr("disabled", true);
                    }
                }
            });


            $.post({
                url: '${pageContext.request.contextPath}/exam/checkRecovery',
                data: {
                    eID:${sessionScope.get("stuCheckInfo").getEID()},
                    sID:${sessionScope.get("stuCheckInfo").getSID()}
                },
                dataType: 'json',
                success: function (res) {
                    if (res.data != 'noAnswer') {
                        var isAnswerNum = 0;
                        for (let x in res.data) {
                            // console.log(res.data[x].qNum)
                            // console.log(res.data[x].answer)
                            var qNum = res.data[x].qNum;
                            var answer = (res.data[x].answer).replace(/,/g, '');
                            if (answer.length == 1) {
                                $("#" + qNum).children("." + answer).attr("checked", "true");
                                $("#n" + qNum).css("background-color", "#009688");
                                // console.log(children)
                                isAnswerNum++;
                            } else if (answer.length > 1) {
                                for (let x in answer) {
                                    $("#" + qNum).children("." + answer[x]).attr("checked", "true");
                                    $("#n" + qNum).css("background-color", "#009688");
                                }
                                isAnswerNum++;
                            } else if (answer.length == 0) {
                                // isAnswerNum--;
                            }
                        }
                        $("#isAnswer").html("已答 " + isAnswerNum + " 题");
                        $("#isNoAnswer").html("还剩 " + (${sessionScope.get('all').size()}-isAnswerNum) + " 题");
                    }
                }
            });


            var host = window.location.host;
            var webSocket =
                new WebSocket("ws://" + host + "/examSystem/ws?id=" + ${sessionScope.get("stuCheckInfo").getSID()});
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
            webSocket.onclose = function (event) {
                onClose(event);
            };


            function onMessage(event) {
                console.log(event.data)
                var receiveMsg = JSON.parse(event.data)

                if (receiveMsg.info == 'showTime') {
                    // console.log(receiveMsg.timeData)
                    $("#restTime").text(receiveMsg.timeData)
                }

                if (receiveMsg.info == 'pauseExam') {
                    alert("考试已暂停")
                    changeState("暂停考试")
                    $("#handPaper").attr("class", "layui-btn layui-btn-disabled").attr("disabled", true)
                    $("input[type='checkbox']").attr("disabled", true);
                    $("input[type='radio']").attr("disabled", true);
                }

                if (receiveMsg.info == 'startExam') {
                    changeState("考试中")
                    $("#handPaper").attr("class", "layui-btn").removeAttr("disabled")
                    $("input[type='checkbox']").removeAttr("disabled");
                    $("input[type='radio']").removeAttr("disabled");
                }

                if (receiveMsg.info == 'compulsorySubmit') {
                    var stuID = (receiveMsg.data).substr(0, (receiveMsg.data).length - 1);
                    var arr = (stuID).split(",")
                    for (let x in arr) {
                        if (arr[x] ==${sessionScope.get("stuCheckInfo").getSID()}) {
                            handPaper("force");
                            alert("已被强制交卷")
                        }
                    }
                }

                if (receiveMsg.info == 'cheatSubmit') {
                    var stuID = (receiveMsg.data).substr(0, (receiveMsg.data).length - 1);
                    var arr = (stuID).split(",")
                    for (let x in arr) {
                        if (arr[x] ==${sessionScope.get("stuCheckInfo").getSID()}) {
                            handPaper("cheat");
                            alert("你作弊被抓了")
                        }
                    }
                }

                if (receiveMsg.info == 'violation') {
                    console.log(receiveMsg.data)
                    var stuID = (receiveMsg.data).substr(0, (receiveMsg.data).length - 1);
                    var arr = (stuID).split(",")
                    for (let x in arr) {
                        if (arr[x] ==${sessionScope.get("stuCheckInfo").getSID()}) {
                            handPaper("violation");
                            alert("违纪警告")
                        }
                    }
                }

                if (receiveMsg.info == 'over') {
                    handPaper("force");
                    alert("时间到了，做不了了")
                }

                if (receiveMsg.info == 'close') {
                    layer.msg("管理端异常关闭，请联系管理员", function () {
                    });
                }


            }

            function onOpen(event) {
                console.log("握手成功");
                var msg = {
                    info: "stuExamIng",
                    data:${sessionScope.get("stuCheckInfo").getSID()}
                };
                webSocket.send(JSON.stringify(msg));
                changeState("考试中");
            }

            function onError(event) {
                // alert(event.data);
                alert("wrong")
            }

            function onClose(event) {

            }


            function changeState(state) {
                $.post({
                    url: '${pageContext.request.contextPath}/stuExam/changeState',
                    data: {
                        eID:${sessionScope.get("stuCheckInfo").getEID()},
                        sID:${sessionScope.get("stuCheckInfo").getSID()},
                        state: state
                    },
                    dataType: 'text',
                    success: function (res) {
                        console.log(res)

                    }
                });
            }

            $("input[type=checkbox]").click(function () {
                <%--var num = getNum();--%>
                <%--$("#isAnswer").html("已答 " + num + " 题");--%>
                <%--$("#isNoAnswer").html("还剩 " + (${sessionScope.get('all').size()}-num) + " 题");--%>
                var mName = $(this).attr("name");
                var mNum = mName.replace(/[^0-9]/ig, "");
                var id = "#n" + mNum;
                var str = '';
                $("input[name='" + mName + "']").each(function () {
                    if ($(this).is(":checked")) {
                        str += $(this).attr("class") + ",";
                    }
                });
                console.log(str.substring(0, str.length - 1))
                doCheckBox(str.substring(0, str.length - 1), $(this).val())
                if ($(this).is(":checked")) {
                    $(id).css("background-color", "#009688")
                } else if (!$("input[name='" + mName + "']").is(":checked")) {
                    $(id).css("background-color", "white")
                }
                checkBgColor();
            });


            $("input[type=radio]").click(function () {

                var sName = $(this).attr("name");
                var sNum = sName.replace(/[^0-9]/ig, "");
                console.log(sNum)
                var id = "#n" + sNum;
                if ($(this).is(":checked")) {
                    $(id).css("background-color", "#009688");
                    doRadio($(this));
                }
                checkBgColor();
                <%--var num = getNum();--%>
                <%--$("#isAnswer").html("已答 " + num + " 题");--%>
                <%--$("#isNoAnswer").html("还剩 " + (${sessionScope.get('all').size()}-num) + " 题");--%>
            })

            function checkBgColor() {
                var count = 0;
                $("[name='tab']").each(function () {
                    if ($(this).css('background-color') == 'rgb(0, 150, 136)') {
                        count++;
                    }
                });

                var all = $("#allAnswer").text().replaceAll(/([^\u0000-\u00FF])/g, "");
                $("#isAnswer").text('已答 ' + count + ' 题');
                $("#isNoAnswer").text('还剩 ' + (parseInt(all) - count) + ' 题')
            }

            function getNum() {
                var len = 0;
                $.post({
                    url: '${pageContext.request.contextPath}/exam/checkRecovery',
                    async: false,
                    data: {
                        eID:${sessionScope.get("stuCheckInfo").getEID()},
                        sID:${sessionScope.get("stuCheckInfo").getSID()}
                    },
                    dataType: 'json',
                    success: function (res) {
                        console.log(res.data)
                        if (res.data != 'noAnswer') {
                            len = res.data.length;
                            // for (let x in res.data) {
                            //     if (res.data[x].answer.length > 0) {
                            //         len++;
                            //     }
                            // }
                        }
                    }
                });
                return len;
            }


            function doCheckBox(answer, qNum) {
                $.post({
                    url: '${pageContext.request.contextPath}/exam/answer',
                    data: {
                        eID:${sessionScope.get("stuCheckInfo").getEID()},
                        qNum: qNum,
                        sID:${sessionScope.get("stuCheckInfo").getSID()},
                        answer: answer
                    },
                    dataType: 'text',
                    success: function (res) {
                        console.log(res)
                    }
                });
            };

            function doRadio(radio) {
                $.post({
                    url: '${pageContext.request.contextPath}/exam/answer',
                    data: {
                        eID:${sessionScope.get("stuCheckInfo").getEID()},
                        qNum: radio.val(),
                        sID:${sessionScope.get("stuCheckInfo").getSID()},
                        answer: radio.attr("class")
                    },
                    dataType: 'text',
                    success: function (res) {
                        console.log(res)
                    }
                });
            };

            $("#handPaper").click(function () {
                handPaper("normal")
                layer.msg('已交卷', function () {
                });
            });

            function handPaper(state) {
                $.post({
                    url: '${pageContext.request.contextPath}/stuExam/handPaper',
                    data: {
                        eID:${sessionScope.get("stuCheckInfo").getEID()},
                        sID:${sessionScope.get("stuCheckInfo").getSID()},
                        state: state
                    },
                    dataType: 'json',
                    success: function (res) {
                        console.log(res)
                        if (res.isHandPaper != null) {
                            var msg = {
                                info: 'isHandPaper',
                                point: res.isHandPaper,
                                data:${sessionScope.get("stuCheckInfo").getSID()}
                            };
                            webSocket.send(JSON.stringify(msg));
                            $(location).attr("href", "${pageContext.request.contextPath}/stuExam/grade/${sessionScope.stuCheckInfo.EID}/${sessionScope.stuCheckInfo.SID}")
                        }
                    }
                });
            }

        })
        ;


    </script>
</head>
<body>

<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md6">
            <div class="grid-demo grid-demo-bg1">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>${sessionScope.get("qExamInfo").getEName()}</legend>

                    <div class="layui-field-box">
                        <label>科目代码：${sessionScope.get("qExamInfo").getCourseID()}</label>
                        <label>科目名称：${sessionScope.get("qExamInfo").getCourseName()}</label>
                        <label>准考证号：${sessionScope.get("stuCheckInfo").getANumber()}</label>
                        <label>考生姓名：${sessionScope.get("stuCheckInfo").getSName()}</label>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 10px;">
                    <div class="layui-field-box">
                        <label>${sessionScope.get("multipleTip")}</label><br><br>
                        <c:forEach items="${sessionScope.multiples}" var="mutipleOpt" varStatus="i">
                            <label>${mutipleOpt.getQNum()}</label>
                            <label>${mutipleOpt.getQTitle()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;A.${mutipleOpt.getQOptA()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;B.${mutipleOpt.getQOptB()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;C.${mutipleOpt.getQOptC()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;D.${mutipleOpt.getQOptD()}</label><br>
                            <div class="layui-input-block" id="${mutipleOpt.getQNum()}">
                                <input type="checkbox" name="m${mutipleOpt.getQNum()}" lay-skin="primary"
                                       value="${mutipleOpt.getQNum()}" class="A">&nbsp;A&nbsp;</input>
                                <input type="checkbox" name="m${mutipleOpt.getQNum()}" lay-skin="primary"
                                       value="${mutipleOpt.getQNum()}" class="B">&nbsp;B&nbsp;</input>
                                <input type="checkbox" name="m${mutipleOpt.getQNum()}" lay-skin="primary"
                                       value="${mutipleOpt.getQNum()}" class="C">&nbsp;C&nbsp;</input>
                                <input type="checkbox" name="m${mutipleOpt.getQNum()}" lay-skin="primary"
                                       value="${mutipleOpt.getQNum()}" class="D">&nbsp;D&nbsp;</input>
                            </div>
                        </c:forEach>
                    </div>
                </fieldset>
                <fieldset class="layui-elem-field" style="margin-top: 10px;">
                    <div class="layui-field-box">
                        <label>${sessionScope.get("singleTip")}</label><br><br>
                        <c:forEach items="${sessionScope.singles}" var="singleOpt" varStatus="i">
                            <label>${singleOpt.getQNum()}</label>
                            <label>${singleOpt.getQTitle()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;A.${singleOpt.getQOptA()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;B.${singleOpt.getQOptB()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;C.${singleOpt.getQOptC()}</label><br>
                            <label>&nbsp;&nbsp;&nbsp;&nbsp;D.${singleOpt.getQOptD()}</label><br>
                            <div class="layui-input-block" id="${singleOpt.getQNum()}">
                                <input type="radio" value="${singleOpt.getQNum()}"
                                       name="s${singleOpt.getQNum()}" class="A">&nbsp;A&nbsp;</input>
                                <input type="radio" value="${singleOpt.getQNum()}"
                                       name="s${singleOpt.getQNum()}" class="B">&nbsp;B&nbsp;</input>
                                <input type="radio" value="${singleOpt.getQNum()}"
                                       name="s${singleOpt.getQNum()}" class="C">&nbsp;C&nbsp;</input>
                                <input type="radio" value="${singleOpt.getQNum()}"
                                       name="s${singleOpt.getQNum()}" class="D">&nbsp;D&nbsp;</input>
                            </div>
                        </c:forEach>
                    </div>
                </fieldset>


            </div>
        </div>

        <div class="layui-col-md6">
            <div class="grid-demo" id="fieldFix">
                <fieldset class="layui-elem-field" style="margin-top: 30px;">
                    <legend>注意事项</legend>
                    <div class="layui-field-box">
                        <label>1、本试卷依据2005年颁布的《数控二手车》国家职业标准命制，考试时间120分钟</label><br>
                        <label>2、本试卷依据2005年颁布的《数控二手车》国家职业标准命制，考试时间120分钟</label><br>
                        <label>3、本试卷依据2005年颁布的《数控二手车》国家职业标准命制，考试时间120分钟</label><br><br>
                        <label id="restTime">剩余时间：2:00:00</label><br><br>
                        <label>题目导航栏</label><br>
                        <div class="layui-form">
                            <table class="layui-table" id="answerTable">
                                <tbody>
                                <c:forEach items="${sessionScope.get('all')}" var="question" varStatus="i">
                                    <td id="n${question.getQNum()}" name="tab">${question.getQNum()}</td>
                                    <c:if test="${(i.index+1)%5==0}">
                                        <tr></tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div style="text-align: center">
                            <label id="allAnswer">共${sessionScope.get('all').size()}题</label>&nbsp;&nbsp;
                            <label id="isAnswer">已答&nbsp;&nbsp;题</label>&nbsp;&nbsp;
                            <label id="isNoAnswer">还剩&nbsp;&nbsp;题</label><br><br>
                            <button class="layui-btn" id="handPaper">交&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;卷
                            </button>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>

    </div>


</div>

</body>
</html>
