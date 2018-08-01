package weixin.dao;

import java.util.List;

import weixin.model.ServerService;

public interface ServerServiceMapper extends BaseDao<ServerService, String>{
	public void deleteByServiceId(Integer id);
}