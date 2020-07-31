package Servlet;

import Classes.User;
import JDBC.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class FavorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("Username") != null) {
            UserDaoImp userDaoImp = new UserDaoImp();
            User user = userDaoImp.getUser("select UID uid from traveluser where UserName=?", req.getSession().getAttribute("Username"));
            String sql1="",sql2="";
            if (Integer.parseInt(req.getParameter("type")) == 1) {
                sql1 = "insert into travelimagefavor (UID,ImageID) values (?,?)";
                sql2="update travelimage set Favor=Favor+1 where ImageID=?";
            }else if(Integer.parseInt(req.getParameter("type"))==2){
                sql1="delete from travelimagefavor where UID=? and ImageID=?";
                sql2="update travelimage set Favor=Favor-1 where ImageID=?";
            }
            userDaoImp.updateUser(sql1,user.getUid(),req.getParameter("imgid"));
            userDaoImp.updateUser(sql2,req.getParameter("imgid"));
            resp.sendRedirect("src/jsp/details.jsp?id="+req.getParameter("imgid"));
        }else {
            req.setAttribute("message","请先登录");
            req.getRequestDispatcher("src/jsp/details.jsp?id="+req.getParameter("imgid"));
        }
    }
}
