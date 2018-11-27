package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Dao.Database;

public class theaterService {
	public JSONArray getTheater() throws Exception {
		//List<String> movieList = new ArrayList<String>();
		JSONArray theaterList = new JSONArray();
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select * from theater";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				theater.put("theaterID-"+i,rs.getString("theaterID"));
				theater.put("theaterName-"+i,rs.getString("theaterName"));
				theater.put("address-"+i,rs.getString("address"));
				theater.put("number-"+i,rs.getString("number"));
				theaterList.add(theater);
				i++;
			}
			return theaterList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public JSONObject getSpecificTheater(String theaterID) throws Exception {
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select * from theater where theaterID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, theaterID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				theater.put("theaterID",rs.getString("theaterID"));
				theater.put("theaterName",rs.getString("theaterName"));
				theater.put("address",rs.getString("address"));
				theater.put("number",rs.getString("number"));
			}
			return theater;
		}
		catch(Exception e ) {
			
		}
		return null;
	}

	public JSONArray getTheaterList() throws Exception {
		JSONArray theaterList = new JSONArray();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select theaterName from theater";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				theaterList.add(rs.getString("theaterName"));
			}
			return theaterList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public JSONArray getTheaterListWithID() throws Exception {
		JSONArray theaterList = new JSONArray();
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select theaterID,theaterName from theater";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				theater.put("theaterID-"+i, rs.getString("theaterID"));
				theater.put("theaterName-"+i, rs.getString("theaterName"));
				theaterList.add(theater);
				i++;
			}
			return theaterList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public String getTheaterID(String theaterName) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select theaterID from theater where theaterName=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, theaterName);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String theaterID = rs.getString("theaterID");
			return theaterID;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public boolean addSangyounggwan(String sID, String theaterID, String movieName,String movieTime) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String addQuery = "insert into sangyounggwan (sID,theaterID,movieName,seats) values (?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, sID);
			ps.setString(2, theaterID);
			ps.setString(3, movieName);
			ps.setInt(4, 120);
			ps.executeUpdate();
			ps.close();
			conn.close();
			//addTime(sID, theaterID, movieTime);
			return true;
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
		return false;
	}
	
	public boolean addTime(String sID, String theaterID, String time) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		String[] split_time = time.split("/");
		try {
			
			String addQuery = "insert into time (theaterID,sID,seats,time) values (?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, theaterID);
			ps.setString(2, sID);
			ps.setInt(3, 120);
			ps.setString(4, time);
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
	
	public JSONArray getSangyounggwanInfo(String theaterID) throws Exception {
		JSONArray sList = new JSONArray();
		JSONObject sangyounggwan = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select sID,movieName from theater";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				sangyounggwan.put("sID-"+i, rs.getString("sID"));
				sangyounggwan.put("movieName-"+i, rs.getString("movieName"));
				sList.add(sangyounggwan);
				i++;
			}
			return sList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public JSONObject getSTime(String theaterID,String sID) throws Exception {
		JSONObject time = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select time from time from theaterID=? and sID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				time.put("time-"+i, rs.getString("time"));
				i++;
			}
			return time;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
}
