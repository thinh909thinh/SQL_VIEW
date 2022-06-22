use master 
go

drop database Lad9
go

create database Lad9
go 

use Lad9
go

create table KhachHang 
(
	KhachHangID int primary key,
	TenKhachHang nvarchar(50),
	DiaChi nvarchar(100),
	SDT varchar(15)
)
go

insert into KhachHang values (1,N'Vũ Duy Khánh',N'Nam Định','0369852147'),
							(2,N'Mai Xuân Tiến',N'Hà Nội','0123456789'),
							(3,N'Nguyễn Xuân Hạnh',N'Bắc Ninh','0456123789'),
							(4,N'Tống Minh Dương',N'Thanh Hoá','0321654789'),
							(5,N'Nguyễn Bá Quốc',N'Hà Nội','0123963852147'),
							(6,N'Nguyễn Bá Tiến',N'Hà Nội','0123963852147')

create table Sach_ 
(	
	SachID int primary key,
	LoaiSach nvarchar(50),
	TacGia nvarchar(50),
	NhaXuatBan nvarchar(50),
	TenSach nvarchar(100),
	Gia int ,
	SoLuong int,
)
go

insert into Sach_ values (101,N'Truyện tranh',N'Khuất Duy Tiến',N'Kim Đồng',N'Đô rê mon',10000,50),
						(102,N'Trinh Thám',N'Khuất Duy Khánh',N'Trí Đức',N'Harryporter',30000,75),
						(103,N'Văn Học',N'Khuất Duy Lai',N'Đông Đô',N'Em và Trịnh',50000,55),
						(104,N'Toán Học',N'Khuất Duy Dũng',N'Quốc Gia',N'Định Lý Viet',15000,25),
						(105,N'CNTT',N'Khuất Duy Trinh',N'Hoài Đức',N'Lập Trình C',1000,14)


create table SachDaBan 
(	
	HoaDonSach int primary key,
	KhachHangID int constraint fk_KhachHangID 
	foreign key (KhachHangID) 
	references KhachHang(KhachHangID),
	SachID int constraint fk_SachID 
	foreign key (SachID) 
	references Sach_(SachID),
	NgayBan date,
	GiaSachTaiThoiDiemBan int,
	SoLuongDaBan int
)
go

insert into SachDaBan values (301,1,101,'2022-1-9',25000,3),
							(302,1,102,'2022-2-9',25000,3),
							(303,2,103,'2022-5-9',25000,3),
							(304,2,104,'2022-5-9',25000,3),
							(305,3,105,'2022-1-9',25000,3),
							(306,3,101,'2022-4-9',25000,3),
							(307,4,102,'2022-3-9',25000,3),
							(308,4,103,'2022-6-9',25000,3),
							(309,5,104,'2022-6-9',25000,3),
							(310,5,105,'2022-5-9',25000,3)

create view V_SachDaBan as 
select Sach_.TenSach,SachDaBan.GiaSachTaiThoiDiemBan,sum(SachDaBan.SoLuongDaBan) as
TongSoLuongBan
from Sach_
join SachDaBan on
Sach_.SachID = SachDaBan.SachID 
group by Sach_.TenSach,SachDaBan.GiaSachTaiThoiDiemBan

select * from V_SachDaBan 
go

create view V_SachDaMuaKhachHang as 
select TenKhachHang,DiaChi, sum(SoLuongDaBan) as SoLuongDaMua
from KhachHang
join SachDaBan on 
KhachHang.KhachHangID = SachDaBan.KhachHangID
group by TenKhachHang,DiaChi

select * from V_SachDaMuaKhachHang 
go

create view V_SachDaMuaKhachHangDaMuaThangTruoc as 
select TenKhachHang,DiaChi,TenSach 
from ((KhachHang join SachDaBan on KhachHang.KhachHangID = SachDaBan.KhachHangID)
join Sach_ on Sach_.SachID = SachDaBan.SachID)
where month(GETDATE()) - month(NgayBan) = 1

