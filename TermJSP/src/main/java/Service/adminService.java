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
	
	
	
	
}
