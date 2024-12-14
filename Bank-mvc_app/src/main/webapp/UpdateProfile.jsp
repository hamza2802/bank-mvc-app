<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Profile</title>

<!-- Link to Bootstrap 5 for styling -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<style>
:root {
	--primary-color: #AE275F;
	--card-bg: #ffffff;
	--text-color: #333;
	--footer-bg: #f4f7fa;
	--navbar-bg: var(--primary-color);
	--navbar-text-color: #fff;
	--navbar-text-hover: #f0c0d4;
	--spacing: 10px;
}

body {
	background-color: var(--footer-bg);
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
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
 .label-theme {
        color: var(--primary-color);
        font-weight: bold;
    }
footer {
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

.profile-form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

label {
	font-size: 1.2em;
	color: var(--text-color);
}

input {
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 1em;
}

button {
	padding: 10px 20px;
	font-size: 1.2em;
	background-color: var(--primary-color);
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button:hover {
	background-color: #e04f50;
}
</style>
</head>

<body>

	<div class="container">
		<div class="form-container">
			<h3 class="custom-header mb-4">Update Profile</h3>

			<!-- Success Message Handling -->
			<c:if test="${not empty successMessage}">
				<script>
					alert("${successMessage}");
					window.location.href = "CustomerDashboard.jsp";
				</script>
			</c:if>

			<!-- Error Message Handling -->
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-danger">${errorMessage}</div>
			</c:if>

			<form id="updateProfileForm" action="UpdateProfileController"
				method="POST" class="profile-form">

				<!-- Current Customer Info -->
				<div class="mb-3">
					<label for="currentFirstName" class="label-theme">Current
						First Name:</label>
					<p>${sessionScope.customer.firstname}</p>
				</div>

				<div class="mb-3">
					<label for="currentLastName" class="label-theme">Current
						Last Name:</label>
					<p>${sessionScope.customer.lastname}</p>
				</div>

				<div class="mb-3">
					<label for="currentEmail" class="label-theme">Current
						Email:</label>
					<p>${sessionScope.customer.email}</p>
				</div>


				<!-- Editable Fields -->
				<div class="mb-3">
					<label for="firstName">Enter New First Name:</label> <input
						type="text" id="firstName" name="firstName"
						value="${firstName != null ? firstName : ''}" required>
				</div>

				<div class="mb-3">
					<label for="lastName">Enter New Last Name:</label> <input
						type="text" id="lastName" name="lastName"
						value="${lastName != null ? lastName : ''}" required>
				</div>

				<div class="mb-3">
					<label for="newPassword">Enter New Password:</label> <input
						type="password" id="newPassword" name="newPassword" required>
				</div>

				<div class="mb-3">
					<button type="submit" class="btn btn-primary">Update
						Profile</button>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
