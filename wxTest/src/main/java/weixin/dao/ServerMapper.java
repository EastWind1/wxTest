package weixin.dao;

import java.util.List;

import weixin.model.Server;


public interface ServerMapper extends BaseDao<Server, String>{
	Server selectByPrimaryKey(String id);
	List<Server> getByOrderId(Integer id);
}