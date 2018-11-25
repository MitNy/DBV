package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 public class Database {
	/* Mysql DB Connection */
	public Connection GetConnection() throws Exception {
		try{
			String connectionURL = "jdbc:mysql://localhost:3306/db_term?characterEncoding=UTF-8&serverTimezone=UTC";
			Connection connection = null;
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "root", "mijin0314");
			return connection;
			}
		catch (SQLException e) {
			throw e;	
		}
		catch (Exception e) {
			throw e;	
		}
	}
}