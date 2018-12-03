package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Dao.Database;
import Dao.nameGetter;

public class errorService {
	public JSONObject error(String message) throws Exception {
		JSONObject theater = new JSONObject();
		theater.put("error", message);
		return theater;
	}
}
