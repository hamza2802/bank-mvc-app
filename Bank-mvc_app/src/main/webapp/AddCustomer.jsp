<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer</title>
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

        .logout-btn {
            background-color: #ff4d4d;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #e04f50;
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
            font-size: 1.8rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Main Content (Add Customer Form) -->
    <div class="container">
        <div class="form-container">
            <h3 class="custom-header mb-4">Add New Customer</h3>

            <!-- Success or Error Message (Only display if the message is present) -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    ${successMessage}
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Add Customer Form -->
            <form id="addCustomerForm" action="AddCustomerController" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label">Customer ID</label>
                    <input type="number" class="form-control" id="id" name="id" required>
                </div>
                <div class="mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                </div>
                <div class="mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary">Add Customer</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Show alert and redirect if there is a success message
            <c:if test="${not empty successMessage}">
                alert("${successMessage}");
                
                // Redirect to Admin Dashboard after the alert
                setTimeout(function() {
                    window.location.href = 'AdminDashboard.jsp'; // Adjust the path if necessary
                }, 2000); // Redirect after 2 seconds
            </c:if>
        });
    </script>

</body>
</html>
