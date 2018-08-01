<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="weixin.util.weixin.pojo.SNSUserInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
SNSUserInfo user = (SNSUserInfo)session.getAttribute("user"); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
   	<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport" />
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
    <meta content="telephone=no" name="format-detection" />
	
	<link href="wxpage/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- 引入YDUI样式 -->
    <link rel="stylesheet" href="wxpage/dist/YDUI/css/ydui.css">
    <!-- 引入YDUI样式 -->
    <link rel="stylesheet" href="wxpage/css/box-flex.css">
    <link rel="stylesheet" href="wxpage/css/reset.css">
    <link rel="stylesheet" href="wxpage/css/common.css">
    <link rel="stylesheet" href="wxpage/css/iconfont.css">
    <link rel="stylesheet" href="wxpage/css/style.css">
    
    <script src="wxpage/dist/jquery.min.js"></script>
	<script src="wxpage/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- 自适应解决方案类库 -->
    <script src="wxpage/js/adaptive.js"></script>
    <!-- 自适应解决方案类库 -->
    <script type="text/javascript">
    adaPtive(); //铺页面调用             
    //页面加载时调用
    $(function() { direction(); });
    //用户变化屏幕方向时调用
    $(window).on('orientationchange', function(e) { direction(); });
    //调用adaptive
    function adaPtive(max) {
        window['adaptive'].desinWidth = 640;
        window['adaptive'].baseFont = 24;
        window['adaptive'].scaleType = 1;
        window['adaptive'].maxWidth = 640;
        window['adaptive'].init();
    }
    //判断手机屏幕方向
    function direction() { if (window.orientation == 90 || window.orientation == -90) { adaPtive(320); return false; } else if (window.orientation == 0 || window.orientation == 180) { adaPtive(); return false; } }
    
    function returnimg(kind){
	    	var url="";
	    	switch(kind){
	    		case "网站建设":
	    			url="wxpage/images//wangzhan.png";
	    			break;
	    		case "APP开发":
	    			url="wxpage/images//APP.png";
	    			break;
	    		case "微信开发":
	    			url="wxpage/images//weixin.png";
	    			break;
	    		case "桌面软件开发":
	    			url="wxpage/images//desktop.png";
	    			break;
	    		case "UI设计":
	    			url="wxpage/images//UI.png";
	    			break;
	    		case "解决方案":
	    			url="wxpage/images//jiejue.png";
	    			break;
	    		case "数据服务":
	    			url="wxpage/images//shuju.png";
	    			break;
	    		case "安全服务":
	    			url="wxpage/images//safe.png";
	    			break;
	    		case "测试服务":
	    			url="wxpage/images//test.png";
	    			break;
	    		case "H5开发":
	    			url="wxpage/images//H5.png";
	    			break;
	    		case "域名服务":
	    			url="wxpage/images//yuming.png";
	    			break;
	    		case "云服务":
	    			url="wxpage/images//yun.png";
	    			break;
	    		case "人力外派":
	    			url="wxpage/images//people.png";
	    			break;
	    	}
	    return url;
	}
	function returnOrderState(state){
		switch(state){
			case "1":
				return "WAIT_RECEIVE";
				break;
			case "2":
				return "WAIT_CONFIME";
				break;
			case "3":
				return "ONGOING";
				break;
			case "4":
				return "WAIT_PAY";
				break;
			case "5":
				return "WAIT_EVALUATE";
				break;
			case "6":
				return "COMPLETE";
				break;
			case "7":
				return "WAIT_SERVER_RECEIVE";
				break;
			case "8":
				return "REFUSED";
				break;		
		}
	}
	function returnServerState(state){
		switch(state){
			case "0":
				return "CHECKING";
				break;
			case "1":
				return "PASS";
				break;
			case "2":
				return "REFUSED";
				break;
		}
	}
	function returnBaseUrl(){
		return "wxpagetest.action?";
	}
    </script>
	<script src="wxpage/dist/raty/jquery.raty.min.js"></script>
    <script type="text/javascript" src="wxpage/dist/YDUI/js/ydui.js"></script>
  </head>
  
  <body>
  </body>
</html>
