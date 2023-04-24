package com.bbbox.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;

public class BoardDao {
	
	Properties prop = new Properties();
	
	public BoardDao() {
		String filePath = BoardDao.class.getResource("/sql/board/board-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	//등록된 게시글 조회
	public ArrayList<Board> selectBoardList(Connection conn, PageInfo pi) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectBoardList");
		
		try {
			int start=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int end=(start+pi.getBoardLimit())-1;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("RP_COUNT")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	//게시판 조회수 증가
	public int increaseBoardCount(Connection conn, int boardNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("increaseBoardCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);			
		}
		
		return result;
	}
	

	//특정 게시글 한개 조회
	public Board selectBoard(Connection conn, int boardNo) {
		
		Board b = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new Board(rset.getInt("BOARD_NO"),
							  rset.getString("USER_ID"),
							  rset.getInt("CATEGORY_NO"),
							  rset.getString("TITLE"),
							  rset.getString("CONTENT"),
							  rset.getInt("COUNT"),
							  rset.getDate("CREATE_DATE"),
							  rset.getInt("LIKED"),
							  rset.getInt("RP_COUNT"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		
		return b;
	}

	//좋아요 증가 메소드
	public int insertLiked(Connection conn, int boardNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertLiked");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);			
		}
		
		return result;
	}

	//게시글 작성 메소드 (카테고리 1고정 -> pstmt 위치함수로 바꾸기)
	public int insertBoard(Connection conn, Board b) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(b.getBoardWriter()));
			pstmt.setString(2, b.getTitle());
			pstmt.setString(3, b.getContent());
			pstmt.setString(4, b.getNotice());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//게시글 작성할때 포함된 첨부파일 등록
	public int insertAttachment(Connection conn, Attachment at) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//게시글에 관련된 첨부파일 조회
	public Attachment selectAttachment(Connection conn, int boardNo) {
		
		Attachment at = null;
		ResultSet rset= null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				at = new Attachment(rset.getInt("FILE_NO"),
									rset.getInt("REF_BNO"),
									rset.getString("ORIGIN_NAME"),
									rset.getString("CHANGE_NAME"),
									rset.getString("FILE_PATH"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return at;
	}

	//총 게시글 개수
	public int boardListCount(Connection conn) {
		
		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("boardListCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				result = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return result;
	}

	//첨부파일 아예 삭제해버리기
	public int delAt(Connection conn, int fno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("delAt");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		
		return result;
	}

	//게시글 업데이트
	public int updateBoard(Connection conn, Board b) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateBoard");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getTitle());
			pstmt.setString(2, b.getContent());
			pstmt.setInt(3, b.getBoardNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//업데이트한 게시글의 포함된 첨부파일 업데이트
	//insertAttachment메소드를 안쓰고 새로만드는 이유는 mapper에 ref_bno가 SEQ_BNO.CURRVAL로 고정되어있기 때문
	public int updateAttachment(Connection conn, Attachment at, int boardNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateAttachment");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			pstmt.setString(2, at.getOriginName());
			pstmt.setString(3, at.getChangeName());
			pstmt.setString(4, at.getFilePath());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//게시글 삭제
	public int deleteBoard(Connection conn, int bno) {

		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteBoard");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//공지사항 리스트 조회
	public ArrayList<Board> selectNoticeList(Connection conn) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		Statement stmt = null;
		
		String sql = prop.getProperty("selectNoticeList");
		
		try {
			
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("RP_COUNT")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
		}
		
		return list;
	}

	//댓글등록
	public int insertRp(Connection conn, int uno, int bno, String content) {

		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertRp");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setInt(2, uno);
			pstmt.setString(3, content);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		
		return result;
	}

	//댓글 리스트 조회
	public ArrayList<Reply> selectRpList(Connection conn, int bno) {
		
		ArrayList<Reply> list = new ArrayList<>();
		
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectRpList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Reply(rset.getInt("RP_NO"),
								   rset.getString("USER_ID"),
								   rset.getString("CONTENT"),
								   rset.getString("CREATE_DATE")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return list;
	}

	//키워드에 연관된 게시글리스트 조회
	public ArrayList<Board> selectBoardList(Connection conn, PageInfo pi, String kind, String keyword) {

		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = null;
		
		if(kind.equals("title")) {
			sql = prop.getProperty("searchTitle");
		}else if(kind.equals("content")){
			sql = prop.getProperty("searchContent");
		}else if(kind.equals("userId")) {
			sql = prop.getProperty("searchUser");
		}
		
		try {
			int start=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int end=(start+pi.getBoardLimit())-1;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("RP_COUNT")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}
	
	
	//일반비디오게시글리스트 갯수
	public int VideoListCount(Connection conn) {
		
		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("VideoListCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				result = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return result;
	}

	
	//일반 비디오리스트 조회
	public ArrayList<Board> selectVideoList(Connection conn, PageInfo pi) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectVideoList");
		
		try {
			int start=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int end=(start+pi.getBoardLimit())-1;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("RP_COUNT")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	//키워드에 관련된 비디오조회
	public ArrayList<Board> selectVideoList(Connection conn, PageInfo pi, String kind, String keyword) {

		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = null;
		
		if(kind.equals("title")) {
			sql = prop.getProperty("searchTitleV");
		}else if(kind.equals("content")){
			sql = prop.getProperty("searchContentV");
		}else if(kind.equals("userId")) {
			sql = prop.getProperty("searchUserV");
		}
		
		try {
			int start=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int end=(start+pi.getBoardLimit())-1;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("RP_COUNT")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	//댓글 삭제 기능
	public int delRp(Connection conn, int rpNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("delRp");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rpNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}


	

}
