package weixin.dao;

import weixin.model.ServerOrder;

public interface ServerOrderMapper extends BaseDao<ServerOrder, String>{
	public void deleteByOid(Integer oid);
}