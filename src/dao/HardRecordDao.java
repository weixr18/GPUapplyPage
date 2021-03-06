package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import beans.HardRecordBean;
import utils.DataBaseUtil;

public class HardRecordDao {
	/* 获取当前一周内的所有预约数据 */
	public List<HardRecordBean> getCurrentAppointment(String hard_type) {
		List<HardRecordBean> rbl;
		rbl = new ArrayList<HardRecordBean>();

		Date currentD = new Date();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(currentD);
		int week_day = calendar.get(Calendar.DAY_OF_WEEK);
		int add_day = (Calendar.MONDAY-week_day+7)%7;
		calendar.add(Calendar.DATE, add_day);
		Date nextMonday = calendar.getTime();
		calendar.add(Calendar.DATE, 6*7-1);
		Date weeksLater = calendar.getTime();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = sdf.format(nextMonday);
		
		String nxtWkStr = sdf.format(weeksLater);

		Connection connection = DataBaseUtil.getConnection();

		String sql = "select * from tb_hard_record WHERE aptm_startday between ? and ? and hard_type=?";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, dateStr);
			ps.setString(2, nxtWkStr);
			ps.setString(3, hard_type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				HardRecordBean rb = new HardRecordBean();
				rb.setId(rs.getInt(1));
				rb.setUsername(rs.getNString(2));
				rb.setAppointmentStartDay(rs.getDate(3));
				rb.setAppointmentEndDay(rs.getDate(4));
				rb.setApplyTime(rs.getDate(5));
				rbl.add(rb);
			}
		} catch (SQLException e) {
			System.out.println(e.toString());
			e.printStackTrace();
		} finally {
			DataBaseUtil.closeConnection(connection);
		}

		System.out.println("rbl.size():" + rbl.size());
		return rbl;
	}

	/* 增加新的预约数据 */
	public boolean insertNewAppointment(String name, String id, String aplt,
			String apt_startDay, String apt_endDay, String hard_type)
			throws Exception {

		Date apl_date = parseGMT(aplt);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String apldateStr = sdf.format(apl_date);
		System.out.println(name);
		System.out.println(id);
		System.out.println(apt_startDay);
		System.out.println(apt_endDay);
		System.out.println(apldateStr);
		System.out.println(hard_type);

		String sql = "insert into tb_hard_record values(?, ?, ?, ?, ?, 1, ?)";
		
		
		boolean rs = false;
		Connection connection = DataBaseUtil.getConnection();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setString(3, apt_startDay);
			ps.setString(4, apt_endDay);
			ps.setString(5, apldateStr);
			ps.setString(6, hard_type);
			int resNum = ps.executeUpdate();
			if (resNum == 1) {
				rs = true;
			}
			System.out.println("rs=" + rs);

		} catch (SQLException e) {
			System.out.println(e.toString());
			e.printStackTrace();
		} finally {
			DataBaseUtil.closeConnection(connection);
		}

		return rs;
	}

	/* https://blog.csdn.net/xianzhuo_sky/article/details/82803945 */
	public static Date parseGMT(String strDate) throws Exception {
		if (strDate != null && strDate.trim().length() > 0) {
			strDate = strDate.substring(4, 24).replace(" ", "/");
			strDate = strDate.replace("Jan", "01");
			strDate = strDate.replace("Feb", "02");
			strDate = strDate.replace("Mar", "03");
			strDate = strDate.replace("Apr", "04");
			strDate = strDate.replace("May", "05");
			strDate = strDate.replace("Jun", "06");
			strDate = strDate.replace("Jul", "07");
			strDate = strDate.replace("Aug", "08");
			strDate = strDate.replace("Sep", "09");
			strDate = strDate.replace("Oct", "10");
			strDate = strDate.replace("Nov", "11");
			strDate = strDate.replace("Dec", "12");
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy/HH:mm:ss");
			Date date = sdf.parse(strDate);
			return date;
		}
		return null;
	}

}
