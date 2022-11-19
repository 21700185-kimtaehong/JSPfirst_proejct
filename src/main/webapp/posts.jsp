<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.dao.BoardDAO, com.example.bean.BoardVO"%>
<%--<%@page import="com.example.util.*"--%>
<%@page import="java.util.*, java.io.File"%>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>free board</title>
<style>
#list {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
#list td, #list th {
  border: 1px solid #ddd;
  padding: 8px;
  text-align:center;
}
#list tr:nth-child(even){background-color: #f2f2f2;}
#list tr:hover {background-color: #ddd;}
#list th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #006bb3;
  color: white;
}
</style>
<script>
	function delete_ok(id){
		var a = confirm("정말로 삭제하겠습니까?");
		if(a) location.href='deletepost.jsp?id=' + id;
	}
</script>
</head>
<body>
<h1>도서관리</h1>
<%
	BoardDAO boardDAO = new BoardDAO();
	List<BoardVO> list = boardDAO.getBoardList();
	request.setAttribute("list",list);
%>
<table id="list" width="90%">
<tr>
	<th>일련번호</th>
	<th>카테고리</th>
	<th>서명</th>
	<th>저자</th>
	<th>내용</th>
	<th>등록일</th>
	<th>수정일</th>
	<th>첨부파일</th>
	<th>수정</th>
	<th>삭제</th>
</tr>
<c:forEach items="${list}" var="u">
	<tr>
		<td>${u.getSeq()}</td>
		<td>${u.getCategory()}</td>
		<td>${u.getTitle()}</td>
		<td>${u.getWriter()}</td>
		<td>${u.getContent()}</td>
		<td>${u.getRegdate()}</td>
		<td>${u.getLastupdate()}</td>
<%--		<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${u.getLastupdate()}"/></td>--%>
		<td><img width="30" height="30" src="${pageContext.request.contextPath}/upload/${u.getPhoto()}"></td>
		<%--pageContext.request.contextPath가 서버 내에서 upload폴더가 있는 위치를 찾고, getPhoto로 파일 이름 찾아서 넣어줌		--%>
		<td><a href="editform.jsp?id=${u.getSeq()}">Edit</a></td>
		<td><a href="javascript:delete_ok('${u.getSeq()}')">Delete</a></td>
	</tr>
</c:forEach>
</table>
<br/><a href="addpostform.jsp">Add New Post</a>
</body>
</html>