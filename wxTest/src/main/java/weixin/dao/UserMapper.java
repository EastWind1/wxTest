package weixin.dao;

import weixin.model.User;

public interface UserMapper extends BaseDao<User, String>{
	User selectByPrimaryKey(String id);
}