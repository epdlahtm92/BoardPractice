<%@ page contentType="text/html; charset=UTF-8" %><%--utf8 로 문자형 정해주기--%>
<%@ page import="kopo17.dao.*" %> <!-- dao 임포트 -->
<%@ page import="kopo17.domain.*" %><!-- 도메인 임포트 -->
<%@ page import="kopo17.service.*" %> <!-- 서비스 임포트 -->
<%@ page import="kopo17.dto.*" %> <!-- dto 임포트 -->

<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %> <!-- 리스트 임포트 -->
<%@ page import="java.util.ArrayList" %> <!-- 어레이 리스트 임포트 -->
<%@ page import="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("utf-8"); %> <!-- 파라미터 인코딩 -->

<!DOCTYPE html>
<html>
	<head>
		<style>
			@import "./Style.css";
			td {text-align:left;}
		</style><!-- css 파일 임포트 -->
		<%
			BoardDao boardDao = new BoardDaoImpl(); // dao 클래스 객체 선언
			BoardService boardService = new BoardServiceImpl();
			List<RecordOnBoard> selectAllList = boardDao.selectAll(); // 전체조회 메서드 호출
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			int countPerPage = 10; // 페이지당 레코드 수 변수
			if (request.getParameter("countPerPage") != null) { // 파라미터로 받아오기
				countPerPage = Integer.parseInt(request.getParameter("countPerPage")); // 파라미터 대입
			}
			
			String newRecord = null;
			if (request.getParameter("new") != null){ // 파라미터로 받아오기
				newRecord = request.getParameter("new");
			}
			
			int id = 0;
			int pages = 0; // 페이지 계산용 변수
			if (request.getParameter("id") != null && request.getParameter("page") != null) { // 페이지 파라미터로 받아오기
				pages = Integer.parseInt(request.getParameter("page")); // 파라미터 값 대입하기
				id = Integer.parseInt(request.getParameter("id")); // 파라미터 값 대입하기
			} else if (request.getParameter("id") != null && request.getParameter("page") == null) { //아이디 값은 있지만 페이지는 없을때
				id = Integer.parseInt(request.getParameter("id")); // 파라미터 값 대입하기
				int idCnt = 0;
				int idPage = 0;
				for (RecordOnBoard recordOnBoard : selectAllList){// 전체 읽어들여서
					idCnt++;
					if (recordOnBoard.getId() == id){ // 현재 아이디의
						if (idCnt % countPerPage == 0) { //페이지 위치 계산
							idPage = ((idCnt - 1)/countPerPage) + 1; //페이지가 10의 배수일때 예외 처리
						} else {
							idPage = (idCnt/countPerPage) + 1; // 페이지 위치 계산
						}
						break;
					}
				}
				pages = idPage; //페이지 변수 대입
			} else if (request.getParameter("id") == null && request.getParameter("page") != null) {
				pages = Integer.parseInt(request.getParameter("page")); // 파파미터 값 대입하기
			}
			 
			Pagination pagination = boardService.getPagination(pages, countPerPage); // 페이지 네이션 계산
			
		%>
		<title>게시판 전체 보기</title>
	</head>
	<body>
		<table>
			<thead>
				<tr><td>번호</td><td>제목</td><td>조회 수</td><td>등록일</td></tr> <!-- 테이블 헤드 설정 -->
			</thead>
			<tbody>
				<%
					int count = 0;
					for(RecordOnBoard recordOnBoard: selectAllList){// 반복하면서
						
						String title = "";
						for(int i = 0; i < recordOnBoard.getRe_level(); i++){ // 댓글 레벨 수준 만큼
							title += "-"; // - 넣기
						}
						title = title + ">[Re] "; // 마지막에 붙여주기
						
						String cutTitle = recordOnBoard.getTitle();
						if(cutTitle.length() > 20){
							cutTitle = recordOnBoard.getTitle().substring(0, 20) + "...";
						} 
						
						if (count >= ((pagination.getC() - 1) * countPerPage) && count < (pagination.getC() * countPerPage)){ // 원하는 페이지만 출력하는 조건
							if (sdf.format(now).equals(recordOnBoard.getRecord_date())){
								out.println("<tr><td class='leftIndex'><a href='./SelectOne.jsp?id=" + recordOnBoard.getId() + "'>" + recordOnBoard.getId() + "</a></td>"); //글 아이디
								if (recordOnBoard.getRe_level() != 0){
									out.println("<td width=500 style='word-break:break-all;'><a href='./SelectOne.jsp?id=" + recordOnBoard.getId() + "&root_id=" + recordOnBoard.getRoot_id() + "'>" + title + cutTitle + "</a><span style='color:red;'> new!</span></td>"); // 글 제목
								} else {
									out.println("<td width=500 style='word-break:break-all;'><a href='./SelectOne.jsp?id=" + recordOnBoard.getId() + "&root_id=" + recordOnBoard.getRoot_id() + "'>" + cutTitle + "</a><span style='color:red;'> new!</span></td>"); // 글 제목
								}
								out.println("<td>" + recordOnBoard.getVisit_count() + "</td>"); // 방문자 수 표 안에 출력
								out.println("<td>" + recordOnBoard.getRecord_date() + "</td></tr>"); // 작성일자 표 안에 출력
								count++;
							} else {
								out.println("<tr><td class='leftIndex'><a href='./SelectOne.jsp?id=" + recordOnBoard.getId() + "'>" + recordOnBoard.getId() + "</a></td>"); //글 아이디
								if (recordOnBoard.getRe_level() != 0){
									out.println("<td width=500 style='word-break:break-all;'><a href='./SelectOne.jsp?id=" + recordOnBoard.getId() + "&root_id=" + recordOnBoard.getRoot_id() + "'>" + title + cutTitle + "</a></span></td>"); // 글 제목
								} else {
									out.println("<td width=500 style='word-break:break-all;'><a href='./SelectOne.jsp?id=" + recordOnBoard.getId() + "&root_id=" + recordOnBoard.getRoot_id() + "'>" + cutTitle + "</a></span></td>"); // 글 제목
								}
								out.println("<td>" + recordOnBoard.getVisit_count() + "</td>"); // 방문자 수 표 안에 출력
								out.println("<td>" + recordOnBoard.getRecord_date() + "</td></tr>"); // 작성일자 표 안에 출력
								count++;	
							}
						} else {
							count++;
						}
					}
				%>
			</tbody>
		</table>
		<div style="text-align:left;">
			<%
				if(pagination.getPp() == -1 || pagination.getP() == -1){ // 맨 앞 페이지일때는 앞버튼 맨앞 버튼 출력 안함
				} else {
					out.println("<a href='./ShowList.jsp?page=" + pagination.getPp() + "'>&lt;&lt;</a>"); // 만앞 버튼
					out.println("<a href='./ShowList.jsp?page=" + pagination.getP() + "'>&lt;</a>"); // 앞 버튼
				}
			
				for (int i = pagination.getS(); i <= pagination.getE(); i++) { // 페이지 버튼 반복하면셔ㅓ 출력
					if (pagination.getC() == i){ // 현재 페이지일 경우 하이라이트
						out.println("<a style='font-size:1.2em; font-weight:bold; color:#F25022;' href='./ShowList.jsp?page=" + i + "&countPerPage=" + countPerPage + "'>" + i + "</a>");
					} else { // 아닐경우 그냥
						out.println("<a href='./ShowList.jsp?page=" + i + "&countPerPage=" + countPerPage + "'>" + i + "</a>");
					}
				}
				
				if (pagination.getNn() == -1 || pagination.getN() == -1){ // 다음 및 마지막 버튼 출력 조건
				} else {
					out.println("<a href='./ShowList.jsp?page=" + pagination.getN() + "'>&gt;</a>"); // 다음 버튼
					out.println("<a href='./ShowList.jsp?page=" + pagination.getNn() + "'>&gt;&gt;</a>"); // 마지막 버튼
				}
			%>
		</div>
		<div><button onclick="location.href='./InputNewForm.jsp'">새 글</button></div> <!-- 새글 쓰기 버튼 -->
	</body>
</html>