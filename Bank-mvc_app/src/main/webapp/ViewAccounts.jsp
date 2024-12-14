<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Accounts</title>

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

/* Upper Section - Welcome Card */
.welcome-card {
    --bs-card-spacer-y: 1rem;
    --bs-card-spacer-x: 1rem;
    --bs-card-title-spacer-y: 0.5rem;
    --bs-card-border-width: 0;
    --bs-card-border-color: transparent;
    --bs-card-border-radius: 12px;
    --bs-card-box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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

/* Table Container */
.table-container {
    margin-top: 20px;
    max-width: 1000px; /* Limit the width of the table */
    margin-left: auto; /* Center the table */
    margin-right: auto; /* Center the table */
}

/* Table Styling */
.table {
    background-color: var(--card-bg);
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    width: 100%; /* Ensure full width within container */
    table-layout: fixed; /* Fixes the table layout so it doesn't stretch */
}

/* Optional: Adjust the table header for a better look */
.table th {
    background-color: var(--primary-color);
    color: #fff;
    font-weight: bold;
    text-align: center;
    vertical-align: middle;
}

/* Table content */
.table td {
    color: var(--text-color);
    text-align: center;
    vertical-align: middle;
    font-size: 14px;
}

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

/* Responsive Design for smaller screens */
@media ( max-width : 768px) {
    .table th, .table td {
        font-size: 12px; /* Smaller font size on mobile */
    }
    .table-container {
        padding: 0 15px;
    }
}

/* Styling for the search bar */
.input-group {
    border-radius: 12px; /* Rounded corners */
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Add shadow to the search input */
}

.input-group input {
    border-radius: 12px 0 0 12px; /* Rounded left corners for input */
    border: 1px solid var(--primary-color); /* Set the border color to the primary color */
    padding-left: 15px;
}

.input-group button {
    border-radius: 0 12px 12px 0; /* Rounded right corners for button */
    background-color: var(--primary-color); /* Use the primary color for the button */
    color: #fff; /* White text for the button */
    border: none;
}

.input-group input:focus, .input-group button:focus {
    box-shadow: 0 0 0 0.2rem rgba(174, 39, 95, 0.25); /* Focus effect for both input and button */
    border-color: var(--primary-color); /* Ensure focus color matches */
}
</style>

</head>

<body>

	<!-- Search Form -->
	<div class="container my-4">
		<form action="ViewAccountsController" method="get">
			<div class="input-group">
				<input type="text" name="searchQuery" class="form-control"
					placeholder="Search by Account Number or Customer ID"
					value="${param.searchQuery}">
				<button class="btn btn-primary" type="submit">Search</button>
			</div>
		</form>
	</div>

	<!-- Account Table -->
	<div class="table-container">
		<c:if test="${not empty accounts}">
			<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th>Account Number</th>
						<th>Account Type</th>
						<th>Customer ID</th>
						<th>Customer First Name</th>
						<th>Customer Last Name</th>
						<th>Balance</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="account" items="${accounts}">
						<tr>
							<td>${account.accountNumber}</td>
							<td>${account.accountType}</td>
							<td>${account.customerId}</td>
							<td>${account.customerFirstName}</td>
							<td>${account.customerLastName}</td>
							<td>${account.balance}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

		<c:if test="${empty accounts}">
			<p class="alert alert-warning">No accounts found.</p>
		</c:if>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
