<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   #pagination li{
   	border: 1px solid gray;
   	float : left;
   	margin: 0 5px;
   	list-style: none;
   	padding: 2px 4px;
   }
   #list .item{
   	border-bottom:1px solid #ddd;
   	padding : 5px;
   	width: 400px; 
   	position: relative;
   }
   
   #list .item .text{
   	display: block;
   }
   #list .item .btnWrap{
   	position: absolute;
   	right: 10px;
   	top: 10px;
   }
   #modPopup{
   	width: 300px;
   	height: 100px;
   	padding: 5px;
   	background-color: lightgray;
   	position: absolute;
   	top: 30%;
   	left: 30%;
   	display: none;
   }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<script id="template" type="text/x-handlebars-template">
{{#each list}}
<li>
	<div class = "item">
		<span class="rno">{{rno}}</span> : <span class="writer">{{replyer}}</span>
		<span class="text">{{replytext}}</span>
		<div class="btnWrap">
			<button class="btnMod" data-rno="{{rno}}" data-text="{{replytext}}">수정</button>
			<button class="btnDel" data-rno="{{rno}}">삭제</button>
		</div>
	</div>
</li>
{{/each}}	
</script>
<script type="text/javascript">
	var currentPage = 1;
	//함수로 따로 빼기
	function getPageList(page){
        var bno = $("#bno").val()
        $.ajax({
           url: "/ex02/replies/"+bno+"/"+page,
           type: "get", //get방식으로 댓글 리스트 가져옴
           data: "json",
           success:function(res){
              console.log(res);
              $("#list").empty();
              
              var source = $("#template").html();
              var func = Handlebars.compile(source);
              $("#list").append(func(res)); //리스트 키가 있는 상태에서 넣었으므로 res만 넣으면 된다
              
/*               $(res.list).each(function (i, obj) {
                 var rno = obj.rno;
                 var replyer = obj.replyer;
                 var replytext = obj.replytext;
                 
                 var $li = $("<li>");
              
                 var $div1 = $("<div>").addClass("item");
                 var $span1 = $("<span>").addClass("rno").html(rno);
                 var $span2 = $("<span>").addClass("writer").html(replyer);
                 var $span3 = $("<span>").addClass("text").html(replytext);
                 
                 var $div2 = $("<div>").addClass("btnWrap");
                 var $btn1 = $("<button>").attr("data-rno", rno).attr("data-text", replytext).addClass("btnMod").html("수정");
                 var $btn2 = $("<button>").attr("data-rno", rno).addClass("btnDel").html("삭제");
                 
                 var $divWrap = $div2.append($btn1).append($btn2);
                 var $divItem = $div1.append($span1).append(" : ").append($span2).append($span3).append($divWrap)
                 
                 $li.append($divItem);
                 
                 $("#list").append($li);
              }) */
              
              $("#pagination").empty();     
              for(var i = res.pageMaker.startPage; i<= res.pageMaker.endPage; i++){
                 var $li = $("<li>").html(i);
                 $("#pagination").append($li);
              }
           }
        })   		
	}
	
	
	

   $(function () {
	   $(document).on("click",".btnDel", function() {
			//attr 심어주고
			var no = $(this).attr("data-rno");
			console.log(no);
			
			$.ajax({
				url:"replies/"+no,
				type:"delete",
				dataType:"text",
           success:function(res){
        	   console.log(res);
               if(res == "SUCCESS"){
               	alert("게시글을 삭제하였습니다.");
               	//리스트 갱신
               	getPageList(currentPage);
               }
           }
			})
		})
		
		
		$(document).on("click", ".btnMod", function() {
			var rno = $(this).attr("data-rno"); //rno 뽑아오기
			var text = $(this).attr("data-text"); //text 뽑아오기
			 
			
			$(".mod-rno").html(rno);
			$("#mod-text").attr("value", text);
			$("#modPopup").show();

		})
		
		$("#btnModSave").click(function(){
			var rno = $(this).parent().find(".mod-rno").text();
			var text = $(this).parent().find("#mod-text").val();
		
 			$.ajax({
				url:"replies/"+rno,
				type:"put",
				headers:{"Content-Type":"application/json"},
				data:JSON.stringify({"replytext":text}),
				dataType:"text",
          success:function(res){
        	  console.log(res);
              if(res == "SUCCESS"){
              	alert("댓글이 수정되었습니다.");
    			$("#modPopup").hide();
              	//리스트 갱신
              	getPageList(currentPage);
              }        	  
          }
			
		})
		
		})
		
		$("#btnClose").click(function() {
			$("#modPopup").hide();			
		})
		
	   	   
	   //리스트버튼
      $("#btnList").click(function() {
    	  getPageList(1);
      })
      
      //등록 - 리스트 나오기
      $("#btnAdd").click(function() {
		//댓글 등록
		var bno = $("#bno").val();
		var replyer = $("#replyer").val();
		var text = $("#replytext").val();
		
		//서버 주소 : /replies/
		
		//@RequestBody 서버에서 사용시
		//1. headers - "Content-Type" : "application/json"
		//2. 보내는 data는 json string으로 변형해서 보내야 됨
		// -- "{bno:bno}"
		
		var json = JSON.stringify({"bno":bno, "replyer":replyer, "replytext":text}); //stringify를 이용하여 json
		
		$.ajax({
			url:"replies/",
			method:"post",
			headers:{"Content-Type":"application/json"},
			data:json, //보낼 데이터, 서버에 보낼 vo데이터 값과 이름이 같아야 한다
			dataType : "text", //단순한 글자 1개 / <List<ReplyVO>>의 경우 json
            success:function(res){
                console.log(res);
                if(res == "SUCCESS"){
                	alert("댓글이 등록되었습니다.");
                	//리스트 갱신
                	getPageList(1);
                }
            }
			
		})		
	})
	
	$(document).on("click", "#pagination li", function(){
		//클릭했는 li태그 번호
		var no = $(this).text();
		getPageList(no);
		})
		

   })
</script>
</head>
<body>
   <div id="box">
      <p>
         <label>BNO</label>
         <input type="text" id="bno">
      </p>
      <p>
         <label>Replyer</label>
         <input type="text" id="replyer">
      </p>
      <p>
         <label>Reply Text</label>
         <input type="text" id="replytext">
      </p>
      <p>
         <button id="btnList">List</button>
         <button id="btnAdd">Add</button>
      </p>
   </div>
   <hr>
   <div id="listWrap">
      <ul id="list">
      	
      </ul>
      <ul id="pagination">
      </ul>
   </div>
   
   <div id="modPopup">
   	<div class="mod-rno"></div>
   	<div>
   		<input type="text" id="mod-text">
   	</div>
   	<button id="btnModSave">수정</button>
   	<button id="btnClose">닫기</button>
   </div>
</body>
</html>