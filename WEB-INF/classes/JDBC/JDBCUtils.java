package JDBC;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import javax.xml.crypto.Data;
import java.sql.Connection;
import java.sql.SQLException;

/*
JDBC操作的工具类
* */
public class JDBCUtils{

    private static DataSource dataSource=null;

    static {
        //数据源只创建一次
        dataSource=new ComboPooledDataSource("helloc3p0");
    }

    /*
    * 释放连接
    * */
    public static void releaseConnection(Connection connection){
        try {
            if(connection!=null){
                connection.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /*
    * 返回数据源的一个Connection对象
    * */
    public static Connection getConnection() throws SQLException {
       return dataSource.getConnection();
    }

}