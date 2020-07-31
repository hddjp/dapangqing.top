package Servlet;

import Classes.User;
import JDBC.UserDaoImp;
import sun.rmi.runtime.Log;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddFriendServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String crypt=req.getParameter("id");
        String key=req.getParameter("key");
        int id= Integer.parseInt(LoginServlet.decrypt(crypt,key));
        UserDaoImp userDaoImp=new UserDaoImp();
        User me=userDaoImp.getUser("select UID uid from traveluser where UserName=?",req.getSession().getAttribute("Username"));

        userDaoImp.updateUser("delete from friend where Sender =? and Receiver=? and status=0",me.getUid(),id);
        userDaoImp.updateUser("delete from friend where Sender =? and Receiver=? and status=0",id,me.getUid());
        userDaoImp.updateUser("insert into friend (Sender,Receiver,status) values (?,?,0)",me.getUid(),id);
        req.setAttribute("message","已发送好友请求");
        req.getRequestDispatcher("src/jsp/myfriend.jsp").forward(req,resp);
    }
}
