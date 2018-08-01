<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<html>
	<head>
   	 	<title>我的服务</title>		 	
   	 	<script type="text/javascript">
   	 	function initlist(name,kind){
   	 		var ajaxurl="server.action?getMyService";
   	 		if(name!=null && name!="")
   	 			ajaxurl+=("&name="+name);
   	 		if(kind!=null && kind!="")
   	 			ajaxurl+=("&kind="+kind);
   	 		$.ajax({
   	 			url:ajaxurl,
   	 			data:{},
   	 			type: "get",
   	 			dataType: "JSON",
   	 			success: function(data){
   	 				var servicelist="";
   	 				$.each(data.rows, function(i, elt) {
   	 					var price=elt.price;
   	 					if(price==null)
   	 						price="面议";
   	 					servicelist+='<div class="mer-shop clearfix">'
                            +'<div class="mer-shop-img fl">'
                                +'<a><img src="'+returnimg(elt.kind)+'" alt=""></a>'
                            +'</div>'
                           +'<div class="mer-shop-js fl">'
                                +'<h3><p>'+elt.name+'</p>'
                                +'<div class="mer-shop-logo"><i class="img-logo"><img src="wxpage/images//mer_logo_te.png" alt=""></i>'
                                   +'<p>'+elt.kind+'</p>'
                                +'</div>'
                                +'<div class="mer-shop-logo"><i class="img-logo"><img src="wxpage/images//mer_logo_fan.png" alt=""></i>'
                                    +'<p>'+elt.description+'</p>'
                                +'</div>'
                            +'</div>'
                            +'<div class="mer-shop-phone clearfix fr">'
                                +'<div class="mer-shop-tel">'
									+'<font size="5" face="arial" color="red">￥</font><font size="5" face="arial" color="red">'+price+'</font>'
                                +'</div>'
                          	+'</div>'
                            +'<div class="mer-shop-pj">'
                                +'<p></p>'                 	
	                            +'<a name="change_'+elt.id+'"  class="btn btn-hollow default">修改服务</a>'
								+'<a name="delete_'+elt.id+'"  class="btn btn-hollow default">删除</a>'
                            +'</div>'
                    	 +'</div>';

   	 				});
   	 				$("#servicelist").html(servicelist);
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
		   	 				initlist(null,null);
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
   	 		$('#search').on('keypress',function(event){ 
        		initlist($(this).val(),null);
     		});
     		$('.grids-item').on('click',function(event){ 
        		initlist(null,$(this).attr("value"));
     		});
     		$("#servicelist").on("click",".btn",function(){
     			var	name=$(this).attr("name");
					var orderid=name.substring(name.indexOf('_')+1, name.length);
					var action=name.substring(0,name.indexOf('_'));
					switch(action){
						case "change":
							window.location.href=returnBaseUrl()+"user=server&action=changeService&id="+orderid;
							break;
						case "delete":
							if(confirm("确认删除吗？")){
								$.ajax({
									url:"server.action?deleteService",
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
					}
     		});
   	 	});
   	 	
   	 	</script>
	</head>

	<body>
    	<div class="g-flexview">
        	<header class="m-navbar my-header">
            	<a href="javascript:history.go(-1);" class="navbar-item default">
               	  	<i class="back-ico"></i>
            	</a>
            	<div style="align-items:center;justify-content:center;" class="navbar-center input-center flex-align-start flex">
                	<div class="index-input flex-1" style="align-items:center;justify-content:center;">
                    	<div class="icon-search"></div>
                    	<div class="index-right">
                        	<input id="search" type="text" placeholder="输入要求信息" autocomplete="off">
                    	</div>
                	</div>
            	</div>
        	</header>
	        <!-- mer-main -->
	        <div class="index-main g-scrollview">
	            <!-- m-slider -->
	            <div class="m-slider index-swiper clearfix">
	                <div class="slider-wrapper">
	                    <div class="slider-item">
	                        <a>
	                            <img src="wxpage/images/index_ad.jpg">
	                        </a>
	                    </div>
	                    <div class="slider-item">
	                        <a>
	                              <img src="wxpage/images/index_ad.jpg">
	                        </a>
	                    </div>
	                    <div class="slider-item">
	                        <a>
	                             <img src="wxpage/images/index_ad.jpg">
	                        </a>
	                    </div>
	                </div>
	                <div class="slider-pagination"></div>
	                <!-- 分页标识 -->
	            </div>

	         
	            
	            <!-- index-hot -->
	            <div class="index-near clearfix">
	                <div class="m-cell">
	                    <a class="cell-item" href="javascript:;">
	                        <div class="cell-left"><i class="img_hot"><img src="wxpage/images//mer_logo_area.png" alt=""></i>服务提供</div>
	                        
	                    </a>
	                    
	                    <!-- 店铺列表 -->
	                    <div id="servicelist" class="index-near-cont clearfix">
	                	</div>
	            	</div>
	        	</div>
	    	</div>
	 	</div>
	    <script>
	    $('.star').raty({
	        starOff: 'wxpage/images//star-off.png',
	        starOn: 'wxpage/images//star-on.png',
	        width: '1.4rem',
	        readOnly: true,
	        score: function() {
	            return $(this).attr("data-num");
	        },
	    });
	    $('.star-1').raty({
	        starOff: 'wxpage/images//star-off.png',
	        starOn: 'wxpage/images//star-on.png',
	        width: '1.4rem',
	        readOnly: true,
	        score: function() {
	            return $(this).attr("data-num");
	        },
	    });
	    $('.index-swiper').slider({
	        speed: 200,
	        autoplay: 2000,
	        lazyLoad: true
	    });
	
	    $('.menu-swiper').slider({
	        speed: 200,
	        autoplay: 30000,
	        lazyLoad: true
	    });

	    </script>
	</body>
</html>