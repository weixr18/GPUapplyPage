<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>自动化系科协服务器申请</title>
	<link rel="stylesheet" type="text/css" href="/GPUapl2/css/jump.css">
	
</head>
<body>
	
	<% 
		String hard_options[] = {"机械箱1","机械箱2","机械箱3","大疆无人机"};
		request.setAttribute("hard_opt", hard_options);
	%>
	
	<div id="main">
		<b id="sub_title">自动化科协预约系统</b>
		
		<Button class="soft_button" onClick='serve_click()'>服务器预约</Button>
		<br/> <br/>
		
		<div id="text_list">
			要预约的硬件：
			<select id="hard_select">
				<c:forEach items="${hard_opt}" var="opt_i">
					<option value="${opt_i}}">${opt_i}</option>
				</c:forEach>
			</select>
		</div>
		<br/>
		<Button class="hard_button" onClick='hard_click()'>硬件预约</Button>
	</div>

	<script type="text/javascript">
		
		function serve_click()
		{
			window.location.href="./serv";
		}
	
		function hard_click()
		{
			var myselect=document.getElementById("hard_select");
			var index=myselect.selectedIndex ;
			
			window.location.href="./hard?hard_type="+myselect.options[index].text;;
		}
		
	</script>
</body>
</html>