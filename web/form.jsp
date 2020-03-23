<%--
  Created by IntelliJ IDEA.
  User: Andrii
  Date: 22.03.2020
  Time: 0:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student List Application</title>
</head>
<body>
<div style="text-align: center;">
    <h1>Student List</h1>
    <h2>
        <a href="${pageContext.request.contextPath}/new">Add New Student</a> &nbsp; | &nbsp; <a
            href="${pageContext.request.contextPath}/list">All Students List</a>
    </h2>
</div>
<div align="center">
    <c:if test="${student != null}">
    <form action="update" method="post">
        </c:if>
        <c:if test="${student == null}">
        <form action="insert" method="post">
            </c:if>
            <table border="1" cellpadding="5">
                <caption>
                    <h2>
                        <c:if test="${student != null}">
                            Edit Student
                        </c:if>
                        <c:if test="${student == null}">
                            Add New Student
                        </c:if>
                    </h2>
                </caption>
                <c:if test="${student != null}">
                    <input type="hidden" name="id" value="<c:out value='${student.id}' />"/>
                </c:if>

                <tr>
                    <th>Name:</th>
                    <td>
                        <c:choose>
                            <c:when test="${student != null}">
                                <input type="text" readonly name="name" value="<c:out value='${student.name}'/>"
                            </c:when>
                            <c:otherwise>
                                <input type="text" name="name" size="45" value="<c:out value='${student.name}'/>"
                            </c:otherwise>
                        </c:choose>
                        />
                    </td>
                </tr>

                <tr>
                    <th>Scholarship:</th>
                    <td>
                        <input type="text" name="scholarship" size="5"
                               value="<c:out value='${student.scholarship}'/>"
                        />
                    </td>
                </tr>

                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Save"/>
                    </td>
                </tr>
            </table>
        </form>
</div>
</body>
</html>
