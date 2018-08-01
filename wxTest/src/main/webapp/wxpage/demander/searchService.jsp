<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<html>
	<head>
   	 	<title>查询服务</title>		 	
   	 	<script type="text/javascript">
   	 	function initlist(name,kind){
   	 		var ajaxurl="demander.action?getService";
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
   	 					if(elt.credit=null){
   	 						elt.credit=0;
   	 					}
   	 					servicelist+='<div class="mer-shop clearfix">'
                            +'<div class="mer-shop-img fl">'
                                +'<a><img src="'+returnimg(elt.kind)+'" alt=""></a>'
                            +'</div>'
                           +'<div class="mer-shop-js fl">'
                                +'<h3><p>'+elt.name+'</p>'
                                +'<div class="mer-shop-area"><i class="img-logo"><img src="wxpage/images//mer_logo_area.png" alt=""></i>'
                                    +'<p>'+elt.serverName+'</p>'
                                +'</div>'
                                +'<div class="mer-shop-logo"><i class="img-logo"><img src="wxpage/images//mer_logo_te.png" alt=""></i>'
                                   +'<p>'+elt.kind+'</p>'
                                +'</div>'
                                +'<div class="mer-shop-logo"><i class="img-logo"><img src="wxpage/images//mer_logo_fan.png" alt=""></i>'
                                    +'<p>'+elt.description+'</p>'
                                +'</div>'
                            +'</div>'
                            +'<div class="mer-shop-phone clearfix fr">'
                                +'<div class="mer-shop-tel">'
									+'<font size="5" face="arial" color="red">￥</font><font size="5" face="arial" color="red">'+elt.price+'</font>'
                                +'</div>'
                          	+'</div>'
                            +'<div class="mer-shop-pj">'
                                +'<p></p>'                                	
	                            +'<a name="confirm%'+elt.kind+'_'+elt.serverId+'"  class="btn btn-hollow default">下单</a>'
                            +'</div>'
                    	 +'</div>';

   	 				});
   	 				$("#servicelist").html(servicelist);
   	 			}
   	 		});
   	 	}
   	 	$(function(){
   	 		initlist(null,null);
   	 		$('#search').on('keypress',function(event){ 
        		initlist($(this).val(),null);
     		});
     		$('.grids-item').on('click',function(event){ 
        		initlist(null,$(this).attr("value"));
     		});
     		$("#servicelist").on("click",".btn",function(){
     			var	name=$(this).attr("name");
				var serverid=name.substring(name.indexOf('_')+1, name.length);
				var kind=name.substring(name.indexOf('%')+1, name.indexOf('_'));
				window.location.href=returnBaseUrl()+"user=demander&action=newOrder&id="+serverid+"&kind="+kind;
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

	            <div class="m-slider menu-swiper clearfix" style="height:30%">
	                <div class="slider-wrapper">
	                    <div class="slider-item">
	                        <div class="m-grids-5">
	                            <a value="网站建设" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//wangzhan.png"></div>
	                                <div class="grids-txt"><span>网站建设</span></div>
	                            </a>
	                            <a value="APP开发" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//APP.png"></div>
	                                <div class="grids-txt"><span>APP开发</span></div>
	                            </a>
	                            <a value="微信开发" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//weixin.png"></div>
	                                <div class="grids-txt"><span>微信开发</span></div>
	                            </a>
	                            <a value="桌面软件" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//desktop.png"></div>
	                                <div class="grids-txt"><span>桌面软件</span></div>
	                            </a>
	                            <a value="UI设计" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//UI.png"></div>
	                                <div class="grids-txt"><span>UI设计</span></div>
	                            </a>
	                            <a value="解决方案" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//jiejue.png"></div>
	                                <div class="grids-txt"><span>解决方案</span></div>
	                            </a>
	                            <a value="数据服务" class="grids-item">
	                               <div class="grids-icon"><img src="wxpage/images//shuju.png"></div>
	                                <div class="grids-txt"><span>数据服务</span></div>
	                            </a>
	                            <a value="安全服务" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//safe.png"></div>
	                                <div class="grids-txt"><span>安全服务</span></div>
	                            </a>
	                            <a value="测试服务" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//test.png"></div>
	                                <div class="grids-txt"><span>测试服务</span></div>
	                            </a>
	                            <a value="HTML5" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//H5.png"></div>
	                                <div class="grids-txt"><span>HTML5</span></div>
	                            </a>
	                        </div>
	                    </div>
	                    <div class="slider-item">
	                        <div class="m-grids-5">
	                            <a value="域名服务" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//yuming.png"></div>
	                                <div class="grids-txt"><span>域名服务</span></div>
	                            </a>
	                            <a value="云服务" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//yun.png"></div>
	                                <div class="grids-txt"><span>云服务</span></div>
	                            </a>
	                            <a value="人力外派" class="grids-item">
	                                <div class="grids-icon"><img src="wxpage/images//people.png"></div>
	                                <div class="grids-txt"><span>人力外派</span></div>
	                            </a>
	                            
	                        </div>
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