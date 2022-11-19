<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--<%@page import="com.example.dao.BoardDAO"%>--%>
<%@page import="com.example.dao.BoardDAO, com.example.util.FileUpload"%>
<%@page import="com.example.bean.BoardVO"%>

<% request.setCharacterEncoding("utf-8"); %>

<%--밑에서 VO 객체를 새로 정의해주기 때문에 필요 없음--%>
<%--<jsp:useBean id="u" class="com.example.bean.BoardVO" />--%>
<%--<jsp:setProperty property="*" name="u"/>--%>

<%
	BoardDAO boardDAO = new BoardDAO();
	FileUpload upload = new FileUpload(); //업로드 기능을 위해 추가된 부분
	BoardVO u = upload.uploadPhoto(request); //마찬가지
	int i=boardDAO.updateBoard(u);
	response.sendRedirect("posts.jsp");
%>