package com.example.demo.customersBillPayment;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


@CrossOrigin (origins="http://localhost:4200")
@RestController
public class PayBillController {
	
	@PostMapping(value="/saveTxn")
	public PayBill saveTxn(@RequestBody PayBill p){
		PayBillDA pbd = new PayBillDA();
		return pbd.insertTxn(p);
	}
	
	//API For Flutter Application  Bill Payment
	
	@PostMapping(value="/saveTransectionFlutter")
	public PayBill saveTransectionFlutter(@RequestBody PayBill p){
		PayBillDA pbd = new PayBillDA();
		return pbd.insertTxnForFlutter(p);
	}
	
//	// Get Trnx Id For Flutter
//	@GetMapping(value="/transactionIdForFlutter/{meterNo}/{month}/{year}")
//	public PayBill transactionIdForFlutter(@PathVariable("meterNo") String meterNo, @PathVariable("month") String month, @PathVariable("year") String year) {
//		PayBill pb;
//		PayBillDA pbd = new PayBillDA();
//		pb = pbd.getTrnxIdFlutter(meterNo, month, year);
//		return pb;
//	}
}
