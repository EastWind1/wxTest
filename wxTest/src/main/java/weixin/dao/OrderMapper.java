package weixin.dao;

import java.util.List;
import java.util.Map;

import weixin.model.Order;

public interface OrderMapper extends BaseDao<Order, String> {
	public List get(Map<Object, Object> map);
	public void deleteByPrimaryKey(Integer id);
    Order selectByPrimaryKey(Integer id);
	public List<Order> getMy(Map<Object, Object> map);
	public int getMyCount(Map<Object,Object> map);
	public List<Order> serverGet(Map<Object, Object> map);
	public int serverGetCount(Map<Object,Object> map);
}