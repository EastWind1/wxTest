package weixin.util.weixin.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import weixin.util.weixin.menu.Button;
import weixin.util.weixin.menu.ClickButton;
import weixin.util.weixin.menu.ComplexButton;
import weixin.util.weixin.menu.Menu;
import weixin.util.weixin.menu.ViewButton;
import weixin.util.weixin.message.resp.Article;
import weixin.util.weixin.message.resp.MessArticle;
import weixin.util.weixin.pojo.Token;
import weixin.util.weixin.pojo.WeixinCustom;
import weixin.util.weixin.pojo.WeixinGroup;
import weixin.util.weixin.pojo.WeixinMedia;
import weixin.util.weixin.pojo.WeixinQRCode;
import weixin.util.weixin.pojo.WeixinUserInfo;
import weixin.util.weixin.pojo.WeixinUserList;
import weixin.util.weixin.util.AdvancedUtil;
import weixin.util.weixin.util.CommonUtil;
import weixin.util.weixin.util.MenuUtil;

public class AdvancedService {
	private static Logger log = LoggerFactory.getLogger(AdvancedService.class);
	// 第三方用户唯一凭证
	private static 	String appId = "wx0a4b15a83262f0b1";
	// 第三方用户唯一凭证密钥
	private static String appSecret = "25aed54445558c1e9ce6389b8a57ef21";
	private static String wxAcount="gh_0a8baa819de0";
	private static Token token;
	private static String accessToken;
	
	public AdvancedService(){
		// 调用接口获取凭证
		token = CommonUtil.getToken(appId, appSecret);
		// 获取接口访问凭证
		accessToken = CommonUtil.getToken(appId, appSecret).getAccessToken();
	}
	public void createMenu() {//创建菜单
		
		String serverUrl=null;
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream("resource/config.properties"));
			serverUrl=properties.getProperty("server_url");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ViewButton btn11 = new ViewButton();
		btn11.setName("发布订单");
		btn11.setType("view");
		btn11.setUrl(replace(serverUrl+"wxpage.action?user=demander&action=newOrder"));

		ViewButton btn12 = new ViewButton();
		btn12.setName("查询服务");
		btn12.setType("view");
		btn12.setUrl(replace(serverUrl+"wxpage.action?user=demander&action=searchService"));

		ViewButton btn13 = new ViewButton();
		btn13.setName("管理订单");
		btn13.setType("view");
		btn13.setUrl(replace(serverUrl+"wxpage.action?user=demander&action=myOrder"));

		ViewButton btn21 = new ViewButton();
		btn21.setName("查找订单");
		btn21.setType("view");
		btn21.setUrl(replace(serverUrl+"wxpage.action?user=server&action=searchOrder"));

		ViewButton btn22 = new ViewButton();
		btn22.setName("管理订单");
		btn22.setType("view");
		btn22.setUrl(replace(serverUrl+"wxpage.action?user=server&action=myOrder"));
		
		ViewButton btn23 = new ViewButton();
		btn23.setName("发布服务");
		btn23.setType("view");
		btn23.setUrl(replace(serverUrl+"wxpage.action?user=server&action=newService"));

		ViewButton btn24 = new ViewButton();
		btn24.setName("服务管理");
		btn24.setType("view");
		btn24.setUrl(replace(serverUrl+"wxpage.action?user=server&action=myService"));

		ViewButton btn25 = new ViewButton();
		btn25.setName("商户管理");
		btn25.setType("view");
		btn25.setUrl(replace(serverUrl+"wxpage.action?user=server&action=changeServer"));
		
		ViewButton btn31 = new ViewButton();
		btn31.setName("个人信息");
		btn31.setType("view");
		btn31.setUrl(replace(serverUrl+"wxpage.action?user=personal&action=modifyMe"));

		ClickButton btn32 = new ClickButton();
		btn32.setName("客户服务");
		btn32.setType("click");
		btn32.setKey("service");

		ComplexButton mainBtn1 = new ComplexButton();
		mainBtn1.setName("我是客户");
		mainBtn1.setSub_button(new Button[] { btn11, btn12, btn13 });