select TenKhachHang,sum(SachDaBan.GiaSachTaiThoiDiemBan * SoLuongDaBan) as CCC
from KhachHang
join SachDaBan on
KhachHang.KhachHangID = SachDaBan.KhachHangID
group by TenKhachHang,SachDaBan.GiaSachTaiThoiDiemBan
select * from V_SachDaMuaKhachHangDaMuaThangTruoc


--------------------------BTVN----------------------------------


CREATE TABLE CLASS(
    CLASSCODE VARCHAR(10) PRIMARY KEY,
    HEADTEACHER VARCHAR (30),
    RO0M VARCHAR (30),
    TIMESLOT CHAR,
    CLOSEDATE DATETIME
)
GO

CREATE TABLE STUDENT(
    ROLLNO VARCHAR(10) PRIMARY KEY,
    CLASSCODE VARCHAR(10) FOREIGN KEY (CLASSCODE) REFERENCES CLASS(CLASSCODE),
    FULLNAME VARCHAR (30),
    MALE BIT,
    BIRTHDATE DATETIME,
    ADDRESS VARCHAR(30),
    PROVINE CHAR(2),
    EMAIL VARCHAR(30)

)
GO

CREATE TABLE SUBJECTT(
 SUBJECTTCODE VARCHAR(10) PRIMARY KEY,
 SUBJECTTNAME VARCHAR(40),
 WTEST BIT,
 PTEST BIT,
 WTESTPER INT,
 PTESTPER INT

)

GO

CREATE TABLE MARK(
   ROLLNO VARCHAR (10) FOREIGN KEY (ROLLNO) REFERENCES STUDENT(ROLLNO),
   SUBJECTTCODE VARCHAR (10) FOREIGN KEY (SUBJECTTCODE) REFERENCES SUBJECTT(SUBJECTTCODE),
   WRARK FLOAT,
   PMARK FLOAT,
   MARKT FLOAT

)
GO

INSERT INTO CLASS(CLASSCODE,HEADTEACHER,RO0M,TIMESLOT,CLOSEDATE) VALUES('C01','HANG','LOP3','L','3-7-2022'),
                                                                       ( 'C02','HANG','LOP3','L','3-7-2022'),
                                                                       ('C03','HANG','LOP3','L','3-7-2022'),
                                                                       ('C04','MAI','LOP3','M','3-7-2022'),
                                                                       ('C05','MAI','LOP3','M','3-7-2022'),
                                                                       ('C06','MAI','LOP3','M','3-7-2022')




                                            

INSERT INTO STUDENT(ROLLNO,CLASSCODE,FULLNAME,MALE,BIRTHDATE,ADDRESS,PROVINE,EMAIL) VALUES('111','C01','Thinh1','1','12-27-1998','THAINGUYEN','TN','Thinh1@GMAIL'),
																							('112','C01','Thinh2','1','12-27-1998','THAINGUYEN','TN','Thinh2@GMAIL'),
                                                                                          ('113','C02','Thinh3','1','12-27-2000','HANOI','HN','Thinh3@GMAIL'),
																						  ('114','C02','Thinh31','1','12-27-2000','HANOI','HN','Thinh3@GMAIL'),
                                                                                          ('115','C03','Thinh4','1','12-30-1998','BACKAN','BK','Thinh4@GMAIL'),
																						   ('116','C03','Thinh41','1','12-30-1998','BACKAN','BK','Thinh4@GMAIL'),
                                                                                          ('117','C04','Thinh5','1','12-27-2003','THAINGUYEN','TN','Thinh5@GMAIL'),
																						   ('118','C04','Thinh51','1','12-27-2003','THAINGUYEN','TN','Thinh5@GMAIL'),
                                                                                          ('119','C05','Thinh6','1','12-27-1995','BACNINH','BN','Thinh6@GMAIL'),
																						   ('120','C05','Thinh61','1','12-27-1995','BACNINH','BN','Thinh6@GMAIL'),
                                                                                          ('121','C05','Thinh7','1','12-27-1995','BACNINH','BN','Thinh7@GMAIL'),
																						  ('122','C05','Thinh71','1','12-27-1995','BACNINH','BN','Thinh7@GMAIL')

