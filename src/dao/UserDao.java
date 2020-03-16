package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import beans.UserBean;
import utils.DataBaseUtil;

public class UserDao {

	private static int nxtSysUserID = 0;

	public UserBean getNxtSysUser() {
		Connection connection = DataBaseUtil.getConnection();

		String sql = "select * from tb_users";
		UserBean ub = new UserBean();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				if (rs.getInt(1) >= nxtSysUserID) {
					nxtSysUserID++;
					nxtSysUserID = nxtSysUserID % 100;
					ub.setsysUsername("user_" + rs.getInt(1));
					ub.setpassword(rs.getNString(2));
					break;
				}
			}

		} catch (SQLException e) {
			System.out.println(e.toString());
			e.printStackTrace();
		} finally {
			DataBaseUtil.closeConnection(connection);
		}

		System.out.println("ub.username:" + ub.getsysUsername());
		return ub;
	}

}
