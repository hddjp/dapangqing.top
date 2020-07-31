<%@ page import="Classes.Picture" %>
<%@ page import="JDBC.PictureDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    PictureDaoImp pictureDaoImp=new PictureDaoImp(request);
    long total=pictureDaoImp.getForPicValue("select count(ImageID) from travelimage");
    request.setAttribute("total",total);
%>
<html>
    <head>
        <title>搜索页</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/search-common.css" type="text/css">
        <link media="(max-width:1320px) and (min-width:1120px)" rel="stylesheet" href="/pj/src/css/search-middle.css" type="text/css">
        <link media="(max-width:1120px) and (min-width:600px)" rel="stylesheet" href="/pj/src/css/search-small.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/search-mobile.css" type="text/css">
    </head>
    <body>
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
                            <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=search'">
                                <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                            </a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.Username==null}">
                    <div class='dropdown'>
                        <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=search'>登录
                        </a>
                        <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
                    </div>
                </c:if>
            </nav>
        </header>
        <main>
            <h1>请搜索您想要查找的图片</h1>
            <div class="search" id="anchor">
                <form action='${pageContext.request.contextPath}/searchServlet' method='post' id='form'>
                    <select id="way" class="search" name="way">
                        <c:choose>
                            <c:when test="${requestScope.way==null||requestScope.way=='Title'}">
                                <option value="Title" selected>标题筛选</option>
                                <option value="Description">描述筛选</option>
                            </c:when>
                            <c:when test="${requestScope.way=='Description'}">
                                <option value="Title">标题筛选</option>
                                <option value="Description" selected>描述筛选</option>
                            </c:when>
                        </c:choose>
                    </select>
                    <select id="range" class="search" name="range">
                        <c:choose>
                            <c:when test="${requestScope.range==null||requestScope.range=='Favor'}">
                                <option value="Favor" selected>热度排序</option>
                                <option value="UPTIME">时间排序</option>
                            </c:when>
                            <c:when test="${requestScope.range=='UPTIME'}">
                                <option value="Favor">热度排序</option>
                                <option value="UPTIME" selected>时间排序</option>
                            </c:when>
                        </c:choose>
                    </select>
                    <c:choose>
                        <c:when test="${requestScope.search==null}">
                            <input type='text' class='search' name='search' placeholder='search ${requestScope.total} pics' autofocus>
                        </c:when>
                        <c:otherwise>
                            <input type='text' class='search' name='search' placeholder='search ${requestScope.total} pics' autofocus value="${requestScope.search}">
                        </c:otherwise>
                    </c:choose>
                    <input type="submit" value="" class="search">
                </form>
            </div>
            <p><br></p>
            <c:if test="${requestScope.pics!=null&&requestScope.pics!='nothing'}">
                <table>
                    <c:forEach items="${requestScope.pics}" var="pic">
                        <tr class="pics">
                            <td>
                                <div class="pic">
                                    <img src="/pj/img/normal/medium/${pic.path}" class="pic picture" onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/details.jsp?id=${pic.imageId}'">
                                </div>
                            </td>
                            <td>
                                <p class="title" onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/details.jsp?id=${pic.imageId}'">${pic.title}</p>
                                <c:if test="${pic.description!=null}">
                                    <p class="description">${pic.description}</p>
                                </c:if>
                                <c:if test="${pic.description==null}">
                                    <p class="description">This is a beautiful picture</p>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr><td></td><td><p class='hidden'>abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz</p></td></tr>
                </table>
                <div id='page'>
                    <a id="turnleft" class="page">&lt</a>
                    <c:forEach begin="1" end="${requestScope.pages}" var="i">
                        <a class="pagenum" id="${i}">${i}</a>
                    </c:forEach>
                    <a id="turnright" class="page">&gt</a>
                </div>
            </c:if>
            <c:if test="${requestScope.pics=='nothing'}">
                <p class="nothing">未搜索到相关图片</p>
            </c:if>
        </main>
        <footer>
            文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
        </footer>
    </body>
    <c:if test="${requestScope.message!=null}">
        <script>alert("${requestScope.message}")</script>
        <% request.setAttribute("message",null);%>
    </c:if>
    <script src="/pj/src/javascript/search.js"></script>
</html>