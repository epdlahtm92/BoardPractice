package kopo17.dto;

public class Pagination {
	private int c; // 현재 페이지
	private int s; // 맨 앞 탭
	private int e; // 맨 뒤 탭
	private int p; // 앞으로
	private int pp; // 맨 앞
	private int n; // 다음
	private int nn; // 맨뒤

	/// 게터 세터 설정////
	public int getC() {
		return c;
	}
	public void setC(int c) {
		this.c = c;
	}
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
	}
	public int getE() {
		return e;
	}
	public void setE(int e) {
		this.e = e;
	}
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public int getPp() {
		return pp;
	}
	public void setPp(int pp) {
		this.pp = pp;
	}
	public int getN() {
		return n;
	}
	public void setN(int n) {
		this.n = n;
	}
	public int getNn() {
		return nn;
	}
	public void setNn(int nn) {
		this.nn = nn;
	}
	
	
	
}
