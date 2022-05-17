<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    request.setCharacterEncoding("UTF-8");
    
    String pageNum = request.getParameter("page");
    int num = Integer.parseInt(request.getParameter("num"));
    String pass = request.getParameter("pass");
	    
    
    NewsDAO newsDAO = new NewsDAO();
    
	int deleteCount = newsDAO.deleteNews(num, pass);
   
	
	if(deleteCount > 0){
		response.sendRedirect("news.jsp?page=" + pageNum);
		
	} 
	else{%> 
		
		<script>
		alert("글 삭제 실패!");
		history.back();
		
		</script>
		
		
	<%}
	
    %>
    
   
    
    