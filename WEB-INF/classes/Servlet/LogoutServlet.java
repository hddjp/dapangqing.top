package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("Username")!=null){
            req.getSession().setAttribute("Username",null);
        }
        String from=req.getParameter("from");
        req.setAttribute("message","已成功登出！");
        if(from.equals("index")){
            req.getRequestDispatcher("index.jsp").forward(req,resp);
        }else if(from.equals("details")){
            req.getRequestDispatcher("src/jsp/details.jsp?id="+req.getParameter("imgid")).forward(req,resp);
        }else {
            req.getRequestDispatcher("src/jsp/"+from+".jsp").forward(req,resp);
        }
    }
}
