package com.techlabs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.techlabs.entity.Admin;

public class AdminService {

	private Admin admin;
	private DbService dbService;

	public AdminService(Admin admin, DbService dbService) {
		this.admin = admin;
		this.dbService = dbService;
	}

	public AdminService() {
		// TODO Auto-generated constructor stub
	}

	public boolean addAdmin() {
		boolean isAdded = false;
		Connection connection = null;

		try {
			connection = dbService.connectToDb();
			if (connection == null) {
				System.out.println("Database connection failed.");
				return false;
			}

			String sql = "INSERT INTO admin VALUES (?, ?, ?)";
			System.out.println("Executing SQL: " + sql);

			try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
				preparedStatement.setInt(1, admin.getAdminId());
				preparedStatement.setString(2, admin.getAdminName());
				preparedStatement.setString(3, admin.getPassword());

				System.out.println("Prepared Statement: " + preparedStatement.toString());

				int rowsAffected = preparedStatement.executeUpdate();
				if (rowsAffected > 0) {
					System.out.println("Admin added successfully!");
					isAdded = true;
				} else {
					System.out.println("No rows affected. Admin registration failed.");
				}
			}
		} catch (SQLException e) {
			System.out.println("Error while adding admin:");
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
	
	public Admin verifyAdminCredentials(Connection connection, String adminId, String password) throws SQLException {
        Admin admin = null;
        String query = "SELECT * FROM admin WHERE id = ? AND password = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, adminId);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String adminName = resultSet.getString("name");
                admin = new Admin(id, adminName, password);
            }
        }
        return admin;
    }

}
