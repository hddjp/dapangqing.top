package Servlet;

import Classes.Picture;
import JDBC.PictureDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SearchServlet extends HttpServlet {
    private final int PICPERPAGE=6;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String way=req.getParameter("way");
        String range=req.getParameter("range");
        String search=req.getParameter("search");
        String likeSearch="'%"+search+"%'";

        String sql="select ImageID imageId,Title title,Description description,PATH path from travelimage where "+way+" like "+likeSearch+" order by "+range+" desc";
        PictureDaoImp pictureDaoImp=new PictureDaoImp(req);
        List<Picture> pictures=pictureDaoImp.getForPicList(sql);
        if(pictures!=null&&pictures.size()>0) {
            req.setAttribute("pics", pictures);
            int pages=(pictures.size()-1)/PICPERPAGE+1;
            req.setAttribute("pages",pages);
        }else {
            req.setAttribute("pics","nothing");
        }
        req.setAttribute("way",way);
        req.setAttribute("range",range);
        req.setAttribute("search",search);
        req.getRequestDispatcher("src/jsp/search.jsp").forward(req,resp);
    }
}
