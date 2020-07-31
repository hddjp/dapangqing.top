package Servlet;

import Classes.User;
import JDBC.UserDaoImp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;

public class SearchUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDaoImp userDaoImp=new UserDaoImp();
        String search=req.getParameter("search");
        String likeSearch="'%"+search+"%'";
        String sql="select UID uid,UserName userName,Email email,DateJoined time from traveluser where UserName like "+likeSearch;
        User me=userDaoImp.getUser("select UID uid from traveluser where UserName=?",req.getSession().getAttribute("Username"));

        List<User> list=userDaoImp.getForUserList(sql);
        if(list.size() == 0){
            req.setAttribute("users","nothing");
        }else {
            String key = LoginServlet.generateKey(16);
            req.setAttribute("key", key);
            for (User user : list) {
                user.setCryptId(URLEncoder.encode(Objects.requireNonNull(LoginServlet.encrypt(String.valueOf(user.getUid()), key)), "UTF-8"));
                long c1 = userDaoImp.getForUserValue("select count(ID) from friend where Sender=? and Receiver=? and status=1", me.getUid(), user.getUid());
                long c2 = userDaoImp.getForUserValue("select count(ID) from friend where Sender=? and Receiver=? and status=1", user.getUid(), me.getUid());
                if (c1 == 0 && c2 == 0) {
                    user.setIsFriend(0);
                } else {
                    user.setIsFriend(1);
                }
            }
            req.setAttribute("users", list);
        }
        req.getRequestDispatcher("src/jsp/myfriend.jsp").forward(req,resp);
    }
}
