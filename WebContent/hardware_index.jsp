<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="beans.HardRecordBean"%>
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
   	List<HardRecordBean> appointments = (List<HardRecordBean>)request.getAttribute("appointments");
   	String hard_type = (String)request.getAttribute("hard_type");
   	
   	
   	Date[] start_dates = new Date[6];
	String[] start_datestr = new String[6];
	Date[] end_dates = new Date[6];
	String[] end_datestr = new String[6];
   	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   	Date currentD = new Date();
	Calendar calendar = new GregorianCalendar();
	calendar.setTime(currentD);
	int week_day = calendar.get(Calendar.DAY_OF_WEEK);
	int add_day = (Calendar.MONDAY-week_day+7)%7;
	calendar.add(Calendar.DATE, add_day);
	Date nextMonday = calendar.getTime();
	
	start_dates[0]=nextMonday;
	start_datestr[0]=sdf.format(nextMonday);
	
	calendar.add(Calendar.DATE, 6);
	end_dates[0] = calendar.getTime();
	end_datestr[0] = sdf.format(end_dates[0]);
	
	for(int i=1;i<6;i++)
	{
		calendar.add(Calendar.DATE, 1);
		start_dates[i] = calendar.getTime();
		start_datestr[i] = sdf.format(start_dates[i]);
		
		calendar.add(Calendar.DATE, 6);
		end_dates[i] = calendar.getTime();
		end_datestr[i] = sdf.format(end_dates[i]);
	}
	
	request.setAttribute("start_datestr",start_datestr);
	request.setAttribute("end_datestr",end_datestr);
	
	%>


    <div id="t1">
    	申请硬件：<b id="hard_type">${hard_type}</b>
    </div>
    <div id="m">
	    <div id="t2">
	    	可用申请时段
	    </div>
	    
	    <%
	 	//决定表格显示
		boolean isBooked[][] = {{false, false, false, false, false, false}};
	    
		//获取已提交记录的姓名和学号
		Set<String> names = new TreeSet<String>();
		Set<Integer> ids = new TreeSet<Integer>();
	    
	    if(appointments != null)
	    {
	    	for(HardRecordBean b: appointments)
			{
				Date start_date = b.getAppointmentStartDay();
	
				for(int i = 0; i < 6; i++)
				{
					if(start_date.toString().equals(start_datestr[i]))
					{
						isBooked[0][i] = true;
						System.out.printf("isBooked[%d] = true\n", i);
					}	
				}
				names.add(b.getUsername());
				ids.add(b.getId());
			}
	    }
	    
		JSONObject json = new JSONObject();
		json.put("isBooked", isBooked);
		request.setAttribute("isBooked",json);
		
		json.put("names", names);
		request.setAttribute("names",json);
		
		json.put("ids", ids);
		request.setAttribute("ids",json);
		
		String index_type = "hard";
		json.put("index_type", index_type);
		request.setAttribute("index_type",json);
		
		json.put("hard_type", hard_type);
		request.setAttribute("hard_type",hard_type);
		
		request.setAttribute("isBooked_all",isBooked[0]);
		//request.setAttribute("isBooked0",isBooked[0]);
		//request.setAttribute("isBooked1",isBooked[1]);
		//request.setAttribute("isBooked2",isBooked[2]);
		//request.setAttribute("isBooked3",isBooked[3]);
		
	   	%>
	   	
	   	<input type = 'hidden' id = 'isBooked' name = 'isBooked' value = '${isBooked}'></input>
	   	<input type = 'hidden' id = 'names' name = 'names' value = '${names}'></input>
	   	<input type = 'hidden' id = 'ids' name = 'ids' value = '${ids}'></input>
	   	<input type = 'hidden' id = 'index_type' name = 'index_type' value = '${index_type}'></input>
	    <input type = 'hidden' id = 'hard_type' name = 'hard_type' value = '${hard_type}'></input>
	    
    	<div id="d1">
	    <table id="ta" cellpadding="2" border="1" onclick="TabClick();">
	    	<tbody>
	    	<tr bgcolor="#efefef">
	    		<th>时段\日期</th>
	    		<c:forEach items="${start_datestr}" var="start_date" varStatus="data_status">
	    			<th><span>${start_date}</span><br>~${end_datestr[data_status.index]}</th>
				</c:forEach>
			</tr>
			<tr>
				<td bgcolor="#efefef">预约情况</td>
				<c:forEach items="${isBooked_all}" var="ib0">
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
	    
	    <!--end div m-->
    </div>
    <!--end div wrapper-->
</div>


</body>
</html>
