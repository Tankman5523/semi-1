package com.bbbox.lawyer.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.dao.LawyerDao;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

public class LawyerService {

	public ArrayList<Lawyer> selectList() {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Lawyer> list = new LawyerDao().selectList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public ArrayList<PartCategory> selectPart() {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<PartCategory> list = new LawyerDao().selectPart(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public Lawyer selectLawyer(int lno) {
		Connection conn = JDBCTemplate.getConnection();
		
		Lawyer law = new LawyerDao().selectLawyer(conn,lno);
		
		JDBCTemplate.close(conn);
		
		return law;
	}

}
