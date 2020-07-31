<%@ page import="JDBC.PictureDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    PictureDaoImp pictureDaoImp=new PictureDaoImp(request);
    pictureDaoImp.initialFavor();
    pictureDaoImp.getNewPics();
%>
<html>
<head>
    <title>首页</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="stylesheet" href="reset.css" type="text/css">
    <link rel="stylesheet" href="/pj/src/css/index-common.css" type="text/css">
    <link media="(max-width:1175px)" rel="stylesheet" href="/pj/src/css/index-middle.css" type="text/css">
    <link media="(max-width:1020px)" rel="stylesheet" href="/pj/src/css/index-small.css" type="text/css">
    <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/index-mobile.css" type="text/css">
</head>
<body>
<header>
    <!--以下为导航栏内容-->
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
                    <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=index'">
                        <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                    </a>
                </div>
            </div>
        </c:if>
        <c:if test="${sessionScope.Username==null}">
            <div class='dropdown'>
                <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=index'>登录
                </a>
                <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
            </div>
        </c:if>
    </nav>
</header>
<main>
    <div class="container">
        <div class="wrap">
            <c:forEach items="${requestScope.picShow}" var="pic">
                <img src="/pj/img/normal/medium/${pic.path}" onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/details.jsp?id=${pic.imageId}'">
            </c:forEach>
        </div>
        <div class="buttons">
            <span class="on">1</span>
            <span>2</span>
            <span>3</span>
            <span>4</span>
            <span>5</span>
        </div>
        <a href="javascript:" class="arrow arrow_left">&lt;</a>
        <a href="javascript:" class="arrow arrow_right">&gt;</a>
    </div>
    <div id="div1">
        <div id="div2">
            <table name="picshow">
                <c:forEach items="${requestScope.newPic}" var="pic">
                    <tr>
                        <td>
                            <figure class='show'>
                                <div class='pic'>
                                    <img src='/pj/img/normal/medium/${pic.path}' class='pic' onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/details.jsp?id=${pic.imageId}'">
                                </div>
                                <figcaption onclick="window.location.href='/pj/src/jsp/details.jsp?id=${pic.imageId}'">
                                    ${pic.title}
                                </figcaption>
                            </figure>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pic.description!=null}">
                                    <p class='show show1'>${pic.description}</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="show show1">This is a beautiful picture</p>
                                </c:otherwise>
                            </c:choose>
                            <p class="show">作者：${pic.userName}</p>
                            <p class="show">主题：${pic.theme}</p>
                            <p class="show">发布时间：${pic.time}</p>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</main>
<footer>
    <p>
        Copyright © 2001 - 2020 eproject.fudan.edu.cn All Rights Reserved. 大胖氢股份有限公司 版权所有
    </p>
    <p>
        沪网文[2020]9527-666号|新出网证(沪)字00号|ICP证沪AA-112233445566|沪公网安备 19302010036号|版权保护投诉指引
    </p>
    <p>
        文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
    </p>
</footer>
</body>
<!--如果有信息就用这个方法打印，是个不错的方法-->
<c:if test="${requestScope.message!=null}">
    <script>alert("${requestScope.message}")</script>
    <% request.setAttribute("message",null);%>
</c:if>
<script src="/pj/src/javascript/index.js"></script>
</html>