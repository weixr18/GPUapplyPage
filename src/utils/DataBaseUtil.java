package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseUtil {

	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // mysql version 6+:
														// com.mysql.cj.jdbc.Driver
			String url = "jdbc:mysql://localhost:3306/apl_sys?serverTimezone=GMT";
			connection = DriverManager.getConnection(url, "root", "b13319731225");
			return connection;

		} catch (ClassNotFoundException nfe) {
			nfe.printStackTrace();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		}
		return connection;
	}

	public static void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException sqle) {
				sqle.printStackTrace();
			}
		}
	}
}
