package news;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import news.NewsBean;

// static import : 특정 클래스의 static 메서드를 클래스명 없이 접근하기 위한 import 문
// < 기본 문법 > import static 패키지명.클래스명.메서드명; 
//               또는 import static 패키지명.클래스명.메서드명; 
//import static db.JdbcUtil.getConnection;
//import static db.JdbcUtil.close;

// db.jdbcUtil 클래스의 모든 static 메서드를 import 하는 경우
import static db.JdbcUtil.*;

public class NewsDAO {
	Connection con;
	PreparedStatement pstmt, pstmt2;
	ResultSet rs;

	// 글쓰기 작업 수행하는 insertBoard()
	// => 파라미터 : BoardBean 객체   리턴타입 : int(insertCount)
	public int insertNews(NewsBean news) {
		int insertCount = 0;
		int num = 1; // 새 글 번호를 저장할 변수(초기값으로 1 지정) 
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 3단계. SQL 구문 작성 및 전달
			// 1) 새 글 번호(num) 계산
			// 현재 게시물들 중 가장 큰 번호(num) 조회하여 조회된 num 값 + 1 을 num 에 저장하고
			// 조회 결과가 없을 경우 num 값을 새 글 번호로 사용
			String sql = "SELECT MAX(num) FROM news"; // board 테이블의 num 컬럼 중 최대값 조회
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// rs.next() 메서드를 통해 다음 레코드 존재 여부 확인
			// => 다음 레코드가 존재하는 경우 기존 게시물이 있다는 의미이므로
			//    조회된 값(num 의 최대값) + 1 을 num 변수에 저장
			if(rs.next()) { // 등록된 게시물이 하나라도 존재할 경우(= 최대값이 조회될 경우)
				num = rs.getInt(1) + 1;
			}
//			System.out.println("새 글 번호 : " + num);
			
			// 2) 글 쓰기 작업 수행(글번호는 num 변수값, 작성일은 now() 함수, 조회수는 0 으로 설정)
			sql = "INSERT INTO news VALUES (?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, news.getName());
			pstmt2.setString(3, news.getPass());
			pstmt2.setString(4, news.getSubject());
			pstmt2.setString(5, news.getContent());
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertNews()");
		} finally {
			// 자원 반환(static import 로 인해 JdbcUtil 클래스명 생략 가능)
			close(rs);
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return insertCount;
	}
	
