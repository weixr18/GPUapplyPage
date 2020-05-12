package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.HardRecordBean;
import dao.HardRecordDao;

public class FirstServlet_Hard extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String hard_type = request.getParameter("hard_type");
		//System.out.println("hard type:"+hard_type);
		
		HardRecordDao recordDao = new HardRecordDao();
		List<HardRecordBean> crtApnt = recordDao.getCurrentAppointment(hard_type);
		System.out.println(crtApnt);

		request.setAttribute("appointments", crtApnt);
		request.setAttribute("hard_type", hard_type);
		request.getRequestDispatcher("hardware_index.jsp").forward(request, response);

	}
}
