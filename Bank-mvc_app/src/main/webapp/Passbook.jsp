<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passbook</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #AE275F;
            --card-bg: #ffffff;
            --text-color: #333;
            --footer-bg: #f4f7fa;
            --navbar-bg: var(--primary-color);
            --navbar-text-color: #fff;
            --navbar-text-hover: #f0c0d4;
        }

        body {
            background-color: var(--footer-bg);
            font-family: 'Inter', sans-serif;
        }

        /* Table Container */
        .table-container {
            margin-top: 20px;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Table Styling */
        .table {
            background-color: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            table-layout: fixed;
        }

        /* Table Header Styling */
        .table th {
            background-color: var(--primary-color);
            color: #fff;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
        }

        /* Table Content Styling */
        .table td {
            color: var(--text-color);
            text-align: center;
            vertical-align: middle;
            font-size: 14px;
        }

        /* Optional: Add some space if no transactions are available */
        .alert-warning {
            margin-top: 20px;
            text-align: center;
        }

        /* Footer Styling */
        footer {
            background-color: var(--footer-bg);
            padding: 20px;
            text-align: center;
            color: #777;
            font-size: 14px;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        /* Navbar Styling */
        .navbar {
            background-color: var(--navbar-bg);
            padding: 10px 30px;
        }

        .navbar-brand, .navbar-nav .nav-link {
            color: var(--navbar-text-color);
            font-weight: bold;
        }

        .navbar-brand:hover, .navbar-nav .nav-link:hover {
            color: var(--navbar-text-hover);
        }
    </style>
</head>

<body>

  

        <!-- Transaction History Table -->
        <div class="table-container">
            <c:if test="${not empty transactions}">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Transaction ID</th>
                            <th>Sender Account</th>
                            <th>Receiver Account</th>
                            <th>Transaction Type</th>
                            <th>Amount</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="transaction" items="${transactions}">
                            <tr>
                                <td>${transaction.transactionId}</td>
                                <td>${transaction.senderAccount}</td>
                                <td>${transaction.receiverAccount}</td>
                                <td>${transaction.transactionType}</td>
                                <td>${transaction.amount}</td>
                                <td>${transaction.date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty transactions}">
                <div class="alert alert-warning">
                    No transactions available.
                </div>
            </c:if>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Your Bank. All Rights Reserved.</p>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
