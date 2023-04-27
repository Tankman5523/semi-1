package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.BoardDao;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;

public class BoardService {
	
	//등록된 게시글리스트 조회
	public ArrayList<Board> selectBoardList(PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectBoardList(conn, pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
	//게시판 조회수 증가
	public int increaseBoardCount(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().increaseBoardCount(conn, boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//특정 게시글 한개 조회
	public Board selectBoard(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new BoardDao().selectBoard(conn, boardNo);
		
		JDBCTemplate.close(conn);
		
		return b;
	}

	//좋아요 개수 증가 메소드
	public int insertLiked(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().insertLiked(conn, boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	//싫어요 개수 증가 메소드
	public int insertDislike(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().insertDislike(conn, boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}


	//게시글 작성 메소드
	public int insertBoard(Board b, Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result1 = new BoardDao().insertBoard(conn, b);
		
		int result2 = 0;
		
		if(at != null) {
			result2 = new BoardDao().insertAttachment(conn, at);
		}else {
			result2 = 1;
		}
		
		if(result1>0 && result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result1*result2;
	}
	
	
	//게시글 작성 메소드(카테고리 2)
	public int insertVideo(Board b, Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result1 = new BoardDao().insertVideo(conn, b);
		
		int result2 = 0;
		
		if(at != null) {
			result2 = new BoardDao().insertVideoAt(conn, at);
		}else {
			result2 = 1;
		}
		
		if(result1>0 && result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result1*result2;
	}
	
	

	//게시글안의 첨부파일 조회
	public Attachment selectAttachment(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Attachment at = new BoardDao().selectAttachment(conn, boardNo);
		
		JDBCTemplate.close(conn);
		
		return at;
	}

	//총 게시글 개수
	public int boardListCount() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().boardListCount(conn);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//첨부파일 아예 삭제해버리기
	public int delAt(int fno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().delAt(conn, fno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	//게시글 업데이트!
	public int updateBoard(Board b, Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result1 = new BoardDao().updateBoard(conn, b);
		
		int result2 = 0;
		
		if(at != null) {
			result2 = new BoardDao().updateAttachment(conn, at, b.getBoardNo());
		}else {
			result2 = 1;
		}
		
		if(result1>0 && result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result1*result2;
	}

	//게시글 삭제
	public int deleteBoard(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().deleteBoard(conn, bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//공지사항 조회
	public ArrayList<Board> selectNoticeList() {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectNoticeList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//댓글 등록
	public int insertRp(int uno, int bno, String content) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().insertRp(conn, uno, bno, content);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//댓글 리스트 조회
	public ArrayList<Reply> selectRpList(int bno) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Reply> list = new BoardDao().selectRpList(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//키워드에 연관된 게시글리스트 조회
	public ArrayList<Board> selectBoardList(PageInfo pi, String kind, String keyword) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectBoardList(conn, pi, kind, keyword);
		
		JDBCTemplate.close(conn);
		
		return list;

	}
	
	
	//비디오 리스트 갯수
	public int VideoListCount() {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().VideoListCount(conn);
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
		
	
	//일반비디오게시판리스트
	public ArrayList<Board> selectVideoList(PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectVideoList(conn, pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//키워드에 연관된 비디오리스트 조회
	public ArrayList<Board> selectVideoList(PageInfo pi, String kind, String keyword) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectVideoList(conn, pi, kind, keyword);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//댓글 삭제 기능
	public int delRp(int rpNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().delRp(conn, rpNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//게시글의 좋아요 취소
	public int deleteLiked(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().deleteLiked(conn, boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
			result = 2;
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//좋아요 갯수 가져오기
	public int LikedCount(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().LikedCount(conn, boardNo);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//게시글에 댓글 카운트 증가
	public int RpCountUp(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().RpCountUp(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//게시글에 댓글 카운트 감소
	public int RpCountDown(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().RpCountDown(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//키워드에의한 총 게시글 개수
	public int boardKeywordCount(String kind, String keyword) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().boardKeywordCount(conn, kind, keyword);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//일반영상페이지 업데이트
	public int updateVideo(Board b, Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().updateBoard(conn, b);
		
		int result2 = new BoardDao().updateVideoAttachment(conn, at, b.getBoardNo());
		
		if(result>0 && result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}


}
