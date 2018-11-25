package Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Dao.Database;

public class reservationService {
	public JSONArray getMovieList() throws Exception {
		JSONArray movieList = new JSONArray();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select title from movie";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				movieList.add(rs.getString("title"));
			}
			return movieList;
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
}
