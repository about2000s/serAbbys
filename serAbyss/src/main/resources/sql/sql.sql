
/*기찬씨가 06/14일에 sql 편집 해놓음 사업자등록번호 등등 추가*/
--사람
create table person (
   person_idx number primary key,--인덱스
   person_id varchar2(50) unique,--아이디
   person_pw varchar2(500) not null,--비밀번호
   person_name varchar2(20) not null,--이름
   person_birth varchar2(50) not null,--생년월일
   person_email varchar2(100) unique,--이메일
   person_address varchar2(200) not null,--주소
   person_phone varchar2(20) unique,--폰번호
   person_call varchar2(20),--유선전화번호
   person_fax varchar2(20),--팩스
   person_check varchar2(10) check(person_check in ('n', 'y', 'a')),
   person_belong varchar2(50),  --소속 회사. 고객이거나, 개인사업자의 경우 null
   person_busiNum number
);

select * from person;

insert into person (person_idx, person_id, person_pw, person_name, person_birth, person_email, person_address, person_phone, person_call, person_fax, person_check) 
values (person_seq.nextval, 'adminjjh', '111111', '관리자정재훈', '980819', 'wjdwogns@as.com', '정재훈주소', '01012112352', null, null, 'a');

insert into person (person_idx, person_id, person_pw, person_name, person_birth, person_email, person_address, person_phone, person_call, person_fax, person_check, person_belong, person_busiNum) 
values (person_seq.nextval, 'samsungadmin', '111111', '삼성관리자', '980819', 'a@as.com', '삼성본사주소', '01099999999', null, null, 'y', 'samsung', 1234);

insert into person (person_idx, person_id, person_pw, person_name, person_birth, person_email, person_address, person_phone, person_call, person_fax, person_check, person_belong) 
values (person_seq.nextval, 'choi123', '111111', '삼성직원1', '982819', 'asd@as.com', '직원주소', '01011112352', null, null, 'y', 'samsung');

insert into person (person_idx, person_id, person_pw, person_name, person_birth, person_email, person_address, person_phone, person_call, person_fax, person_check, person_belong) 
values (person_seq.nextval, 'kim123', '111111', '삼성직원2', '982819', 'asd@as.coms', '직원주소2', '01011114352', null, null, 'y', 'samsung');

insert into person (person_idx, person_id, person_pw, person_name, person_birth, person_email, person_address, person_phone, person_call, person_fax, person_check, person_belong, person_busiNum) 
values (person_seq.nextval, 'kang123', '111111', '개인사업자1', '382819', 'qsd@as.com', '개인사업자주소1', '01011512352', null, null, 'y', null, 4354332);

insert into person (person_idx, person_id, person_pw, person_name, person_birth, person_email, person_address, person_phone, person_call, person_fax, person_check, person_belong) 
values (person_seq.nextval, 'lee123', '111111', '고객1', '982819', 'asd@s.com', '고객1주소', '01011111352', null, null, 'n', null);

create sequence person_seq start with 1 maxvalue 999999999 increment by 1 nocache;

--회사 리스트
create table companyList (
   companyList_idx number primary key,--인덱스
   companyList_name varchar2(50) unique,--회사명
   companyList_address varchar2(100) not null
);

insert into companyList values(companyList_seq.nextval, 'samsung', '삼성본사주소');

create sequence companyList_seq start with 1 maxvalue 999999999 increment by 1 nocache;

--서비스
create table service (
	service_idx number primary key,--인덱스
	service_custId varchar2(50) not null,--고객 아이디
	service_title varchar2(100) not null,--제목
	service_content varchar2(2000) not null,--내용
	service_status varchar2(50) check(service_status in ('register', 'accept', 'fixing', 'fixed', 'payBefore', 'payAfter', 'cancelRegister', 'cancelComplete', 'success')),
	service_address varchar2(500) not null,--주소
    service_uploadFile1 varchar2(200),
    service_uploadFile2 varchar2(200),
	service_reg varchar2(50) default to_char(sysdate, 'yyyy-MM-dd hh24:mi'),--글 등록 날짜
	service_engiId varchar2(50) not null,--기사 아이디
	service_viewcount number default 0,--조회수
    service_compBelong varchar2(50), --기사의 소속 회사 (개인사업자이면 null)
    service_price number --서비스 가격(서비스 완료 후 적게끔)
);

create sequence service_seq start with 1 maxvalue 999999999 increment by 1 nocache;

select * from service;

insert into service (service_idx, service_custId, service_title,
service_content, service_status, service_address, service_engiId)
values (service_seq.nextval, 'lee123', '이길동고객제목입니다', '이길동고객내용입니다',
'register', '이길동고객주소입니다', 'kim123');


