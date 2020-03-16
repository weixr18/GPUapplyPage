package service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StaticResServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 使用response获得字节输出流
		ServletOutputStream out = response.getOutputStream();

		// 获得服务器上面的图片
		String path = request.getRequestURI();
		path = (String) deleteSubString(path, "/GPUapl2")[0];
		String realpath = this.getServletContext().getRealPath(path);
		System.out.println(realpath);
		InputStream in = new FileInputStream(realpath);
		int len = 0;
		byte[] buffer = new byte[1024];
		while ((len = in.read(buffer)) > 0) {
			out.write(buffer, 0, len);
		}
		in.close();
		out.close();
	}

	Object[] deleteSubString(String str1, String str2) {
		StringBuffer sb = new StringBuffer(str1);
		int delCount = 0;
		Object[] obj = new Object[2];

		while (true) {
			int index = sb.indexOf(str2);
			if (index == -1) {
				break;
			}
			sb.delete(index, index + str2.length());
			delCount++;

		}
		if (delCount != 0) {
			obj[0] = sb.toString();
			obj[1] = delCount;
		} else {
			// 不存在返回-1
			obj[0] = -1;
			obj[1] = -1;
		}

		return obj;
	}

}
