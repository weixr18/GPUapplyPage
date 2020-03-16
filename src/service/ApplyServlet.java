package service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import beans.UserBean;
import dao.RecordDao;
import dao.UserDao;

public class ApplyServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String aplt = request.getParameter("apply_time");
		String apt_date = request.getParameter("appointment_date");
		String apt_period = request.getParameter("appointment_period");

		UserDao udao = new UserDao();
		UserBean ub = new UserBean();
		try {
			ub = udao.getNxtSysUser();
		} catch (Exception e) {
			e.printStackTrace();
		}

		String sysUserName = ub.getsysUsername();

		String regEx = "[^0-9]";
		Pattern pattern = Pattern.compile(regEx);
		Matcher matcher = pattern.matcher(sysUserName);
		int iid = Integer.valueOf(matcher.replaceAll("").trim());
		String sysUserId = String.format("%03d", iid);
		sysUserName = "user_" + sysUserId;

		RecordDao rdao = new RecordDao();
		boolean state = true;
		try {
			state = rdao.insertNewAppointment(name, id, aplt, apt_date,
					apt_period, sysUserId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		json.put("insertstate", state);
		json.put("username", sysUserName);
		json.put("password", ub.getpassword());

		out.print(json);
		System.out.println(json);
		out.flush();
		out.close();

	}

}
