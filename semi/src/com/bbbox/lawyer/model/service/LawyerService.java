package com.bbbox.lawyer.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.dao.LawyerDao;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

public class LawyerService {

	//전체 변호사 리스트 조회
	public ArrayList<Lawyer> selectList() {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Lawyer> list = new LawyerDao().selectList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//변호사 분야 조회
	public ArrayList<PartCategory> selectPart() {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<PartCategory> list = new LawyerDao().selectPart(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//선택된 변호사의 상세내용
	public Lawyer selectLawyer(int lno) {
		Connection conn = JDBCTemplate.getConnection();
		
		Lawyer law = new LawyerDao().selectLawyer(conn,lno);
		
		JDBCTemplate.close(conn);
		
		return law;
	}

	//이름으로 검색한 리스트 조회
	public ArrayList<Lawyer> searchList(String nameKey, String cateKey, String localKey) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Lawyer> lawList = new LawyerDao().searchList(conn, nameKey, cateKey, localKey);
		
		JDBCTemplate.close(conn);
				
		return lawList;
	}

	public int dibsCheck(int lawNo, int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new LawyerDao().dibsCheck(conn, lawNo, userNo);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

	public int dibsUpdate(String heart, int lawNo, int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new LawyerDao().dibsUpdate(conn,heart,lawNo,userNo);
		
		if(count==0) {
			JDBCTemplate.rollback(conn);
		}else {
			JDBCTemplate.commit(conn);
		}
		
		return count;
	}

	public int insertCounsel(Counsel c) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new LawyerDao().insertCounsel(conn, c);
		
		if(count==0) {
			JDBCTemplate.rollback(conn);
		}else {
			JDBCTemplate.commit(conn);
		}
		
		return count;
	}

	//분야 카테고리로 조회한 변호사번호,이름 리스트 조회
	public ArrayList<Lawyer> lawOptionChange(String partName) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Lawyer> lawList = new LawyerDao().lawOptionChange(conn, partName);
		
		JDBCTemplate.close(conn);
				
		return lawList;
	}

	public PartCategory partOptionChange(String lawNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		PartCategory part = new LawyerDao().partOptionChange(conn, lawNo);
		
		JDBCTemplate.close(conn);
				
		return part;
	}

}
