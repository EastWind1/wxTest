<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<html>
	<head>
	    <title>选择商家</title>
	    <%String orderid=request.getParameter("id"); %>
	    <script>
	    	$(function(){
	    		$.ajax({
					url:"demander.action?getOrderById",
			   	 	data:{"id":<%=orderid%>},
			   	 	type: "get",
			   	 	dataType: "JSON",
			   	 	success: function(data){
			   	 		var html='<div class="m-cell">'
	                        +'<div class="cell-item">'
	                            +'<a class="cell-left cell-arrow">'
	                               +'<p class="shop-name">订单编号：'+<%=orderid%>+'</p>'
	                            +'</a>'
	                            +'<div class="cell-right">'
	                            +'</div>'
	                        +'</div>'
	                    +'</div>'
						+'<div class="orl-cont clearfix">'
	                     	+'<div class="orl-cont-img fl">'
	                            +'<img src="'+returnimg(data.rows.kind)+'" alt="">'
	                        +'</div>'
	                        +'<div class="orl-cont-p fl">'
	                            +'<p>'+data.rows.name+'</p>'
	                            +'<div class="orl-cont-sx clearfix">'
	                                +'<em>'+data.rows.derscription+'</em>'
	                            +'</div>'
	                        +'</div>'
	                        +'<div class="orl-cont-price fr">'
	                            +'<span class="price">'+data.rows.price+'</span>'
	                        +'</div>'
	                    +'</div>';
			   	 		$("#order").html(html);
			   	 	}
				});
	    		$.ajax({
					url:"demander.action?getServerByOrder",
			   	 	data:{"id":<%=orderid%>},
			   	 	type: "get",
			   	 	dataType: "JSON",
			   	 	success: function(data){
			   	 			var html='<div class="m-cell">'
	                        +'<div class="cell-item">'
	                            +'<a class="cell-left cell-arrow">'
	                               +'<p class="shop-name">接单商家：</p>'
	                            +'</a>'
	                            +'<div class="cell-right">'
	                            +'</div>'
	                        +'</div>'
	                    +'</div>';
			   	 		$.each(data.rows, function(i, server) {
							html+='<div class="orl-cont clearfix">'
	                     	+'<div class="orl-cont-img fl">'
	                            +'<img src="" alt="">'
	                        +'</div>'
	                        +'<div class="orl-cont-p fl">'
	                            +'<p>'+server.name+'</p>'
	                            +'<div class="orl-cont-sx clearfix">'
	                                +'<em>'+server.description+'</em><p></p>'
	                                +'<div id="star" class="star star-1" data-num="'+server.credit+'"></div>'
                                	+'<div class="hinit">'+server.credit+'分</div>'
	                            +'</div>'
	                        +'</div>'
	                        +'<div class="orl-cont-price fr">'
	                            +'<span class="price"><input style="width:20px;height:20px;-webkit-appearance:radio" type="radio" name="serverlist" value="'+server.id+'"/></span>'
	                        +'</div>'
	                    +'</div>';
			   	 		$("#server").html(html);
			   	 		});
			   	 	}
				});
				$("#submit").on("click", function() {
					var serverid=$("input[name='serverlist']:checked").val(); 
					if(serverid!=null){
						if(confirm("确认选择商家:"+serverid+"?")){
							$.ajax({
								url:"demander.action?confirm",
						   	 	data:{"id":<%=orderid%>,"sid":serverid},
						   	 	type: "post",
						   	 	dataType: "JSON",
						   	 	success: function(data){
									alert(data.msg);
									window.history.go(-1);
						   	 	}
							});
						}
					}
					else{
						alert("未选中商家");
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
	                <span class="navbar-title">选择商家</span>
	            </div>
	        </header>
	        <!-- header -->
	        <!-- ori-main -->
	        <div class="cart-main g-scrollview">
	            <div class="cart-list clearfix">
	                <div id="order" class="orl-list clearfix">
	                </div>
	                <div id="server" class="orl-list clearfix">
	                </div>         
	            </div>
	        <footer  style="position: absolute;width:100%;bottom:0;" class="m-tabbar cart-footer clearfix">
	        	<h3 class="flex-1"></h3>
	            <a id="submit" class="btn btn-primary ">提交</a>
	        </footer>
	    </div>   
	</body>

</html>