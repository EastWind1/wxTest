<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<% 
	String orderid=request.getParameter("id");
	String price=request.getParameter("price");
%>
<html>
<head>
<title>微信支付</title>
<link rel="stylesheet" type="text/css" href="wxpage/css/wxzf.css">
<script type="text/javascript">
$(function(){
	//出现浮动层
	$(".ljzf_but").click(function(){
		$(".ftc_wzsf").show();
		});
	//关闭浮动
	$(".close").click(function(){
		$(".ftc_wzsf").hide();
		});
		//数字显示隐藏
		$(".xiaq_tb").click(function(){
		$(".numb_box").slideUp(500);
		});
		$(".mm_box").click(function(){
		$(".numb_box").slideDown(500);
		});
		//----
		var i = 0;
		$(".nub_ggg li a").click(function(){
			i++
			if(i<6){
				$(".mm_box li").eq(i-1).addClass("mmdd");
				}else{
					$(".mm_box li").eq(i-1).addClass("mmdd"); 
					setTimeout(function(){
						$.ajax({
							url:"demander.action?pay",
							data:{"id":<%=orderid%>},
					   	 	type: "post",
					   	 	dataType: "JSON",
					   	 	success: function(data){
								alert(data.msg);
				   	 			window.location.reload();
				   	 			}
						});
					location.href=returnBaseUrl()+"user=pay&action=success&id=<%=orderid%>&price=<%=price%>"; 
					},500);
					//window.document.location="cg.html"
			 } 
		});
		$(".nub_ggg li .del").click(function(){
			if(i>0){
				i--
				$(".mm_box li").eq(i).removeClass("mmdd");
				i==0;
				}
			//alert(i);
		});
});
</script>
</head>
<body>
<div class="header">
  <div class="all_w ">
    <div class="gofh"> <a><img src="wxpage/images/jt_03.jpg" ></a> </div>
    <div class="ttwenz">
      <h4>确认交易</h4>
      <h5>微信安全支付</h5>
    </div>
  </div>
</div>
<div class="wenx_xx">
  <div class="mz">LGSSP平台服务费</div>
  <div class="wxzf_price">￥<%=price %></div>
</div>
<div class="skf_xinf">
  <div class="all_w"> <span class="bt">收款方</span> <span class="fr">LGSSP平台</span> </div>
</div>
<a href="javascript:void(0);" class="ljzf_but all_w">立即支付</a> 
<!--浮动层-->
<div class="ftc_wzsf">
  <div class="srzfmm_box">
    <div class="qsrzfmm_bt clear_wl"> <img src="wxpage/images/xx_03.jpg" class="tx close fl" > <img src="wxpage/images/jftc_03.jpg" class="tx fl" ><span class="fl">请输入支付密码</span> </div>
    <div class="zfmmxx_shop">
      <div class="mz">LGSSP平台</div>
      <div class="wxzf_price"><%=price %></div>
    </div>
    <a class="blank_yh"> <img src="wxpage/images/jftc_07.jpg" class="fl"  ><span class="fl ml5">招商银行信用卡</span> </a>
    <ul class="mm_box">
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
    </ul>
  </div>
  <div class="numb_box">
    <div class="xiaq_tb"> <img src="wxpage/images/jftc_14.jpg" style="height:10px"> </div>
    <ul class="nub_ggg">
      <li><a href="javascript:void(0);">1</a></li>
      <li><a href="javascript:void(0);" class="zj_x">2</a></li>
      <li><a href="javascript:void(0);">3</a></li>
      <li><a href="javascript:void(0);">4</a></li>
      <li><a href="javascript:void(0);" class="zj_x">5</a></li>
      <li><a href="javascript:void(0);">6</a></li>
      <li><a href="javascript:void(0);">7</a></li>
      <li><a href="javascript:void(0);" class="zj_x">8</a></li>
      <li><a href="javascript:void(0);">9</a></li>
      <li><span></span></li>
      <li><a href="javascript:void(0);" class="zj_x">0</a></li>
      <li><span  class="del" > <img src="wxpage/images/jftc_18.jpg"   ></span></li>
    </ul>
  </div>
  <div class="hbbj"></div>
</div>
</body>
</html>
