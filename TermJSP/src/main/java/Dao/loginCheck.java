package Dao;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import Dao.Database;
public class loginCheck {
	public String loginCheck(String id,String pwd) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String userQuery="select id,password from customer where id=? and password=?";
			String adminQuery="select id,password from admin where id=? and password=?";
			PreparedStatement uq = conn.prepareStatement(userQuery);
			PreparedStatement aq = conn.prepareStatement(adminQuery);
			uq.setString(1, id); aq.setString(1, id);
			uq.setString(2, pwd); aq.setString(2, pwd);
			ResultSet us = uq.executeQuery();
			ResultSet as = aq.executeQuery();
			
			if( us.isBeforeFirst()) {
				return "isCustomer";
			}
			else if( as.isBeforeFirst()) {
				return "isAdmin";
			}
			else {
				return null;
			}
		}
		catch(Exception e ) {
			
		}
		return null;
	}

}
