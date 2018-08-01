<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<html>
	<head>
	    <title>发布服务</title>
	    <script>
	    	$(function(){
	    		$.ajax({
					url:"server.action?getMyServer",
		   	 		data:{},
		   	 		type: "get",
		   	 		dataType: "JSON",
		   	 		success: function(data){
		   	 			if(data.rows!=null){
		   	 			}
		   	 			else{
		   	 				if(confirm("您没有店铺，是否前去开店")){
		   	 					window.location.href=returnBaseUrl()+"user=server&action=openShop";
		   	 				}
		   	 				else{
		   	 					window.open('', '_self', '');window.close();
		   	 				}
		   	 			}
		   	 		}
				});
	    		$('#submit').bind('click',function(){
					var name=$('#name').val();
					var kind=$("#classId").val();
					if(name!=""&&kind!="请选择类型"){
						$.ajax({
							url:"server.action?addService",
			   	 			data:{"name":name,"description":$("#dec").val(),"price":$("#price").val(),"kind":kind},
			   	 			type: "post",
			   	 			dataType: "JSON",
			   	 			success: function(data){
			   	 				alert(data.msg);
			   	 			}
						});
					}
					else{
						alert("名称或类型为空");
					}
				});
	    	});
	    </script>
	</head>
	<body>
	    <div class="g-flexview">
	        <!-- header -->
	        <header class="m-navbar my-header">
	            <a href="javascript:history.go(-1);" class="navbar-item">
	                <i class="back-ico"></i>
	            </a>
	            <div class="navbar-center">
	                <span class="navbar-title">发布服务</span>
	            </div>
	        </header>
	        <!-- header -->
	        <!-- ori-main -->
	        <div class="eva-main g-scrollview">
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">服务标题</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <input style="margin-left:20px;width:400px;height:40px" id="name" type="text" name="tital" class="tital" placeholder="输入你的服务标题">
	                    </div>
	                </div>
	            </div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">服务类型</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <select style="margin-left:20px" class="btn btn-default" name="classId" id="classId">
	                        	<option value="请选择订单类型">请选择类型</option>
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
	                <div class="m-celltitle">提供服务简介</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <div class="cell-right">
	                            <textarea id="dec" class="cell-textarea" placeholder="输入你所能提供的服务内容"></textarea>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">平均费用</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <font style="margin-left:20px" size="5" face="arial" color="red">￥</font>
	                        <input  style="width:400px;height:40px" id="price" type="number" name="price" class="price" plplaceholder="输入平均费用">
	                    </div>
	                </div>
	            </div>
	            <div class="eva-list">
	                <div class="orl-list clearfix">  
	                    <a id="submit" class="btn-block btn-primary">发布服务</a>
	                </div>
	            </div>
	        </div>  
	    </div>
	</body>
</html>
