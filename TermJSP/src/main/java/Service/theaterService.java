package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
			addTime(sID, theaterID, movieTime);
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
		String[] split_hour = split_time[0].split(":");
		int hour = Integer.parseInt(split_hour[0]);
		int forValue = Integer.parseInt(split_time[1]);
		try {
			String addQuery = "insert into time (theaterID,sID,seats,time) values (?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			while(hour < 24 ) {
				ps.setString(1, theaterID);
				ps.setString(2, sID);
				ps.setInt(3, 120);
				
				String input = String.valueOf(hour)+":"+split_hour[1];
				hour += forValue;
				ps.setString(4,input );
				ps.executeUpdate();
			}
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
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			JSONObject total = new JSONObject();
			JSONArray totalList = new JSONArray();
			String sID = null;
			String movieName = null;
			String getQuery="select sID,movieName from sangyounggwan where theaterID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1,theaterID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				sID = rs.getString("sID");
				movieName = rs.getString("movieName");
				JSONObject timeList = getSTime(theaterID,sID,movieName);
				totalList.add(timeList);
			}
			
			return totalList;
		}
		catch(Exception e ) {
			System.out.print(e.getMessage());
		}
		return null;
	}
	
	public JSONObject getSTime(String theaterID, String sID,String movieName) throws Exception {
		JSONObject time = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select time from time where theaterID=? and sID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, theaterID);
			ps.setString(2, sID);
			ResultSet rs = ps.executeQuery();
			int i=0;
			time.put("sID",sID);
			time.put("movieName",movieName);
			while(rs.next()) {
				time.put("time-"+i, rs.getString("time"));
				i++;
			}
			return time;
		}
		catch(Exception e ) {
			System.out.print(e.getMessage());
		}
		return null;
	}
	
	public String getSList(String theaterID) throws Exception {
		JSONArray sArray = new JSONArray();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select sID from sangyounggwan where theaterID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, theaterID);
			ResultSet rs = ps.executeQuery();
			String result = "";
			while(rs.next()) {
				result += rs.getString("sID")+" ";
			}
			return result;
		}
		catch(Exception e ) {
			System.out.print(e.getMessage());
		}
		return null;
	}
	
	public int getSeatsNumber(String theaterID) throws Exception {
		JSONArray sArray = new JSONArray();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select count(*) as totalSeats from sangyounggwan where theaterID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, theaterID);
			ResultSet rs = ps.executeQuery();
			int totalSeats = 0;
			while(rs.next()) {
				totalSeats = rs.getInt("totalSeats");
			}
			return totalSeats;
		}
		catch(Exception e ) {
			System.out.print(e.getMessage());
		}
		return 0;
	}
	
	public boolean deleteTheater(String theaterID) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String deleteQuery = "delete from theater where theaterID=?";
			PreparedStatement ps = conn.prepareStatement(deleteQuery);
			ps.setString(1, theaterID);
			ps.executeUpdate();
			
			return true;
		}
		catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return false;
	}
}
