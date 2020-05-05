<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<ul id="list">	
	</ul>
	
	<!-- 들어오는 데이터가 배열이라고 표시 : {{#each.}}  -->
	<script id="template" type="text/x-handlebars-template">
		{{#each.}} 
		<li class="replies">
		<div>
			<p>{{rno}}</p>
			<p>{{replyer}}</p>
			<p>{{replytext}}</p>
			<p>{{dateHelper replydate}}</p>
		</div>
		</li>
		{{/each}}
	</script>
	
	<script>
		Handlebars.registerHelper("dateHelper", function(value){
			var d = new Date(value);
			var year = d.getFullYear();
			var month = d.getMonth() +1;
			var day = d.getDate();
			var week = new Array("일", "월", "화", "수", "목", "금", "토");
			var dd = week[d.getDay()]; // 숫자를 반환하므로 배열~
			
			
			return year +"/"+ month+"/"+ day +"/"+dd+"요일";
		});
		var s1 = $("#template").html();
		var data = [
					{rno:1, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date(2020,0,23)},
					{rno:2, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date(2020,1,23)},
					{rno:3, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date(2020,2,23)},
					{rno:4, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date()}
					];
		var f1 = Handlebars.compile(s1);
		$("#list").html(f1(data));
	</script>
</body>
</html>