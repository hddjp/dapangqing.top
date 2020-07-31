package Servlet;

import Classes.User;
import JDBC.PictureDaoImp;
import JDBC.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UnfavorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("Username")!=null) {
            String crypted = req.getParameter("id");
            String key = req.getParameter("key");
            int id = Integer.parseInt(LoginServlet.decrypt(crypted, key));
            UserDaoImp userDaoImp=new UserDaoImp();
            User user=userDaoImp.getUser("select UID uid from traveluser where UserName=?",req.getSession().getAttribute("Username"));

            PictureDaoImp pictureDaoImp = new PictureDaoImp(req);
            pictureDaoImp.updatePic("delete from travelimagefavor where UID=? and ImageID=?",user.getUid(),id);
            pictureDaoImp.updatePic("update travelimage set Favor=Favor-1 where ImageID=?",id);

            resp.sendRedirect("src/jsp/favorates.jsp");
        }
    }
}
