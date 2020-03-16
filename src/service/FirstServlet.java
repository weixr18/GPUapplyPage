package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.RecordBean;
import dao.RecordDao;

public class FirstServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RecordDao recordDao = new RecordDao();
		List<RecordBean> crtApnt = recordDao.getCurrentAppointment();
		System.out.printf("record number = %d\n", crtApnt.size());

		request.setAttribute("appointments", crtApnt);
		request.getRequestDispatcher("index.jsp").forward(request, response);

	}
}
