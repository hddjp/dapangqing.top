package Servlet;

import Classes.User;
import JDBC.UserDaoImp;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class LoginServlet extends HttpServlet {

    private int imageid;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name=req.getParameter("name");
        String pass=req.getParameter("password");
        String check=req.getParameter("check");
        String key=req.getParameter("key");
        String from=req.getParameter("from");
        if(from.equals("details")){
            imageid= Integer.parseInt(req.getParameter("imgid"));
        }
        //将密码用密钥解密
        String password= null;
        password =decrypt(pass,key);

        //检查验证码
        if(!check.equals(req.getSession().getAttribute("checkCode"))){
            goBack(name,password,"验证码错误",from,req,resp);
        }else {
            UserDaoImp userDaoImp = new UserDaoImp();
            long count = userDaoImp.getForUserValue("select count(UID) from traveluser where UserName=?", name);
            if (count < 0) {
                goBack(name, password, "用户名或密码错误", from, req, resp);
            }else {
                User user = userDaoImp.getUser("select UserName userName,HashValue hashValue,salt salt from traveluser where UserName=?", name);

                //密码加盐后与哈希值对比
                String aftersalt = password + user.getSalt();
                MessageDigest messageDigest = null;
                try {
                    messageDigest = MessageDigest.getInstance("SHA");
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }
                assert messageDigest != null;
                byte[] cipherBytes = messageDigest.digest(aftersalt.getBytes());
                String hashValue = Hex.encodeHexString(cipherBytes);
                if (!hashValue.equals(user.getHashValue())) {
                    goBack(name, password, "用户名或密码错误", from, req, resp);
                } else {
                    //返回登录前的页面
                    req.setAttribute("message", "欢迎回来，" + name);
                    req.getSession().setAttribute("Username", name);
                    if (from.equals("index")) {
                        req.getRequestDispatcher("index.jsp").forward(req, resp);
                    } else if (from.equals("details")) {
                        req.getRequestDispatcher("src/jsp/details.jsp?id=" + imageid).forward(req, resp);
                    } else {
                        req.getRequestDispatcher("src/jsp/" + from + ".jsp").forward(req,resp);
                    }
                }
            }
        }
    }

    //带着输入的参数返回登录页，可以防止用户输入的信息不被保留
    private void goBack(String name,String password,String message,String from,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("name",name);
        request.setAttribute("password",password);
        request.setAttribute("message",message);
        if(from.equals("details")){
            request.getRequestDispatcher("src/jsp/signin.jsp?from=details&imgid="+imageid).forward(request,response);
        }else {
            request.getRequestDispatcher("src/jsp/signin.jsp?from=" + from).forward(request, response);
        }
    }

    private static final String ALGORITHMSTR = "AES/ECB/PKCS5Padding";

    public static String encrypt(String content, String key) {
        try {
            byte[] raw = key.getBytes();  //获得密码的字节数组
            SecretKeySpec skey = new SecretKeySpec(raw, "AES"); //根据密码生成AES密钥
            Cipher cipher = Cipher.getInstance(ALGORITHMSTR);  //根据指定算法ALGORITHM自成密码器
            cipher.init(Cipher.ENCRYPT_MODE, skey); //初始化密码器，第一个参数为加密(ENCRYPT_MODE)或者解密(DECRYPT_MODE)操作，第二个参数为生成的AES密钥
            byte [] byte_content = content.getBytes("utf-8"); //获取加密内容的字节数组(设置为utf-8)不然内容中如果有中文和英文混合中文就会解密为乱码
            byte [] encode_content = cipher.doFinal(byte_content); //密码器加密数据
            return Base64.encodeBase64String(encode_content); //将加密后的数据转换为字符串返回
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String decrypt(String encryptStr, String decryptKey){
        try {
            byte[] raw = decryptKey.getBytes();  //获得密码的字节数组
            SecretKeySpec skey = new SecretKeySpec(raw, "AES"); //根据密码生成AES密钥
            Cipher cipher = Cipher.getInstance(ALGORITHMSTR);  //根据指定算法ALGORITHM自成密码器
            cipher.init(Cipher.DECRYPT_MODE, skey); //初始化密码器，第一个参数为加密(ENCRYPT_MODE)或者解密(DECRYPT_MODE)操作，第二个参数为生成的AES密钥
            byte [] encode_content = Base64.decodeBase64(encryptStr); //把密文字符串转回密文字节数组
            byte [] byte_content = cipher.doFinal(encode_content); //密码器解密数据
            return new String(byte_content,"utf-8"); //将解密后的数据转换为字符串返回
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    public static String generateKey(int n){
        String str="zxcvbnmlkjhgfdsaqwertyuiopQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
        Random random=new Random();
        StringBuilder sb=new StringBuilder();
        for(int i=0; i<n; ++i){
            int number=random.nextInt(62);
            sb.append(str.charAt(number));
        }
        return sb.toString();
    }
}
