package app.apps.dao;

import java.io.Serializable;
import java.util.List;

public interface InterfaceDAO {
    public <T> void create(T o) throws Exception;

    public <T> T findById(Class<T> o, Serializable id) throws Exception;

    public <T> T findOneBySql(Class<T> o, String sql) throws Exception;// on donne une requete sql

    public <T> T findOneWhere(T entity, boolean and, boolean like) throws Exception; //on donne l'objet entite qui servira de filtre, et on indique si on veut que les conditions soient AND ou OR, et on indique si on veut que les conditions soient LIKE ou =

    public <T> List<T> findBySql(Class<T> o, String sql, int deb, int size) throws Exception;// on donne une requete sql

    public void update(Object o) throws Exception;

    public void delete(Object o) throws Exception;

    public <T> List<T> findAll(Class<T> tClass, int deb, int size, String order, boolean asc) throws Exception; //on donne la classe de l'objet,et on indique la ou les colonnes sur quoi ils sont order sinon null si on veut pas, et on indique si on veut que l'ordre soit ASC ou DESC

    public <T> List<T> findWhere(T entity, int deb, int size, String order, boolean asc, boolean and, boolean like)
            throws Exception; //la meme chose que findall mais on donne l'objet entite qui servira de filtre, et on indique si on veut que les conditions soient AND ou OR, et on indique si on veut que les conditions soient LIKE ou =
}