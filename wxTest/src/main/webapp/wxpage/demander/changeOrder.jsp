<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<%String orderid=request.getParameter("id"); %>
<html>
	<head>
 		<title>修改订单</title>
 		<script>
 			$(function(){
 				$.ajax({
					url:"demander.action?getOrderById",
		   	 		data:{"id":<%=orderid%>},
		   	 		type: "get",
		   	 		dataType: "JSON",
		   	 		success: function(data){
		   	 			$("#name").val(data.rows.name);
		   	 			$("#classId").val(data.rows.kind);
		   	 			$("#description").val(data.rows.description);
		   	 			$("#price").val(data.rows.price);
		   	 		}
				});
				$("#submit").on("click", function() {
					$.ajax({
						url:"demander.action?updMoreByPkId",
			   	 		data:{"id":<%=orderid%>,"name":$('#name').val(),"description":$("#description").val(),"price":$("#price").val(),"kind":$("#classId").val()},
			   	 		type: "get",
			   	 		dataType: "JSON",
			   	 		success: function(data){
			   	 			$("#name").val(data.rows.name);
			   	 			$("#classId").val(data.rows.kind);
			   	 			$("#description").val(data.rows.description);
			   	 			$("#price").val(data.rows.price);
			   	 		}
					});
				});
 			});
 		</script>
  	</head>
  
	<body>
	    <div class="g-flexview">
	        <header class="m-navbar my-header">
	            <a href="javascript:history.go(-1);" class="navbar-item">
	                <i class="back-ico"></i>
	            </a>
	            <div class="navbar-center">
	                <span class="navbar-title">修改订单</span>
	            </div>
	        </header>
	        <div class="eva-main g-scrollview">
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">订单标题</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <input id="name" style="margin-left:20px;width:400px;height:40px" type="text" name="tital" class="tital" placeholder="输入你的订单标题" >
	                    </div>
	                </div>
	            </div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">订单类型</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <select style="margin-left:20px" class="btn btn-default" name="classId" id="classId">
	                        	<option value="请选择订单类型">请选择订单类型</option>
				                <option value="网站建设">网站建设</option>
				                <option value="APP开发">APP开发</option>
				                <option value="微信开发">微信开发</option>
				                <option value="桌面软件开发">桌面软件开发</option>
				                <option value="UI设计">UI设计</option>
				                <option value="解决方案">解决方案</option>
				                <option value="数据服务">数据服务</option>
				                <option value="安全服务">安全服务</option>
				                <option value="测试服务">测试服务</option>
				                <option value="HTML5开发">HTML5开发</option>
				                <option value="域名服务">域名服务</option>
				                <option value="云服务">云服务</option>
				                <option value="人力外派">人力外派</option>
							</select> 
	                    </div>
	                </div>
	            </div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">需求订单简介</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <div class="cell-right">
	                            <textarea id="description" class="cell-textarea" placeholder="输入你所需要的要求" maxlength="500"></textarea>
	                        </div>
	                    </div>
	                </div>
	            </div>
           
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">订单报酬</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                    	<font style="margin-left:20px" size="5" face="arial" color="red">￥</font>
	                        <input id="price" style="width:200px;height:40px" type="number" name="price" class="price" plplaceholder="输入你想要提供的报酬">
	                    </div>
	                </div>
	            </div>

	            <div class="eva-list">
	                <div class="orl-list clearfix">
	                    <a id="submit" class="btn-block btn-primary">提交需求</a>
	                </div>
	            </div>
	        </div>      
	    </div>
	</body>
	
</html>