package JDBC;

import Classes.Picture;
import Classes.User;
import Servlet.LoginServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class UserDaoImp extends DAO<User> {

    public UserDaoImp(){}

    public <E> E getForUserValue(String sql,Object...args){
        return getForValue(sql,args);
    }

    public List<User> getForUserList(String sql, Object...args){
        return getForList(sql,args);
    }

    public User getUser(String sql,Object...args){
        return get(sql,args);
    }

    public void updateUser(String sql,Object...args){
        update(sql,args);
    }

    public void getFriends(HttpServletRequest request) throws UnsupportedEncodingException {
        if(request.getSession().getAttribute("Username")!=null){
            User me=getUser("select UID uid from traveluser where UserName=?",request.getSession().getAttribute("Username"));
            int myid=me.getUid();

            List<User> list1=getForUserList("select Receiver uid from friend where Sender=? and status=1",myid);
            List<User> list2=getForUserList("select Sender uid from friend where Receiver=? and status=1",myid);
            List<User> friends=new ArrayList<>();
            for(User user:list1){
                User u=getUser("select UID uid,Email email,UserName userName,DateJoined time,allow viewable from traveluser where UID=?",user.getUid());
                friends.add(u);
            }
            for(User user:list2){
                User u=getUser("select UID uid,Email email,UserName userName,DateJoined time,allow viewable from traveluser where UID=?",user.getUid());
                friends.add(u);
            }
            //生成密钥
            String key="";
            if(request.getAttribute("key")==null) {
                key = LoginServlet.generateKey(16);
                request.setAttribute("key", key);
            }else {
                key= String.valueOf(request.getAttribute("key"));
            }
            for(User user:friends){
                user.setCryptId(URLEncoder.encode(Objects.requireNonNull(LoginServlet.encrypt(String.valueOf(user.getUid()), key)),"UTF-8"));
            }
            request.setAttribute("friends",friends);

            //获取当前收到的好友请求
            List<User> re=getForUserList("select Sender uid from friend where Receiver=? and status=0",me.getUid());
            List<User> requestUsers=new ArrayList<>();
            for(User user:re){
                User user1=getUser("select UID uid,UserName userName from traveluser where UID=?",user.getUid());
                user1.setCryptId(URLEncoder.encode(Objects.requireNonNull(LoginServlet.encrypt(String.valueOf(user1.getUid()), key)),"UTF-8"));
                requestUsers.add(user1);
            }
            request.setAttribute("request",requestUsers);
        }
    }
}
