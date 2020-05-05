<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 400px;
		border-collapse: collapse;
	}
	th, td{
		border: 1px solid black;
		text-align: center;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<div id="wrap"></div>
	
	<script id="template" type="text/x-handlebars-template">
		<h1>{{title}}</h1>
		<ul>
		{{#each list}}
		<li class="replies">
		<div>
			<p>{{rno}}</p>
			<p>{{replyer}}</p>
			<p>{{replytext}}</p>
			<p>{{dateHelper replydate}}</p>
		</div>
		</li>
		{{/each}}
		</ul>
	</script>
	
	<script>
	Handlebars.registerHelper("dateHelper", function(value){
		var d = new Date(value);
		var year = d.getFullYear();
		var month = d.getMonth() +1;
		var day = d.getDate();
		var week = new Array("일", "월", "화", "수", "목", "금", "토");
		var dd = week[d.getDay()]; // 숫자를 반환하므로 배열~
		
		
		return year +"-"+ month+"-"+ day +"-"+dd+"요일";
	});
		
		var source = $("#template").html();
		var data = {
				title : "제목입니다.",
				list : [
					{rno:1, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date(2020,0,23)},
					{rno:2, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date(2020,1,23)},
					{rno:3, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date(2020,2,23)},
					{rno:4, replyer:"홍길동", replytext:"안녕하세요", replydate:new Date()}
					]
		};
		var func = Handlebars.compile(source);
		$("#wrap").html(func(data));
	</script>
	
	<hr>
	
	<table>
		<tr>
			<th>이름</th>
			<th>아이디</th>
			<th>메일주소</th>
		</tr>
	</table>
	
	<script id="template2" type="text/x-handlebars-template">
		{{#each user}}
		<tr>
		<td>{{name}}</td>
		<td>{{id}}</td>
		<td><a href="#">{{email}}</a></td>
		</tr>
		{{/each}}
	</script>
	<script>
		var source = $("#template2").html();
		var data = {
				user : [
				{name : "홍길동", id:"aaa", email:"aaa@nate.com"},
				{name : "홍길동", id:"aaa", email:"aaa@nate.com"},
				{name : "홍길동", id:"aaa", email:"aaa@nate.com"},
				{name : "홍길동", id:"aaa", email:"aaa@nate.com"},
				{name : "홍길동", id:"aaa", email:"aaa@nate.com"}
			]
		};
		var func = Handlebars.compile(source);
		$("table").append(func(data)); //추가 개념 append
	</script>
	
</body>
</html>