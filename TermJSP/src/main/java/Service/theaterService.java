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
}