INSERT INTO SUBJECTT(SUBJECTTCODE,SUBJECTTNAME,WTEST,PTEST,WTESTPER,PTESTPER) VALUES('M1','HOAHOC','1','1',20,20),
                                                                                    ('M2','TOANHOC','1','1',20,20),
                                                                                    ('M3','VANHOC','1','1',20,20),
                                                                                    ('M4','LY','1','1',20,20),
                                                                                    ('M5','VAN','1','1',20,20)
                                                                                    

INSERT INTO   MARK(ROLLNO,SUBJECTTCODE,WRARK,PMARK,MARKT) VALUES('111','M1',80,80,100),   
                                                               ('112','M2',80,80,100) ,
                                                               ('113','M3',80,80,100) ,
                                                               ('114','M4',80,80,100) ,
                                                               ('115','M5',80,80,100) ,
                                                               ('116','M1',80,80,80) ,
															   ('117','M2',80,80,100) ,
                                                               ('118','M3',80,80,100) ,
                                                               ('119','M4',80,80,100) ,
                                                               ('120','M5',80,80,100) ,
                                                               ('121','M1',80,80,80) 

INSERT INTO   MARK(ROLLNO,SUBJECTTCODE,WRARK,PMARK,MARKT) VALUES('111','M3',80,80,100)
INSERT INTO   MARK(ROLLNO,SUBJECTTCODE,WRARK,PMARK,MARKT) VALUES('111','M3',80,80,100)
INSERT INTO   MARK(ROLLNO,SUBJECTTCODE,WRARK,PMARK,MARKT) VALUES('112','M3',80,80,100)




SELECT * FROM CLASS        
SELECT * FROM STUDENT    
SELECT * FROM SUBJECTT       
SELECT * FROM MARK  
												
	
----cau 1

CREATE VIEW MT1 AS
SELECT S.FullName, COUNT(M.SUBJECTTCODE) AS KETQUA
FROM STUDENT S , MARK M 
WHERE S.ROLLNO = M.ROLLNO 
GROUP BY S.FullName
HAVING COUNT(M.SUBJECTTCODE) >=2

SELECT * FROM MT1
----------cau 2 
CREATE VIEW map11 AS
  SELECT STUDENT.FULLNAME, STUDENT.ROLLNO, MARK.MARKT
  FROM STUDENT
  INNER JOIN MARK
  ON STUDENT.ROLLNO = MARK.ROLLNO
  WHERE MARK.MARKT >= 100
  SELECT * FROM map11
  --------cau 3                
  CREATE VIEW Vcau3 AS
  SELECT STUDENT.FULLNAME, CLASS.TIMESLOT
  FROM STUDENT
  INNER JOIN CLASS
  ON STUDENT.CLASSCODE = CLASS.CLASSCODE
  WHERE CLASS.TIMESLOT = 'M';

  SELECT * FROM Vcau3
  CREATE VIEW TENGIAOVIEN AS
  SELECT  CLASS.HEADTEACHER, COUNT(MARK.MARKT) AS TENGV
  FROM CLASS,STUDENT,MARK
  WHERE STUDENT.CLASSCODE = CLASS.CLASSCODE AND STUDENT.ROLLNO = MARK.ROLLNO AND MARKT=100
  GROUP BY HEADTEACHER
  HAVING COUNT(MARKT)>2

  SELECT * FROM TENGIAOVIEN
----------------------------------------------CAU 6
------Tạo một khung nhìn chứa danh sách các sinh viên thi trượt môn EPC của từng lớp. Khung nhìn
------------------------------------------này phải chứa các cột: Tên sinh viên, Tên lớp, Tên Giáo viên, Điểm thi môn EPC.
create view V_Diem as 
select MARK.MARKT,CLASS.HEADTEACHER ,CLASS.RO0M,STUDENT.FULLNAME
from STUDENT join MARK on STUDENT.ROLLNO=MARK.ROLLNO 
join CLASS on   CLASS.CLASSCODE=STUDENT.CLASSCODE 
join SUBJECTT on SUBJECTT.SUBJECTTCODE=MARK.SUBJECTTCODE
where SUBJECTT.SUBJECTTNAME='HOAHOC' and MARK.MARKT<100
	
	select * from V_Diem

