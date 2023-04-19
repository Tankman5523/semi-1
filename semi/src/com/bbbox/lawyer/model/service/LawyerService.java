package com.bbbox.lawyer.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.dao.LawyerDao;
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

}
