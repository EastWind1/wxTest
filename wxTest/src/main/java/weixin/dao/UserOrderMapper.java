package weixin.dao;

import java.util.List;

import weixin.model.UserOrder;

public interface UserOrderMapper extends BaseDao<UserOrder, String>{
	public void deleteMoreByOrder(List<String> oid);
	public void deleteByOrderId(Integer id);
	
}