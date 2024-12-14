package com.techlabs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.techlabs.entity.Customer;

public class CustomerService {

	private Customer customer;
	private DbService dbService;

	public CustomerService(Customer customer, DbService dbService) {
		this.customer = customer;
		this.dbService = dbService;
	}

	public CustomerService(DbService dbService2) {
		super();
		if (this.dbService == null) {
			this.dbService = new DbService();
		}
	}

	public CustomerService() {
		// TODO Auto-generated constructor stub
	}

	public boolean addCustomer() {
		boolean isAdded = false;
		Connection connection = null;

		try {
			connection = dbService.connectToDb();
			if (connection == null) {
				System.out.println("Database connection failed.");
				return false;
			}

			String sql = "INSERT INTO customer (id, firstname, lastname, email, password) VALUES (?, ?, ?, ?, ?)";
			System.out.println("Executing SQL: " + sql);
			try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
				preparedStatement.setInt(1, customer.getId());
				preparedStatement.setString(2, customer.getFirstname());
				preparedStatement.setString(3, customer.getLastname());
				preparedStatement.setString(4, customer.getEmail());
				preparedStatement.setString(5, customer.getPassword());

				System.out.println("Prepared Statement: " + preparedStatement.toString());

				int rowsAffected = preparedStatement.executeUpdate();
				if (rowsAffected > 0) {
					System.out.println("Customer added successfully!");
					isAdded = true;
				} else {
					System.out.println("No rows affected. Customer addition failed.");
				}
			}
		} catch (SQLException e) {
			System.out.println("Error while adding customer:");
			e.printStackTrace();
		} finally {
			try {
				if (connection != null && !connection.isClosed()) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return isAdded;
	}

	public Customer getCustomerDetails(int customerId) {
		Customer customer = null;
		Connection connection = dbService.connectToDb();

		String sql = "SELECT * FROM customer WHERE id = ?";

		try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setInt(1, customerId);

			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				customer = new Customer(resultSet.getInt("id"), resultSet.getString("firstname"),
						resultSet.getString("lastname"), resultSet.getString("email"), resultSet.getString("password")

				);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return customer;
	}
	 public Customer verifyCustomerCredentials(Connection connection, String email, String password)
	            throws SQLException {
	        Customer customer = null;
	        String query = "SELECT * FROM customer WHERE email = ? AND password = ?";

	        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
	            preparedStatement.setString(1, email);
	            preparedStatement.setString(2, password);

	            ResultSet resultSet = preparedStatement.executeQuery();

	            if (resultSet.next()) {
	                int id = resultSet.getInt("id");
	                String firstname = resultSet.getString("firstname");
	                String lastname = resultSet.getString("lastname");
	                customer = new Customer(id, firstname, lastname, email, password);
	            }
	        }
	        return customer;
	    }

	public void updateFirstName(int customerID, String newFirstName) throws SQLException {
		Customer customer = null;
		Connection connection = dbService.connectToDb();
		String query = "UPDATE customer SET firstname = ? WHERE id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, newFirstName);
			ps.setInt(2, customerID);
			ps.executeUpdate();
		}
	}

	public void updateLastName(int customerID, String newLastName) throws SQLException {

		Customer customer = null;
		Connection connection = dbService.connectToDb();
		String query = "UPDATE customer SET lastname = ? WHERE id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, newLastName);
			ps.setInt(2, customerID);
			ps.executeUpdate();
		}
	}

	public void updatePassword(int customerID, String newPassword) throws SQLException {

		Customer customer = null;
		Connection connection = dbService.connectToDb();

		String query = "UPDATE customer SET password = ? WHERE id = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, newPassword);
			ps.setInt(2, customerID);
			ps.executeUpdate();
		}
	}
}
