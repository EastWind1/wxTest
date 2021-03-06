<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<html>
	<head>
    	<title>商户修改</title>
    	<script type="text/javascript">
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
    			$.ajax({
					url:"server.action?getMyServer",
		   	 		data:{},
		   	 		type: "get",
		   	 		dataType: "JSON",
		   	 		success: function(data){
		   	 			$("#name").val(data.rows.name);
		   	 			$("#dec").val(data.rows.description);
		   	 		}
				});
    			$("#submit").on('click',function(){
					var name=$('#name').val();
					if(name!=""){
						$.ajax({
							url:"server.action?changeServer",
				   	 		data:{"name":name,"description":$("#dec").val()},
				   	 		type: "post",
				   	 		dataType: "JSON",
				   	 		success: function(data){
				   	 			alert(data.msg);
								window.history.go(-1);
				   	 		}
						});
					}
					else{
						alert("店名不能为空");
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
	                <span class="navbar-title">商户修改</span>
	            </div>
	        </header>
	        <!-- header -->
	        <!-- ori-main -->
	        <div class="eva-main g-scrollview">
	        	<div class="eva-text clearfix">
		            <div class="m-celltitle">商户名称</div>
		            <div class="m-cell">
		                <div class="cell-item">
		                     <input id="name" style="margin-left:20px;width:400px;height:40px" type="text" name="tital" class="tital" placeholder="输入店铺名称" >
		                </div>
		            </div>
	        	</div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">商户描述</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <div class="cell-right">
	                            <textarea id="dec" class="cell-textarea" placeholder="店铺简介"></textarea>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="eva-list">
	                <div class="orl-list clearfix">
	                    <a id="submit" class="btn-block btn-primary">提交修改</a>
	                </div>
	            </div>
	        </div>
	    </div>   
	</body>
</html>
