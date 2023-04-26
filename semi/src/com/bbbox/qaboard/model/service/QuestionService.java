package com.bbbox.qaboard.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.qaboard.model.dao.QuestionDao;
import com.bbbox.qaboard.model.vo.Question;

public class QuestionService {

	public int selectQuestionBoardCount() {

		Connection conn = JDBCTemplate.getConnection();
		
		int listCount = new QuestionDao().selectQuestionBoardCount(conn);
		
		JDBCTemplate.close(conn);
		
		return listCount;
	}

	public ArrayList<Question> selectQuestionBoardList() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Question> qList = new QuestionDao().selectQuestionBoardList(conn);
		
		
		JDBCTemplate.close(conn);
		
		return qList;
	}

	public int insertQuestion(int userNo, String title, String content, String open) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new QuestionDao().insertQuestion(conn, userNo, title, content, open );
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}
	
	//작성한 1대1문의 게시글 조회 메소드 
	public Question selectQuestion(int qno, int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Question qa = new QuestionDao().selectQuestion(conn, qno, userNo);
		
		JDBCTemplate.close(conn);
		
		return qa;
	}

}
