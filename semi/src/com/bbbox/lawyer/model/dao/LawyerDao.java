package com.bbbox.lawyer.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

public class LawyerDao {
	
	private Properties prop = new Properties();
	
	public LawyerDao() {
		String filePath = LawyerDao.class.getResource("/sql/lawyer/lawyer-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	//변호사 전체 리스트 조회
	public ArrayList<Lawyer> selectList(Connection conn) {
		
		ArrayList<Lawyer> list = new ArrayList<>();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Lawyer(rset.getInt("LAW_NO"),
									rset.getString("USER_NAME"),
									rset.getString("PART_NAME"),
									rset.getString("COMPANY_NAME"),
									rset.getString("COMPANY_ADDRESS")));

			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	public ArrayList<PartCategory> selectPart(Connection conn) {
		ArrayList<PartCategory> list = new ArrayList<>();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectPart");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new PartCategory(rset.getInt("PART_NO"),
									rset.getString("PART_NAME")));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	public Lawyer selectLawyer(Connection conn, int lno) {
		Lawyer law = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectLawyer");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, lno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				law = new Lawyer(rset.getInt("LAW_NO"),
								 rset.getString("USER_NAME"),
								 rset.getString("PART_NAME"),
								 rset.getString("EXAM"),
								 rset.getInt("EXAM_SESSION"),
								 rset.getInt("PASS_DATE"),
								 rset.getString("COMPANY_NAME"),
								 rset.getString("COMPANY_ADDRESS"),
								 rset.getString("COMPANY_PN"),
								 rset.getString("LAW_COMMENT"),
								 rset.getString("CAREER"));
			}
			
			System.out.println(law);
					
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
	
		return law;
	}

	public ArrayList<Lawyer> searchList(Connection conn, String nameKey, String cateKey, String localKey) {
		
		ArrayList<Lawyer> lawList = new ArrayList<>();
		
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("searchList");
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			//이름 값
			if(nameKey.equals("")) {
				pstmt.setString(1, "%%");
			}else {
				pstmt.setString(1, "%"+nameKey+"%");
			}
			
			//분야 값
			if(cateKey.equals("전체")) {
				pstmt.setString(2, "%%");
			}else {
				pstmt.setString(2, "%"+cateKey+"%");
			}
			
			//지역 값
			if(localKey.equals("전체")) {
				pstmt.setString(3, "%%");
			}else {
				pstmt.setString(3, "%"+localKey+"%");
			}
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				lawList.add(new Lawyer(rset.getInt("LAW_NO"),
									rset.getString("USER_NAME"),
									rset.getString("PART_NAME"),
									rset.getString("COMPANY_NAME"),
									rset.getString("COMPANY_ADDRESS")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return lawList;
	}

}
