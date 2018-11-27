package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Dao.Database;

public class movieService {
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
	
	public String getMovieID(String movieName) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select movieID from movie where title=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, movieName);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String movieID = rs.getString("movieID");
			return movieID;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public boolean deleteMovie(String movieName) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String deleteQuery = "delete from movie where title=?";
			PreparedStatement ps = conn.prepareStatement(deleteQuery);
			ps.setString(1, movieName);
			ps.executeUpdate();
			
			return true;
		}
		catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return false;
	}
	
	public boolean editMovie(String originID, String movieID,String movieTitle, String director,
			String cast, String grade, String information ) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		int int_grade = Integer.parseInt(grade);
		try {
			String editQuery = "update movie set movieID=?,director=?,title=?,cast=?,grade=?,information=? where movieID=?";
			PreparedStatement ps = conn.prepareStatement(editQuery);
			ps.setString(1,movieID);
			ps.setString(2, director);
			ps.setString(3, movieTitle);
			ps.setString(4, cast);
			ps.setInt(5, int_grade);
			ps.setString(6, information);
			ps.setString(7, originID);
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
