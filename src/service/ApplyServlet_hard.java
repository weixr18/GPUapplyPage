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

import dao.HardRecordDao;

public class ApplyServlet_hard extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String aplt = request.getParameter("apply_time");
		String apt_date = request.getParameter("appointment_date");
		String hard_type = request.getParameter("hard_type");
		String start_date = apt_date.substring(6, 16);
		String end_date = apt_date.substring(28);

		HardRecordDao rdao = new HardRecordDao();
		boolean state = true;
		try {
			state = rdao.insertNewAppointment(name, id, aplt,
					start_date, end_date, hard_type);
		} catch (Exception e) {
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		json.put("insertstate", state);

		out.print(json);
		System.out.println(json);
		out.flush();
		out.close();

	}

}
