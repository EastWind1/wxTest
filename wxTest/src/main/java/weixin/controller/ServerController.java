package weixin.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import weixin.dao.OrderMapper;
import weixin.dao.ServerMapper;
import weixin.dao.ServerOrderMapper;
import weixin.dao.ServerServiceMapper;
import weixin.dao.ServiceMapper;
import weixin.model.Order;
import weixin.model.Server;
import weixin.model.ServerOrder;
import weixin.model.ServerService;
import weixin.model.Service;
import weixin.util.OrderState;
import weixin.util.ServerState;
import weixin.util.weixin.pojo.SNSUserInfo;

@Controller("Server")
@Scope("prototype")
@RequestMapping("server.action")

//服务 方功能

public class ServerController {
	@Autowired
	public OrderMapper orderMapper;
	@Autowired
	public ServerMapper serverMapper;
	@Autowired
	public ServiceMapper serviceMapper;
	@Autowired
	public ServerOrderMapper serverOrderMapper;
	@Autowired
	public ServerServiceMapper serverServiceMapper;
	
	@RequestMapping(params="openShop")
	@ResponseBody
	public Map<Object, Object> openShop(HttpServletRequest request,HttpSession session,Server server)//创建商家
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		
    	Map<Object, Object> map=new HashMap<Object, Object>();
    	try {
    		server.setState(ServerState.CHECKING);
    		server.setId(userId);
    		serverMapper.insertSelective(server);
    		
    		map.put("msg", "等待审核中");
    		
		} catch (Exception e) {
			map.put("msg", "开店失败");
		}
    	
