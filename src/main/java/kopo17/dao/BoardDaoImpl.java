package kopo17.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;
import kopo17.domain.*;

public class BoardDaoImpl implements BoardDao{

	private String sqlUrl = "jdbc:mysql://localhost:33060/kopo17"; // 디비 주소
	private String sqlUser = "root"; // 디비 아이디
	private String sqlPassWd = "kopo1717"; // 디비 비번
		
		@Override
		public String[] insertOne(int root_id, int re_level, int re_order, String title, String content) {
			// TODO Auto-generated method stub
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				if (re_order == 0) {
					stmt.execute("update board set re_order = re_order + 1;");
				} else {
					stmt.execute("update board set re_order = re_order+1 where re_order >=" + re_order + ";");
				}
				
				stmt.execute("insert into board (root_id, re_level, re_order, visit_count, title, content, record_date, modable) "
							+ "values(" + root_id + ", " + re_level + ", " + re_order + ", 0, '" + title + "', '" + content + "', date(now()), 1);"); // 일렬번호 및 인자 넣어서 새 글 작성 쿼리 실행
				
				ResultSet rset = stmt.executeQuery("select max(id) from board;");
				rset.next();
				int id = rset.getInt(1);
				
				stmt.close(); // 스테이트먼트 종료
				rset.close();
				conn.close(); // 커넥션 종료
				
				String[] res = {"글 쓰기 완료", Integer.toString(id)};
				return res; //과정 완료 후 리턴 할 문구
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				
				String[] resError = {"글 쓰기 실패", "-1"};
				return resError; // 과정 실패 후 출력할 문구
			}		
		}

	// read	
		@Override
		public List<RecordOnBoard> selectAll() {
			// TODO Auto-generated method stub
			
			List<RecordOnBoard> RecordOnBoardList = new ArrayList<RecordOnBoard>(); // 전체 조회할 리스트 선언
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				ResultSet rset = stmt.executeQuery("select * from board order by re_order;"); // 전체 조회하는 쿼리문 실행
				while (rset.next()) { // 리절트셋 
					RecordOnBoard recordOnBoard = new RecordOnBoard(); // 도메인 클래스 객체 선언
					recordOnBoard.setId(rset.getInt(1)); // 일렬번호 구해서 세터로 넣기
					recordOnBoard.setRoot_id(rset.getInt(2));
					recordOnBoard.setRe_level(rset.getInt(3));
					recordOnBoard.setRe_order(rset.getInt(4));
					recordOnBoard.setVisit_count(rset.getInt(5));
					recordOnBoard.setTitle(rset.getString(6)); // 타이틀 구해서 세터로 넣기
					recordOnBoard.setContent(rset.getString(7)); // 내용 구해서 세터로 넣기
					recordOnBoard.setRecord_date(rset.getString(8)); // 날짜 구해서 세터로 넣기
					recordOnBoard.setModable(rset.getInt(9));
					
					RecordOnBoardList.add(recordOnBoard); // 넣은 클래스 리스트에 넣기
				}
					
				stmt.close(); // 스테이트먼트 종료
				rset.close(); // 리절트셋 종료
				conn.close(); // 커넥션 종료
				
				return RecordOnBoardList; // 전체 조회 리스트 반환
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				return null; // 과정 실패 시 널 값 반환
			}
		}
	
		@Override
		public RecordOnBoard selectOne(int id) {
			// TODO Auto-generated method stub
			
			RecordOnBoard recordOnBoard = new RecordOnBoard(); // 도메인 클래스 객체 선언

			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				stmt.execute("update board set visit_count = visit_count + 1 where id = " + id + ";");
				
				ResultSet rset = stmt.executeQuery("select * from board where id = " + id + ";"); // 일렬번호 구하는 쿼리문 실행
				rset.next(); // 리절트셋 
					recordOnBoard.setId(rset.getInt(1)); // 일렬번호 구해서 세터로 넣기
					recordOnBoard.setRoot_id(rset.getInt(2));
					recordOnBoard.setRe_level(rset.getInt(3));
					recordOnBoard.setRe_order(rset.getInt(4));
					recordOnBoard.setVisit_count(rset.getInt(5));
					recordOnBoard.setTitle(rset.getString(6)); // 타이틀 구해서 세터로 넣기
					recordOnBoard.setContent(rset.getString(7)); // 내용 구해서 세터로 넣기
					recordOnBoard.setRecord_date(rset.getString(8)); // 날짜 구해서 세터로 넣기
					recordOnBoard.setModable(rset.getInt(9));
					
				stmt.close(); // 스테이트먼트 종료
				rset.close(); // 리절트셋 종료
				conn.close(); // 커넥션 종료
				
				return recordOnBoard; //과정 완료 후 리턴 할 문구
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				return null; // 과정 실패 후 출력할 문구
			}
			
		}
		

		@Override
		public int totalRecordCount() {
			// TODO Auto-generated method stub
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				
				ResultSet rset = stmt.executeQuery("select count(*) from board;"); // 전체 레코드 개수 구하는 쿼리문 실행
				rset.next(); // 리절트셋 
				int totalRecordCount = rset.getInt(1); // 전체 레코드 구하기
				
				stmt.close(); // 스테이트먼트 종료
				rset.close(); // 리절트셋 종료
				conn.close(); // 커넥션 종료
				
				return totalRecordCount; //과정 완료 후 리턴 할 값
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				return -1; // 과정 실패 후 출력할 값
			}
			
		}


	// update
		@Override
		public String updateOne(int id, String title, String content) {
			// TODO Auto-generated method stub
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				
				stmt.execute("update board set title = '" + title + "', content = '" + content + "', record_date = date(now())  where id =" + id + ";"); // 레코드 수정하는 쿼리문 실행
				
				stmt.close(); // 스테이트먼트 종료
				conn.close(); // 커넥션 종료
				
				return "글 수정 완료"; //과정 완료 후 리턴 할 문구
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				return "글 수정 오류"; // 과정 실패 후 출력할 문구
			}
		}

	// delete
		@Override
		public String deleteOne(int id, int re_level, int re_order) {
			// TODO Auto-generated method stub
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				if (re_level != 0) {
					stmt.execute("update board set title = '삭제된 댓글입니다.', content = '삭제된 댓글입니다.', modable=false where id =" + id + ";");
					
				} else {
					ResultSet rset = stmt.executeQuery("select count(*) from board where id = " + id + " or root_id =" + id + ";");
					rset.next();
					int cnt = rset.getInt(1);
					
					stmt.execute("delete from board where id =" + id + " or root_id = " + id + ";"); // 레코드 삭제하는 쿼리문 실행
					
					stmt.execute("update board set re_order=re_order - " + cnt + " where re_order > " + re_order + ";");
					
					rset.close();
				}
				
				stmt.close(); // 스테이트먼트 종료
				conn.close(); // 커넥션 종료
				
				return "글 삭제 완료"; //과정 완료 후 리턴 할 문구
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				return "글 삭제 오류"; // 과정 실패 후 출력할 문구
			}
			
		}

		@Override
		public int replyOrderCount(int root_id, int re_level, int re_order) {
			// TODO Auto-generated method stub
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버
				Connection conn = DriverManager.getConnection(sqlUrl,sqlUser,sqlPassWd); // 커넥션
				Statement stmt = conn.createStatement(); //스테이트먼트
				
				ResultSet rset = stmt.executeQuery("select count(*)+1 from board where root_id=" + root_id + " and re_level = " + re_level + " and re_order < " + re_order  + ";"); // 전체 레코드 개수 구하는 쿼리문 실행
				rset.next(); // 리절트셋 
				int replyOrderCount = rset.getInt(1); // 전체 레코드 구하기
				
				stmt.close(); // 스테이트먼트 종료
				rset.close(); // 리절트셋 종료
				conn.close(); // 커넥션 종료
				
				return replyOrderCount; //과정 완료 후 리턴 할 값
				
			} catch (Exception e) { // 예외 처리
				e.printStackTrace(); //예외 출력
				return -1; // 과정 실패 후 출력할 값
			}
		}


		

}
