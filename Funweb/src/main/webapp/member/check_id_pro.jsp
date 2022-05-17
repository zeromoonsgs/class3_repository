<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = request.getParameter("id");

MemberDAO memberDAO= new MemberDAO();
boolean isDuplicate = memberDAO.checkId(id);



// if(isDuplicate){ //중복일 경우
// 	response.sendRedirect("")
	
// }else { //중복이 아닐 경우
	
// }

	response.sendRedirect("check_id.jsp?id=" + id + "&duplicate=" + isDuplicate);



%>