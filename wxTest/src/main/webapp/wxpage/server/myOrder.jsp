<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<%@page language="java" import="weixin.util.OrderState" %>
<html>
	<head>
		<title>订单列表</title>
		<script type="text/javascript">
			function returnHtml(order){
				var html="";
				if(order.evaluation==""){
					order.evaluation="未评价";
				}
				switch(returnOrderState(order.state)){
					case "WAIT_SERVER_RECEIVE":
						html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>待接单</h3></div>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-cont clearfix">'
	                            	+'<div class="orl-cont-img fl">'
	                                    +'<img src="'+returnimg(order.kind)+'" alt="">'
	                                +'</div>'
	                                +'<div class="orl-cont-p fl">'
	                                    +'<p>'+order.name+'</p>'
	                                +'</div>'
	                                +'<div class="orl-cont-price fr">'
	                                    +'<span class="price">￥'+order.price+'</span>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-post clearfix">'
	                                +'<div class="orl-post-num fl">订单编号：'+order.id+'</div>'
	                            +'</div>'
	                            +'<div class="orl-button clearfix">'
	                            	+'<a name="confirm_'+order.id+'" which="rc" class="btn btn-hollow default">接收</a>'
	                                +'<a name="confirm_'+order.id+'" which="rf" class="btn btn-hollow">拒绝</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitreceive").append(html);
	                    break;
	                case "WAIT_CONFIME":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>等待发布者确认</h3></div>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-cont clearfix">'
	                            	+'<div class="orl-cont-img fl">'
	                                    +'<img src="'+returnimg(order.kind)+'" alt="">'
	                                +'</div>'
	                                +'<div class="orl-cont-p fl">'
	                                    +'<p>'+order.name+'</p>'
	                                     +'<p>'+order.description+'</p>'
	                                +'</div>'
	                                +'<div class="orl-cont-price fr">'
	                                    +'<span class="price">￥'+order.price+'</span>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-post clearfix">'
	                                +'<div class="orl-post-num fl">订单编号：'+order.id+'</div>'
	                            +'</div>'
	                            +'<div class="orl-button clearfix">'
	                            	+'<a name="delete_'+order.id+'" class="btn btn-hollow default">删除</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitconfirm").append(html);
	                    break;
	                case "ONGOING":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>进行中</h3></div>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-cont clearfix">'
	                            	+'<div class="orl-cont-img fl">'
	                                    +'<img src="'+returnimg(order.kind)+'" alt="">'
	                                +'</div>'
	                                +'<div class="orl-cont-p fl">'
	                                    +'<p>'+order.name+'</p>'
	                                +'</div>'
	                                +'<div class="orl-cont-price fr">'
	                                    +'<span class="price">￥'+order.price+'</span>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-post clearfix">'
	                                +'<div class="orl-post-num fl">订单编号：'+order.id+'</div>'
	                            +'</div>'
	                        +'</div>';
	                    $("#ongoing").append(html);
	                    break;
	                case "WAIT_PAY":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>等待付款</h3></div>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-cont clearfix">'
	                            	+'<div class="orl-cont-img fl">'
	                                    +'<img src="'+returnimg(order.kind)+'" alt="">'
	                                +'</div>'
	                                +'<div class="orl-cont-p fl">'
	                                    +'<p>'+order.name+'</p>'
	                                +'</div>'
	                                +'<div class="orl-cont-price fr">'
	                                    +'<span class="price">￥'+order.price+'</span>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-post clearfix">'
	                                +'<div class="orl-post-num fl">订单编号：'+order.id+'</div>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitpay").append(html);
	                    break;
	                case "WAIT_EVALUATE":case "COMPLETE":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>已交付</h3></div>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-cont clearfix">'
	                            	+'<div class="orl-cont-img fl">'
	                                    +'<img src="'+returnimg(order.kind)+'" alt="">'
	                                +'</div>'
	                                +'<div class="orl-cont-p fl">'
	                                    +'<p>'+order.name+'</p>'
	                                +'</div>'
	                                +'<div class="orl-cont-p fl">'
	                                    +'<p>'+order.evaluation+'</p>'
	                                +'</div>'
	                                +'<div class="orl-cont-price fr">'
	                                    +'<span class="price">￥'+order.price+'</span>'
	                                +'</div>'
	                            +'</div>'
	                            +'<div class="orl-post clearfix">'
	                                +'<div class="orl-post-num fl">订单编号：'+order.id+'</div>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitevaluate").append(html);
	                    break;   	                    
				}
			}
			function get(){
				$.ajax({
					url:"server.action?getMyOrder",
   	 				type: "get",
   	 				dataType: "JSON",
   	 				success: function(data){
   	 					$.each(data.rows, function(i, order) {
							returnHtml(order);
   	 					});
   	 				}
				});
			}
			$(function(){
				$.ajax({
					url:"server.action?getMyServer",
		   	 		data:{},
		   	 		type: "get",
		   	 		dataType: "JSON",
		   	 		success: function(data){
		   	 			if(data.rows!=null){
		   	 				get();
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
				
				$(".tab-panel-item").on("click",".btn", function() {
					var	name=$(this).attr("name");
					var orderid=name.substring(name.indexOf('_')+1, name.length);
					var action=name.substring(0,name.indexOf('_'));
					switch(action){
						case "confirm":
							var caction=$(this).attr("which");
							if(caction=="rc"){
								if(confirm("确定接受订单："+orderid)){
									$.ajax({
										url:"server.action?confirm",
										data:{"id":orderid,"state":<%=OrderState.ONGOING%>},
					   	 				type: "post",
					   	 				dataType: "JSON",
					   	 				success: function(data){
											alert(data.msg);
											window.location.reload();
					   	 				}
									});
								}
							}
							if(caction=="rf"){
								if(confirm("确定拒绝订单："+orderid)){
									$.ajax({
										url:"server.action?confirm",
										data:{"id":orderid,"state":<%=OrderState.REFUSED%>},
					   	 				type: "post",
					   	 				dataType: "JSON",
					   	 				success: function(data){
					   	 					$.each(data.rows, function(i, order) {
												alert(data.msg);
												window.location.reload();
					   	 					});
					   	 				}
									});
								}
							}	
							if(caction=="f"){
								if(confirm("确定完成订单："+orderid)){
									$.ajax({
										url:"server.action?confirm",
										data:{"id":orderid,"state":<%=OrderState.WAIT_PAY%>},
					   	 				type: "post",
					   	 				dataType: "JSON",
					   	 				success: function(data){
					   	 					$.each(data.rows, function(i, order) {
												alert(data.msg);
												window.location.reload();
					   	 					});
					   	 				}
									});
								}
							}	
							break;
						case "delete":
							if(confirm("确认删除:"+orderid)){
								$.ajax({
									url:"server.action?deleteOrder",
				   	 				data:{"id":orderid},
				   	 				type: "post",
				   	 				dataType: "JSON",
				   	 				success: function(data){
				   	 					alert(data.msg);
				   	 					window.location.reload();
				   	 				}
								});
							}
							break;

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
	                <span class="navbar-title">我的订单</span>
	            </div>
	        </header>
	        <!-- header -->
	        <!-- pro-main -->
	        <div class="orl-main g-scrollview">
	            <div id="J_Tab" class="m-tab">
	                <ul class="tab-nav">
	                    <li class="tab-nav-item tab-active"><a href="javascript:;">进行中</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">待接收</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">待确认</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">待付款</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">已完成</a></li>
	                </ul>
	                
	                <div class="tab-panel">
	                    <div id="ongoing" class="tab-panel-item">
	                    </div>
						<div id="waitreceive" class="tab-panel-item">
	                    </div>
	                    <div id="waitconfirm" class="tab-panel-item">
	                    </div>
	                    <div id="waitpay" class="tab-panel-item">
	                    </div>
	                    <div id="complete" class="tab-panel-item tab-active">
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <script>
	    var $tab = $('#J_Tab');
	    $tab.tab({
	        nav: '.tab-nav-item',
	        panel: '.tab-panel-item',
	        activeClass: 'tab-active'
	    });
	    </script>
	</body>

</html>