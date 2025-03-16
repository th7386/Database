<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>COMP322: Databases</title>
</head>
<body>

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

<h2>--- List of Students ---</h2>

<%

	// run the SQL statement to read the "student" table
	// display the student information with "<table>" tag in a html.
	// add the hyperlink for each nickName as follows:
	// student_detail.jsp?nick_name=DongBao (If nick_name is DongBao)

	String sql = "SELECT * FROM STUDENT";
	rs = stmt.executeQuery(sql);

	ResultSetMetaData rsm = rs.getMetaData();

	out.println("<table border=\"1\">");
	int cnt = rsm.getColumnCount();
	out.println("<tr>");
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsm.getColumnName(i)+"</th>");
	}
	out.println("</tr>");


	while(rs.next()){
		out.println("<tr>");
		for(int i = 1; i <= cnt; i++) {
			String columnName = rsm.getColumnName(i);
			if(columnName.equals("Nick_name")) {
				String Nick_name = rs.getString(i);
				out.println("<td><a href=\"student_detail.jsp?nick_name=" + Nick_name + "\">" + Nick_name + "</a></td>");
			} else {
				out.println("<td>" + rs.getString(i) + "</td>");
			}
		}
		out.println("</tr>");
	}

	out.println("</table>");



	rs.close();
	stmt.close();
	conn.close();
%>



</body>
</html>