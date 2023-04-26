package com.bbbox.liked.model.service;

import java.sql.Connection;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.liked.model.dao.LikedDao;
import com.bbbox.liked.model.vo.Liked;

public class LikedService {

	//좋아요 등록
	public int insertLiked(Liked l) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new LikedDao().insertLiked(conn, l);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//좋아요 취소
	public int deleteLiked(Liked l) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new LikedDao().deleteLiked(conn, l);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
}
