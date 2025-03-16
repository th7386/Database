<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
	<title> COMP322: Databases </title>
</head>
<body>

<p>
	<i> ------ For Debugging ------ <br>
			<%

String nickName = request.getParameter("nick_name");
 
out.println("Nickname parameter: <b>"+nickName+"</b>");
out.println("<br>");
%>
</p>
<hr>

<%!

	String getStudentInfo(String selectedNickName, String tabName, Statement stmt) {

		String result = "<h3> # " +tabName+"</h3>";

		try {
			result = result + "<table border=\"1\">\n";
			String query;
			ResultSet rs;
			ResultSetMetaData rsm;

			// 1. write an SQL query to get the information of the "selectedNickName" student in the "tabName" table
			// 2. run the SQL query
			// 3. display the results in the table format (header information: use rs.getMetaData() )



			query = "SELECT * FROM " + tabName + " WHERE Nick_name = '" + selectedNickName + "'";
			rs = stmt.executeQuery(query);
			rsm = rs.getMetaData();
			result = result + "<tr>";
			for (int i = 1; i <= rsm.getColumnCount(); i++) {
				result = result + "<th>" + rsm.getColumnName(i) + "</th>";
			}
			result = result + "</tr>";
			while (rs.next()) {
				result = result + "<tr>";
				for (int i = 1; i <= rsm.getColumnCount(); i++) {
					result = result + "<td>" + rs.getString(i) + "</td>";
				}
				result = result + "</tr>";
			}

			rs.close();



			result = result + "</table>\n";
		} catch (Exception SQLException) {
			return "# getStudentInfo Error";
		}
		return result;
	}
%>



<%

	String user = "root";
	String passwd = "th7386";
	String url = "jdbc:mysql://localhost/project2";


	Connection conn = null;
	Statement stmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url,user,passwd);
	stmt = conn.createStatement();
%>


<%
	out.println("<h2> All Information about <u>" + nickName + "</u></h2> \n");
	out.println(getStudentInfo(nickName, "STUDENT", stmt));
	out.println(getStudentInfo(nickName, "FAVORITE_COURSE", stmt));
	out.println(getStudentInfo(nickName, "PREFERRED_PL", stmt));
	out.println(getStudentInfo(nickName, "FAVORITE_FOOD", stmt));

	stmt.close();
	conn.close();
%>



</body>
</html>