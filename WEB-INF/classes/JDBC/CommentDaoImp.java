package JDBC;

import Classes.City;
import Classes.Comment;

import java.util.List;

public class CommentDaoImp extends DAO<Comment>{
    public CommentDaoImp(){}

    public <E> E getForCommentValue(String sql,Object...args){
        return getForValue(sql,args);
    }

    public List<Comment> getForCommentList(String sql, Object...args){
        return getForList(sql,args);
    }

    public Comment getComment(String sql,Object...args){
        return get(sql,args);
    }

    public void updateComment(String sql,Object...args){
        update(sql,args);
    }
}
