<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pyrih.homework.dao.OracleDAOConnection" %>
<%@ page import="pyrih.homework.entity.Student" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Student List Application WebLogic</title>
  </head>
  <body>
  <%
    String name = request.getParameter("val");
    List<Student> DB = OracleDAOConnection.getInstance().selectAllStudents();
    if (name == null || name.trim().equals("")) {  %>
      <p>Please enter name!</p>
  <%
    } else {
      try {
        boolean flag = false;
        Student currentStudent = null;
        for (Student s : DB) {
          if(s.getName().equals(name)){
            currentStudent = s;
            flag = true;
          }
        }
        if (!flag) {
  %>
          <p>No Record Found!</p>
  <%    }
        else {                             %>
            <table align="center" border="1" cellpadding="5">
              <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Scholarship</th>
              </tr>
              <tr>
                <td><%=currentStudent.getId()%></td>
                <td><%=currentStudent.getName()%></td>
                <td><%=currentStudent.getScholarship()%></td>
              </tr>
            </table>
  <%    }
      } catch (Exception e) {                     %>
          <p>Some problems ...</p>
  <%  }
    }                                             %>
  </body>
</html>
