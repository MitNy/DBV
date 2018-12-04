package Service;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Dao.Database;
import Dao.nameGetter;

public class reservationService {// 랜덤한 reserv_number 생성
	public String genReservNumber() {
		SecureRandom random = new SecureRandom ();
		int numLength = 11;
		String randomStr = "";

		for (int i = 0; i < numLength; i++) {
			randomStr += random.nextInt(10);
		}
		return randomStr;
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
			ps.close();
			rs.close();
			conn.close();
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
			String addQuery = "insert into pay (payID,userID,date,howmany,point,usePoint,totalPrice) values (?,?,?,?,?,?,?)";
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
	
	public int getHowmany(String reserv_number) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select howmany from reservation where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, reserv_number);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int howmany = rs.getInt("howmany");
			ps.close();
			rs.close();
			conn.close();
			return howmany;
		}
		catch(Exception e ) {
			
		}
		return 0;
	}
	
	public String getUserID(String reserv_number) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select userID from reservation where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, reserv_number);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String userID = rs.getString("userID");
			ps.close();
			rs.close();
			conn.close();
			return userID;
		}
		catch(Exception e ) {
			
		}
		return null;
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
			String payID = "PAY-"+reserv_number;
			String ticketID = "TK-"+reserv_number;
			
			String addQuery = "insert into reservation (reserv_number,userID,title,howmany,theaterName,seat,date,time,TF,payID,ticketID) values(?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(addQuery);
			ps.setString(1, reserv_number);
			ps.setString(2, userID);
			ps.setString(3, movieName);
			ps.setInt(4, int_seats);
			ps.setString(5, theaterName);
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
	
	public JSONArray getReservation(String userID) throws Exception {
		nameGetter ng = new nameGetter();
		JSONArray theaterList = new JSONArray();
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select reserv_number,title,howmany,theaterName,seat,date,time,TF from reservation where userID=? order by date desc";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, userID);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				theater.put("reservNumber-"+i,rs.getString("reserv_number"));
				theater.put("movie-"+i,rs.getString("title"));
				theater.put("howmany-"+i,rs.getInt("howmany"));
				theater.put("theater-"+i,rs.getString("theaterName"));
				theater.put("seat-"+i, rs.getString("seat"));
				theater.put("date-"+i,rs.getString("date"));
				theater.put("time-"+i,rs.getString("time"));
				theater.put("TF-"+i, rs.getString("TF"));
				theaterList.add(theater);
				i++;
			}
			ps.close();
			rs.close();
			conn.close();
			return theaterList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	

	public JSONObject getSpecificReservation(String reserv_number) throws Exception {
		nameGetter ng = new nameGetter();
		JSONArray theaterList = new JSONArray();
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select title,theaterName,seat,date,time,payID,ticketID from reservation where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, reserv_number);
			String ticketID = "";
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				theater.put("movieName",rs.getString("title"));
				theater.put("theaterName",rs.getString("theaterName"));
				theater.put("seats", rs.getString("seat"));
				theater.put("date",rs.getString("date"));
				theater.put("time",rs.getString("time"));
				theater.put("payID", rs.getString("payID"));
				theater.put("ticketID", rs.getString("ticketID"));
				ticketID = rs.getString("ticketID");
			}
			setTicket(reserv_number, ticketID);
			ps.close();
			rs.close();
			conn.close();
			return theater;
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public JSONArray getAllReservation() throws Exception {
		JSONArray theaterList = new JSONArray();
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select * from reservation order by date desc";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ResultSet rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				theater.put("reservNumber-"+i,rs.getString("reserv_number"));
				theater.put("user-"+i,rs.getString("userID"));
				theater.put("movie-"+i,rs.getString("title"));
				theater.put("howmany-"+i,rs.getInt("howmany"));
				theater.put("theater-"+i,rs.getString("theaterName"));
				theater.put("seat-"+i, rs.getString("seat"));
				theater.put("date-"+i,rs.getString("date"));
				theater.put("time-"+i,rs.getString("time"));
				theater.put("TF-"+i, rs.getString("TF"));
				theaterList.add(theater);
				i++;
			}
			ps.close();
			rs.close();
			conn.close();
			return theaterList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
	public boolean cancelReservation(String reserv_number) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String deleteQuery = "delete from reservation where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(deleteQuery);
			ps.setString(1, reserv_number);
			int howmany = getHowmany(reserv_number);
			String userID = getUserID(reserv_number);
			subPoint(userID, howmany*100);
			deleteTicket(reserv_number);
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
	
	public void setTicket(String reserv_number, String ticketID) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String insertQuery = "insert into ticket (ticketID,reserv_number) values(?,?)";
		
			PreparedStatement ps = conn.prepareStatement(insertQuery);
			ps.setString(1, ticketID);
			ps.setString(2, reserv_number);
			ps.executeUpdate();
			
			ps.close();
			conn.close();
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
	}
	
	public boolean isTicket(String reserv_number) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select ticketID from ticket where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, reserv_number);
			ResultSet rs = ps.executeQuery();
			ps.close();
			rs.close();
			conn.close();
			return rs.isBeforeFirst();
		}
		catch(Exception e ) {
			
		}
		return false;
	}
	
	public JSONObject getSpecificTicket(String reserv_number) throws Exception {
		nameGetter ng = new nameGetter();
		JSONArray theaterList = new JSONArray();
		JSONObject theater = new JSONObject();
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select title,theaterName,seat,date,time,payID,ticketID from reservation where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, reserv_number);
			String ticketID = "";
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				theater.put("movieName",rs.getString("title"));
				theater.put("theaterName",rs.getString("theaterName"));
				theater.put("seats", rs.getString("seat"));
				theater.put("date",rs.getString("date"));
				theater.put("time",rs.getString("time"));
				theater.put("payID", rs.getString("payID"));
				theater.put("ticketID", rs.getString("ticketID"));
				ticketID = rs.getString("ticketID");
			}
			ps.close();
			rs.close();
			conn.close();
			return theater;
		}
		catch(Exception e ) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public void deleteTicket(String reserv_number) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String deleteQuery = "delete from ticket where reserv_number=?";
			PreparedStatement ps = conn.prepareStatement(deleteQuery);
			ps.setString(1, reserv_number);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e) {
			System.out.print(e.getMessage());
		}
	}
	
	public void deleteReservationWithUserID(String id) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String deleteQuery = "delete from reservation where userID=?";
			PreparedStatement ps = conn.prepareStatement(deleteQuery);
			ps.setString(1, id);
			ps.executeUpdate();
			ps.close();
			conn.close();
		}
		catch(Exception e) {
			System.out.print(e.getMessage());
		}
	}
	
	public JSONArray getSelectedSeats(String movieName, String theaterName,String date, String time) throws Exception {
		Database dbCon = new Database();
		Connection conn = dbCon.GetConnection();
		try {
			String getQuery="select seat from reservation where title=? and theaterName=? and date=? and time=?";
			JSONArray seatList = new JSONArray();
			String seatValue = "";
			PreparedStatement ps = conn.prepareStatement(getQuery);
			ps.setString(1, movieName);
			ps.setString(2, theaterName);
			ps.setString(3, date);
			ps.setString(4, time);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				seatValue += rs.getString("seat").toString()+",";
			}
			String[] splitList = seatValue.split(" ,");
			for( int i=0; i<splitList.length; i++ ) {
				seatList.add(splitList[i]);
			}
			ps.close();
			rs.close();
			conn.close();
			return seatList;
		}
		catch(Exception e ) {
			
		}
		return null;
	}
	
}
