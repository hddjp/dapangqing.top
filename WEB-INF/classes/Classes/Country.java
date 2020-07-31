package Classes;

import java.util.List;

public class Country {

    private String countryCodeIso;
    private String countryName;
    private List<City> cities;


    public Country(){}

    public String getCountryCodeIso() {
        return countryCodeIso;
    }

    public void setCountryCodeIso(String countryCodeIso) {
        this.countryCodeIso = countryCodeIso;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public List<City> getCities() {
        return cities;
    }

    public void setCities(List<City> cities) {
        this.cities = cities;
    }
}
