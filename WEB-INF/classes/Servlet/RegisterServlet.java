package Servlet;

import JDBC.UserDaoImp;
import org.apache.commons.codec.binary.Hex;
import sun.rmi.runtime.Log;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name=req.getParameter("UserName");
        String pass=req.getParameter("Pass");
        String key=req.getParameter("key");
        String password=LoginServlet.decrypt(pass,key);
        String email=req.getParameter("Email");
        String confirm=req.getParameter("confirm");
        String check=req.getParameter("check");

        if(!check.equals(req.getSession().getAttribute("checkCode"))){
            goBack(name,email,password,confirm,"验证码错误",req,resp);
        }else {
            UserDaoImp userDaoImp = new UserDaoImp();
            long repeat = userDaoImp.getForUserValue("select count(UID) from traveluser where UserName=?", name);
            if (repeat > 0) {
                goBack(name, email, password, confirm, "用户名重复，请换一个", req, resp);
            }else {
                //生成随机盐
                String salt=LoginServlet.generateKey(32);

                //用盐生成哈希值
                assert password != null;
                String aftersalt=password.concat(salt);
                MessageDigest messageDigest = null;
                try {
                    messageDigest = MessageDigest.getInstance("SHA");
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }
                assert messageDigest != null;
                byte[] cipherBytes = messageDigest.digest(aftersalt.getBytes());
                String hashValue = Hex.encodeHexString(cipherBytes);

                //生成现在的时间
                SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = new Date(System.currentTimeMillis());
                String time=formatter.format(date);

                String sql="insert into traveluser (Email,UserName,DateJoined,HashValue,salt,allow) values (?,?,?,?,?,1)";
                userDaoImp.updateUser(sql,email,name,time,hashValue,salt);
                req.getSession().setAttribute("Username",name);
                req.setAttribute("message","注册成功！");
                req.getRequestDispatcher("index.jsp").forward(req,resp);
            }
        }
    }

    //注册不成功是时返回填入各框的值
    private void goBack(String name,String email,String password,String confirm,String message,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("name",name);
        request.setAttribute("email",email);
        request.setAttribute("password",password);
        request.setAttribute("confirm",confirm);
        request.setAttribute("message",message);
        request.getRequestDispatcher("src/jsp/register.jsp").forward(request,response);
    }
}
