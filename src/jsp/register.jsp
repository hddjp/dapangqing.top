<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
    <head>
        <title>注册</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/register-common.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/register-mobile.css" type="text/css">
    </head>
    <body>
        <main>
            <h1>注册您的新账号</h1>
            <form  action='${pageContext.request.contextPath}/registerServlet' method='post' id='form'>
                <input type="hidden" name="key">
                <p class="contents">
                    <img src="/pj/img/others/name.png" class="name">
                    <c:if test="${requestScope.name==null}">
                        <input type='text' class='name' placeholder='用户名' name='UserName'>
                    </c:if>
                    <c:if test="${requestScope.name!=null}">
                        <input type='text' class='name' value="${requestScope.name}" name='UserName'>
                    </c:if>
                </p>
                <p class="contents">
                    <img src="/pj/img/others/email.png" class="email">
                    <c:if test="${requestScope.email==null}">
                        <input type='email' class='email' placeholder='邮箱地址' name='Email'>
                    </c:if>
                    <c:if test="${requestScope.email!=null}">
                        <input type='email' class='email' value="${requestScope.email}" name='Email'>
                    </c:if>
                </p>
                <p class="contents">
                    <img src="/pj/img/others/password.png" class="password">
                    <c:if test="${requestScope.password==null}">
                        <input type='password' class='password' placeholder='密码' name='Pass'>
                    </c:if>
                    <c:if test="${requestScope.password!=null}">
                        <input type='password' class='password' value="${requestScope.password}" name='Pass'>
                    </c:if>
                </p>
                <p class="strong"></p>
                <p class="contents">
                    <img src="/pj/img/others/password.png" class="password">
                    <c:if test="${requestScope.confirm==null}">
                        <input type='password' class='confirm' placeholder='密码确认' name='confirm'>
                    </c:if>
                    <c:if test="${requestScope.confirm!=null}">
                        <input type='password' class='confirm' value="${requestScope.confirm}" name='confirm'>
                    </c:if>
                </p>
                <p class="contents">
                    <input type="text" class="check" placeholder="验证码" name="check">
                    <img class="check" src="${pageContext.request.contextPath}/checkCodeGenerator" onclick='this.src=this.src+"?"+Math.random()'>
                </p>
                <input type="submit" id="register" value="注册">
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
    <script src="/pj/src/javascript/register.js"></script>
</html>