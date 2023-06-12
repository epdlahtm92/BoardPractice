package kopo17.service;

import kopo17.dao.*;
import kopo17.dto.*;

public class BoardServiceImpl implements BoardService{

	@Override
	public Pagination getPagination(int page, int countPerPage) { // 페이지 네이션 계산 메소드
		BoardDao boardDao = new BoardDaoImpl(); // 객체 생성
		int totalCount = boardDao.totalRecordCount(); // 총개수 가져오기
		Pagination pagination = new Pagination(); // 페이지네이션 객체 생성
		
		int maxPage; // 총 페이지수
		if (totalCount % countPerPage != 0) { // 총 페이지수 구하기
			maxPage = (totalCount/countPerPage) + 1;
		} else {
			maxPage = (totalCount/countPerPage);
		}
		
		int c = page; // 현재 페이지
		if(c > maxPage) {
			c = maxPage;
		} else if (c <= 0) {
			c = 1;
		}
		
		int s;
		if (c % 10 == 0) { // 탭 시작 페이지
			s = ((c-1) / 10)*10 + 1;
		} else {
			s = (c / 10)*10 + 1;
		}
		
		int pp = 1; // 맨 앞 페이지
		if(s == 1) {
			pp = -1;
		}
		
		int e = s + 9; // 탭 마지막 페이지
		if (e > maxPage) {
			e = maxPage;
		}
		
		int p = s - 10; // 이전
		if (s == 1) {
			p = -1;
		} 
		
		int n = s + 10; // 다음
		if (n > maxPage) {
			n = -1;
		}
		
		int nn = maxPage; // 맨 뒤

		if (s + 10 > maxPage) { //맨뒤 예외 조건
			nn = -1;
		}
	
		//세터로 값 넣어주기
		pagination.setPp(pp);
		pagination.setP(p);
		pagination.setC(c);
		pagination.setS(s);
		pagination.setE(e);
		pagination.setN(n);
		pagination.setNn(nn);
	
		return pagination;
	}
}
