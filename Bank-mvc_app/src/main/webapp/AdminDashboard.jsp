<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>

<!-- Bootstrap 5 CSS -->
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
}

/* Ensure body and html fill the full height */
html, body {
	height: 100%; /* Full height of the viewport */
	margin: 0;
	padding: 0;
}

/* Container and flex layout for body */
.container {
	display: flex;
	flex-direction: column;
	min-height: 100%;
}

/* Main content area should grow to fill available space */
.main-content {
	flex-grow: 1; /* This ensures content takes the remaining space */
	margin-top: 20px;
	padding: 20px;
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

/* Upper Section - Welcome Card */
.welcome-card {
	--bs-card-spacer-y: 1rem;
	--bs-card-spacer-x: 1rem;
	--bs-card-title-spacer-y: 0.5rem;
	--bs-card-border-width: 0;
	--bs-card-border-color: transparent;
	--bs-card-border-radius: 12px;
	--bs-card-box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	/* Increased shadow opacity */
	--bs-card-bg: var(--card-bg);
	--bs-card-color: var(--text-color);
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	height: auto;
	word-wrap: break-word;
	background-color: var(--bs-card-bg);
	background-clip: border-box;
	border: var(--bs-card-border-width) solid var(--bs-card-border-color);
	border-radius: var(--bs-card-border-radius);
	box-shadow: var(--bs-card-box-shadow);
	margin-top: 20px;
	padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
}

.welcome-card h3 {
	font-size: 24px;
	font-weight: bold;
	color: var(--primary-color);
}

.welcome-card p {
	font-size: 17px;
	color: var(--text-color);
}

/* Main Taskbar */
.taskbar {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-top: 30px;
	flex-wrap: nowrap; /* Prevent items from wrapping */
}

.task {
	background-color: var(--card-bg);
	padding: 30px;
	text-align: center;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	width: 22%; /* Ensure tasks are horizontal */
	cursor: pointer;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	flex-shrink: 0; /* Prevent shrinking */
}

.task:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.task i {
	font-size: 50px;
	color: var(--primary-color);
}

.task h4 {
	margin-top: 10px;
	font-size: 18px;
	color: var(--text-color);
}

/* Footer Styling */
.container {
	display: flex;
	flex-direction: column;
	min-height: 100%;
	padding-bottom: 60px;
	/* Add padding to ensure footer isn't overlapping */
}

footer {
	position: relative;
	width: 100%;
}

/* Responsive Design */
@media ( max-width : 992px) {
	.task {
		width: 45%; /* Two items per row */
	}
}

@media ( max-width : 768px) {
	.taskbar {
		flex-direction: column; /* Stack tasks vertically on smaller screens */
		align-items: center;
	}
	.task {
		width: 80%; /* Make tasks wider on mobile */
		margin-bottom: 20px;
	}
}
</style>
</head>

<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Admin Dashboard</a>
			<!-- Logout Button inside Navbar -->
			<a href="Login.jsp" class="btn logout-btn ms-auto">Logout</a>
		</div>
	</nav>

	<!-- Main Content (Welcome and Stats) -->
	<div class="container">
		<!-- Welcome Card -->
		<div class="welcome-card card">
			<div class="card-body">
				<h3 class="card-title">Welcome ${sessionScope.admin.adminName},</h3>
				<p>You're logged in as an Admin. You can manage customers,
					accounts, and transactions from the options above.</p>
			</div>
		</div>

		<!-- Main Taskbar -->
		<div class="taskbar">
			<div class="task" id="addCustomer">
				<i class="fas fa-user-plus"></i>
				<h4>Add Customer</h4>
			</div>
			<div class="task" id="addAccount">
				<i class="fas fa-university"></i>
				<h4>Add Bank Account</h4>
			</div>
			<div class="task" id="viewAccounts">
				<i class="fas fa-users"></i>
				<h4>View
					Accounts</h4>
			</div>
			<div class="task" id="viewTransactions">
				<i class="fas fa-money-check-alt"></i>
				<h4>View Transactions</h4>
			</div>
		</div>

		<!-- Lower Section where content will be loaded -->
		<div class="main-content" id="lowerSection">
			<!-- Content will be dynamically loaded here -->
		</div>
	</div>

	<!-- Footer -->
	<footer>
		<p>&copy; 2024 Your Bank. All Rights Reserved.</p>
	</footer>

	<!-- Bootstrap JS and dependencies -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

	<!-- AJAX for loading content dynamically -->
	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							document.getElementById("addCustomer")
									.addEventListener("click", function() {
										loadContent("AddCustomer.jsp");
									});

							document.getElementById("addAccount")
									.addEventListener("click", function() {
										loadContent("AddBankAccount.jsp");
									});

							document.getElementById("viewAccounts")
									.addEventListener("click", function() {
										loadContent("ViewAccountsController");
									});

							document
									.getElementById("viewTransactions")
									.addEventListener(
											"click",
											function() {
												loadContent("ViewTransactionsController");
											});

							function loadContent(page) {
								var xhr = new XMLHttpRequest();
								xhr.open("GET", page, true);
								xhr.onload = function() {
									if (xhr.status == 200) {
										document.getElementById("lowerSection").innerHTML = xhr.responseText;
									} else {
										document.getElementById("lowerSection").innerHTML = "Failed to load content.";
									}
								};
								xhr.onerror = function() {
									document.getElementById("lowerSection").innerHTML = "An error occurred while loading content.";
								};
								xhr.send();
							}
						});
	</script>
</body>

</html>
