<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<% 
	String orderid=request.getParameter("id");
	String price=request.getParameter("price");
%>

<html>
<head>
<title>微信支付成功</title>
<link rel="stylesheet" type="text/css" href="wxpage/css/wxzf.css">
<script type="text/javascript">
function back(){
	window.location.href= returnBaseUrl()+"user=demander&action=searchService";
}
</script>
</head>
<body >
<div class="header">
  <div class="all_w" style="position:relative; z-index:1;">
    <div class="ttwenz" style=" text-align:center; width:100%;">
      <h4>交易详情</h4>
      <h5>微信安全支付</h5>
    </div>
    <a href="javascript:back()" class="fh_but">返回</a> </div>
</div>

<div class="zfcg_box ">
<div class="all_w">
<img src="wxpage/images/cg_03.jpg" > 支付成功 </div>

</div>
<div class="cgzf_info">
<div class="wenx_xx">
  <div class="mz">LGSSP平台</div>
  <div class="wxzf_price">￥<%=price %></div>
</div>

<div class="spxx_shop">
 <div class=" mlr_pm">
 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>商   品</td>
    <td align="right">平台服务费</td>
  </tr>

   <tr>
    <td>支付方式</td>
    <td align="right">招商银行</td>
  </tr>
   <tr>
    <td>交易单号</td>
    <td align="right"><%=orderid%></td>
  </tr>
</table>
 </div>

</div>
</div>


<div class="wzxfcgde_tb"><img src="wxpage/images/cg_07.jpg" ></div>
  
</body>
</html>