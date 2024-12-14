<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bank App - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        :root {
            --primary-color: #AE275F;
            --dark-bg: #f4f4f4;
            --card-bg: #ffffff;
            --text-color: #333;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--primary-color);
            color: var(--text-color);
        }

        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .login-card {
            background-color: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
            padding: 40px;
        }

        .app-title {
            text-align: center;
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 30px;
        }

        .form-select, .form-control {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            color: var(--text-color);
        }

        .form-select:focus, .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(174, 39, 95, 0.25);
        }

        .btn-login {
            background-color: var(--primary-color);
            border: none;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-login:hover {
            background-color: #8c1f4d;
        }

        .register-link {
            color: var(--primary-color);
        }

        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="app-title">Bank App</div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <form id="loginForm" action="LoginController" method="post">
                <div class="form-group mb-3">
                    <label for="role" class="form-label">Login as</label>
                    <select class="form-select" id="role" name="role" required>
                    	<option >-</option>
                        <option value="Admin">Admin</option>
                        <option value="Customer">Customer</option>
                    </select>
                </div>

                <div class="form-group mb-3">
                    <label for="username" class="form-label" id="usernameLabel">Admin ID</label>
                    <input type="number" class="form-control" id="adminId" name="adminId" placeholder="Enter Admin ID" required>
                    <input type="email" class="form-control" id="customerEmail" name="email" placeholder="Enter Customer Email" required style="display: none;">
                </div>

                <div class="form-group mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn btn-login btn-primary w-100">Login</button>
            </form>

            <div class="text-center mt-3">
                <a href="Registration.jsp" class="register-link">Register as Admin</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        const roleSelect = document.getElementById('role');
        const usernameLabel = document.getElementById('usernameLabel');
        const adminIdInput = document.getElementById('adminId');
        const emailInput = document.getElementById('customerEmail');
        
        roleSelect.addEventListener('change', () => {
            const role = roleSelect.value;

            if (role === 'Admin') {
                usernameLabel.textContent = 'Admin ID';
                adminIdInput.style.display = 'block';
                emailInput.style.display = 'none';
                adminIdInput.setAttribute('required', 'required');
                emailInput.removeAttribute('required');
            } else {
                usernameLabel.textContent = 'Customer Email';
                adminIdInput.style.display = 'none';
                emailInput.style.display = 'block';
                adminIdInput.removeAttribute('required');
                emailInput.setAttribute('required', 'required');
            }
        });

        roleSelect.dispatchEvent(new Event('change'));

        const passwordToggle = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');

        passwordToggle.addEventListener('click', () => {
            const type = passwordInput.type === 'password' ? 'text' : 'password';
            passwordInput.type = type;
            passwordToggle.querySelector('i').classList.toggle('fa-eye');
            passwordToggle.querySelector('i').classList.toggle('fa-eye-slash');
        });
    });


    </script>
</body>
</html>
