package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Dao.Database;
import Dao.nameGetter;

public class adminService {
	public boolean addMovie(String movieID, String movieTitle, String director, String cast, String grade, String information) throws Exception  {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			int int_grade = Integer.parseInt(grade);
			String addQuery = "insert into movie (movieID,director,title,cast,grade,information) values (?,?,?,?,?,?)";		
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, movieID);
			ps.setString(2, director);
			ps.setString(3, movieTitle);
			ps.setString(4, cast);
			ps.setInt(5, int_grade);
			ps.setString(6, information);
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
	
	
	
	public boolean addTheater(String theaterID, String theaterName, String address, String number) throws Exception  {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String addQuery = "insert into theater (theaterID,theaterName,address,number) values(?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, theaterID);
			ps.setString(2, theaterName);
			ps.setString(3, address);
			ps.setString(4, number);
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
	
	public JSONArray getVipUser() throws Exception {
		JSONArray userList = new JSONArray();
		JSONObject user = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select id,point,(select count(*) from reservation where userID=customer.id) as result,grade from customer order by result desc limit 10;";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			String[] vipList = new String[10];
			int i=0;
			while(rs.next()) {
				user.put("userID-"+i, rs.getString("id"));
				user.put("userPoint-"+i,rs.getInt("point"));
				user.put("result-"+i, rs.getInt("result"));
				user.put("userGrade-"+i, rs.getString("grade"));
				userList.add(user);
				vipList[i] = rs.getString("id").toString();
				updateUserGrade(rs.getString("id").toString(),"VIP");
				i++;
			}
			truncateVip();
			updateVip(vipList);
			updateAllGrade();
			return userList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public boolean updateUserGrade(String userID, String grade) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String updateQuery = "update customer set grade=? where id=?";
			PreparedStatement ps = conn.prepareStatement(updateQuery);
			ps.setString(1, grade);
			ps.setString(2,userID);
			ps.executeUpdate();
			ps.close();
			conn.close();
			return true;
		}
		catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return false;
	}
	
	public void truncateVip() throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String trunQuery = "truncate vip";
			PreparedStatement ps = conn.prepareStatement(trunQuery);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	
	public void updateVip(String[] vipList) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String addQuery = "insert into vip (id) values (?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			for(int i=0; i<vipList.length; i++ ) {
				String vipUser = vipList[i];
				ps.setString(1, vipUser);
				ps.executeUpdate();
			}
			
			ps.close();
			conn.close();
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	
	public void updateAllGrade() throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String updateQuery = "update customer as c set c.grade='일반' where c.id = (select c2.id from (select c3.id from customer as c3 where c3.id not in (select * from vip)) as c2);";
			PreparedStatement ps = conn.prepareStatement(updateQuery);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e) {
			System.out.print(e.getMessage());
		}
	}
	
	
	
}
