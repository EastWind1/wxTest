package weixin.controller;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import weixin.dao.UserMapper;
import weixin.model.User;
import weixin.util.weixin.pojo.SNSUserInfo;
import weixin.util.weixin.pojo.WeixinOauth2Token;
import weixin.util.weixin.util.AdvancedUtil;


@Controller("WxPage")
@Scope("prototype")
@RequestMapping("wxpage.action")
public class WxPageController {
	public static UserMapper userMapper2;
	@Autowired
	public UserMapper userMapper;
	@PostConstruct
	public void setBaseDao(){
		userMapper2=userMapper;
	}
	
	@RequestMapping(params={"user","action"})
	@ResponseBody
	public void toCenter(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws ServletException, IOException {
		
		request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
		String user=request.getParameter("user");
		String action=request.getParameter("action");
		// 用户同意授权后，能获取到code
		String code = request.getParameter("code");

		// 用户同意授权
		if (!"authdeny".equals(code)) {
			// 获取网页授权access_token
			WeixinOauth2Token weixinOauth2Token = AdvancedUtil.getOauth2AccessToken("wx0a4b15a83262f0b1", "25aed54445558c1e9ce6389b8a57ef21", code);
			// 网页授权接口访问凭证
			String accessToken = weixinOauth2Token.getAccessToken();
			// 用户标识
			String openId = weixinOauth2Token.getOpenId();
			// 获取用户信息
			SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);

			String userid = snsUserInfo.getOpenId();
			
			User user1 =new User();
			if(userMapper.selectByPrimaryKey(userid)==null){
				//   自动注册逻辑
				user1.setId(userid);
				user1.setName(snsUserInfo.getNickname());
				user1.setPhoto_url(snsUserInfo.getHeadImgUrl());
				autoRegister(user1);
			}
			
			// 设置要传递的参数
			request.getSession().setAttribute("user", snsUserInfo);
			
			
		}
		request.getRequestDispatcher("wxpage/"+user+"/"+action+".jsp").forward(request, response);
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
