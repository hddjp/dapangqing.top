package JDBC;

import Classes.*;
import Servlet.LoginServlet;
import com.sun.deploy.net.HttpRequest;
import org.apache.commons.fileupload.servlet.ServletRequestContext;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PictureDaoImp extends DAO<Picture> {

    final int DISPLAY_MIDDLE = 6;
    final int DISPLAY_LESS = 5;
    HttpServletRequest request = null;

    public PictureDaoImp(HttpServletRequest request) {
        this.request = request;
    }

    public <E> E getForPicValue(String sql, Object... args) {
        return getForValue(sql, args);
    }

    public List<Picture> getForPicList(String sql, Object... args) {
        return getForList(sql, args);
    }

    public Picture getPic(String sql, Object... args) {
        return get(sql, args);
    }

    public void updatePic(String sql, Object... args) {
        update(sql, args);
    }

    //首页使用的方法，初始化最高人气图片
    public void initialFavor() {
        long count = getForPicValue("select count(*) from travelimage where ImageID>0");
        List<Picture> list = new ArrayList<>();
        list = getForPicList("select ImageID imageId,PATH path from travelimage order by Favor desc");
        List<Picture> picShow = list.subList(0, DISPLAY_LESS);
        request.setAttribute("picShow", picShow);
    }

    //初始化最新的图片
    public void getNewPics() {
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = getForPicList("select ImageID imageId,Title title,Description description,PATH path,UID uid,Content theme, UPTIME time from travelimage order by UPTIME desc");
        List<Picture> newPic = pictures.subList(0, DISPLAY_MIDDLE);
        //为图片加入上传者名字
        UserDaoImp userDaoImp = new UserDaoImp();
        for (Picture picture : newPic) {
            User user = userDaoImp.getUser("select UserName userName from traveluser where UID=?", picture.getUid());
            picture.setUserName(user.getUserName());
        }
        request.setAttribute("newPic", newPic);
    }

    public void initialDetails() {
        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "select ImageID imageId , Title title,Description description,CityCode cityCode,CountryCodeISO countryCodeIso,UID uid,PATH path,Content theme,UPTIME time,Favor favors from travelimage where ImageID=?";
        Picture picture = getPic(sql, id);

        //得到上传者的名字
        UserDaoImp userDaoImp = new UserDaoImp();
        User user = userDaoImp.getUser("select UserName userName from traveluser where UID=?", picture.getUid());
        picture.setUserName(user.getUserName());
        //得到城市名字
        if (picture.getCityCode() != 0) {
            CityDaoImp cityDaoImp = new CityDaoImp();
            City city = cityDaoImp.getCity("select AsciiName cityName from geocities where GeoNameID=?", picture.getCityCode());
            picture.setCityName(city.getCityName());
        }
        //得到国家名字
        CountryDaoImp countryDaoImp = new CountryDaoImp();
        Country country = countryDaoImp.getCountry("select CountryName countryName from geocountries where ISO=?", picture.getCountryCodeIso());
        picture.setCountryName(country.getCountryName());

        //根据图片收藏数，评论数得到热度
        long commentNum = getForPicValue("select count(ID) from comments where ImageID=?", id);
        long hot = commentNum * 300 + picture.getFavors() * 500;
        request.setAttribute("hot", hot);
        request.setAttribute("pic", picture);
        //得到当前用户的uid
        long isfavor = 0;
        if (request.getSession().getAttribute("Username") != null) {
            User me = userDaoImp.getUser("select UID uid from traveluser where UserName=?", request.getSession().getAttribute("Username"));
            isfavor = getForPicValue("select count(FavorID) from travelimagefavor where ImageID=? and UID=?", id, me.getUid());
        }
        request.setAttribute("isfavor", isfavor);

        //初始化图片的评论
        CommentDaoImp commentDaoImp = new CommentDaoImp();
        if (request.getSession().getAttribute("range") == null || request.getSession().getAttribute("range").equals("hot")) {
            sql = "select ID id,UID uid,comment comment,time time,Favors favors from comments where ImageID=? order by Favors desc";
        } else if (request.getSession().getAttribute("range").equals("time")) {
            sql = "select ID id,UID uid,comment comment,time time,Favors favors from comments where ImageID=? order by time desc";
        }
        List<Comment> comments = commentDaoImp.getForCommentList(sql, id);
        for (Comment comment : comments) {
            User user1 = userDaoImp.getUser("select UserName userName from traveluser where UID=?", comment.getUid());
            comment.setUserName(user1.getUserName());
            //看当前用户是否点赞此照片
            if (request.getSession().getAttribute("Username") != null) {
                User me = userDaoImp.getUser("select UID uid from traveluser where UserName=?", request.getSession().getAttribute("Username"));
                if (commentDaoImp.getForCommentValue("select count(ID) from commentzan where commentID=? and UID=?", comment.getId(), me.getUid()) != null) {
                    long i = commentDaoImp.getForCommentValue("select count(ID) from commentzan where commentID=? and UID=?", comment.getId(), me.getUid());
                    if (i == 1) {
                        comment.setIsZan(1);
                    } else {
                        comment.setIsZan(0);
                    }
                }
            } else {
                comment.setIsZan(0);
            }
        }
        request.setAttribute("comments", comments);
    }

    public void printFoot(){
        int id = Integer.parseInt(request.getParameter("id"));
        if(request.getSession().getAttribute("Username")!=null){
            UserDaoImp userDaoImp=new UserDaoImp();
            User user=userDaoImp.getUser("select UID uid from traveluser where UserName=?",request.getSession().getAttribute("Username"));
            int uid=user.getUid();
            updatePic("delete from footprint where ImageID=? and UID=?",id,uid);
            updatePic("insert into footprint (ImageID,UID) values (?,?)",id,uid);
        }
    }

    //初始化上传页面
    public void initialUpload() {
        CountryDaoImp countryDaoImp = new CountryDaoImp();
        CityDaoImp cityDaoImp = new CityDaoImp();
        String sql = "select ISO countryCodeIso,CountryName countryName from geocountries";
        List<Country> countries = countryDaoImp.getForCountryList(sql);

        for (Country country : countries) {
            List<City> cities = cityDaoImp.getForCityList("select GeoNameID cityCode,AsciiName cityName from geocities where CountryCodeISO=?", country.getCountryCodeIso());
            country.setCities(cities);
        }
        request.setAttribute("countries", countries);

        //如果url参数有id则是修改图片信息
        if (request.getParameter("id") != null) {
            //传输过来的id是加密的，要先解密
            String id = request.getParameter("id");
            String key = request.getParameter("key");
            String imgid = LoginServlet.decrypt(id, key);

            sql = "select ImageID imageId,Title title,Description description,CityCode cityCode,CountryCodeISO countryCodeIso,PATH path,Content theme from travelimage where ImageID=?";
            Picture picture = getPic(sql, imgid);
            if (picture.getCityCode() > 0) {
                City city = new CityDaoImp().getCity("select AsciiName cityName from geocities where GeoNameID=?", picture.getCityCode());
                picture.setCityName(city.getCityName());
            }
            request.setAttribute("picture", picture);
        }
    }

    public void initialMypic() throws UnsupportedEncodingException {
        if (request.getSession().getAttribute("Username") != null) {
            User user = new UserDaoImp().getUser("select UID uid from traveluser where UserName=?", request.getSession().getAttribute("Username"));
            int uid = user.getUid();
            //生成密钥以供使用
            String key = LoginServlet.generateKey(16);

            String sql = "select ImageID imageId,Title title,Description description,PATH path from travelimage where UID=?";
            List<Picture> pictures = getForPicList(sql, uid);
            if (pictures.size() == 0) {
                request.setAttribute("pictures", "nothing");
            } else {
                for (Picture picture : pictures) {
                    String crypted = LoginServlet.encrypt(String.valueOf(picture.getImageId()), key);
                    assert crypted != null;
                    picture.setCryptID(URLEncoder.encode(crypted, "UTF-8"));
                }
                request.setAttribute("pictures", pictures);
                int pages = (pictures.size() - 1) / DISPLAY_MIDDLE + 1;
                request.setAttribute("pages", pages);
            }
            request.setAttribute("key", key);
        }
    }

    public void initialFavorates() throws UnsupportedEncodingException {
        if (request.getSession().getAttribute("Username") != null) {
            User user = new UserDaoImp().getUser("select UID uid,allow viewable from traveluser where UserName=?", request.getSession().getAttribute("Username"));
            int uid = user.getUid();
            String key = LoginServlet.generateKey(16);
            request.setAttribute("key", key);

            String sql = "select ImageID imageId from travelimagefavor where UID=?";
            List<Picture> pictures = getForPicList(sql, uid);
            if (pictures.size() == 0) {
                request.setAttribute("pictures", "nothing");
            } else {
                List<Picture> pictures1=new ArrayList<>();
                for(Picture picture:pictures){
                    Picture picture1=getPic("select ImageID imageId,Title title,Description description,PATH path from travelimage where ImageID=?",picture.getImageId());
                    pictures1.add(picture1);
                }
                for (Picture picture : pictures1) {
                    String crypted = LoginServlet.encrypt(String.valueOf(picture.getImageId()), key);
                    assert crypted != null;
                    picture.setCryptID(URLEncoder.encode(crypted, "UTF-8"));
                }
                request.setAttribute("pictures", pictures1);
                int pages = (pictures.size() - 1) / DISPLAY_MIDDLE + 1;
                request.setAttribute("pages", pages);
            }

            //是否对好友可见
            request.setAttribute("viewable",user.getViewable());
        }
    }

    //为进入好友的收藏重写初始化方法
    public void initialFavorates(int id){
        UserDaoImp userDaoImp=new UserDaoImp();
        User user=userDaoImp.getUser("select UID uid,UserName userName ,allow viewable from traveluser where UID=?",id);
        if(user.getViewable()==0){
            request.setAttribute("pictures","notallow");
        }else {
            List<Picture> pictures=getForPicList("select ImageID imageId from travelimagefavor where UID=?",user.getUid());
            if(pictures.size()==0){
                request.setAttribute("pictures","nothing");
            }else {
                List<Picture> pictures1 = new ArrayList<>();
                for (Picture picture : pictures) {
                    Picture p = getPic("select ImageID imageId,Title title,Description description,PATH path from travelimage where ImageID=?", picture.getImageId());
                    pictures1.add(p);
                }
                request.setAttribute("pictures", pictures1);
                int pages = (pictures.size() - 1) / DISPLAY_MIDDLE + 1;
                request.setAttribute("pages", pages);
            }
        }
        request.setAttribute("user",user);
    }

    public void getFootPrint(){
        if(request.getSession().getAttribute("Username")!=null){
            User user = new UserDaoImp().getUser("select UID uid from traveluser where UserName=?", request.getSession().getAttribute("Username"));
            int uid = user.getUid();
            String sql="select ImageID imageId from footprint where UID=? order by ID desc";
            List<Picture> list=getForPicList(sql,uid);
            if(list.size()==0){
                request.setAttribute("footprint","nothing");
            }else {
                List<Picture> foot = new ArrayList<>();
                for (Picture picture : list) {
                    Picture picture1 = getPic("select ImageID imageId ,Title title from travelimage where ImageID=?", picture.getImageId());
                    foot.add(picture1);
                }
                //只显示10个以下
                if (foot.size() > 10) {
                    foot = foot.subList(0, 10);
                }
                request.setAttribute("footprint", foot);
            }
        }
    }
}
