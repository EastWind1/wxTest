package weixin.controller;

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
import weixin.dao.ServiceMapper;
import weixin.dao.UserMapper;
import weixin.dao.UserOrderMapper;
import weixin.model.Order;
import weixin.model.Server;
import weixin.model.ServerOrder;
import weixin.model.Service;
import weixin.model.UserOrder;
import weixin.util.OrderState;
import weixin.util.weixin.pojo.SNSUserInfo;

@Controller("Demander")
@Scope("prototype")
@RequestMapping("demander.action")

//需求方功能

public class DemanderController {
	@Autowired
	public UserMapper userMapper;
	@Autowired
	public OrderMapper orderMapper;
	@Autowired
	public ServerMapper serverMapper;
	@Autowired
	public UserOrderMapper userOrderMapper;
	@Autowired
	public ServiceMapper serviceMapper;
	@Autowired
	public ServerOrderMapper serverOrderMapper;
	
	@RequestMapping(params="releaseOrder")
	@ResponseBody
	public Map<Object, Object> releaseOrder(HttpServletRequest request,HttpSession session,Order order)//发布公共订单
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		
		
		int newOrderId = 0;
		String userId = user.getOpenId();
		
    	Map<Object, Object> map=new HashMap<Object, Object>();
    	try {
    		order.setState(OrderState.WAIT_PAY);
    		orderMapper.insertSelective(order);
    		
    		newOrderId=order.getId();
    		
    		UserOrder userOrder = new UserOrder();
    		userOrder.setUid(userId);
    		userOrder.setOid(newOrderId);
    		userOrderMapper.insertSelective(userOrder);
    		map.put("msg", "新增成功");
    		
		} catch (Exception e) {
			map.put("msg", "新增失败");
		}
    	return map;
    }
	@RequestMapping(params="releaseOrderToServer")
	@ResponseBody
	public Map<Object, Object> releaseOrderToServer(HttpServletRequest request,HttpSession session,Order order,String serverId)//发布定向订单
    {
		SNSUserInfo user=(SNSUserInfo)session.getAttribute("user");
		int newOrderId = 0;
		String userId = user.getOpenId();
		
    	Map<Object, Object> map=new HashMap<Object, Object>();
    	try {
    		order.setState(OrderState.WAIT_PAY);
    		orderMapper.insertSelective(order);
    		
    		newOrderId=order.getId();
    		
    		UserOrder userOrder = new UserOrder();
    		userOrder.setUid(userId);
    		userOrder.setOid(newOrderId);
    		userOrderMapper.insertSelective(userOrder);
    		
    		ServerOrder serverOrder=new ServerOrder();
    		serverOrder.setOid(newOrderId);
    		serverOrder.setSid(serverId);
    		serverOrderMapper.insertSelective(serverOrder);
    		
    		map.put("msg", "新增成功");
    		
		} catch (Exception e) {
			map.put("msg", "新增失败");
		}
    	return map;
    }
	@RequestMapping(params="getOrderById")
	@ResponseBody
	public Map<Object, Object> getOrderById(HttpServletRequest request,Integer id)//根据id获取订单详情
    {
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		try {
			Order order = orderMapper.selectByPrimaryKey(id);
			resultMap.put("rows", order);
			resultMap.put("success",true);
			resultMap.put("msg","查询成功");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
			resultMap.put("msg","查询失败");
		}
		return resultMap;
    }
	@RequestMapping(params="getService")
	@ResponseBody
	public Map<Object, Object> getService(HttpServletRequest request)//查询并获取服务列表，可进行条件查询
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
		// 如果没有page和rows则不传到SQL语句中
		if (page != null && rows != null) {
			ifMap.put("pageIndex",(Integer.parseInt(page)));
			ifMap.put("rows", (Integer.parseInt(rows)));

		}
		ifMap.put("name", request.getParameter("name"));
		ifMap.put("kind", request.getParameter("kind"));
		ifMap.put("id", request.getParameter("id"));
		try {
			List<Service> list = serviceMapper.get(ifMap);
			resultMap.put("rows", list);
			resultMap.put("total", serviceMapper.getCount(ifMap));
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
	
	
	@RequestMapping(params="getMyOrder")
	@ResponseBody
	public Map<Object, Object> getMyOrder(HttpServletRequest request,HttpSession session)//查询用户发布的订单
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
		ifMap.put("state",request.getParameter("state"));
		ifMap.put("id", request.getParameter("id"));
		ifMap.put("uid", userId);
		try {
			List<Order> list = orderMapper.getMy(ifMap);
			resultMap.put("rows", list);
			resultMap.put("total", orderMapper.getMyCount(ifMap));
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
	@RequestMapping(params = "updMoreByPkId")
	@ResponseBody
	public Map<Object, Object> updMoreByPkId(Order order){//修改订单
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			if(order.getState().equals(OrderState.WAIT_RECEIVE) || order.getState().equals(OrderState.WAIT_SERVER_RECEIVE)
					||order.getState().equals(OrderState.REFUSED) ){
				orderMapper.updateByPrimaryKeySelective(order);
				map.put("msg", "修改成功");
				map.put("success", true);
			}
			else{
				map.put("msg", "当前订单已被接单，无法修改");
				map.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "修改失败");
			map.put("success", false);
		}
		return map;
	}
	@RequestMapping(params = "getServerByOrder")
	@ResponseBody
	public Map<Object, Object> getServerByOrder(Integer id){//获取接单商家
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			List<Server> list = (List<Server>) serverMapper.getByOrderId(id);
			map.put("rows", list);
			map.put("msg", "查询成功");
			map.put("success", true);
		}
		catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "查询失败");
			map.put("success", false);
		}
		return map;
	}
	@RequestMapping(params = "pay")
	@ResponseBody
	public Map<Object, Object> pay(Order order){//付款
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			//
			//付款逻辑
			//
			if(true){//支付成功
				if(serverMapper.getByOrderId(order.getId())!=null){
					order.setState(OrderState.WAIT_SERVER_RECEIVE);
				}
				else{
					order.setState(OrderState.WAIT_RECEIVE);
				}
				
				orderMapper.updateByPrimaryKeySelective(order);
				map.put("msg", "支付成功");
				map.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "支付失败");
			map.put("success", false);
		}
		return map;
	}
	@RequestMapping(params = "unpay")
	@ResponseBody
	public Map<Object, Object> unpay(Order order){//退款
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			//
			//退款逻辑
			//
			if(true){//退款成功
				orderMapper.deleteByPrimaryKey(order.getId());
				userOrderMapper.deleteByOrderId(order.getId());
				serverOrderMapper.deleteByOid(order.getId());
				map.put("msg", "退款成功");
				map.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "退款失败");
			map.put("success", false);
		}
		return map;
	}
	@RequestMapping(params = "evaluate")
	@ResponseBody
	public Map<Object, Object> evaluate(Order order){//评价
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			order.setState(OrderState.COMPLETE);
			orderMapper.updateByPrimaryKeySelective(order);
			map.put("msg", "评价成功");
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "评价失败");
			map.put("success", false);
			return map;
		}
		return map;
	}
	@RequestMapping(params = "confirm")
	@ResponseBody
	public Map<Object, Object> confirm(Order order,String sid){//选择商家，确认订单
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			ServerOrder serverOrder = new ServerOrder();
			serverOrder.setOid(order.getId());
			serverOrder.setSid(sid);
			serverOrderMapper.deleteByOid(order.getId());
			serverOrderMapper.insertSelective(serverOrder);
					
			order.setState(OrderState.ONGOING);
			orderMapper.updateByPrimaryKeySelective(order);
			
			map.put("msg", "确认成功");
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "确认失败");
			map.put("success", false);
		}
		return map;
	}
	@RequestMapping(params = "confirmFinish")
	@ResponseBody
	public Map<Object, Object> confirmFinish(Order order){//确认订单完成
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {			
			order.setState(OrderState.WAIT_EVALUATE);
			orderMapper.updateByPrimaryKeySelective(order);
			
			map.put("msg", "确认成功");
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "确认失败");
			map.put("success", false);
		}
		return map;
	}
	@RequestMapping(params = "delete")
	@ResponseBody
	public Map<Object, Object> delete(String id){//删除订单
		Map<Object, Object> map = new HashMap<Object, Object>();
        try {
        	Integer oid=Integer.parseInt(id);
            Order tempOrder =orderMapper.selectByPrimaryKey(oid);
            if(tempOrder.getState().equals(OrderState.WAIT_RECEIVE) || tempOrder.getState().equals(OrderState.WAIT_SERVER_RECEIVE)
    					||tempOrder.getState().equals(OrderState.REFUSED)){
            	orderMapper.deleteByPrimaryKey(oid);
            	userOrderMapper.deleteByOrderId(oid);
            	map.put("msg", "删除成功");
                map.put("success", true);
            }else{
            	 map.put("msg", "缺少删除条件");
                 map.put("success", false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "删除失败");
            map.put("success", false);
            
        }
        return map;
	}
}
