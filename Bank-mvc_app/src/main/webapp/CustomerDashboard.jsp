<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>

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

        /* Navbar Styling */
        .navbar {
            background-color: var(--navbar-bg);
            padding: 10px 30px;
        }

        .navbar-brand,
        .navbar-nav .nav-link {
            color: var(--navbar-text-color);
            font-weight: bold;
        }

        .navbar-brand:hover,
        .navbar-nav .nav-link:hover {
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

        /* Main Content Styling */
        .taskbar {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: nowrap; /* Prevent items from wrapping */
        }

        /* Remove underline from anchor tags in .task */
        .task {
            background-color: var(--card-bg);
            padding: 30px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 30%; /* Adjusted for three items */
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            flex-shrink: 0; /* Prevent shrinking */
            text-decoration: none; /* Remove the underline from task links */
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

        /* Lower Section Styling */
        .lower-section {
            margin-top: 30px;
            margin-left: 30px;
            min-height: 500px; /* Fixed minimum height to prevent shifting */
            padding: 20px;
            overflow-y: auto;
        }

        /* Footer Styling */
        footer {
            background-color: var(--footer-bg);
            padding: 20px;
            text-align: center;
            color: #777;
            font-size: 14px;
        }

        /* Prevent body or html styles from affecting the layout of upper section */
        html,
        body {
            margin: 0;
            padding: 0;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .task {
                width: 45%; /* Two items per row */
            }
        }

        @media (max-width: 768px) {
            .taskbar {
                flex-direction: column;
                /* Stack tasks vertically on smaller screens */
                align-items: center;
            }

            .task {
                width: 80%;
                /* Make tasks wider on mobile */
                margin-bottom: 20px;
            }
        }
    </style>
</head>

<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Customer Dashboard</a>
            <!-- Logout Button inside Navbar -->
            <a href="Login.jsp" class="btn logout-btn ms-auto">Logout</a>
        </div>
    </nav>

    <!-- Main Content (Welcome and Stats) -->
    <div class="container">
        <!-- Welcome Card -->
        <div class="welcome-card card">
            <div class="card-body">
                <h3 class="card-title">Welcome ${sessionScope.customer.firstname},</h3>
                <p>You're logged in as a Customer. You can manage your accounts, make transactions, and update your profile from the options below.</p>
            </div>
        </div>

        <!-- Main Taskbar -->
        <div class="taskbar">
            <a href="#" class="task" id="viewPassbook">
                <i class="fas fa-book"></i>
                <h4>Passbook</h4>
            </a>
            <a href="TransactionController" class="task" id="newTransaction">
                <i class="fas fa-credit-card" onclick = "TransactionController"></i>
                <h4>New Transaction</h4>
            </a>
            <a href="#" class="task" id="updateProfile">
                <i class="fas fa-user-edit"></i>
                <h4>Update Profile</h4>
            </a>
        </div>

        <!-- Lower Section where content will be loaded -->
        <div class="lower-section" id="lowerSection">
            <!-- Content will be dynamically loaded here -->
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Your Bank. All Rights Reserved.</p>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- AJAX for loading content dynamically -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Add event listeners for each task item
            document.getElementById("viewPassbook").addEventListener("click", function () {
                loadContent("PassbookController");
            });

           // document.getElementById("newTransaction").addEventListener("click", function () {
             //   loadContent("TransactionController");
           // });

            document.getElementById("updateProfile").addEventListener("click", function () {
                loadContent("UpdateProfileController");
            });

            // Function to load content dynamically into the lower section
            function loadContent(page) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", page, true);
                xhr.onload = function () {
                    if (xhr.status == 200) {
                        document.getElementById("lowerSection").innerHTML = xhr.responseText;
                        revalidateForm(); // Trigger revalidation after content is loaded
                    }
                };
                xhr.onerror = function () {
                    document.getElementById("lowerSection").innerHTML = "An error occurred while loading content.";
                };
                xhr.send();
            }

        });
    </script>
</body>

</html>
