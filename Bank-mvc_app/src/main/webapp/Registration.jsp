<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration</title>
    <!-- Bootstrap 5 CSS -->
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

        .register-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding-top: 50px;
            padding-bottom: 50px;
        }

        .register-card {
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

        .form-select,
        .form-control {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            color: var(--text-color);
        }

        .form-select:focus,
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(174, 39, 95, 0.25);
        }

        .btn-register {
            background-color: var(--primary-color);
            border: none;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-register:hover {
            background-color: #8c1f4d;
        }

        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
            color: #777;
            padding: 20px;
            font-size: 14px;
        }

        .container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-link {
            color: var(--primary-color);
        }
    </style>
</head>

<body>
    <div class="register-container">
        <div class="register-card">
            <div class="app-title">Bank App</div>

            <form action="RegistrationController" method="post">
                <div class="form-group mb-3">
                    <label for="adminid" class="form-label">Admin ID</label>
                    <input type="number" class="form-control" id="adminid" name="adminid" placeholder="Enter Admin ID" required>
                </div>

                <div class="form-group mb-3">
                    <label for="username" class="form-label">Name</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter Name" required>
                </div>

                <div class="form-group mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                </div>

                <div class="form-group mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                </div>

                <button type="submit" class="btn btn-register btn-primary w-100">Register</button>
            </form>

            <div class="text-center mt-3">
                <a href="Login.jsp" class="register-link">Back to Login</a>
            </div>
        </div>
    </div>

    <!-- Modal for success or error messages -->
    <div class="modal fade" id="registrationModal" tabindex="-1" aria-labelledby="registrationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registrationModalLabel">Registration Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalMessage">
                    <!-- Dynamic message will be inserted here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="closeModalButton">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Check if there is a message set from the backend (via request attributes)
        var message = '<%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>';
        var messageType = '<%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "" %>';
        var registrationSuccess = '<%= request.getAttribute("registrationSuccess") != null ? request.getAttribute("registrationSuccess") : false %>';

        if (message) {
            var modalMessage = document.getElementById('modalMessage');
            modalMessage.innerHTML = message;

            // Set modal color based on success or error
            if (messageType === 'success') {
                modalMessage.classList.add('text-success');
            } else {
                modalMessage.classList.add('text-danger');
            }

            // Show the modal
            var myModal = new bootstrap.Modal(document.getElementById('registrationModal'));
            myModal.show();

            // Redirect to login page after the user clicks 'OK' on the modal
            if (registrationSuccess) {
                document.getElementById('closeModalButton').onclick = function() {
                    window.location.href = "Login.jsp";
                };
            }
        }
    </script>
</body>

</html>
