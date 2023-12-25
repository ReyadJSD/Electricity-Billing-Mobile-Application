package com.example.demo.customersBillPayment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.demo.customerDashboard.MonthChart;

public class PayBillDA {
	Connection con;
	PreparedStatement pst;
    
	public PayBill insertTxn(PayBill p) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring_project", "root", "nh123456");
			pst = con.prepareStatement("INSERT INTO transactions VALUES(?,?,?,?)");
			pst.setString(1, p.tnxId);
			pst.setString(2, p.meterNo);
			pst.setString(3, p.phone);
			pst.setDouble(4, p.totalBill);
			int x = pst.executeUpdate();
			if(x != -1) {
				return p;
			}
			con.close();
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	
	//Pay Bill Method For Flutter Application
	
	public PayBill insertTxnForFlutter(PayBill p) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring_project", "root", "nh123456");
			pst = con.prepareStatement("INSERT INTO flutter_transection VALUES(?,?,?,?,?,?,?)");
			pst.setString(1, p.tnxId);
			pst.setString(2, p.meterNo);
			pst.setString(3, p.mobileBanking);
			pst.setString(4, p.phone);
			pst.setDouble(5, p.totalBill);
			pst.setString(6, p.month);
			pst.setString(7, p.year);
			int x = pst.executeUpdate();
			if(x != -1) {
				return p;
			}
			con.close();
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	// Get Transaction Id for Flutter Application
	
//	public PayBill getTrnxIdFlutter(String meterNo, String month, String year) {
//		PayBill p = null;
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring_project", "root", "nh123456");
//			pst = con.prepareStatement("SELECT * FROM flutter_transection WHERE meter_no = ? AND month = ? AND year = ?");
//			pst.setString(1, meterNo);
//			pst.setString(2, month);
//			pst.setString(3, year);
//			ResultSet rs = pst.executeQuery();
//			while(rs.next()) {
//				p = new PayBill();
//				p.setTnxId(rs.getString(1));
//			}
//		}catch(Exception e) {
//			System.out.println(e);
//		}
//		return p;
//	}

}
