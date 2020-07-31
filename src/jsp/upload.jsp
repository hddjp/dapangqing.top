<%@ page import="JDBC.PictureDaoImp" %>
<%@ page import="Classes.Picture" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
    PictureDaoImp pictureDaoImp=new PictureDaoImp(request);
    pictureDaoImp.initialUpload();
%>
<html>
    <head>
        <title>上传照片</title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="/pj/reset.css" type="text/css">
        <link rel="stylesheet" href="/pj/src/css/upload-common.css" type="text/css">
        <link media="(max-width:1320px) and (min-width:1120px)" rel="stylesheet" href="/pj/src/css/upload-middle.css" type="text/css">
        <link media="(max-width:1120px) and (min-width:600px)" rel="stylesheet" href="/pj/src/css/upload-small.css" type="text/css">
        <link media="(max-width:600px)" rel="stylesheet" href="/pj/src/css/upload-mobile.css" type="text/css">
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
                            <a id='logout' onclick="window.location.href='${pageContext.request.contextPath}/logoutServlet?from=upload'">
                                <img class='manu' src='/pj/img/others/logout.png' width='25px' height='25px'>登出
                            </a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.Username==null}">
                    <div class='dropdown'>
                        <a class='dropbt box' href='${pageContext.request.contextPath}/src/jsp/signin.jsp?from=upload'>登录
                        </a>
                        <img class='list' src='/pj/img/others/login.png' width='25px' height='25px'>
                    </div>
                </c:if>
            </nav>
        </header>
        <main>
            <h1>随时随地，上传你喜爱的照片</h1>
            <h2>上传的照片将被保存至“我的照片”</h2>
            <form action="${pageContext.request.contextPath}/uploadServlet" method="post" enctype="multipart/form-data">
                <c:choose>
                    <c:when test="${param.id==null}">
                        <table>
                            <tr>
                                <td class='td1'>
                                    <button class='upld'>
                                        <img class='upld' src='/pj/img/others/upload2.png'>上传
                                    </button>
                                    <input type='file' class='file filepath' name='file' accept='image/jpg,image/jpeg,image/png,image/PNG'><br>
                                    <div class='pic'><img class='uploadimg' src='/pj/img/others/mypic1.png'></div>
                                </td>
                                <td>
                                    <p class='things'>
                                        <span class='things'>图片标题：</span>
                                        <input type='text' class='things' name='title' placeholder="请输入图片标题">
                                    </p>
                                    <p class='things'>
                                        <span class='things' name='description'>图片描述：</span>
                                        <textarea class='description' name='description' placeholder='请输入图片的描述'></textarea>
                                    </p>
                                    <p class='things'>
                                        <span class='things'>拍摄国家：</span>
                                        <select class='things' name='country'>
                                            <c:forEach items="${requestScope.countries}" var="country">
                                                <option value="${country.countryCodeIso}">${country.countryName}</option>
                                            </c:forEach>
                                        </select>
                                    </p>
                                    <p class='things'>
                                        <span class='things'>拍摄城市：</span>
                                        <c:forEach items="${requestScope.countries}" var="country">
                                            <c:forEach items="${country.cities}" var="city">
                                                <option value="${city.cityCode}" class="${country.countryCodeIso}" name="city1">${city.cityName}</option>
                                            </c:forEach>
                                        </c:forEach>
                                        <select class='things' name='city'>
                                            <option value=''>--</option>
                                        </select>
                                    </p>
                                    <p class='things'>
                                        <span class='things'>图片主题：</span>
                                        <select class='things' name='theme'>
                                            <option value="scenery">scenery</option>
                                            <option value="building">building</option>
                                            <option value="city">city</option>
                                            <option value="people">people</option>
                                            <option value="wonder">wonder</option>
                                            <option value="animal">animal</option>
                                            <option value="others">others</option>
                                        </select>
                                    </p>
                                </td>
                            </tr>
                        </table>
                        <input type='submit' onclick="return confirm('请确认上传信息无误')" class='submit' value='提交'>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <input type="hidden" name="id" value="${requestScope.picture.imageId}">
                            <tr>
                                <td class='td1'>
                                    <button class='upld'>
                                        <img class='upld' src='/pj/img/others/upload2.png'>修改
                                    </button>
                                    <input type='file' class='file filepath' name='file' accept='image/jpg,image/jpeg,image/png,image/PNG'><br>
                                    <div class='pic'><img class='uploadimg' src='/pj/img/normal/medium/${requestScope.picture.path}'></div>
                                </td>
                                <td>
                                    <p class='things'>
                                        <span class='things'>图片标题：</span>
                                        <input type='text' class='things' name='title' value="${requestScope.picture.title}">
                                    </p>
                                    <p class='things'>
                                        <span class='things' name='description'>图片描述：</span>
                                        <textarea class='description' name='description'>${requestScope.picture.description}</textarea>
                                    </p>
                                    <p class='things'>
                                        <span class='things'>拍摄国家：</span>
                                        <select class='things' name='country'>
                                            <c:forEach items="${requestScope.countries}" var="country">
                                                <c:if test="${requestScope.picture.countryCodeIso==country.countryCodeIso}" >
                                                    <option value="${country.countryCodeIso}" selected>${country.countryName}</option>
                                                </c:if>
                                                <c:if test="${requestScope.picture.countryCodeIso!=country.countryCodeIso}">
                                                    <option value="${country.countryCodeIso}">${country.countryName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </p>
                                    <p class='things'>
                                        <span class='things'>拍摄城市：</span>
                                        <c:forEach items="${requestScope.countries}" var="country">
                                            <c:forEach items="${country.cities}" var="city">
                                                <option value="${city.cityCode}" class="${country.countryCodeIso}" name="city1">${city.cityName}</option>
                                            </c:forEach>
                                        </c:forEach>
                                        <select class='things' name='city'>

                                            <c:if test="${requestScope.picture.cityCode!=null}">
                                                <option value="${requestScope.picture.cityCode}" selected>${requestScope.picture.cityName}</option>
                                            </c:if>
                                        </select>
                                    </p>
                                    <p class='things'>
                                        <span class='things'>图片主题：</span>
                                        <select class='things' name='theme'>
                                            <option value="scenery" ${requestScope.picture.theme=='scenery'?'':'selected'}>scenery</option>
                                            <option value="building" ${requestScope.picture.theme=='building'?'':'selected'}>building</option>
                                            <option value="city" ${requestScope.picture.theme=='city'?'':'selected'}>city</option>
                                            <option value="people" ${requestScope.picture.theme=='people'?'':'selected'}>people</option>
                                            <option value="wonder" ${requestScope.picture.theme=='wonder'?'':'selected'}>wonder</option>
                                            <option value="animal" ${requestScope.picture.theme=='animal'?'':'selected'}>animal</option>
                                            <option value="others" ${requestScope.picture.theme=='others'?'':'selected'}>others</option>
                                        </select>
                                    </p>
                                </td>
                            </tr>
                        </table>
                        <input type='submit' onclick="return confirm('请确认上传信息无误')" class='submit' value='提交'>
                    </c:otherwise>
                </c:choose>
            </form>
        </main>
        <footer>
            文明办网 文明上网 举报、纠纷处理及不良内容举报电话：110 | 举报邮箱：19302010036@fudan.com
        </footer>
        <script src="/pj/src/javascript/upload.js"></script>
        <c:if test="${requestScope.message!=null}">
            <script>alert("${requestScope.message}")</script>
            <% request.setAttribute("message",null);%>
        </c:if>
    </body>
</html>