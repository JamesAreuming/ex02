<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>작성자 : ${test}</p>
	<p>파일이름 : ${fileList}</p>
	<%-- <p><img src = "${pageContext.request.contextPath}/resources/upload/${fileList}"></p> --%>
	<c:forEach var="img" items="${fileList}"> <!-- 받는게 객체가 아니라 string 이므로  -->
		<img src = "${pageContext.request.contextPath}/resources/upload/${img}">
	</c:forEach>
</body>
</html>