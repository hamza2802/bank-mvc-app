<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.techlabs.entity.Customer"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Bank Account</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #AE275F;
            --card-bg: #ffffff;
            --text-color: #333;
            --footer-bg: #f4f7fa;
        }

        body {
            background-color: var(--footer-bg);
            font-family: 'Inter', sans-serif;
        }

        .container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding-bottom: 50px;
        }

        .form-container {
            background-color: var(--card-bg);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border: none;
        }

        .btn-primary:hover {
            background-color: #9d1f4b;
        }

        footer {
            position: relative;
            bottom: 0;
            width: 100%;
            background-color: var(--footer-bg);
            padding: 20px;
            text-align: center;
            color: #777;
            font-size: 14px;
        }

        .custom-header {
            color: var(--primary-color);
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h3 class="custom-header mb-4">Add New Bank Account</h3>

            <!-- Search for Customer by ID -->
            <form action="AddBankAccountController" method="get">
                <div class="mb-3">
                    <label for="customerIdSearch" class="form-label">Customer ID</label>
                    <input type="number" class="form-control" id="customerIdSearch" name="customerIdSearch" required>
                </div>
                <button type="submit" class="btn btn-primary">Search Customer</button>
            </form>

            <%
                // Retrieve customer data if set by controller
                Customer customer = (Customer) request.getAttribute("customer");
                if (customer != null) {
            %>
            <div id="addBankAccountContent" class="content-section">

                <!-- Display Customer Details -->
                <div id="customerDetails">
                    <h5>Customer Details:</h5>
                    <p><span class="customer-field">Name:</span> <%= customer.getFirstname() %> <%= customer.getLastname() %></p>
                    <p><span class="customer-field">Email:</span> <%= customer.getEmail() %></p>
                </div>

                <!-- Add Bank Account Form -->
                <form action="AddBankAccountController" method="post">
                    <div class="mb-3">
                        <label for="accountNumber" class="form-label">Account Number</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" value="<%= request.getAttribute("accountNumber") != null ? request.getAttribute("accountNumber").toString() : "" %>" readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="accountType" class="form-label">Account Type</label>
                        <select class="form-select" id="accountType" name="accountType" required>
                            <option value="">Select Account Type</option>
                            <option value="Savings">Savings</option>
                            <option value="Current">Current</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="balance" class="form-label">Balance</label>
                        <input type="number" class="form-control" id="balance" name="balance" value="10000" required>
                    </div>

                    <!-- Hidden customerId to submit -->
                    <input type="hidden" name="customerId" value="<%= customer.getId() %>">

                    <button type="submit" class="btn btn-primary">Add Bank Account</button>
                </form>
            </div>

            <script>
                document.getElementById('addBankAccountContent').style.display = 'block';
            </script>
            <%
                } else {
            %>
         
            <%
                }
            %>

        </div>
    </div>

    <!-- Check for success message and show browser alert -->
    <script>
        <% if (request.getAttribute("successMessage") != null) { %>
            // Show the success alert
            alert("<%= request.getAttribute("successMessage") %>");
            // Redirect to Admin Dashboard after 2 seconds
            setTimeout(function() {
                window.location.href = "AdminDashboard.jsp"; // Redirect to your admin dashboard page
            }, 2000);
        <% } %>
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
