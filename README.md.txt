# MVC(모델2) 패턴을 활용한 게시판

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
* 로그인/로그아웃, 회원가입/탈퇴
* 회원이 등록한 경매, 경매에 참여한 목록, 회원 정보 확인
* 경매상품 등록/수정/삭제
* 입찰 등록/취소(회원만 가능)
* 입찰알림창(입찰금액이 경매조건에 맞거나 제한시간내에 최고입찰금일 경우)
* 경매물품 질문(게시판)
* 사이트 이용시 질문(게시판)