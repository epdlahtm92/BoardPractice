package kopo17.dao;

import java.util.List;

import kopo17.domain.RecordOnBoard;

public interface BoardDao {

	// create
		public String[] insertOne(int root_id, int re_level, int re_order, String title, String content);
		
	// read
		public List<RecordOnBoard> selectAll();
		public RecordOnBoard selectOne(int id);
		
		public int totalRecordCount();
		public int replyOrderCount(int root_id, int re_level, int re_order);
		
	// update
		public String updateOne (int id, String title, String content);
		
	// delete
		public String deleteOne(int id, int re_level, int re_order);
}
