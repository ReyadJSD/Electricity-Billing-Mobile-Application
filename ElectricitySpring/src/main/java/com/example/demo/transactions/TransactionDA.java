package com.example.demo.transactions;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class TransactionDA {
	Connection con;
	PreparedStatement pst;
	public Transaction getTrnxIdFlutter(String meterNo, String month, String year) {
		Transaction p = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring_project", "root", "nh123456");
			pst = con.prepareStatement("SELECT * FROM flutter_transection WHERE meter_no = ? AND month = ? AND year = ?");
			pst.setString(1, meterNo);
			pst.setString(2, month);
			pst.setString(3, year);
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				p = new Transaction();
				p.setTnxId(rs.getString(1));
				p.setMeterNo(rs.getString(2));
				p.setMobileBanking(rs.getString(3));
				p.setPhone(rs.getString(4));
				p.setTotalBill(rs.getDouble(5));
				p.setMonth(rs.getString(6));
				p.setYear(rs.getString(7));
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return p;
	}
}
