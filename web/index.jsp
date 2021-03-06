<%--
  Created by IntelliJ IDEA.
  User: Andrii
  Date: 21.03.2020
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student List Application WebLogic</title>
    <script>
        var request = new XMLHttpRequest();
        function searchInfo() {
            var name = document.vinform.name.value;
            var url = "search.jsp?val=" + name;

            try {
                request.onreadystatechange = function () {
                    if (request.readyState == 4) {
                        var val = request.responseText;
                        document.getElementById('mylocation').innerHTML = val;
                    }
                }
                request.open("GET", url, true);
                request.send();
            } catch (e) {
                alert("Unable to connect to server");
            }
        }
    </script>
</head>
<body>

<div style="text-align: center;">
    <h1>Student List</h1>
    <h2>
        <a href="${pageContext.request.contextPath}/new">Add New Student</a> &nbsp; | &nbsp;
        <a href="${pageContext.request.contextPath}/list">All Students List</a>
    </h2>
</div>
<div style="text-align: center;">
    <h1>Search Student</h1>

    <form name="vinform">
        <input type="text" name="name" onkeyup="searchInfo()">
    </form>

    <span id="mylocation"></span>
</div>
<div align="center">
    <table border="1" cellpadding="5">
        <caption><h2>List of Students</h2></caption>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Scholarship</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="student" items="${listStudent}">
            <tr>
                <td><c:out value="${student.id}"/></td>
                <td><c:out value="${student.name}"/></td>
                <td><c:out value="${student.scholarship}"/></td>
                <td>
                    <a href="${pageContext.request.contextPath}/edit?id=<c:out value='${student.id}' />">Edit</a>
                    &nbsp;|&nbsp;
                    <a href="${pageContext.request.contextPath}/delete?id=<c:out value='${student.id}' />">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
