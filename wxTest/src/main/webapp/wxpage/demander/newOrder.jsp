<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<% 
	String serverId=request.getParameter("id");
	String kind=request.getParameter("kind");
%>
<html>
	<head>
	    <title>发表需求</title> 
	    <script>
		$(function(){
			var serverId="<%=serverId%>";
			var kind="<%=kind%>";
			if(serverId!="null"){
				$("title").html("发布定向订单");
				$("#classId").val(kind);
				$("#classId").attr("disabled","disabled");
				
				$("#submit").on("click",function(){
				console.log($("#date").val());
					var name=$('#name').val();
					var kind=$("#classId").val();
					var price=$("#price").val();
					if(name!="" &&kind!="0"&&price!=""){
						$.ajax({
							url:"demander.action?releaseOrderToServer",
			   	 			data:{"name":name,"description":$("#description").val(),"price":$("#price").val(),"kind":kind,"serverId":serverId,"finishdate":$("#date").val()},
			   	 			type: "post",
			   	 			dataType: "JSON",
			   	 			success: function(data){
			   	 				alert(data.msg);
			   	 			}
						});
					}
					else{
						alert("订单标题、报酬不能为空");
					}
				});
			}
			else{
				$("#submit").on("click",function(){
					var name=$('#name').val();
					var kind=$("#classId").val();
					var price=$("#price").val();
					if(name!="" &&kind!="请选择订单类型"&&price!=""){
						$.ajax({
							url:"demander.action?releaseOrder",
			   	 			data:{"name":name,"description":$("#description").val(),"price":$("#price").val(),"kind":kind,"finishdate":$("#date").val()},
			   	 			type: "post",
			   	 			dataType: "JSON",
			   	 			success: function(data){
			   	 				alert(data.msg);
			   	 			}
						});
					}
					else{
						alert("订单标题、种类、报酬不能为空");
					}
				});
			}
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
	                <span class="navbar-title">发布需求</span>
	            </div>
	        </header>
	        <div class="eva-main g-scrollview">
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">订单标题</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <input id="name" style="margin-left:20px;width:400px;height:40px" type="text" name="tital" class="tital" placeholder="输入你的订单标题" required="required">
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
                	<div class="m-celltitle">截止日期</div>
                	<div class="m-cell">
                    	<div class="cell-item">
							<input style="margin-left:20px;width:200px;height:40px" id="date" type="date" name="date" class="date">                        
                    	</div>
                	</div>
            	</div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">订单报酬</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                    	<font style="margin-left:20px" size="5" face="arial" color="red">￥</font>
	                        <input id="price" style="width:200px;height:40px" type="number" name="price" class="price" plplaceholder="输入你想要提供的报酬" required="required">
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