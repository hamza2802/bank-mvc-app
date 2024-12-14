package com.techlabs.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.techlabs.entity.Account;

public class AccountService {

	private DbService dbService;

	public AccountService(DbService dbService) {
		this.dbService = dbService;
	}

	public AccountService() {
		this.dbService = new DbService();
	}

	public boolean addAccount(Account account) {
		String query = "INSERT INTO account (account_number, account_type, cust_id, balance) VALUES (?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = dbService.connectToDb();
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, account.getAccountNumber());
			stmt.setString(2, account.getAccountType());
			stmt.setInt(3, account.getCustomerId());
			stmt.setDouble(4, account.getBalance());

			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			dbService.closeConnection();
		}
	}
	
	public List<Account> getFilteredAccounts(String searchQuery) {
	    List<Account> accounts = new ArrayList<>();
	    String query = "SELECT account.account_number, account.account_type, account.cust_id, account.balance, "
	                 + "customer.firstname, customer.lastname "
	                 + "FROM account "
	                 + "JOIN customer ON account.cust_id = customer.id "
	                 + "WHERE account.account_number LIKE ? OR account.cust_id LIKE ?";

	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        conn = dbService.connectToDb();  // Use DbService to get the connection
	        stmt = conn.prepareStatement(query);

	        // Prepare the search pattern with wildcards for SQL LIKE search
	        String searchPattern = "%" + searchQuery + "%";
	        stmt.setString(1, searchPattern);  // Set the search term for account number
	        stmt.setString(2, searchPattern);  // Set the search term for customer ID

	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            int accountNumber = rs.getInt("account_number");
	            String accountType = rs.getString("account_type");
	            int customerId = rs.getInt("cust_id");
	            double balance = rs.getDouble("balance");
	            String firstName = rs.getString("firstname");
	            String lastName = rs.getString("lastname");

	            // Map result set to Account object
	            Account account = new Account(accountNumber, accountType, customerId, balance);
	            account.setCustomerFirstName(firstName);
	            account.setCustomerLastName(lastName);

	            accounts.add(account);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // Close the database connection using DbService method
	        dbService.closeConnection();
	    }

	    return accounts;
	}


	public List<Account> getAllAccounts() {
		List<Account> accounts = new ArrayList<>();
		String query = "SELECT account.account_number, account.account_type, account.cust_id, account.balance, "
				+ "customer.firstname, customer.lastname " + "FROM account "
				+ "JOIN customer ON account.cust_id = customer.id ORDER BY account.cust_id";

		try (Connection conn = dbService.connectToDb();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				int accountNumber = rs.getInt("account_number");
				String accountType = rs.getString("account_type");
				int customerId = rs.getInt("cust_id");
				double balance = rs.getDouble("balance");
				String firstName = rs.getString("firstname");
				String lastName = rs.getString("lastname");

				Account account = new Account(accountNumber, accountType, customerId, balance);
				account.setCustomerFirstName(firstName);
				account.setCustomerLastName(lastName);

				accounts.add(account);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbService.closeConnection();
		}

		return accounts;
	}

	public Account getAccountById(int accountId) {
		String query = "SELECT * FROM account WHERE account_number = ?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbService.connectToDb();
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, accountId);

			rs = stmt.executeQuery();
			if (rs.next()) {
				return mapResultSetToAccount(rs);
			} else {
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			dbService.closeConnection();
		}
	}

	public List<Account> getAccountsByCustomerId(int customerId) {
		List<Account> accounts = new ArrayList<>();
		String query = "SELECT * FROM account WHERE cust_id = ?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbService.connectToDb();
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, customerId);

			rs = stmt.executeQuery();
			while (rs.next()) {
				accounts.add(mapResultSetToAccount(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbService.closeConnection();
		}
		return accounts;
	}

	public int generateRandomAccountNumber() {
		Random random = new Random();
		int accountNumber = 100000 + random.nextInt(900000);

		while (accountNumberExists(accountNumber)) {
			accountNumber = 100000 + random.nextInt(900000);
		}

		return accountNumber;
	}

	private boolean accountNumberExists(int accountNumber) {
		String query = "SELECT COUNT(*) FROM account WHERE account_number = ?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbService.connectToDb();
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, accountNumber);

			rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbService.closeConnection();
		}

		return false;
	}

	private Account mapResultSetToAccount(ResultSet rs) throws SQLException {
		int accountNumber = rs.getInt("account_number");
		String accountType = rs.getString("account_type");
		int customerId = rs.getInt("cust_id");
		double balance = rs.getDouble("balance");

		return new Account(accountNumber, accountType, customerId, balance);
	}
}
