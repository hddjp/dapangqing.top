<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>登录</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/signin-common.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/signin-mobile.css" type="text/css">
    </head>
    <body>
        <main>
            <h1>账号密码登录</h1>
            <form action="${pageContext.request.contextPath}/loginServlet" method='post' id='form'>
                <input type="hidden" name="from" value="${param.from}">
                <input type="hidden" name="imgid" value="${param.imgid}">
                <input type="hidden" name="key">
                <p class="contents">
                    <img src="/pj/img/others/name.png" class="name">
                    <c:if test="${requestScope.name==null}">
                        <input type="text" class="name" placeholder="输入用户名" name="name">
                    </c:if>
                    <c:if test="${requestScope.name!=null}">
                        <input type="text" class="name" value="${requestScope.name}" name="name">
                    </c:if>
                </p>
                <p class="contents">
                    <img src="/pj/img/others/password.png" class="password">
                    <c:if test="${requestScope.password==null}">
                        <input type="password" class="password" placeholder="输入密码" name="password">
                    </c:if>
                    <c:if test="${requestScope.password!=null}">
                        <input type="password" class="password" value="${requestScope.password}" name="password">
                    </c:if>
                </p>
                <p class="contents">
                    <input type="text" class="check" placeholder="验证码" name="check">
                    <img class="check" src="${pageContext.request.contextPath}/checkCodeGenerator" onclick='this.src=this.src+"?"+Math.random()'>
                </p>
                <input type="submit" value="登录" id="signin">
                <p class="register">
                    <a href="${pageContext.request.contextPath}/src/jsp/register.jsp">注册新账号</a>
                </p>
            </form>
        </main>
        <footer>
            文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
        </footer>
    </body>
    <c:if test="${requestScope.message!=null}">
        <script>alert("${requestScope.message}")</script>
        <% request.setAttribute("message",null);%>
    </c:if>
    <script src="/pj/crypto-js.js"></script>
    <script src="/pj/src/javascript/signin.js"></script>
</html>