	// 게시물 목록 조회작업을 수행하는 selectBoardList()
	// => 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit)
	//  리턴타입 : java.util.ArrayList<BoardBean>(boardList)
	public ArrayList<NewsBean> selectNewsList(int pageNum, int listLimit) {
		ArrayList<NewsBean> newsList = null;
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
			// => 시작행번호는 (페이지번호 - 1) * 목록갯수 값 사용
			//    ex) 1페이지 = (1 - 1) * 10 = 0
			//        2페이지 = (2 - 1) * 10 = 10
			//        3페이지 = (3 - 1) * 10 = 20
			int startRow = (pageNum - 1) * listLimit;
			
			// 3단계. SQL 구문 작성 및 전달
			// board 테이블의 모든 레코드 조회(글번호(num) 기준으로 내림차순 정렬)
			// => SELECT 컬럼명 FROM 테이블명 ORDER BY 정렬할컬럼명 정렬방식;
			//    (정렬 방식 - 오름차순 : ASC, 내림차순 : DESC)
			// => SELECT 컬럼명 FROM 테이블명 LIMIT 시작행번호,목록갯수;
			String sql = "SELECT * FROM news ORDER BY num DESC LIMIT ?,?";
			// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
			// => 주의! 반복문 시작 전에 미리 생성해야함
			newsList = new ArrayList<NewsBean>();
			
			// 다음레코드가 존재할 동안 반복하면서
			// 1개 레코드 정보를 BoardBean 객체에 저장 후
			// 다시 BoardBean 객체를 전체 레코드 저장하는 ArrayList<BoardBean> 객체에 추가
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardBean 객체 생성
				NewsBean news = new NewsBean();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				newsList.add(news);
			}
			
//			System.out.println(boardList);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectNewsList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return newsList;
	}
	
	// 전체 게시물 목록 갯수를 조회하는 selectListCount()
	public int selectListCount() {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM news";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectListCount()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
	}
	
	
	// 게시물 상세 내용 조회하는 selectBoard()
	// => 파라미터 : 글번호(num), 리턴타입 : BoardBean(board)
	public NewsBean selectNews(int num) {
		NewsBean news= null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM news WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// BoardBean 객체 생성 후 조회된 컬럼 데이터를 저장
				news = new NewsBean();
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
				
//				System.out.println(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectNews()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return news;
	}
	
	// 전달받은 글번호에 해당하는 게시물 조회수 증가하는 updateReadcount()
	// => 파라미터 : 글번호(num), 리턴타입 : void
	public void updateReadcount(int num) {
		try {
			con = getConnection();
			
			String sql = "UPDATE news SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateReadcount()");
		} finally {
			close(pstmt);
			close(con);
		}
		
	}
	
	// 게시물 수정 작업 
	// => 파라미터 : BoardBean 객체(board), 리턴타입 : int(updateCount)
	public int updateNews(NewsBean news) {
		int updateCount = 0;
		
		try {
			con = getConnection();
			
			// 1. 패스워드 판별 작업
//			String sql = "SELECT * FROM board WHERE num=? AND pass=?"; // 패스워드에 맞는 게시물 조회 시
			String sql = "SELECT pass FROM news WHERE num=?"; // 패스워드 조회 후 별도로 비교 시
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, news.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 조회 결과가 존재할 경우
				// 패스워드 판별 작업 수행
				if(rs.getString("pass").equals(news.getPass())) { // 패스워드 일치 시
					// 2. 수정(UPDATE) 작업
					// => 번호에 해당하는 작성자, 제목, 내용 수정
					sql = "UPDATE news SET name=?,subject=?,content=? WHERE num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, news.getName());
					pstmt2.setString(2, news.getSubject());
					pstmt2.setString(3, news.getContent());
					pstmt2.setInt(4, news.getNum());
					
					updateCount = pstmt2.executeUpdate();
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateNews()");
		} finally {
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return updateCount;
	}
	
	
	// 게시물 삭제 작업 
	// => 파라미터 : 글번호(num), 패스워드(pass)    리턴타입 : int(deleteCount)
	public int deleteNews(int num, String pass) {
		int deleteCount = 0;
		
		try {
			con = getConnection();
			
			// 글번호와 패스워드가 모두 일치하는 게시물 조회
			String sql = "SELECT * FROM news WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 조회 결과가 있을 경우(= 패스워드까지 일치할 경우)에만 삭제 작업 수행
				sql = "DELETE FROM news WHERE num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, num);
				deleteCount = pstmt2.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteNews()");
		} finally {
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return deleteCount;
	}
	
	// 최근 게시물 5개 조회 후 리턴하는 selectRecentBoardList()
	// => 파라미터 : 없음    리턴타입 : ArrayList<BoardBean>(boardList)
	public ArrayList<NewsBean> selectRecentNewsList() {
		ArrayList<NewsBean> NewsList = null;
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 3단계. SQL 구문 작성 및 전달
			// board 테이블의 모든 레코드 조회(글번호(num) 기준으로 내림차순 정렬)
			// => 단, 최근 5개의 게시물 = LIMIT 5 적용
			String sql = "SELECT * FROM news ORDER BY num DESC LIMIT ?";
			// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 5);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
			// => 주의! 반복문 시작 전에 미리 생성해야함
			NewsList = new ArrayList<NewsBean>();
			
			// 다음레코드가 존재할 동안 반복하면서
			// 1개 레코드 정보를 BoardBean 객체에 저장 후
			// 다시 BoardBean 객체를 전체 레코드 저장하는 ArrayList<BoardBean> 객체에 추가
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardBean 객체 생성
				NewsBean news = new NewsBean();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				NewsList.add(news);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectRecentNewsList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return NewsList;
	}
	
	public int selectSearchListCount(String search, String searchType) {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM news WHERE " + searchType + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + search + "%" );
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectListCount()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
	}
	public ArrayList<NewsBean> selectSearchNewsList(int pageNum, int listLimit, String search, String searchType) {
		ArrayList<NewsBean> newsList = null;
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
			// => 시작행번호는 (페이지번호 - 1) * 목록갯수 값 사용
			//    ex) 1페이지 = (1 - 1) * 10 = 0
			//        2페이지 = (2 - 1) * 10 = 10
			//        3페이지 = (3 - 1) * 10 = 20
			int startRow = (pageNum - 1) * listLimit;
			
			// 3단계. SQL 구문 작성 및 전달
			// board 테이블의 모든 레코드 조회(글번호(num) 기준으로 내림차순 정렬)
			// => SELECT 컬럼명 FROM 테이블명 ORDER BY 정렬할컬럼명 정렬방식;
			//    (정렬 방식 - 오름차순 : ASC, 내림차순 : DESC)
			// => SELECT 컬럼명 FROM 테이블명 LIMIT 시작행번호,목록갯수;
			String sql = "SELECT * FROM news WHERE " + searchType + " LIKE ? ORDER BY num DESC LIMIT ?,? ";
			// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
			// => 주의! 반복문 시작 전에 미리 생성해야함
			newsList = new ArrayList<NewsBean>();
			
			// 다음레코드가 존재할 동안 반복하면서
			// 1개 레코드 정보를 BoardBean 객체에 저장 후
			// 다시 BoardBean 객체를 전체 레코드 저장하는 ArrayList<BoardBean> 객체에 추가
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardBean 객체 생성
				NewsBean news = new NewsBean();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				newsList.add(news);
			}
			
//			System.out.println(boardList);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectNewsList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return newsList;
	}
}



















