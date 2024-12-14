<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>New Transaction</title>

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
}

body {
	background-color: var(--footer-bg);
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
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

/* Main Content Styling */
.container {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	padding-bottom: 50px;
}

/* New Transaction Card Styling */
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

/* Footer Styling */
footer {
	background-color: var(--footer-bg);
	padding: 20px;
	text-align: center;
	color: #777;
	font-size: 14px;
}

/* Custom Header */
.custom-header {
	color: var(--primary-color);
	text-align: center;
	font-size: 1.8rem;
	font-weight: bold;
}

/* Flex Layout for the Transaction Form */
.transaction-form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

label {
	font-size: 1.2em;
	color: var(--text-color);
}

select, input {
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

.extra-input {
	display: none;
}
</style>
</head>

<body>

    <!-- Main Content (New Transaction Form) -->
    <div class="container">
        <div class="form-container">
            <!-- New Transaction Header -->
            <h3 class="custom-header mb-4">New Transaction</h3>

            <!-- New Transaction Form -->
            <form id="transactionForm" action="TransactionController" method="POST" class="transaction-form" onsubmit="return validateForm()">

                <!-- Account Selection Dropdown -->
                <div class="mb-3">
                    <label for="accountSelect">Select Account:</label>
                    <select id="accountSelect" name="accountSelect" required>
                        <!-- Correct usage of JSTL tag -->
                        <c:forEach var="account" items="${accounts}">
                            <option value="${account.accountNumber}">${account.accountNumber}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Other form fields (Transaction Type, Amount, etc.) -->
                <div class="mb-3">
                    <label for="transactionType">Select Transaction Type:</label>
                    <select id="transactionType" name="transactionType" onchange="toggleAccountNumberField()">
                        <option>-</option>
                        <option value="Credit">Credit</option>
                        <option value="Debit">Debit</option>
                        <option value="Transfer">Transfer</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="amount">Enter Amount:</label>
                    <input type="number" id="amount" name="amount" required>
                </div>

                <div id="accountNumberInput" class="extra-input">
                    <div class="mb-3">
                        <label for="accountNumber">Enter Account Number for Transfer:</label>
                        <input type="text" id="accountNumber" name="accountNumber" placeholder="Account Number" required>
                    </div>
                </div>

                <input type="hidden" id="senderAccount" name="senderAccount" value="<%=session.getAttribute("loggedInAccount")%>">

                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Submit Transaction</button>
                </div>
            </form>
        </div>
    </div>

  

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script to toggle account number input for Transfer -->
    <script>
    function toggleAccountNumberField() {
        const transactionType = document.getElementById("transactionType").value;
        const accountNumberInput = document.getElementById("accountNumberInput");
        const accountNumber = document.getElementById("accountNumber");  // This is the correct element

        if (transactionType === "Transfer") {
            accountNumberInput.style.display = "block";  // Show account number input for Transfer
            accountNumber.setAttribute("required", true);  // Make the account number field required when visible
        } else {
            accountNumberInput.style.display = "none";  // Hide account number input if not Transfer
            accountNumber.removeAttribute("required");  // Remove required attribute if hidden
        }
    }

        // Initialize the form with the default transaction type (Credit)
        window.onload = function() {
            toggleAccountNumberField();
        };

        function validateForm() {
            const transactionType = document.getElementById("transactionType").value;
            const amount = document.getElementById("amount").value;
            const senderAccount = document.getElementById("senderAccount").value;
            const accountNumber = document.getElementById("accountNumber");

            if (!amount || amount <= 0) {
                alert("Please enter a valid amount.");
                return false;
            }

            if (transactionType === "Transfer" && !accountNumber.value) {
                alert("Please enter an account number for the transfer.");
                return false;
            }

            return true;
        }

        <c:if test="${not empty message}">
            alert("${message}");
            window.location.href = "CustomerDashboard.jsp";
        </c:if>
    </script>

</body>

</html>
