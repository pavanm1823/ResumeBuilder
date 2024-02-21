<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%
    // Retrieve form data from request
    String firstName = request.getParameter("firstname");
    String middleName = request.getParameter("middlename");
    String lastName = request.getParameter("lastname");
    String designation = request.getParameter("designation");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String phoneno = request.getParameter("phoneno");
    // Similarly, retrieve other form data

    // Print HTML directly in JSP
    out.println("<p>complete</p>");

    // JDBC driver name and database URL
    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost/resume_database"; // Change DATABASE_NAME to your database name

    // Database credentials
    String USER = "root"; // Change username to your database username
    String PASS = ""; // Change password to your database password

    Connection conn = null;
    PreparedStatement preparedStatement = null;

    try {
        // Register JDBC driver
        Class.forName(JDBC_DRIVER);

        // Open a connection
        conn = DriverManager.getConnection(DB_URL, USER, PASS);

        // Prepare SQL statement to insert form data into the database
        String sql = "INSERT INTO data (firstname, middlename, lastname, designation, address, email, phoneno) VALUES (?, ?, ?, ?, ?, ?, ?)";
        preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1, firstName);
        preparedStatement.setString(2, middleName);
        preparedStatement.setString(3, lastName);
        preparedStatement.setString(4, designation);
        preparedStatement.setString(5, address);
        preparedStatement.setString(6, email);
        preparedStatement.setString(7, phoneno);
        
        // Similarly, set parameters for other form fields

        // Execute the prepared statement
        preparedStatement.executeUpdate();

        // Display an alert box using JavaScript
        out.println("<script>alert('CV saved successfully'); window.history.back();</script>");
    } catch (ClassNotFoundException | SQLException e) {
        // Handle errors
        e.printStackTrace();
        // Display an alert box for error
        out.println("<script>alert('An error occurred while saving the CV');</script>");
        // Navigate back to the previous page on error
        out.println("<script>window.history.back();</script>");
    } finally {
        // Close resources in a finally block
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
