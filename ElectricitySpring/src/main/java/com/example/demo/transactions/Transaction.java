package com.example.demo.transactions;

public class Transaction {
	String tnxId;
	String meterNo;
	String mobileBanking;
	String phone;
	double totalBill;
	String month;
	String year;
	public Transaction() {
		super();
	}
	public Transaction(String tnxId, String meterNo, String mobileBanking, String phone, double totalBill, String month,
			String year) {
		super();
		this.tnxId = tnxId;
		this.meterNo = meterNo;
		this.mobileBanking = mobileBanking;
		this.phone = phone;
		this.totalBill = totalBill;
		this.month = month;
		this.year = year;
	}
	public String getTnxId() {
		return tnxId;
	}
	public void setTnxId(String tnxId) {
		this.tnxId = tnxId;
	}
	public String getMeterNo() {
		return meterNo;
	}
	public void setMeterNo(String meterNo) {
		this.meterNo = meterNo;
	}
	public String getMobileBanking() {
		return mobileBanking;
	}
	public void setMobileBanking(String mobileBanking) {
		this.mobileBanking = mobileBanking;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public double getTotalBill() {
		return totalBill;
	}
	public void setTotalBill(double totalBill) {
		this.totalBill = totalBill;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

}
