package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Dao.Database;

public class infoService {
	private String userName;
	private String userBirthday;
	private String userAddress;
	private String userPhone;
	private int userPoint;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserBirthday() {
		return userBirthday;
	}
	public void setUserBirthday(String userBirthday) {
		this.userBirthday = userBirthday;
	}
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public int getUserPoint() {
		return userPoint;
	}
	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}
	
	
	public void getUserInto(String sessionID) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String pointQuery="select name,birthday,address,phone,point from customer where id=?";
			PreparedStatement pq = conn.prepareStatement(pointQuery);
			pq.setString(1, sessionID);
			ResultSet rs = pq.executeQuery();
			rs.next();
			setUserName(rs.getString("name"));
			setUserBirthday(rs.getDate("birthday").toString());
			setUserAddress(rs.getString("address"));
			setUserPhone(rs.getString("phone"));
			setUserPoint(rs.getInt("point"));
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	
	public boolean editInfo(String id,String password, String name, String address, String tel ) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String editQuery = "update customer set password=?,name=?,address=?,phone=? where id=?";
			PreparedStatement ps = conn.prepareStatement(editQuery);
			ps.setString(1,password);
			ps.setString(2, name);
			ps.setString(3, address);
			ps.setString(4, tel);
			ps.setString(5, id);
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
