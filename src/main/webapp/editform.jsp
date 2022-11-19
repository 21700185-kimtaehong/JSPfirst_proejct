<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.example.dao.BoardDAO, com.example.bean.BoardVO"%>
 <%@page import="java.util.Date" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Form</title>
</head>
<body >

<%
	BoardDAO boardDAO = new BoardDAO();
	String id=request.getParameter("id");
	BoardVO u=boardDAO.getBoard(Integer.parseInt(id));
	request.setAttribute("u", u); // Fileupload를 위해 추가된 부분
%>

<h1>Edit Form</h1>
<form action="editpost.jsp" enctype="multipart/form-data" method="post">
	<input type="hidden" name="seq" value="<%=u.getSeq() %>"/>
	<table>
		<input type="hidden" name="lastupdate" id="lastupdate" value="">
		<tr><td>카테고리:</td><td><input type="text" name="category" value="<%= u.getCategory()%>"/></td></tr>
		<tr><td>서명:</td><td><input type="text" name="title" value="<%= u.getTitle()%>"/></td></tr>
		<tr><td>저자:</td><td><input type="text" name="writer" value="<%= u.getWriter()%>" /></td></tr>
		<tr><td>내용:</td><td><textarea cols="50" rows="5" name="content"><%= u.getContent()%></textarea></td></tr>
		<tr><td>첨부파일: </td><td><input type="file" name="photo" id="photo"/></td></tr>
		<tr><td colspan="2"><input type="submit" value="Edit Post"/>
			<input type="button" value="Cancel" onclick="history.back()"/></td></tr>
	</table>
</form>

</body>
</html>