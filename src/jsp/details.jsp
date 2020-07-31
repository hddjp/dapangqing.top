<%@ page import="Classes.Picture" %>
<%@ page import="JDBC.PictureDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    PictureDaoImp pictureDaoImp=new PictureDaoImp(request);
    pictureDaoImp.initialDetails();
    pictureDaoImp.printFoot();
%>

<html>
    <head>
        <title>图片详情</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/details-common.css" type="text/css">
        <link media="(max-width:1320px) and (min-width:1120px)" rel="stylesheet" href="/pj/src/css/details-middle.css" type="text/css">
        <link media="(max-width:1120px) and (min-width:600px)" rel="stylesheet" href="/pj/src/css/details-small.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/details-mobile.css" type="text/css">
    </head>
    <body>
        <div class="big">
            <div id="mirror">
                <img src='/pj/img/normal/medium/${requestScope.pic.path}' class='biggest'>
            </div>
            <img src='/pj/img/normal/medium/${requestScope.pic.path}' class='big'>
        </div>
        <header>
            <nav>
                <a href="${pageContext.request.contextPath}/index.jsp" class="navigation" name="index">首页</a>
                <a href="${pageContext.request.contextPath}/src/jsp/search.jsp" class="navigation" name="search">搜索页</a>
                <c:if test="${sessionScope.Username!=null}">
                    <div class='dropdown'>
                        <a class='dropbt'>个人中心
                            <img class='list' src='/pj/img/others/list.png' width='20px' height='20px'>
                        </a>
                        <div class='dropdown-content'>
                            <a href='/pj/src/jsp/upload.jsp' class='box'>
                                <img class='manu' src='/pj/img/others/upload.png' width='25px' height='25px' >上传
                            </a>
                            <a href='/pj/src/jsp/mypic.jsp' class='box'>
                                <img class='manu' src='/pj/img/others/mypic.png' width='25px' height='25px'>我的照片
                            </a>
                            <a href='/pj/src/jsp/favorates.jsp' class='box'>
                                <img class='manu' src='/pj/img/others/favorate.png' width='25px' height='25px'>我的收藏
                            </a>
                            <a href="/pj/src/jsp/myfriend.jsp" class="box">
                                <img class="manu" src="/pj/img/others/myfriend.png" width="25px" height="25px">我的好友
                            </a>
                            <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=details&imgid=${param.id}'">
                                <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                            </a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.Username==null}">
                    <div class='dropdown'>
                        <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=details&imgid=${param.id}'>登录
                        </a>
                        <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
                    </div>
                </c:if>
            </nav>
        </header>
        <main>
            <h1>${requestScope.pic.title}</h1>
            <h2>热度：${requestScope.hot}</h2>
            <c:if test="${sessionScope.Username!=null}">
                <c:choose>
                    <c:when test="${requestScope.isfavor!=1}">
                        <button class='favor' onclick="window.location.href='${pageContext.request.contextPath}/favorServlet?type=1&imgid=${param.id}'">
                            <img src='/pj/img/others/favorate2.png' class='favor'>收藏
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button class='favor1' onclick="window.location.href='${pageContext.request.contextPath}/favorServlet?type=2&imgid=${param.id}'">
                            <img src='/pj/img/others/favorate2.png' class='favor1'>取消收藏
                        </button>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <hr>
            <table class='table1' id='fav'>
                <tr>
                    <td>
                        <div class='picture'>
                            <img src='/pj/img/normal/medium/${requestScope.pic.path}' class='picture'>
                        </div>
                    </td>
                    <td name='infor'>
                        <table class='table2'>
                            <tr><td>拍摄者：</td><td>${requestScope.pic.userName}</td></tr>
                            <tr><td>主题：</td><td>${requestScope.pic.theme}</td></tr>
                            <tr><td>拍摄国家:</td><td>${requestScope.pic.countryName}</td></tr>
                            <c:choose>
                                <c:when test="${requestScope.pic.cityCode!=0}">
                                    <tr><td>拍摄城市：</td><td>${requestScope.pic.cityName}</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <tr><td>拍摄城市:</td><td>未知</td></tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </td>
                </tr>
            </table>
            <c:choose>
                <c:when test="${requestScope.pic.description!=null}">
                    <p id="description">${requestScope.pic.description}</p>
                </c:when>
                <c:otherwise>
                    <p id='description'>This is a beautiful picture</p>
                </c:otherwise>
            </c:choose>
            <div class="comment" id="anchor">
                <c:if test="${sessionScope.range==null||sessionScope.range=='hot'}">
                    <button class="range" onclick="window.location.href='${pageContext.request.contextPath}/rangeServlet?type=1&id=${param.id}#anchor'">
                        <img class="range" src="/pj/img/others/range.png">热度排序
                    </button>
                </c:if>
                <c:if test="${sessionScope.range=='time'}">
                    <button class="range" onclick="window.location.href='${pageContext.request.contextPath}/rangeServlet?type=2&id=${param.id}#anchor'">
                        <img class="range" src="/pj/img/others/range.png">时间排序
                    </button>
                </c:if>
                <form action="${pageContext.request.contextPath}/commentServlet#anchor" method="post" class="comment">
                    <textarea class="comment" name="comment" placeholder="请输入评论。。。"></textarea>
                    <input type="hidden" name="imgid" value="${param.id}">
                    <input type="submit" class="comment" value="发布">
                </form>
            </div>
            <hr>
            <c:forEach items="${requestScope.comments}" var="comment">
                <div class="commentpiece">
                    <div class="zan">
                        <c:if test="${comment.isZan==0}">
                            <img class="zan" src="/pj/img/others/zan.png" onclick="window.location.href='${pageContext.request.contextPath}/zanServlet?type=1&id=${param.id}&cid=${comment.id}#anchor'">${comment.favors}
                        </c:if>
                        <c:if test="${comment.isZan==1}">
                            <img class="zan" src="/pj/img/others/zan1.png" onclick="window.location.href='${pageContext.request.contextPath}/zanServlet?type=2&id=${param.id}&cid=${comment.id}#anchor'">${comment.favors}
                        </c:if>
                    </div>
                    <p class="commentor">${comment.userName}</p>
                    <p class="commentext">${comment.comment}</p>
                    <p class="commentime">${comment.time}</p>
                </div>
                <hr>
            </c:forEach>
            <p><br><br><br><br><br><br><br><br></p>
        </main>
        <footer>
            文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
        </footer>
    </body>
    <c:if test="${requestScope.message!=null}">
        <script>alert("${requestScope.message}")</script>
        <% request.setAttribute("message",null);%>
    </c:if>
    <script src="/pj/src/javascript/details.js"></script>
</html>