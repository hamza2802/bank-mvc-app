package com.techlabs.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbService {

    private Connection connection = null;

    public Connection connectToDb() {	
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankmvc_app", "root", "root");
            System.out.println("Connection Successful.");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connection closed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
