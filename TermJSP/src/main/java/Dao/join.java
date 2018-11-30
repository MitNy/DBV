package Dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

public class join {
	public boolean joinCheck(String id,String pwd,String name,String birthday, String address,String tel ) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = formater.parse(birthday);
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			String joinQuery = "insert into customer (id,password,name,birthday,address,phone,point,grade) values (?,?,?,?,?,?,?,?)";
		
			PreparedStatement ps = conn.prepareStatement(joinQuery);
			ps.setString(1, id);
			ps.setString(2, pwd);
			ps.setString(3,name);
			ps.setDate(4,sqlDate);
			ps.setString(5,address);
			ps.setString(6,tel);
			ps.setInt(7, 0);
			ps.setString(8, "일반");
			ps.executeUpdate();
			
			ps.close();
			conn.close();
			return true;
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
		return false;
	}
}
