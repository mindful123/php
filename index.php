<!DOCTYPE html>
<html>
<head>
        <title> AzureAppService MySQL Table Viewer</title>
</head>
<body>
        <h1>AzureAppService MySQL Table Viewer</h1>
        <?php
                // Define database connection variables
                $servername = "myflexiblemysqlserver74842.mysql.database.azure.com";
                $username = "my1user";
                $password = "mypassword1@";
                $dbname = "mydatabase";

                // Create database connection
                $conn = new mysqli($servername, $username, $password, $dbname);

                // Check connection
                if ($conn->connect_error) {
                        die("Connection failed: " . $conn->connect_error);
                }

                // Query database for all rows in the table
                $sql = "SELECT * FROM dept_manager";
                $result = $conn->query($sql);
        
                if ($result->num_rows > 0) {
                        // Display table headers
                        echo "<table><tr><th>EMP No</th><th>Dept No</th><th>From_Date</th></tr>";
                        // Loop through results and display each row in the table

                        while($row = $result->fetch_assoc()) {
                                echo "<tr><td>" . $row["emp_no"] . "</td><td>" . $row["dept_no"] . "</td><td>" . $row["from_date"] . "</td></tr>";
                        }
                        echo "</table>";
                } else {
                        echo "0 results";
                }

                // Close database connection
                $conn->close();

        ?>
</body>
</html>


