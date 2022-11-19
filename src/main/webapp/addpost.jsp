<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.dao.BoardDAO, java.io.File, com.example.util.FileUpload"%>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="com.example.bean.BoardVO" %>

<% request.setCharacterEncoding("utf-8"); %>

<%--<jsp:useBean id="u" class="com.example.bean.BoardVO" />--%>
<%--<jsp:setProperty property="*" name="u"/>--%>

<%
	BoardDAO boardDAO = new BoardDAO();
	FileUpload upload = new FileUpload(); // 파일업로드를 위해 추가된 부분
	BoardVO u = upload.uploadPhoto(request); // 마찬가지, 위에서 정의된 u를 여기서 대신 정의
	int i = boardDAO.insertBoard(u);
	String msg = "데이터 추가 성공 !";
	if(i == 0) msg = "[에러] 데이터 추가 ";
%>

<script>
	alert('<%=msg%>');
	location.href='posts.jsp';
</script>