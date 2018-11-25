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
	
	public JSONArray getMovie() throws Exception {
		//List<String> movieList = new ArrayList<String>();
		JSONArray movieList = new JSONArray();
		JSONObject movie = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select * from movie";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				movie.put("movieID-"+i,rs.getString("movieID"));
				movie.put("director-"+i,rs.getString("director"));
				movie.put("movieTitle-"+i,rs.getString("title"));
				movie.put("cast-"+i,rs.getString("cast"));
				movie.put("grade-"+i,rs.getInt("grade"));
				movie.put("information-"+i,rs.getString("information"));
				movieList.add(movie);
				i++;
			}
			return movieList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
}
