<%@ page contentType="text/html; charset=UTF-8" %><%--utf8 로 문자형 정해주기--%>
<%@ page import="kopo17.dao.*" %> <!-- dao 임포트 -->
<%@ page import="kopo17.domain.*" %> <!-- 도메인 임포트 -->
<!DOCTYPE html>
<html>
	<script>
		function characterCheck(obj){
		  // 허용하고 싶은 특수문자가 있다면 여기서 삭제
		  var regExp = /<!--|-->/gi; 
		 // var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
		
		  if( regExp.test(obj.value) ){
		     alert("해당 문자는 입력하실수 없습니다.");
		     obj.value = obj.value.trim().substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움
		  }
		
		}
		
		function spaceCheck(){
			 var titleBox = document.getElementById("titleBox").value.trim();
			 document.getElementById("titleBox").value = titleBox;
		}
		
		function textCheck(){
			var textareaStr = document.getElementById("content").value;
			var titleBoxStr =  document.getElementById("titleBox").value;
			document.getElementById("content").value = textareaStr.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("\\", "&#39;");
			document.getElementById("titleBox").value = titleBoxStr.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("\\", "&#39;");
			
		}
	</script>
	<head>
	<%
		int id = 0; // 아이디 변수 초기화
		if (request.getParameter("id") != null){ // 아이디 파라미터가 비어있지 않다면
			id = Integer.parseInt(request.getParameter("id")); //대입
		}
		
		BoardDao boardDao = new BoardDaoImpl(); // 클래스 객체 선언
		RecordOnBoard recordOnBoard = boardDao.selectOne(id); // 하나 조회하는 메서드 호출
	%>
		<style>@import "./Style.css";</style><!-- css 파일 임포트 -->
		<title>글 수정 하기</title>
	</head>
	<body>
		<form method="post">
			<table>
				<tbody>
					<tr><td class="leftIndex">번호</td><td><input type="text" value=<%=recordOnBoard.getId() %> name="id" readonly></td></tr><!-- 아이디 받아오는 폼 -->
					<tr><td class="leftIndex">제목</td><td><input type="text" name="title" pattern=".{1,100}" id="titleBox" value=<%=recordOnBoard.getTitle() %> required></td></tr> <!-- 제목 답아오는 폼 -->
					<tr><td class="leftIndex">일자</td><td><input type="text" value=<%=recordOnBoard.getRecord_date() %> name="record_date" readonly></td></tr> <!-- 날짜 받아오는 폼 -->
					<tr><td class="leftIndex">내용</td>
						<td><textarea name="content" id="content" style="width:300px; height:300px;"><%=recordOnBoard.getContent() %></textarea></td></tr> <!-- 내용 입력하는 폼 -->
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td><button type="button" onclick="location.href='./ShowList.jsp'">목록</button> <!-- 전체 목록으로 돌아가는 버튼 -->
							<input type="submit" onclick=spaceCheck();textCheck() formaction="./UpdateOne.jsp" value="글 수정 하기"> <!-- 수정하는 버튼 -->
							<button type="button" onclick="location.href='./DeleteOne.jsp?id=<%=id %>'">삭제</button></td> <!-- 삭제하는 버튼 -->
					</tr>
				</tfoot>
			</table>
		</form>
	</body>
</html>