package Servlet;

import Classes.User;
import JDBC.CommentDaoImp;
import JDBC.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int imageId = Integer.parseInt(req.getParameter("imgid"));
        if(req.getSession().getAttribute("Username")!=null) {
            User user = new UserDaoImp().getUser("select UID uid from traveluser where UserName=?", req.getSession().getAttribute("Username"));
            String comment = req.getParameter("comment");
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date(System.currentTimeMillis());
            String time = formatter.format(date);

            String sql = "insert into comments (ImageID,UID,comment,time,Favors) values (?,?,?,?,0)";
            CommentDaoImp commentDaoImp = new CommentDaoImp();
            commentDaoImp.updateComment(sql,imageId,user.getUid(),comment,time);
            req.setAttribute("message","评论已发布");
        }else {
            req.setAttribute("message","请先登录");
        }
        req.getRequestDispatcher("src/jsp/details.jsp?id="+imageId).forward(req,resp);
    }
}
