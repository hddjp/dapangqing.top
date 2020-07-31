package Servlet;

import Classes.User;
import JDBC.CommentDaoImp;
import JDBC.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ZanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("Username")==null){
            req.setAttribute("message","请先登录！");
            req.getRequestDispatcher("src/jsp/details.jsp?id="+req.getParameter("id")).forward(req,resp);
        }else {
            int commentID= Integer.parseInt(req.getParameter("cid"));
            User user=new UserDaoImp().getUser("select UID uid from traveluser where UserName=?",req.getSession().getAttribute("Username"));
            CommentDaoImp commentDaoImp=new CommentDaoImp();

            String sql1="",sql2="";
            if(Integer.parseInt(req.getParameter("type"))==1){
                sql1="insert into commentzan (commentID,UID) values (?,?)";
                sql2="update comments set Favors=Favors+1 where ID=?";
            }else if(Integer.parseInt(req.getParameter("type"))==2){
                sql1="delete from commentzan where commentID=? and UID=?";
                sql2="update comments set Favors=Favors-1 where ID=?";
            }
            commentDaoImp.updateComment(sql1,commentID,user.getUid());
            commentDaoImp.updateComment(sql2,commentID);
            int imgid= Integer.parseInt(req.getParameter("id"));
            resp.sendRedirect("src/jsp/details.jsp?id="+imgid);
        }
    }
}
