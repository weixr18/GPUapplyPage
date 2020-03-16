<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="beans.RecordBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.TreeSet"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="org.json.JSONObject"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<html><head>
    <title>自动化系科协服务器申请</title>
    <link rel="stylesheet" type="text/css" href="/GPUapl2/css/c1.css">
    <script type="text/javascript" src="js/jquery-3.3.1.min.js" ></script>
	<script type="text/javascript" src="js/cfm.js"></script>
</head>
<body class="html">
<div id="wrapper">
   	<div id="logo">
   		<img src="/GPUapl2/images/sastda.png" class="img-responsive" >
   	</div>
   	
   	<% 
   	List<RecordBean> appointments = (List<RecordBean>)request.getAttribute("appointments");
   	
   	//获取今天和未来7天的时间
   	Date currentD = new Date();
	Date[] dates = new Date[8];
	String[] datestr = new String[8];
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	dates[0] = currentD;
	datestr[0] = sdf.format(currentD);
	
	Calendar calendar = new GregorianCalendar();
	calendar.setTime(currentD);
	for(int i = 1; i < 8; i++)
	{
		calendar.add(Calendar.DATE, 1);
		dates[i] = calendar.getTime();
		datestr[i] = sdf.format(dates[i]);
	}
	request.setAttribute("datestr",datestr);
	
	
	%>


    <div id="t1">
    	申请GPU
    </div>
    <div id="m">
	    <div id="t2">
	    	可用申请时段
	    </div>
	    
	    <%
	 	//决定表格显示
		boolean isBooked[][] = {
				{false, false, false, false, false, false, false, false}, 
				{false, false, false, false, false, false, false, false}, 
				{false, false, false, false, false, false, false, false}, 
				{false, false, false, false, false, false, false, false}};
	    
		//获取已提交记录的姓名和学号
		Set<String> names = new TreeSet<String>();
		Set<Integer> ids = new TreeSet<Integer>();
	    
	    if(appointments != null)
	    {
	    	for(RecordBean b: appointments)
			{
				int date = b.getAppointmentDay().getDate();
				int period = b.getAppointmentPeriod();
				if(period <= 0 || period >= 5)
					continue;
				
				for(int i = 0; i < 8; i++)
				{
					if(date == dates[i].getDate())
					{
						isBooked[period-1][i] = true;
						System.out.printf("isBooked[%d][%d] = true\n", period, i);
					}	
				}
				names.add(b.getUsername());
				ids.add(b.getId());
			}
	    }
	    
		JSONObject json = new JSONObject();
		json.put("isBooked", isBooked);
		request.setAttribute("isBooked",json);
		
		JSONObject json2 = new JSONObject();
		json.put("names", names);
		request.setAttribute("names",json);
		
		JSONObject json3 = new JSONObject();
		json.put("ids", ids);
		request.setAttribute("ids",json);
		
		request.setAttribute("isBooked0",isBooked[0]);
		request.setAttribute("isBooked1",isBooked[1]);
		request.setAttribute("isBooked2",isBooked[2]);
		request.setAttribute("isBooked3",isBooked[3]);
	   	%>
	   	
	   	<input type = 'hidden' id = 'isBooked' name = 'isBooked' value = '${isBooked}'></input>
	   	<input type = 'hidden' id = 'names' name = 'names' value = '${names}'></input>
	   	<input type = 'hidden' id = 'ids' name = 'ids' value = '${ids}'></input>
	       
	    
    	<div id="d1">
	    <table id="ta" cellpadding="2" border="1" onclick="TabClick();">
	    	<tbody>
	    	<tr bgcolor="#efefef">
	    		<th>时段\日期</th>
	    		<c:forEach items="${datestr}" var="date">
	    			<th>${date}</th>
				</c:forEach>
			</tr>
			<tr>
				<td bgcolor="#efefef">A<br>9:00-13:00</td>
				<c:forEach items="${isBooked0}" var="ib0">
					<c:choose>
						<c:when test="${ib0}">
							<th bgcolor="#e0faff">&nbsp;</th>
						</c:when> 
						<c:otherwise>  
							<th>&nbsp;</th>
						</c:otherwise>
					</c:choose>	    			
				</c:forEach>
			</tr>
			<tr>
				<td bgcolor="#efefef">B<br>13:30-18:00</td>
				<c:forEach items="${isBooked1}" var="ib1">
					<c:choose>
						<c:when test="${ib1}">
							<th bgcolor="#f8fec7">&nbsp;</th>
						</c:when> 
						<c:otherwise>  
							<th>&nbsp;</th>
						</c:otherwise>
					</c:choose>	    			
				</c:forEach>
			</tr>
			<tr>
				<td bgcolor="#efefef">C<br>18:30-22:00</td>
				<c:forEach items="${isBooked2}" var="ib2">
					<c:choose>
						<c:when test="${ib2}">
							<th bgcolor="#c6ffc6">&nbsp;</th>
						</c:when> 
						<c:otherwise>  
							<th>&nbsp;</th>
						</c:otherwise>
					</c:choose>	    			
				</c:forEach>
			</tr>
			<tr>
				<td bgcolor="#efefef">D<br>22:30-次日8:00</td>
				<c:forEach items="${isBooked3}" var="ib3">
					<c:choose>
						<c:when test="${ib3}">
							<th bgcolor="#fecfd6">&nbsp;</th>
						</c:when> 
						<c:otherwise>  
							<th>&nbsp;</th>
						</c:otherwise>
					</c:choose>	    			
				</c:forEach>
			</tr>
			</tbody>
		</table>
		<!--end ta-->
		</div>
		
		<div id="t2">
	    	提交申请
	    </div>
	    
		<div id="apl">
	        <table id="tb" border="0">
	            <tbody>
	            <tr>
	                <td style="width: auto;" align="left">姓名</td>
	                <td>
	                    <input type="text" class="input-nme" id="username" style="width: 200px;font-size: 16px;">
	                </td>
	            </tr>
	            <tr>
	                <td style="width: auto;" align="left">学号</td>
	                <td style="">
	                    <input type="text" class="input-id" id="id" style="width: 200px;font-size: 16px;">
	                </td>
	            </tr>
	            <!--验证码-->
	            <tr class="code">
	            	<td style="width: 130px;" align="left">验证码</td>
	                <td style="">
						<input type="text" value="" class="input-cfm" style="font-size: 16px;max-width: 100%;">
					</td>
					<td>
						<canvas id="canvas" width="100" height="35"></canvas>
					</td>
	            </tr>
	        	</tbody>
	        </table>
	        <!--end table tb-->
	        <center><button id="btn" class="btn">提交</button></center>
	    </div>
	    
	    <div id="t2">
	    	使用手册
	    </div>
	    
	    <div id="t3">
	    	<a href="/GPUapl2/documents/README.pdf">自动化系科协服务器申请说明.pdf</a>
	    </div>
	    
	    <!--end div m-->
    </div>
    <!--end div wrapper-->
</div>


</body>
</html>
