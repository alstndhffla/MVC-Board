# MVC(모델2) 패턴을 활용한 게시판
* 답변형 게시판

# 개발 환경
* 프로그래밍 언어 - Java 11
* 데이터베이스 - Oracle 11g database(sqldeveloper)
* Tomcat9.0 활용 웹 어플리케이션 동작

# 데이터베이스 구조 
* t_board
  * articleNO, parentNO, title, content, imgFileName, writeDate, id
> 답변형 게시판 글을 저장하는 테이블 컬럼. 게시판의 글을 작성하려면 회원이 로그인 상태여야 한다. 즉, 각 글에는 작성자 ID 가 저장된다. 따라서 게시판 테이블의 ID 컬럼은 회원 테이블의 ID 컬럼에 대해 외래키를 속성으로 가진다.
> 부모 글 번호는 답변을 단 글 번호를 의미. 자신이 최초 글이면 부모 글 번호는 0이다.
* t_member
  * id, pwd, name, email, joinDate 

# MVC 설계 구조
* Model : BoardService.java, BoardDAO.java, ArticleVO.java
* View : JSP 파일
* Controller : BoardController.java

# 흐름도
* 클라이언트(브라우저) 요청시 : JSP -> BoardController -> BoardService -> BoardDAO -> DB(데이터베이스)
> Service 클래스의 메서드를 이용해 큰 기능을 단위 기능으로 나눈 후 Service 클래스의 각 메서드는 자신의 기능을 더 세부적인 기능을 하는 DAO의 SQL문들을 조합해서 구현(유지보수 및 확장성을 위함)

# 기능
* 전체 글 목록 보기
* 글 쓰기
* 글 상세보기
* 글 수정
* 글 삭제
* 글 답글쓰기
* 전체 글 목록 페이징
* 이미지 업로드(제이쿼리 사용해 이미지 파일첨부 시 미리보기 가능)