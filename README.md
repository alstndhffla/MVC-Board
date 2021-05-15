# MVC(모델2) 패턴을 활용한 게시판
* 질문 및 답변 계층형 구조 게시판

# 개발환경
* 프로그래밍 언어 - Java 11
* 데이터베이스 - Oracle 11g database(sqldeveloper)
* Tomcat9.0 활용 웹 어플리케이션 동작

# 데이터베이스 구조 
* t_board
  * articleNO, parentNO, title, content, imgFileName, writeDate, id
* t_member
  * id, pwd, name, email, joinDate 

# 기능
* 이미지 업로드(제이쿼리 사용해 이미지 파일첨부 시 미리보기 가능)