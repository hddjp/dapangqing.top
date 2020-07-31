package JDBC;

import Classes.City;
import Classes.Picture;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class CityDaoImp extends DAO<City>{
    public CityDaoImp(){}

    public <E> E getForCityValue(String sql,Object...args){
        return getForValue(sql,args);
    }

    public List<City> getForCityList(String sql, Object...args){
        return getForList(sql,args);
    }

    public City getCity(String sql,Object...args){
        return get(sql,args);
    }

    public void updateCity(String sql,Object...args){
        update(sql,args);
    }
}
