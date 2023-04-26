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
	
	//작성한 1대1문의 게시글 조회 메소드(작성자)
	public Question selectQuestion(int qno, int userNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Question qa = new QuestionDao().selectQuestion(conn, qno, userNo);
		
		JDBCTemplate.close(conn);
		
		return qa;
	}
	
	//작성한 1대1문의 게시글 조회 메소드 (관리자) 
	public Question selectQuestion(int qno, String admin) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Question qa = new QuestionDao().selectQuestion(conn, qno, admin);
		
		JDBCTemplate.close(conn);
		
		
		return qa;
	}

	//1대1문의 관리자 답글 메소드 
	public int insertAnswer(int qno, String answer ) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new QuestionDao().insertAnswer(conn, qno ,answer);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}

	//1대1 문의 관리자 답글 조회 
	public String selectAnswer(int qno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		String answer = new QuestionDao().selectAnswer(conn, qno);
		
		JDBCTemplate.close(conn);
		
		return answer;
	}
	
	//1대1 문의 삭제 
	public int deletQuestion(int qno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new QuestionDao().deleteQuestion(conn, qno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

}
