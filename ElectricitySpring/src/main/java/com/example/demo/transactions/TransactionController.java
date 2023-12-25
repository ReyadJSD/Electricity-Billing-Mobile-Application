package com.example.demo.transactions;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin (origins="http://localhost:4200")
@RestController
public class TransactionController {
	// Get Trnx Id For Flutter
		@GetMapping(value="/transactionIdForFlutter/{meterNo}/{month}/{year}")
		public Transaction transactionIdForFlutter(@PathVariable("meterNo") String meterNo, @PathVariable("month") String month, @PathVariable("year") String year) {
			Transaction pb;
			TransactionDA pbd = new TransactionDA();
			pb = pbd.getTrnxIdFlutter(meterNo, month, year);
			return pb;
		}
}