    	return map;
    }
	
	@RequestMapping(params="getMyServer")
	@ResponseBody
	public Map<Object, Object> getMyServer(HttpSession session)//修改商家
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		Server server=null;
		
    	Map<Object, Object> map=new HashMap<Object, Object>();
    	try {
    		server=serverMapper.selectByPrimaryKey(userId);
    		
    		map.put("rows", server);
    		map.put("msg", "查询成功");
    		
		} catch (Exception e) {
			map.put("msg", "查询失败");
		}
    	
    	return map;
    }
	
	@RequestMapping(params = "changeServer")
	@ResponseBody
	public Map<Object, Object> changeServer(Server server,HttpSession session){//修改服务
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		
    	Map<Object, Object> map=new HashMap<Object, Object>();
    	try {
    		server.setId(userId);
    		serverMapper.updateByPrimaryKeySelective(server);
    		
    		map.put("msg", "更改成功");
    		
		} catch (Exception e) {
			map.put("msg", "更改失败");
		}
    	
    	return map;
	}
	
	@RequestMapping(params="addService")
	@ResponseBody
	public Map<Object, Object> addService(HttpServletRequest request,HttpSession session,Service service)//添加服务
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		int newServiceId=0;
		
    	Map<Object, Object> map=new HashMap<Object, Object>();
    	try {
    		Server server = serverMapper.selectByPrimaryKey(userId);
    		if(server!=null && server.getState().equals(ServerState.PASS)){
    			serviceMapper.insertSelective(service);
    			
    			newServiceId=service.getId();
    			
    			ServerService serverService= new ServerService();
    			serverService.setServerid(userId);
    			serverService.setServiceid(newServiceId);
    			serverServiceMapper.insertSelective(serverService);

    			map.put("msg", "添加成功");
    		}
    		else{
    			map.put("msg", "未开店或您的商铺还未审核通过");
    		}
    		
		} catch (Exception e) {
			map.put("msg", "添加失败");
		}
    	
    	return map;
    }
	
	
	@RequestMapping(params="getOrder")
	@ResponseBody
	public Map<Object, Object> getOrder(HttpServletRequest request)//查询并获取订单列表，可进行条件查询
    {
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		Map<Object, Object> ifMap = new HashMap<Object, Object>();
		Enumeration<?> en = request.getParameterNames();
		while (en.hasMoreElements()) {
			String paramName = (String) en.nextElement();
			String paramValue = request.getParameter(paramName);
	
			if (paramValue.equals("")) {

			} else {
				//形成键值对应的map
				ifMap.put(paramName, paramValue);
			}
		}
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		// 如果没有page和rows则不传到 SQL语句中
		if (page != null && rows != null) {
			ifMap.put("pageIndex",(Integer.parseInt(page)));
			ifMap.put("rows", (Integer.parseInt(rows)));
		}
		ifMap.put("name", request.getParameter("name"));
		ifMap.put("kind", request.getParameter("kind"));
		ifMap.put("state", OrderState.WAIT_RECEIVE);
		ifMap.put("id", request.getParameter("id"));
		try {
			List list = orderMapper.get(ifMap);			
			resultMap.put("rows", list);
			resultMap.put("total", orderMapper.getCount(ifMap));
			resultMap.put("success",true);
			resultMap.put("page", page);
			resultMap.put("msg","查询成功");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
			resultMap.put("msg","查询失败");
		}
		return resultMap;
    }
	
	@RequestMapping(params="getMyService")
	@ResponseBody
	public Map<Object, Object> getMyService(HttpServletRequest request,HttpSession session)//查询用户发布的服务
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		Map<Object, Object> ifMap = new HashMap<Object, Object>();
		Enumeration<?> en = request.getParameterNames();
		while (en.hasMoreElements()) {
			String paramName = (String) en.nextElement();
			String paramValue = request.getParameter(paramName);
	
			if (paramValue.equals("")) {

			} else {
				//形成键值对应的map
				ifMap.put(paramName, paramValue);
			}
		}
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		// 如果没有page和rows则不传到SQL语句中
		if (page != null && rows != null) {
			ifMap.put("pageIndex",(Integer.parseInt(page)));
			ifMap.put("rows", (Integer.parseInt(rows)));
		}
		ifMap.put("name", request.getParameter("name"));
		ifMap.put("kind", request.getParameter("kind"));
		ifMap.put("id", request.getParameter("id"));
		ifMap.put("uid", userId);
		try {
			List<Service> list = serviceMapper.getMy(ifMap);
			resultMap.put("rows", list);
			resultMap.put("total", serviceMapper.getMyCount(ifMap));
			resultMap.put("success",true);
			resultMap.put("page", page);
			resultMap.put("msg","查询成功");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
			resultMap.put("msg","查询失败");
		}
		return resultMap;
    }
	@RequestMapping(params="getServiceById")
	@ResponseBody
	public Map<Object, Object> getServiceById(HttpServletRequest request,Integer id)//根据id获取订单详情
    {
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		try {
			Service service = serviceMapper.selectByPrimaryKey(id);
			resultMap.put("rows", service);
			resultMap.put("success",true);
			resultMap.put("msg","查询成功");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
			resultMap.put("msg","查询失败");
		}
		return resultMap;
    }
	@RequestMapping(params = "updMoreByPkId")
	@ResponseBody
	public Map<Object, Object> updMoreByPkId(Service service){//修改服务
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			serviceMapper.updateByPrimaryKeySelective(service);
			map.put("msg", "修改成功");
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "修改失败");
			map.put("success", false);
		}
		return map;
	}

	
	@RequestMapping(params = "deleteService")
	@ResponseBody
	public Map<Object, Object> deleteService(Integer id){//删除服务
		Map<Object, Object> map = new HashMap<Object, Object>();
        try {
            serviceMapper.deleteByPrimaryKey(id);
            serverServiceMapper.deleteByServiceId(id);
            map.put("msg", "删除成功");
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "删除失败");
            map.put("success", false);
        }
        return map;
	}
	
	@RequestMapping(params = "deleteOrder")
	@ResponseBody
	public Map<Object, Object> deleteOrder(Integer id){//删除等待确认的订单
		Map<Object, Object> map = new HashMap<Object, Object>();
        try {
        	serverOrderMapper.deleteByOid(id);
        	List<Server> solist = serverMapper.getByOrderId(id);
        	if(solist.isEmpty()){
        		Order order = new Order();
        		order.setId(id);
        		order.setState(OrderState.WAIT_RECEIVE);
        		orderMapper.updateByPrimaryKeySelective(order);
        	}        
            map.put("msg", "删除成功");
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "删除失败");
            map.put("success", false);
        }
        return map;
	}
	
	@RequestMapping(params="getMyOrder")
	@ResponseBody
	public Map<Object, Object> getMyOrder(HttpServletRequest request,HttpSession session)//查询用户接收的订单
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		Map<Object, Object> ifMap = new HashMap<Object, Object>();
		Enumeration<?> en = request.getParameterNames();
		while (en.hasMoreElements()) {
			String paramName = (String) en.nextElement();
			String paramValue = request.getParameter(paramName);
	
			if (paramValue.equals("")) {

			} else {
				//形成键值对应的map
				ifMap.put(paramName, paramValue);
			}
		}
		String page = request.getParameter("start");
		String rows = request.getParameter("length");
		// 如果没有page和rows则不传到SQL语句中
		if (page != null && rows != null) {
			ifMap.put("pageIndex",(Integer.parseInt(page)));
			ifMap.put("rows", (Integer.parseInt(rows)));
		}
		ifMap.put("name", request.getParameter("name"));
		ifMap.put("kind", request.getParameter("kind"));
		ifMap.put("id", request.getParameter("id"));
		ifMap.put("sid", userId);
		try {
			List<Order> list = orderMapper.serverGet(ifMap);
			resultMap.put("rows", list);
			resultMap.put("total", orderMapper.serverGetCount(ifMap));
			resultMap.put("success",true);
			resultMap.put("page", page);
			resultMap.put("msg","查询成功");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
			resultMap.put("msg","查询失败");
		}
		return resultMap;
    }
	
	@RequestMapping(params = "receive")
	@ResponseBody
	public Map<Object, Object> receive(HttpSession session,Order order){//接受公共订单
		Map<Object, Object> map = new HashMap<Object, Object>();
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		String userId = user.getOpenId();//获取用户id
		try {
			Server server = serverMapper.selectByPrimaryKey(userId);
			if(server!=null && server.getState().equals(ServerState.PASS)){
				ServerOrder serverOrder =new ServerOrder();
				serverOrder.setOid(order.getId());
				serverOrder.setSid(userId);
				
				serverOrderMapper.insertSelective(serverOrder);
				
				order.setState(OrderState.WAIT_CONFIME);
				orderMapper.updateByPrimaryKeySelective(order);
				
				map.put("msg", "接单成功");
				map.put("success", true);
			}
			else{
				map.put("msg", "商户审核未通过");
				map.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "接单失败");
			map.put("success", false);
		}
		return map;
	}
	
	@RequestMapping(params = "confirm")
	@ResponseBody
	public Map<Object, Object> confirm(HttpSession session,Order order){//确认订单完成或接受、拒绝定向订单
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			if(order.getState().equals(OrderState.ONGOING)){
				orderMapper.updateByPrimaryKeySelective(order);
				map.put("msg", "接收成功");
			}
			if(order.getState().equals(OrderState.REFUSED)){
				serverOrderMapper.deleteByOid(order.getId());
				orderMapper.updateByPrimaryKeySelective(order);
				map.put("msg", "拒绝成功");
			}
			if(order.getState().equals(OrderState.WAIT_EVALUATE)){
				orderMapper.updateByPrimaryKeySelective(order);
				map.put("msg", "确认完成成功");
			}

			map.put("success", true);
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "修改失败");
			map.put("success", false);
		}
		return map;
	}
}
