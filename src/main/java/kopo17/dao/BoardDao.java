package kopo17.dao;

import java.util.List;

import kopo17.domain.RecordOnBoard;

public interface BoardDao {

	// create
		public String[] insertOne(int root_id, int re_level, int re_order, String title, String content); // 레코드 생성 메소드
		
	// read
		public List<RecordOnBoard> selectAll(); // 전체 선택 메소드
		public RecordOnBoard selectOne(int id); // 하나 선택 메소드
		
		public int totalRecordCount(); // 전체 개수 세기 메소드
		public int replyOrderCount(int root_id, int re_level, int re_order); // 댓글 순서계산 메소드
		
	// update
		public String updateOne (int id, String title, String content); //업데이트 메소드
		
	// delete
		public String deleteOne(int id, int re_level, int re_order); // 지우기 메소드
}
