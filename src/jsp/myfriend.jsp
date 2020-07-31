<%@ page import="JDBC.UserDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    UserDaoImp userDaoImp=new UserDaoImp();
    userDaoImp.getFriends(request);
%>

<html>
<head>
    <title>我的好友</title>
    <link rel="stylesheet" href="/pj/reset.css" type="text/css">
    <link rel="stylesheet" href="/pj/src/css/myfriend.css" type="text/css">
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
                        <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=myfriend'">
                            <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                        </a>
                    </div>
                </div>
            </c:if>
            <c:if test="${sessionScope.Username==null}">
                <div class='dropdown'>
                    <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=myfriend'>登录
                    </a>
                    <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
                </div>
            </c:if>
        </nav>
    </header>
    <main>
        <h1>我的好友</h1>
        <table class="title">
            <tr>
                <td class="one">好友列表</td>
                <td class="two">搜索用户</td>
                <td class="three">好友申请</td>
            </tr>
        </table>
        <div class="one">
            <table class="user">
                <c:forEach items="${requestScope.friends}" var="friend">
                        <tr>
                            <td class="username" rowspan="2" onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/favorates.jsp?id=${friend.cryptId}&key=${requestScope.key}'">${friend.userName}</td>
                            <td class="email" onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/favorates.jsp?id=${friend.cryptId}&key=${requestScope.key}'">邮箱：${friend.email}</td>
                        </tr>
                        <tr>
                            <td class="time">注册时间：${friend.time}</td>
                        </tr>
                </c:forEach>
            </table>
        </div>
        <div class="two">
            <form action="${pageContext.request.contextPath}/searchUserServlet?2" method="post">
                <input type="text" class="search" name="search" placeholder="搜索你想找的用户">
                <input type="submit" class="submit" value="查找">
            </form>
            <c:if test="${requestScope.users!=null}">
                <c:choose>
                    <c:when test="${requestScope.users=='nothing'}">
                        <p class="nothing">没有找到相关用户！</p>
                    </c:when>
                    <c:otherwise>
                        <table class="user">
                            <c:forEach items="${requestScope.users}" var="user">
                                <tr>
                                    <td class="username" rowspan="2">${user.userName}</td>
                                    <td class="email">邮箱：${user.email}</td>
                                    <c:if test="${user.isFriend==0}">
                                        <td class="add"><img class="add" src="/pj/img/others/add.png" onclick="window.location.href='${pageContext.request.contextPath}/addFriendServlet?id=${user.cryptId}&key=${requestScope.key}&2'"></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <td class="time">注册时间：${user.time}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
        <div class="three">
            <c:forEach items="${requestScope.request}" var="reque">
                <div class="request">
                    <p class="request"><span class="request">${reque.userName}</span> 请求加你为好友</p>
                    <button class="accept" onclick="window.location.href='${pageContext.request.contextPath}/acceptServlet?id=${reque.cryptId}&key=${requestScope.key}&3'">接受</button>
                    <button class="refuse" onclick="window.location.href='${pageContext.request.contextPath}/refuseServlet?id=${reque.cryptId}&key=${requestScope.key}&3'">拒绝</button>
                </div>
                <hr>
            </c:forEach>
        </div>
    </main>
</body>
<c:if test="${requestScope.message!=null}">
    <script>alert("${requestScope.message}")</script>
    <% request.setAttribute("message",null);%>
</c:if>
<script src="/pj/src/javascript/myfriend.js"></script>
</html>