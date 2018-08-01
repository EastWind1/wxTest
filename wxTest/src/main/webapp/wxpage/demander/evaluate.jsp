<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<%
	String id=request.getParameter("id");
 %>
<html>
  	<head>
    	<title>发表评价</title>
    	<script>
    	$(function(){
    		var description=$("#desc").val();
	    	$('#submit').on('click',function(){
	    		if(description!=""){
	    			var id=<%=id%>;
					$.ajax({
						url:"demander.action?evaluate",
			   	 		data:{"id":id,"description":$("#desc").val()},
			   	 		type: "post",
			   	 		dataType: "JSON",
			   	 		success: function(data){
			   	 			alert(data.msg);
			   	 		}
					});
				}
				else{
					alert("评价为空");
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
	                <span class="navbar-title">发表评价</span>
	            </div>
	        </header>
	        <!-- header -->
	        <!-- ori-main -->
	        <div class="eva-main g-scrollview">
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">发表评论</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <div class="cell-right">
	                            <textarea id="desc" class="cell-textarea" placeholder="亲，有什么需要评论的么？"></textarea>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            
	            <div class="eva-list">
	                <div class="orl-list clearfix">
	                    <a id="submit" class="btn-block btn-primary">提交评价</a>
	                </div>
	            </div>
	        </div>
	    </div>
	
	   
	    <script>
	
	    $('.star').raty({
	        starOff: 'images/star-off.png',
	        starOn: 'images/star-on.png',
	        width:'3rem'
	    });
	    
	    </script>
	    
	    
	   
	    
	   
	    
	</body>
</html>
