<%@ page import="JDBC.PictureDaoImp" %>
<%@ page import="Classes.Picture" %>
<%@ page import="Servlet.LoginServlet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    PictureDaoImp pictureDaoImp=new PictureDaoImp(request);
    pictureDaoImp.initialFavorates();
    pictureDaoImp.getFootPrint();
%>
<html>
    <head>
        <title>收藏夹</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/favorates-common.css" type="text/css">
        <link media="(max-width:1370px) and (min-width:1170px)" rel="stylesheet" href="/pj/src/css/favorates-middle.css" type="text/css">
        <link media="(max-width:1170px) and (min-width:600px)" rel="stylesheet" href="/pj/src/css/favorates-small.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/favorates-mobile.css" type="text/css">
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
                            <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=favorates'">
                                <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                            </a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.Username==null}">
                    <div class='dropdown'>
                        <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=favorates'>登录
                        </a>
                        <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
                    </div>
                </c:if>
            </nav>
        </header>
        <c:if test="${param.id==null}">
             <aside>
                <h2>我的足迹</h2>
                <c:if test="${sessionScope.Username!=null}">
                    <c:if test="${requestScope.footprint=='nothing'}">
                        <p class="nofoot">尚无浏览记录</p>
                    </c:if>
                    <c:if test="${requestScope.footprint!='nothing'&&requestScope.footprint.size()>0}">
                        <c:forEach items="${requestScope.footprint}" var="footprint">
                            <a class="foot" href="${pageContext.request.contextPath}/src/jsp/details.jsp?id=${footprint.imageId}">${footprint.title}</a>
                            <br><br>
                        </c:forEach>
                    </c:if>
                </c:if>
                <c:if test="${sessionScope.Username==null}">
                    <p class="nofoot">请先登录</p>
                </c:if>
             </aside>
        </c:if>
        <main>
            <c:choose>
                <c:when test="${param.id==null}">
                    <h1 id="anchor">
                        <img src="/pj/img/others/favorate1.png">
                        收藏夹
                    </h1>
                    <c:if test="${sessionScope.Username!=null}">
                        <div class="allow">
                            好友可见
                            <c:choose>
                                <c:when test="${requestScope.viewable==1}">
                                    <img src="/pj/img/others/allow1.png" class="allow" onclick="window.location.href='${pageContext.request.contextPath}/allowServlet?type=1'">
                                </c:when>
                                <c:when test="${requestScope.viewable==0}">
                                    <img src="/pj/img/others/allow2.png" class="allow" onclick="window.location.href='${pageContext.request.contextPath}/allowServlet?type=2'">
                                </c:when>
                            </c:choose>
                        </div>
                    </c:if>
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
                                            <button class='unfavorate butt' title='取消收藏' onclick="if (confirm('确认要从收藏夹中移除该照片？')){window.location.href='${pageContext.request.contextPath}/unfavorServlet?id=${picture.cryptID}&key=${requestScope.key}'}">
                                                <img class='unfavorate' src='/pj/img/others/unfavorate.png'>
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
                            <p class="nothing">收藏夹里空空如也！</p>
                        </c:if>
                    </c:if>
                    <p><br></p>
                </c:when>
                <c:otherwise>
                    <%
                        int id= Integer.parseInt(LoginServlet.decrypt(request.getParameter("id"),request.getParameter("key")));
                        pictureDaoImp.initialFavorates(id);
                    %>
                    <h1 id="anchor" class="smaller">
                        <img src="/pj/img/others/favorate1.png">
                        ${requestScope.user.userName} 的收藏夹
                    </h1>
                    <c:choose>
                        <c:when test="${requestScope.pictures=='notallow'}">
                            <p class="nothing">好友设置了收藏夹权限，仅自己可见</p>
                        </c:when>
                        <c:when test="${requestScope.pictures=='nothing'}">
                            <p class="nothing">收藏夹里空空如也！</p>
                        </c:when>
                        <c:otherwise>
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
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr><td></td><td><p class='hidden'>abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz</p></td></tr>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </main>
        <footer>
            文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
        </footer>
        <script src="/pj/src/javascript/favorates.js"></script>
    </body>
</html>            