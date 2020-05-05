select user(), database();

show tables;

create table tbl_reply(
  rno int not null auto_increment,
  bno int not null default 0,
  replytext varchar(1000) not null,
  replyer varchar(50) not null,
  regdate timestamp not null default now(),
  updatedate timestamp not null default now(),
  primary key(rno)
);
alter table tbl_reply add constraint fk_board foreign key(bno) references tbl_board(bno);

drop table tbl_reply;

desc tbl_reply;

select * from tbl_reply;

select * from tbl_board order by bno desc;

select count(rno) from tbl_reply where bno = 521;
