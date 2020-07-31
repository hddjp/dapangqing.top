package Servlet;

import Classes.Comment;
import JDBC.CommentDaoImp;
import JDBC.PictureDaoImp;
import sun.rmi.runtime.Log;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String crypted=req.getParameter("id");
        String key=req.getParameter("key");
        int id= Integer.parseInt(LoginServlet.decrypt(crypted,key));

        String sql="delete from travelimage where imageID=?";
        PictureDaoImp pictureDaoImp=new PictureDaoImp(req);
        long total=pictureDaoImp.getForPicValue("select count(ImageID) from travelimage");
        pictureDaoImp.updatePic(sql,id);

        //收藏夹、足迹、评论、评论赞都要移除
        pictureDaoImp.updatePic("delete from travelimagefavor where imageID=?",id);
        pictureDaoImp.updatePic("delete from footprint where imageID=?",id);
        List<Comment> commentList=new CommentDaoImp().getForCommentList("select ID id from comments where ImageID=?",id);
        pictureDaoImp.updatePic("delete from comments where imageID=?",id);
        for (Comment comment:commentList){
            pictureDaoImp.updatePic("delete from commentzan where commentID=?",comment.getId());
        }

        for(int i=id+1;i<total+1;i++){
            pictureDaoImp.updatePic("update travelimage set ImageID=ImageID-1 where ImageID=?",i);
        }
        req.setAttribute("message","已成功删除！");
        req.getRequestDispatcher("src/jsp/mypic.jsp").forward(req,resp);
    }
}
