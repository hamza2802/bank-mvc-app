package com.techlabs.entity;

public class Account {

	private int accountNumber;
	private String accountType;
	private int customerId;
	private double balance = 10000;

	public Account(int accountNumber, String accountType, int customerId, double balance, String customerFirstName,
			String customerLastName) {
		super();
		this.accountNumber = accountNumber;
		this.accountType = accountType;
		this.customerId = customerId;
		this.balance = balance;
		this.customerFirstName = customerFirstName;
		this.customerLastName = customerLastName;
	}

	private String customerFirstName;
	private String customerLastName;

	public Account(int accountNumber) {
		super();
		this.accountNumber = accountNumber;
	}

	public Account() {
		super();
	}

	public Account(int accountNumber, String accountType, int customerId, double balance) {
		this.accountNumber = accountNumber;
		this.accountType = accountType;
		this.customerId = customerId;
		this.balance = balance;
	}

	public int getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(int accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public String getCustomerFirstName() {
		return customerFirstName;
	}

	public void setCustomerFirstName(String customerFirstName) {
		this.customerFirstName = customerFirstName;
	}

	public String getCustomerLastName() {
		return customerLastName;
	}

	public void setCustomerLastName(String customerLastName) {
		this.customerLastName = customerLastName;
	}
}
