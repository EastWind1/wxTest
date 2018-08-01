package weixin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import weixin.dao.UserMapper;
import weixin.model.User;
import weixin.util.MD5;
import weixin.util.weixin.pojo.SNSUserInfo;

@Controller("WxUser")
@Scope("prototype")
@RequestMapping("wxuser.action")
public class WxUserController {
	public static UserMapper userMapper2;
	@Autowired
	public UserMapper userMapper;
	@PostConstruct
	public void setBaseDao(){
		userMapper2=userMapper;
	}
	@RequestMapping(params="get")
	@ResponseBody
	public Map<Object, Object> get(HttpServletRequest request,HttpSession session){//获取用户信息
		SNSUserInfo snsUserInfo=(SNSUserInfo) session.getAttribute("user");
		String userid = snsUserInfo.getOpenId();
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		User user =new User();
		if(userMapper.selectByPrimaryKey(userid)!=null){
			try{
				user=userMapper.selectByPrimaryKey(userid);
				map.put("userinfo", user);
				map.put("msg", "查询成功");
				map.put("success", true);
				}
			catch (Exception e) {
				e.printStackTrace();
				map.put("msg", "查询失败");
				map.put("success", false);
			}
		}
		else {
			//   自动注册逻辑
			user.setId(userid);
			user.setPhoto_url(snsUserInfo.getHeadImgUrl());
			user.setName(snsUserInfo.getNickname());
			autoRegister(user);
			map.put("msg", "已帮您自动注册");
			map.put("success", true);
		}
		return map;
	}
	@RequestMapping(params="update")
	@ResponseBody
	public Map<Object, Object> updMoreByPkId(HttpSession session,User user){//修改信息
		SNSUserInfo sessuser=(SNSUserInfo)session.getAttribute("user");
		String userId = sessuser.getOpenId();//获取用户id
		user.setId(userId);
		user.setPassword(MD5.pass(user.getPassword()));
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			userMapper.updateByPrimaryKeySelective(user);
			map.put("msg", "修改成功");
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "修改失败");
			map.put("success", false);
		}
		return map;
	}
	public static int autoRegister(User user){
		int result=0;
		try{
			userMapper2.insertSelective(user);
			result=1;
		}
		catch (Exception e) {
			result=0;
		}
		return result;
	}
}
