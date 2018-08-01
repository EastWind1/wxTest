<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/head.jsp" %>
<html>
	<head>
	    <title>我的信息</title> 
	    <script>
	    	$(function(){
	    		$.ajax({
	    			url:"wxuser.action?get",
	    			type:"get",
	    			dataType: "JSON",
	    			success:function(data){
	    				$('#name').val(data.userinfo.name);
	    				$('#password').val(data.userinfo.password);
	    				$('#question').val(data.userinfo.question);
	    				$('#answer').val(data.userinfo.answer);
	    			}
	    		});
	    		$('#submit').bind('click',function(){
					var name=$('#name').val();
					$.ajax({
						url:"wxuser.action?update",
		   	 			data:{"name":$('#name').val(),"password":$('#password').val(),"question":$('#question').val(),"answer":$('#answer').val()},
		   	 			type: "post",
		   	 			dataType: "JSON",
		   	 			success: function(data){
		   	 				alert("修改成功");
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
	                <span class="navbar-title">修改个人信息</span>
	            </div>
	        </header>
	        <div class="eva-main g-scrollview">
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">昵称</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <input id="name" style="margin-left:20px;width:400px;height:40px" type="text"  class="tital" >
	                    </div>
	                </div>
	            </div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">密码</div>
	                <div class="m-cell">
	                    <div class="cell-item">
	                        <div class="cell-right">
	                            <input id="password" type="password" style="margin-left:20px;width:400px;height:40px"  >
	                        </div>
	                    </div>
	                </div>
	            </div>
	            
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">密保问题</div>
	                <div class="m-cell">
	                    <div class="cell-item">
							<input id="question" style="margin-left:20px;width:400px;height:40px" type="text"  class="email"  >            
	                    </div>
	                </div>
	            </div>
	            <div class="eva-text clearfix">
	                <div class="m-celltitle">密保答案</div>
	                <div class="m-cell">
	                    <div class="cell-item">
							<input id="answer" style="margin-left:20px;width:400px;height:40px" type="text"  class="email"  >            
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
