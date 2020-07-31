package Servlet;

import Classes.User;
import JDBC.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AllowServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("Username")!=null){
            String name= String.valueOf(req.getSession().getAttribute("Username"));
            String sql="";
            if(Integer.parseInt(req.getParameter("type"))==1){
                sql="update traveluser set allow=0 where UserName=?";
            }
            if(Integer.parseInt(req.getParameter("type"))==2){
                sql="update traveluser set allow=1 where UserName=?";
            }
            new UserDaoImp().updateUser(sql,name);
            resp.sendRedirect("src/jsp/favorates.jsp");
        }
    }
}
