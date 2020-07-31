package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RangeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(Integer.parseInt(req.getParameter("type"))==1){
            req.getSession().setAttribute("range","time");
        }
        if(Integer.parseInt(req.getParameter("type"))==2){
            req.getSession().setAttribute("range","hot");
        }
        req.getRequestDispatcher("src/jsp/details.jsp?id="+req.getParameter("id")).forward(req,resp);
    }
}
