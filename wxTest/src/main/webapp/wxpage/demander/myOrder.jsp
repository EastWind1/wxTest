<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page language="java" import="weixin.util.OrderState"%>
<%@include file="../common/head.jsp" %>

<html>
	<head>
		<title>订单列表</title>
		<script type="text/javascript">
			function returnHtml(order){
				var fd = new Date(order.finishdate);
				var nd = new Date();
				var html;
				if(fd<nd){
					html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>已超时</h3></div>'
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
	                            	+'<a name="change_'+order.id+'" class="btn btn-hollow default">修改订单</a>'
	                                +'<a name="unpay_'+order.id+'" class="btn btn-hollow">退款</a>'
	                            +'</div>'
	                        +'</div>';
	                  $("#timeout").append(html);
				}
			else{
				switch(returnOrderState(order.state)){
					case "WAIT_RECEIVE":case "WAIT_SERVER_RECEIVE":
						html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>已发布，待接收</h3></div>'
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
	                            	+'<a name="change_'+order.id+'" class="btn btn-hollow default">修改订单</a>'
	                                +'<a name="delete_'+order.id+'" class="btn btn-hollow">取消订单</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitreceive").append(html);
	                    break;
	                case "WAIT_CONFIME":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>已被一或多方接单</h3></div>'
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
	                            	+'<a name="confirm_'+order.id+'" class="btn btn-hollow default">去确认</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitconfirm").append(html);
	                    break;
	                case "ONGOING":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>已接单，商家正在服务</h3></div>'
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
	                            	+'<a name="confirmf_'+order.id+'"  class="btn btn-hollow default">确认完成</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#ongoing").append(html);
	                    break;
	                case "WAIT_PAY":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>待付款</h3></div>'
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
	                            	+'<a name="pay_'+order.id+'" price="'+order.price+'" class="btn btn-hollow default">去付款</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitpay").append(html);
	                    break;
	                case "WAIT_EVALUATE":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>待评价</h3></div>'
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
	                            	+'<a name="evaluate_'+order.id+'" class="btn btn-hollow default">去评价</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#waitevaluate").append(html);
	                    break;
	                case "COMPLETE":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>已完成</h3></div>'
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
	                            	+'<a name="delete_'+order.id+'" class="btn btn-hollow default">删除记录</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#complete").append(html);
	                    break;
	                case "REFUSED":
	                	html='<div class="orl-list clearfix">'
	                          +'<div class="m-cell">'
	                                +'<div class="cell-item">'
	                                 	+'<a class="cell-left cell-arrow"><p class="shop-name">'+order.kind+'</p></a>'
	                                    +'<div class="cell-right"><h3>商家拒绝</h3></div>'
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
	                            	+'<a name="change_'+order.id+'" class="btn btn-hollow default">去修改</a>'
	                            	+'<a name="delete_'+order.id+'" class="btn btn-hollow">删除</a>'
	                            +'</div>'
	                        +'</div>';
	                    $("#refused").append(html);
	                    break;	                    	                    	                    
				}
				}
			}
			function get(){
				$.ajax({
					url:"demander.action?getMyOrder",
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
				get();
				$(".tab-panel-item").on("click",".btn", function() {
					var	name=$(this).attr("name");
					var orderid=name.substring(name.indexOf('_')+1, name.length);
					var action=name.substring(0,name.indexOf('_'));
					switch(action){
						case "pay":
							window.location.href=returnBaseUrl()+"user=pay&action=pay&id="+orderid+"&price="+$(this).attr("price");
							break;
						case "change":
							window.location.href=returnBaseUrl()+"user=demander&action=changeOrder&id="+orderid;
							break;
						case "confirm":
							window.location.href=returnBaseUrl()+"user=demander&action=confirm&id="+orderid;
							break;
						case "delete":
							if(confirm("确认删除吗？")){
								$.ajax({
									url:"demander.action?delete",
				   	 				data:{"id":orderid},
				   	 				type: "get",
				   	 				dataType: "JSON",
				   	 				success: function(data){
				   	 					alert(data.msg);
				   	 					window.location.reload();
				   	 				}
								});
							}
							break;
						case "evaluate":
							window.location.href=returnBaseUrl()+"user=demander&action=evaluate&id="+orderid;
							break;
						case "unpay":
							if(confirm("确认退款吗？")){
								$.ajax({
									url:"demander.action?delete",
				   	 				data:{"id":orderid},
				   	 				type: "get",
				   	 				dataType: "JSON",
				   	 				success: function(data){
				   	 					alert(data.msg);
				   	 					window.location.reload();
				   	 				}
								});
							}
							break;
						case "confirmf":
							if(confirm("确认完成吗？")){
								$.ajax({
									url:"server.action?confirm",
									data:{"id":orderid,"state":<%=OrderState.WAIT_EVALUATE%>},
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
	                    <li class="tab-nav-item"><a href="javascript:;">待评价</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">被拒</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">已完成</a></li>
	                    <li class="tab-nav-item"><a href="javascript:;">超时</a></li>
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
	                    <div id="waitevaluate" class="tab-panel-item">
	                    </div>
	                    <div id="refused" class="tab-panel-item">
	                    </div>
	                    <div id="complete" class="tab-panel-item tab-active">
	                    </div>
	                    <div id="timeout" class="tab-panel-item ">
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