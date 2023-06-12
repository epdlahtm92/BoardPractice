<%@ page contentType="text/html; charset=UTF-8" %><%--utf8 로 문자형 정해주기--%>
<%@ page import="kopo17.dao.*" %>
<% request.setCharacterEncoding("utf-8"); %> <!-- 파라미터 인코딩 -->
<!DOCTYPE html>
<html>
	<head>
		<%
			int id = 0; // 아이디 변수 초기화
			if (request.getParameter("id") != null){ // 파라미터로 받아와서 대입
				id = Integer.parseInt(request.getParameter("id"));
			}
			
			String title = null; // 제목 변수 초기화
			if (request.getParameter("title") != null){// 파라미터로 받아와서 대입
				title = request.getParameter("title");
			}
			
			String record_date = null; // 일자 변수 초기화
			if (request.getParameter("record_date") != null){// 파라미터로 받아와서 대입
				record_date = request.getParameter("record_date");
			}
			
			String content = null; // 내용 변수 초기화
			if (request.getParameter("content") != null){// 파라미터로 받아와서 대입
				content = request.getParameter("content");
			}
			
			BoardDao boardDao = new BoardDaoImpl();// 클래스 객체 선언
			String res = boardDao.updateOne(id, title, content); // 업데이트 메서드 호출
			
		%>
		<title>글 수정 하기</title>
	</head>
	<body>
		<%=res %><!--  결과 안내문 출력 -->
		<br>
		<button onclick="location.href='./InputMddForm.jsp?id=<%=id %>'">다시 쓰기</button> <!-- 돌아가기버튼 -->
		<button onclick="location.href='./SelectOne.jsp?id=<%=id %>'">글 보기</button> <!-- 돌아가기버튼 -->
		<button onclick="location.href='./ShowList.jsp'">글 목록</button> <!-- 글 목록 보기 버튼 -->
	</body>
</html>