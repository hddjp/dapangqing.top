<%@ page import="JDBC.PictureDaoImp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    PictureDaoImp pictureDaoImp=new PictureDaoImp(request);
    pictureDaoImp.initialMypic();
%>
<html>
    <head>
        <title>我的照片</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/mypic-common.css" type="text/css">
        <link media="(max-width:1320px) and (min-width:1120px)" rel="stylesheet" href="/pj/src/css/mypic-middle.css" type="text/css">
        <link media="(max-width:1120px) and (min-width:600px)" rel="stylesheet" href="/pj/src/css/mypic-small.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/mypic-mobile.css" type="text/css">
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
                            <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=mypic'">
                                <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                            </a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.Username==null}">
                    <div class='dropdown'>
                        <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=mypic'>登录
                        </a>
                        <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
                    </div>
                </c:if>
            </nav>
        </header>
        <main>
            <h1 id="anchor">
                <img src="/pj/img/others/camera.png" class="camera">
                我的照片
                <img src="/pj/img/others/camera.png" class="camera">
            </h1>
            <c:if test="${sessionScope.Username==null}">
                <p class="nothing">您还未登录！</p>
            </c:if>
            <c:if test="${sessionScope.Username!=null}">
                <c:if test="${requestScope.pictures!='nothing'&&requestScope.pictures.size()>0}">
                    <table>
                        <c:forEach items="${requestScope.pictures}" var="picture">
                            <tr class="pics">
                                <td>
                                    <div class='pic'>
                                        <img src='/pj/img/normal/medium/${picture.path}' class='pic picture' onclick="window.location.href='details.php?id=${picture.imageId}'">
                                    </div>
                                </td>
                                <td>
                                    <p class='title'  onclick="window.location.href='details.php?id=${picture.imageId}'">${picture.title}</p>
                                    <c:if test="${picture.description!=null}">
                                        <p class='description'>${picture.description}</p>
                                    </c:if>
                                    <c:if test="${picture.description==null}">
                                        <p class="description">This is a beautiful picture</p>
                                    </c:if>
                                    <button class='delete' onclick="if (confirm('确认要删除该照片？')){window.location.href='${pageContext.request.contextPath}/deleteServlet?id=${picture.cryptID}&key=${requestScope.key}'}" title='删除此照片'>
                                        <img class='button' src='/pj/img/others/delete.png'>
                                    </button>
                                    <button class='modify' onclick="window.location.href='${pageContext.request.contextPath}/src/jsp/upload.jsp?id=${picture.cryptID}&key=${requestScope.key}'" title='修改图片信息'>
                                        <img class='button' src='/pj/img/others/modify.png'>
                                    </button>
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
                <c:if test="${requestScope.pictures=='nothing'}">
                    <p class="nothing">你还没有上传过图片！</p>
                </c:if>
            </c:if>
            <p><br></p>
        </main>
        <footer>
            文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
        </footer>
        <c:if test="${requestScope.message!=null}">
            <script>alert("${requestScope.message}")</script>
            <% request.setAttribute("message",null);%>
        </c:if>
        <script src="/pj/src/javascript/mypic.js"></script>
    </body>
</html>