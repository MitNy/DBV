package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class nameGetter {
	public static String getMovieName(String movieID) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select title from movie where movieID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, movieID);
			ResultSet rs = ps.executeQuery();
			String movieTitle = rs.getString("title");
			return movieTitle;
		}
		catch(Exception e ) {
			System.out.print(e.getMessage());
		}
		return null;
	}
	
	public static String getTheaterName(String theaterID) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select theaterName from theater where theaterID=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, theaterID);
			ResultSet rs = ps.executeQuery();
			String theaterName = rs.getString("theaterName");
			return theaterName;
		}
		catch(Exception e ) {
			System.out.print(e.getMessage());
		}
		return null;
	}
}
