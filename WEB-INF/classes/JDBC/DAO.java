package JDBC;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.util.List;

public class DAO<T>{

    private QueryRunner queryRunner=new QueryRunner();

    private Class<T> clazz;

    public DAO(){
        Type superClass=getClass().getGenericSuperclass();
        if(superClass instanceof ParameterizedType){
            ParameterizedType parameterizedType= (ParameterizedType) superClass;
            Type[] typeArguments=parameterizedType.getActualTypeArguments();
            if(typeArguments!=null&&typeArguments.length>0){
                if(typeArguments[0] instanceof Class){
                    clazz= (Class<T>) typeArguments[0];
                }
            }
        }
    }

    /*
     * 返回某个字段的值
     * */
    public <E> E getForValue(String sql,Object...args){
        Connection connection=null;
        try{
            connection=JDBCUtils.getConnection();
            return (E)queryRunner.query(connection,sql,new ScalarHandler<>(),args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.releaseConnection(connection);
        }
        return null;
    }
    /*
     * 返回T所对应的List
     * */
    public List<T> getForList(String sql,Object...args){
        Connection connection=null;
        try{
            connection=JDBCUtils.getConnection();
            return queryRunner.query(connection,sql,new BeanListHandler<>(clazz),args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.releaseConnection(connection);
        }
        return null;
    }

    /*
     * 返回对应的T的一个实例类的对象
     * */
    public T get(String sql,Object...args){
        Connection connection=null;
        try{
            connection=JDBCUtils.getConnection();
            return queryRunner.query(connection,sql,new BeanHandler<>(clazz),args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.releaseConnection(connection);
        }
        return null;
    }

    /*
     * 封装了INSERT，DELET，UPDATE操作
     * */
    public void update(String sql,Object...args){
        Connection connection=null;
        try{
            connection=JDBCUtils.getConnection();
            queryRunner.update(connection,sql,args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.releaseConnection(connection);
        }
    }
}