package kopo17.domain;

public class RecordOnBoard {

	private int id; // 전역변수 설정
	private int root_id; // 전역변수 설정
	private int re_level; // 전역변수 설정
	private int re_order; // 전역변수 설정
	private int visit_count; // 전역변수 설정
	private String title; // 전역변수 설정
	private String content; // 전역변수 설정
	private String record_date; // 전역변수 설정
	private boolean modable; // 전역변수 설정
	
	//게터 세터 설정
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoot_id() {
		return root_id;
	}
	public void setRoot_id(int root_id) {
		this.root_id = root_id;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public int getRe_order() {
		return re_order;
	}
	public void setRe_order(int re_order) {
		this.re_order = re_order;
	}
	public int getVisit_count() {
		return visit_count;
	}
	public void setVisit_count(int visit_count) {
		this.visit_count = visit_count;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRecord_date() {
		return record_date;
	}
	public void setRecord_date(String record_date) {
		this.record_date = record_date;
	}
	public boolean isModable() {
		return modable;
	}
	public void setModable(int modable) {
		if (modable == 1) {
			this.modable = true;
		} else {
			this.modable = false;
		}
	}
	

	
}