		ComplexButton mainBtn2 = new ComplexButton();
		mainBtn2.setName("我是服务方");
		mainBtn2.setSub_button(new Button[] { btn21, btn22, btn23,btn24,btn25});

		ComplexButton mainBtn3 = new ComplexButton();
		mainBtn3.setName("个人中心");
		mainBtn3.setSub_button(new Button[] { btn31, btn32 });

		Menu menu = new Menu();
		menu.setButton(new Button[] { mainBtn1, mainBtn2, mainBtn3 });
		
		if (null != token) {
			// 创建菜单
			boolean result = MenuUtil.createMenu(menu, token.getAccessToken());

			// 判断菜单创建结果
			if (result)
				log.info("菜单创建成功！");
			else
				log.info("菜单创建失败！");
		}
	}
	private static String replace(String url){//将网址进行utf-8编码
		String utfurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx0a4b15a83262f0b1&redirect_uri=REDIRECT_URL&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
		String newurl=utfurl.replace("REDIRECT_URL", CommonUtil.urlEncodeUTF8(url));
		return newurl;
	}
	private void sendtextcustommessage(String openid,String text){// 发送客服消息
		String jsonTextMsg = AdvancedUtil.makeTextCustomMessage(openid, text);

		AdvancedUtil.sendCustomMessage(accessToken, jsonTextMsg);

	}
	private void sendmediacustommessage(){//发送客服消息（图文消息）
		Article article1 = new Article();
		article1.setTitle("微信上也能斗地主");
		article1.setDescription("");
		article1.setPicUrl("http://www.egouji.com/xiaoq/game/doudizhu_big.png");
		article1.setUrl("http://resource.duopao.com/duopao/games/small_games/weixingame/Doudizhu/doudizhu.htm");
		Article article2 = new Article();
		article2.setTitle("傲气雄鹰\n80后不得不玩的经典游戏");
		article2.setDescription("");
		article2.setPicUrl("http://www.egouji.com/xiaoq/game/aoqixiongying.png");
		article2.setUrl("http://resource.duopao.com/duopao/games/small_games/weixingame/Plane/aoqixiongying.html");
		List<Article> list = new ArrayList<Article>();
		list.add(article1);
		list.add(article2);
		// 组装图文客服消息
		String jsonNewsMsg = AdvancedUtil.makeNewsCustomMessage("oEdzejiHCDqafJbz4WNJtWTMbDcE", list);
		// 发送客服消息
		AdvancedUtil.sendCustomMessage(accessToken, jsonNewsMsg);
	}
	private void sendmessmessage(){//群发消息（图文消息）
		MessArticle article1 = new MessArticle();
		article1.setTitle("微信上也能斗地主");
		article1.setDigest("");
		article1.setShow_cover_pic("1");
		article1.setThumb_media_id(AdvancedUtil.uploadMedia(accessToken, "image", "http://localhost/wxpage/images/index_ad.jpg").getMediaId());
		article1.setContent_source_url("http://resource.duopao.com/duopao/games/small_games/weixingame/Doudizhu/doudizhu.htm");
		MessArticle article2 = new MessArticle();
		article2.setTitle("傲气雄鹰\n80后不得不玩的经典游戏");
		article2.setDigest("");
		article2.setShow_cover_pic("0");
		article2.setThumb_media_id(AdvancedUtil.uploadMedia(accessToken, "image", "http://localhost/wxpage/images/index_ad.jpg").getMediaId());
		article2.setContent_source_url("http://resource.duopao.com/duopao/games/small_games/weixingame/Plane/aoqixiongying.html");
		List<MessArticle> list = new ArrayList<MessArticle>();
		list.add(article1);
		list.add(article2);
		// 组装图文客服消息
		String jsonNewsMsg = AdvancedUtil.makeNewsMassMessage(0,AdvancedUtil.uploadMessMessage(accessToken, list).getMediaId());
		// 发送客服消息
		AdvancedUtil.sendAllMessage(accessToken, jsonNewsMsg);
	}
	private void createtemporaryQRCode(){//创建临时二维码
		WeixinQRCode weixinQRCode = AdvancedUtil.createTemporaryQRCode(accessToken, 900, 111111);
		// 临时二维码的ticket
		System.out.println(weixinQRCode.getTicket());
		// 临时二维码的有效时间
		System.out.println(weixinQRCode.getExpireSeconds());
	}
	private void getuserinfo(String OpenId){//获取用户信息
		WeixinUserInfo user =AdvancedUtil.getUserInfo(accessToken, OpenId);
		System.out.println("OpenID：" + user.getOpenId());
		System.out.println("关注状态：" + user.getSubscribe());
		System.out.println("关注时间：" + user.getSubscribeTime());
		System.out.println("昵称：" + user.getNickname());
		System.out.println("性别：" + user.getSex());
		System.out.println("国家：" + user.getCountry());
		System.out.println("省份：" + user.getProvince());
		System.out.println("城市：" + user.getCity());
		System.out.println("语言：" + user.getLanguage());
		System.out.println("头像：" + user.getHeadImgUrl());
	}
	private void getuserlist(){// 获取关注者列表
		WeixinUserList weixinUserList = AdvancedUtil.getUserList(accessToken, "");
		System.out.println("总关注用户数：" + weixinUserList.getTotal());
		System.out.println("本次获取用户数：" + weixinUserList.getCount());
		System.out.println("OpenID列表：" + weixinUserList.getOpenIdList().toString());
		System.out.println("next_openid：" + weixinUserList.getNextOpenId());
	}
	private void getgroups(){//查询分组
		List<WeixinGroup> groupList = AdvancedUtil.getGroups(accessToken);
		// 循环输出各分组信息
		for (WeixinGroup group : groupList) {
			System.out.println(String.format("ID：%d 名称：%s 用户数：%d", group.getId(), group.getName(), group.getCount()));
		}
	}
	private void creategroup(){//创建分组
		WeixinGroup group = AdvancedUtil.createGroup(accessToken, "用户");
		System.out.println(String.format("成功创建分组：%s id：%d", group.getName(), group.getId()));
	}

	private void updategroup(){//修改分组名
		AdvancedUtil.updateGroup(accessToken, 100, "需求方");
	}
	private void updateMemberGroup(){//移动用户分组
		AdvancedUtil.updateMemberGroup(accessToken, "owTDF1Zla6fxNO_KKjQocBmvK0WA", 101);
	}
	private void uploadmedia(){//上传多媒体文件
		WeixinMedia weixinMedia = AdvancedUtil.uploadMedia(accessToken, "image", "http://localhost/wxpage/images/index_ad.jpg");
		System.out.println(weixinMedia.getMediaId());
		System.out.println(weixinMedia.getType());
		System.out.println(weixinMedia.getCreatedAt());
		
	}
	private void getmedia(){//下载多媒体文件
		AdvancedUtil.getMedia(accessToken, "N7xWhOGYSLWUMPzVcGnxKFbhXeD_lLT5sXxyxDGEsCzWIB2CcUijSeQOYjWLMpcn", "G:/download");
	}
	private void createCustom(String account,String nickname,String wx){
		WeixinCustom weixinCustom = new WeixinCustom();
		weixinCustom.setNickname(nickname);
		weixinCustom.setInvite_wx(wx);
		weixinCustom.setKf_account(account+"@"+wxAcount);
		AdvancedUtil.createCustom(accessToken, weixinCustom);
	}
	public static void main(String args[]) {
		AdvancedService advancedService = new AdvancedService();
		
		String serverUrl=null;
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream("resource/config.properties"));
			serverUrl=properties.getProperty("server_url");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		advancedService.sendtextcustommessage("owTDF1Zla6fxNO_KKjQocBmvK0WA", "点击查看<a href=\"http://www.baidu.com\">百度首页</a>");
		//advancedService.createMenu();
		//advancedService.getgroups();
		//advancedService.updategroup();
		//advancedService.getuserinfo("owTDF1Zla6fxNO_KKjQocBmvK0WA");
		//advancedService.sendtextcustommessage();
		//advancedService.sendmessmessage();
		//advancedService.uploadmedia();
		//advancedService.updateMemberGroup();
		//AdvancedUtil.deleteGroup(accessToken, 104);
		//AdvancedUtil.getAllMedia(accessToken);
		//advancedService.createCustom("custom1", "stone", "chenshipu1996");
	}
	
}
