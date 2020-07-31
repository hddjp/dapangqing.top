package Servlet;

import Classes.User;
import JDBC.PictureDaoImp;
import JDBC.UserDaoImp;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.sun.deploy.net.URLEncoder;
import javax.jws.soap.SOAPBinding;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class UploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DiskFileItemFactory factory= new DiskFileItemFactory();
        File file=new File(req.getSession().getServletContext().getRealPath("/img/normal/medium/"));
        factory.setRepository(file);
        ServletFileUpload upload=new ServletFileUpload(factory);

        String title="",description="",countryCodeIso="",theme="",path="",d="";
        int cityCode=0,imageId=0;
        //从表单中获取信息
        try {
            List<FileItem> items=upload.parseRequest(req);
            for(FileItem item:items){
                if(item.isFormField()){
                    switch (item.getFieldName()) {
                        case "title":
                            title = item.getString();
                            break;
                        case "description":
                            description = item.getString();
                            break;
                        case "country":
                            countryCodeIso = item.getString();
                            break;
                        case "city":
                            cityCode = Integer.parseInt(item.getString());
                            break;
                        case "theme":
                            theme = item.getString();
                            break;
                        case "id":
                            imageId = Integer.parseInt(item.getString());
                            break;
                    }
                }else{
                    SimpleDateFormat formatter= new SimpleDateFormat("yyyyMMddHHmmss");
                    Date date = new Date(System.currentTimeMillis());
                    d=formatter.format(date);
                    path=d+item.getName();
                    InputStream in=item.getInputStream();
                    byte[] buffer=new byte[1024];
                    int len=0;
                    String fileName=req.getSession().getServletContext().getRealPath("/img/normal/medium/"+path);
                    OutputStream output=new FileOutputStream(fileName);

                    while ((len=in.read(buffer))!=-1){
                        output.write(buffer,0,len);
                    }
                    output.close();
                    in.close();
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
        String time=formatter.format(date);

        if(req.getSession().getAttribute("Username")==null){
            req.setAttribute("message","请先登录！");
            req.getRequestDispatcher("src/jsp/upload.jsp").forward(req,resp);
        }else {
            User me = new UserDaoImp().getUser("select UID uid from traveluser where UserName =?",req.getSession().getAttribute("Username"));

            //上传到数据库
            PictureDaoImp pictureDaoImp = new PictureDaoImp(req);
            if (imageId == 0) {
                long total = pictureDaoImp.getForPicValue("select count(ImageID) from travelimage");
                String sql = "insert into travelimage (ImageID,Title,Description,CityCode,CountryCodeISO,UID,PATH,Content,UPTIME,Favor) values (?,?,?,?,?,?,?,?,?,0)";
                pictureDaoImp.updatePic(sql,total+1,title,description,cityCode,countryCodeIso,me.getUid(),path,theme,time);
            }else {
                if(!path.equals(d)) {
                    String sql = "update travelimage set Title=?,Description=?,CityCode=?,CountryCodeISO=?,PATH=?,Content=?,UPTIME=? where ImageID=?";
                    pictureDaoImp.updatePic(sql,title,description,cityCode,countryCodeIso,path,theme,time,imageId);
                }else {
                    String sql = "update travelimage set Title=?,Description=?,CityCode=?,CountryCodeISO=?,Content=?,UPTIME=? where ImageID=?";
                    pictureDaoImp.updatePic(sql,title,description,cityCode,countryCodeIso,theme,time,imageId);
                }
            }
            req.setAttribute("message","上传成功！");
            req.getRequestDispatcher("src/jsp/mypic.jsp").forward(req,resp);
        }
    }
}
