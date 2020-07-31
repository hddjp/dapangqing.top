package Classes;

public class User {

    private int uid;
    private String email;
    private String userName;
    private String hashValue;
    private String salt;
    private int viewable;
    private int isFriend;
    private String time;
    private String cryptId;

    public User(){}

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getHashValue() {
        return hashValue;
    }

    public void setHashValue(String hashValue) {
        this.hashValue = hashValue;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public int getViewable() {
        return viewable;
    }

    public void setViewable(int viewable) {
        this.viewable = viewable;
    }

    public int getIsFriend() {
        return isFriend;
    }

    public void setIsFriend(int isFriend) {
        this.isFriend = isFriend;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getCryptId() {
        return cryptId;
    }

    public void setCryptId(String cryptId) {
        this.cryptId = cryptId;
    }
}
