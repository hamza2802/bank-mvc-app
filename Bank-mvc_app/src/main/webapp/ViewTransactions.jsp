<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Transactions</title>

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<style>
/* Existing Styles */
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

/* Table Header */
.table th {
	background-color: var(--primary-color);
	color: #fff;
	font-weight: bold;
	text-align: center;
	vertical-align: middle;
}

/* Table Body */
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

/* Styling for the search bar */
.input-group {
	border-radius: 12px; /* Rounded corners */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	/* Add shadow to the search input */
}

.input-group input {
	border-radius: 12px 0 0 12px; /* Rounded left corners for input */
	border: 1px solid var(--primary-color);
	/* Set the border color to the primary color */
	padding-left: 15px;
}

.input-group button {
	border-radius: 0 12px 12px 0; /* Rounded right corners for button */
	background-color: var(--primary-color);
	/* Use the primary color for the button */
	color: #fff; /* White text for the button */
	border: none;
}

.input-group input:focus, .input-group button:focus {
	box-shadow: 0 0 0 0.2rem rgba(174, 39, 95, 0.25);
	/* Focus effect for both input and button */
	border-color: var(--primary-color); /* Ensure focus color matches */
}
</style>
</head>

<body>

	<!-- Search Form -->
	<div class="container my-4">
		<form action="ViewTransactionsController" method="get">
			<div class="input-group">
				<input type="text" name="searchQuery" class="form-control"
					placeholder="Search by Transaction ID, Sender or Receiver Account"
					value="${param.searchQuery}">
				<button class="btn btn-primary" type="submit">Search</button>
			</div>
		</form>
	</div>

	<!-- Transaction Table -->
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
			<p class="alert alert-warning">No transactions found.</p>
		</c:if>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
