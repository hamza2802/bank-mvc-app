package com.techlabs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.techlabs.entity.Account;
import com.techlabs.entity.Transaction;

public class TransactionService {

	private DbService dbService;

	public TransactionService(DbService dbService) {
		this.dbService = dbService;
	}

	public List<Transaction> getAllTransactions() throws SQLException {
		List<Transaction> transactions = new ArrayList<>();
		String query = "SELECT transaction_id, sender_account, receiver_account, transaction_type, amount, date "
				+ "FROM transaction ORDER BY date DESC";

		try (Connection conn = dbService.connectToDb();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				int transactionId = rs.getInt("transaction_id");
				int senderAccount = rs.getInt("sender_account");
				int receiverAccount = rs.getInt("receiver_account");
				String transactionType = rs.getString("transaction_type");
				double amount = rs.getDouble("amount");
				String date = rs.getString("date");

				Transaction transaction = new Transaction(transactionId, senderAccount, receiverAccount,
						transactionType, amount, date);

				transactions.add(transaction);
			}
		}

		return transactions;
	}

	public List<Transaction> searchTransactions(String searchQuery) throws SQLException {
		List<Transaction> transactions = new ArrayList<>();
		String query = "SELECT transaction_id, sender_account, receiver_account, transaction_type, amount, date "
				+ "FROM transaction WHERE transaction_id LIKE ? OR sender_account LIKE ? OR receiver_account LIKE ? "
				+ "ORDER BY date DESC";

		try (Connection conn = dbService.connectToDb(); PreparedStatement stmt = conn.prepareStatement(query)) {

			String searchPattern = "%" + searchQuery + "%";

			stmt.setString(1, searchPattern);
			stmt.setString(2, searchPattern);
			stmt.setString(3, searchPattern);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				int transactionId = rs.getInt("transaction_id");
				int senderAccount = rs.getInt("sender_account");
				int receiverAccount = rs.getInt("receiver_account");
				String transactionType = rs.getString("transaction_type");
				double amount = rs.getDouble("amount");
				String date = rs.getString("date");

				Transaction transaction = new Transaction(transactionId, senderAccount, receiverAccount,
						transactionType, amount, date);

				transactions.add(transaction);
			}
		}

		return transactions;
	}

	public List<Transaction> getTransactionsByCustomerId(int customerId) {
		List<Transaction> transactions = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String query = "SELECT t.transaction_id, t.sender_account, t.receiver_account, t.transaction_type, t.amount, t.date "
				+ "FROM transaction t " + "JOIN account a_sender ON t.sender_account = a_sender.account_number "
				+ "JOIN account a_receiver ON t.receiver_account = a_receiver.account_number "
				+ "WHERE a_sender.cust_id = ? OR a_receiver.cust_id = ? " + "ORDER BY t.date DESC";

		try {
			conn = dbService.connectToDb();
			if (conn == null) {
				System.out.println("Database connection failed.");
				return transactions;
			}

			stmt = conn.prepareStatement(query);
			stmt.setInt(1, customerId);
			stmt.setInt(2, customerId);

			rs = stmt.executeQuery();

			while (rs.next()) {
				int transactionId = rs.getInt("transaction_id");
				int senderAccount = rs.getInt("sender_account");
				int receiverAccount = rs.getInt("receiver_account");
				String transactionType = rs.getString("transaction_type");
				double amount = rs.getDouble("amount");
				String date = rs.getString("date");

				Transaction transaction = new Transaction(transactionId, senderAccount, receiverAccount,
						transactionType, amount, date);
				transactions.add(transaction);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					dbService.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return transactions;
	}

	public List<Account> getAccountsForCustomer(int customerId) {
		List<Account> accounts = new ArrayList<>();
		Connection connection = null;

		try {
			connection = dbService.connectToDb();
			if (connection == null) {
				System.out.println("Database connection failed.");
				return accounts;
			}

			String sql = "SELECT account_number FROM account WHERE cust_id = ?";
			try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
				preparedStatement.setInt(1, customerId);
				ResultSet resultSet = preparedStatement.executeQuery();

				while (resultSet.next()) {
					Account account = new Account();
					account.setAccountNumber(resultSet.getInt("account_number"));
					accounts.add(account);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbService.closeConnection();
		}

		return accounts;
	}

	public boolean creditAccount(int accountNumber, double amount) {
		Connection connection = null;
		boolean success = false;

		try {
			connection = dbService.connectToDb();
			if (connection == null) {
				System.out.println("Database connection failed.");
				return false;
			}

			connection.setAutoCommit(false);

			String creditSql = "UPDATE account SET balance = balance + ? WHERE account_number = ?";
			try (PreparedStatement creditStmt = connection.prepareStatement(creditSql)) {
				creditStmt.setDouble(1, amount);
				creditStmt.setInt(2, accountNumber);
				int rowsUpdated = creditStmt.executeUpdate();
				if (rowsUpdated != 1) {
					connection.rollback();
					return false;
				}
			}

			String transactionSql = "INSERT INTO transaction (sender_account, receiver_account, transaction_type, amount) "
					+ "VALUES (?, ?, 'Credit', ?)";
			try (PreparedStatement transactionStmt = connection.prepareStatement(transactionSql)) {
				transactionStmt.setInt(1, accountNumber);
				transactionStmt.setInt(2, accountNumber);
				transactionStmt.setDouble(3, amount);
				transactionStmt.executeUpdate();
			}

			connection.commit();
			success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (connection != null) {
					connection.setAutoCommit(true);
					dbService.closeConnection();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return success;
	}

	public boolean debitAccount(int accountNumber, double amount) {
		Connection connection = null;
		boolean success = false;

		try {
			connection = dbService.connectToDb();
			if (connection == null) {
				System.out.println("Database connection failed.");
				return false;
			}

			connection.setAutoCommit(false);

			String debitSql = "UPDATE account SET balance = balance - ? WHERE account_number = ?";
			try (PreparedStatement debitStmt = connection.prepareStatement(debitSql)) {
				debitStmt.setDouble(1, amount);
				debitStmt.setInt(2, accountNumber);
				int rowsUpdated = debitStmt.executeUpdate();
				if (rowsUpdated != 1) {
					connection.rollback();
					return false;
				}
			}
			String transactionSql = "INSERT INTO transaction (sender_account, receiver_account, transaction_type, amount) "
					+ "VALUES (?, ?, 'Debit', ?)";
			try (PreparedStatement transactionStmt = connection.prepareStatement(transactionSql)) {
				transactionStmt.setInt(1, accountNumber);
				transactionStmt.setInt(2, accountNumber);
				transactionStmt.setDouble(3, amount);
				transactionStmt.executeUpdate();
			}
			connection.commit();
			success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (connection != null) {
					connection.setAutoCommit(true);
					dbService.closeConnection();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return success;
	}

	public boolean transferFunds(int senderAccountNumber, int receiverAccountNumber, double amount) {
		Connection connection = null;
		boolean success = false;

		try {
			connection = dbService.connectToDb();
			if (connection == null) {
				System.out.println("Database connection failed.");
				return false;
			}

			connection.setAutoCommit(false);

			String debitSql = "UPDATE account SET balance = balance - ? WHERE account_number = ?";
			try (PreparedStatement debitStmt = connection.prepareStatement(debitSql)) {
				debitStmt.setDouble(1, amount);
				debitStmt.setInt(2, senderAccountNumber);
				int senderRowsUpdated = debitStmt.executeUpdate();
				if (senderRowsUpdated != 1) {
					connection.rollback();
					return false;
				}
			}

			String creditSql = "UPDATE account SET balance = balance + ? WHERE account_number = ?";
			try (PreparedStatement creditStmt = connection.prepareStatement(creditSql)) {
				creditStmt.setDouble(1, amount);
				creditStmt.setInt(2, receiverAccountNumber);
				int receiverRowsUpdated = creditStmt.executeUpdate();
				if (receiverRowsUpdated != 1) {
					connection.rollback();
					return false;
				}
			}
			String senderTransactionSql = "INSERT INTO transaction (sender_account, receiver_account, transaction_type, amount) "
					+ "VALUES (?, ?, 'Debit', ?)";
			try (PreparedStatement senderTransactionStmt = connection.prepareStatement(senderTransactionSql)) {
				senderTransactionStmt.setInt(1, senderAccountNumber);
				senderTransactionStmt.setInt(2, receiverAccountNumber);
				senderTransactionStmt.setDouble(3, amount);
				senderTransactionStmt.executeUpdate();
			}
			String receiverTransactionSql = "INSERT INTO transaction (sender_account, receiver_account, transaction_type, amount) "
					+ "VALUES (?, ?, 'Credit', ?)";
			try (PreparedStatement receiverTransactionStmt = connection.prepareStatement(receiverTransactionSql)) {
				receiverTransactionStmt.setInt(1, senderAccountNumber); // sender account
				receiverTransactionStmt.setInt(2, receiverAccountNumber); // receiver account
				receiverTransactionStmt.setDouble(3, amount);
				receiverTransactionStmt.executeUpdate();
			}

			connection.commit();
			success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (connection != null) {
					connection.setAutoCommit(true);
					dbService.closeConnection();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return success;
	}

}
