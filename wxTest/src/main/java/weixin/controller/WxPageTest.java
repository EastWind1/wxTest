package weixin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import weixin.util.weixin.pojo.SNSUserInfo;



@Controller("WxPageTest")
@Scope("prototype")
@RequestMapping("wxpagetest.action")
public class WxPageTest {
	@RequestMapping(params={"user","action"})
	@ResponseBody
	public void toCenter(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws ServletException, IOException {
		
		request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
		String user=request.getParameter("user");
		String action=request.getParameter("action");
		// 用户同意授权后，能获取到code
	
			// 获取用户信息
		SNSUserInfo snsUserInfo = new SNSUserInfo();
		snsUserInfo.setNickname("东风");
		snsUserInfo.setOpenId("test1");

			// 设置要传递的参数
		request.setAttribute("snsUserInfo", snsUserInfo);
		request.getSession().setAttribute("user", snsUserInfo);

		request.getRequestDispatcher("wxpage/"+user+"/"+action+".jsp").forward(request, response);
	}

}
