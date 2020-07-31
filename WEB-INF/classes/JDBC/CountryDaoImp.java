package JDBC;

import Classes.City;
import Classes.Country;

import java.util.List;

public class CountryDaoImp extends DAO<Country>{
    public CountryDaoImp(){}

    public <E> E getForCountryValue(String sql,Object...args){
        return getForValue(sql,args);
    }

    public List<Country> getForCountryList(String sql, Object...args){
        return getForList(sql,args);
    }

    public Country getCountry(String sql,Object...args){
        return get(sql,args);
    }

    public void updateCountry(String sql,Object...args){
        update(sql,args);
    }
}
