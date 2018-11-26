package Service;
import java.security.SecureRandom;
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
	
	// 랜덤한 reserv_number 생성
	public String genReservNumber() {
		SecureRandom random = new SecureRandom ();
		int numLength = 11;
		String randomStr = "";

		for (int i = 0; i < numLength; i++) {
			randomStr += random.nextInt(10);
		}
		return randomStr;
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
	public int getUserPoint(String userID) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select point from customer where id=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, userID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int point = rs.getInt("point");
			return point;
		}
		catch(Exception e ) {
			
		}
		return 0;
	}
	
	
	public void savePoint(String userID,int ticketNumber) throws Exception {
		int point = getUserPoint(userID);
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String editQuery = "update customer set point=? where id=?";
			PreparedStatement ps = conn.prepareStatement(editQuery);
			ps.setInt(1, point+(100*ticketNumber));
			ps.setString(2, userID);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	public void subPoint(String userID,int usedPoint) throws Exception {
		
		int point = getUserPoint(userID);
		int updatedPoint = point-usedPoint;
		System.out.print("saved point: "+point);
		System.out.print(usedPoint);
		System.out.print(updatedPoint);
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String editQuery = "update customer set point=? where id=?";
			PreparedStatement ps = conn.prepareStatement(editQuery);
			ps.setInt(1, updatedPoint);
			ps.setString(2, userID);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	
	public void updatePay(String payID, String userID,String date,int ticketNumber,String usePoint,int usedPoint,int totalPrice) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		int point = getUserPoint(userID);
		try {
			String addQuery = "insert into pay (pay_number,customer,date,howmany,point,usePoint,totalPrice) values (?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, payID);
			ps.setString(2, userID);
			ps.setString(3, date);
			ps.setInt(4, ticketNumber);
			ps.setInt(5, usedPoint);
			ps.setString(6, usePoint);
			ps.setInt(7, totalPrice);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	
	
	
	public boolean reservation(String userID,String movieName,String theaterName,
		String date, String time, String seats, String ticketNumber, String usePoint,String usedPoint, String totalPrice) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			int int_seats = Integer.parseInt(ticketNumber);
			int int_point = Integer.parseInt(usedPoint);
			int int_price = Integer.parseInt(totalPrice);
			String reserv_number = genReservNumber();  // reserv_number 생성
			String movieID = getMovieID(movieName);
			String theaterID = getTheaterID(theaterName);
			String payID = "PAY-"+reserv_number;
			String ticketID = "TK-"+reserv_number;
			
			String addQuery = "insert into reservation (reserv_number,customerID,movieID,howmany,theaterID,seat,date,time,TF,pay_number,ticketID) values(?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, reserv_number);
			ps.setString(2, userID);
			ps.setString(3, movieID);
			ps.setInt(4, int_seats);
			ps.setString(5, theaterID);
			ps.setString(6, seats);
			ps.setString(7, date);
			ps.setString(8, time);
			ps.setString(9, "T");
			ps.setString(10, payID);
			ps.setString(11,ticketID);
			
			ps.executeUpdate();
			updatePay(payID,userID,date,int_seats,usePoint,int_point,int_price);
			if( usePoint.equals("T")) {
				subPoint(userID,int_point);
			}
			savePoint(userID,int_seats);
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
