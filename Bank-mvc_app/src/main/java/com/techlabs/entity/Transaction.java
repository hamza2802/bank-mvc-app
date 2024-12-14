package com.techlabs.entity;

public class Transaction {

	public Transaction() {
		super();
	}

	private int transactionId;
	private int senderAccount;
	private int receiverAccount;
	private String transactionType;
	private double amount;
	private String date;

	public Transaction(int transactionId, int senderAccount, int receiverAccount, String transactionType, double amount,
			String date) {
		super();
		this.transactionId = transactionId;
		this.senderAccount = senderAccount;
		this.receiverAccount = receiverAccount;
		this.transactionType = transactionType;
		this.amount = amount;
		this.date = date;
	}

	public int getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
	}

	public int getSenderAccount() {
		return senderAccount;
	}

	public void setSenderAccount(int senderAccount) {
		this.senderAccount = senderAccount;
	}

	public int getReceiverAccount() {
		return receiverAccount;
	}

	public void setReceiverAccount(int receiverAccount) {
		this.receiverAccount = receiverAccount;
	}

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