--리뷰글
create table review (
	review_idx number primary key references service(service_idx),--인덱스(service글을 참조하되, 단 하나만)
	review_custId varchar2(50) not null,--게시글 작성자(헷갈리지 않기 위해 custId라 했습니다. 이건 session의 값을 받아옵니다)
	review_engiId varchar2(50),--수리기사(service 글의 engineer) @@@@@나의 생각: 이건 외래키를 써도 되지 않을 까요??
	review_uploadFile1 varchar2(200),--업로드 파일1
    review_uploadFile2 varchar2(200),--업로드 파일2
	review_title varchar2(100) not null,--리뷰글 제목
	review_content varchar2(2000) not null,--리뷰글 내용
	review_reg varchar2(50) default to_char(sysdate, 'yyyy-MM-dd hh24:mi'),
	review_starScore number not null,--별점(0.5 , 1.0 ... 4.5 , 5.0)*2 => (1, ... , 10)
	review_viewCount number default 0,
    review_compBelong varchar2(50),  --소속 회사
    review_price number
);

insert into review (review_idx, review_custId, review_engiId, review_title, review_content, review_starScore, review_compBelong) 
values(1, 'lee123', 'kim123', '수리 후기입니다', '수리 잘 받았습니다', 10, 'samsung');

--댓글
create table reply (
	reply_idx number primary key,--인덱스
	reply_bnum number references review(review_idx),--게시판의 인덱스를 외래키로 참조(나중에 a 게시글에 해당하는 댓글 리스트 불러오기용)
	reply_content varchar2(2000) not null,--댓글내용
	reply_id varchar2(50) not null,--댓글작성자(session의 값을 받아온다)
	reply_reg varchar2(50) default to_char(sysdate, 'yyyy-MM-dd hh24:mi')--댓글등록일
);

create sequence reply_seq start with 1 maxvalue 999999999 increment by 1 nocache;

insert into reply (reply_idx, reply_bnum, reply_content, reply_id) values (1, 1, '댓글내용입니다', '댓글작성id');

--예약시간에 대한 테이블.
create table reserve(
	year number,
    month number,
    day number,
    hour number
    --(ex)hour:00 ...
);

commit;

create table serCen(
    serCen_idx number primary key,
    serCen_viewCount number default 0,--조회수
    serCen_id varchar2(50) not null,--글작성자 아이디
    serCen_title varchar2(100) not null,--제목
    serCen_content varchar2(2000) not null,--내용
    serCen_reg varchar2(50) default to_char(sysdate, 'yyyy-MM-dd hh24:mi'),--날짜
    serCen_belong varchar2(50)--공지사항(notice), 자주 묻는 질문(faq).. 더 추가될 수도 있음 그래서 check 걸지 않았습니다.
    );

create sequence serCen_seq start with 1 maxvalue 999999 increment by 1 nocache;

insert into serCen ( serCen_idx,  serCen_id,  serCen_title,  serCen_content,  serCen_belong) values (serCen_seq.nextval, 'adminjjh', '공지사항 1입니다', '잘 읽어봐봐요 내용이에요', 'notice');


commit;


create table customer(
	customer_idx number references service(service_idx),  -- service 테이블 idx 외래키 겁니다~
	customer_comments varchar2(2000) not null,
	customer_reg varchar2(50) default to_char(sysdate, 'yyyy-MM-dd hh24:mi')
);

--이름으로 고객정보 쿼리 --
select * from person where person_name = '관리자정재훈';

--서비스 테이블 name 칼럼 추가
alter table service add service_name varchar(50);
alter table service add service_phone varchar(20);

--서비스 테이블 더미데이터 추가
update service set service_name = '이지은' where service_idx=3;
update service set service_name = '조이' where service_idx=2; 
update service set service_phone = '01099999999' where service_idx=2; 
update service set service_phone = '01022222222' where service_idx=3; 

--검색을 위한 customer 테이블 칼럼 추가(서비스테이블의 idx값과 동일한 값이지만 중복 가능) --
alter table customer add customer_service_idx varchar(50);

--customer table 더미데이터 --
insert into customer values( customer_seq.nextval, '전화연락 해달라고 하심' ,'2021-06-16 22:22:22' ,'1');

--customer table 고객 응대 insert 
insert into customer values (customer_seq.nextval, '전화연락 해달라고 하심' ,to_char(sysdate, 'yyyy-MM-dd hh24:mi') ,'1');


create sequence customer_idx start with 1 maxvalue 999999 increment by 1 nocache;

commit; 