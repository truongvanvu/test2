
CREATE TABLE Bandoc (
	MaBD char(10) primary key,
	HoTenBD nvarchar(50),
	NgaySinh Date,
	GT nchar(5) check (GT in (N'Nam', N'Nữ')),
	Diachi nvarchar(50),
	Email nchar(30),
	NgayHetHanthe date
)
go
create table NXB (
	MaNXB char(10) primary key,
	TenNXB nvarchar(50),
	SoBan int,
	Diachi nvarchar(50), 
	SDT int
)
go
create table Tacgia (
	MaTG char(10) primary key,
	TenTG nvarchar(50),
	Diachi nvarchar(50),
	SDT int
)
go
CREATE TABLE Theloai(
	MaTL char(10) primary key,
	TenTL nvarchar(30)
)
go
CREATE TABLE TuaSach(
	MaTS char(10) primary key,
	TenTS nvarchar(30),
	MaTL char(10),
	MaNXB char(10),
	Sotrang char(10),
	NamXB date,
	GiaBan int,
	foreign key (MaTL) references Theloai(MaTL),
	foreign key (MaNXB) references NXB(MaNXB),
)
go
CREATE TABLE Sangtac(
	MaTS char(10) references TuaSach(MaTS),
	MaTG char(10) references Tacgia(MaTG),
	SoBan int
	primary key (MaTS,MaTG),
)
go
CREATE TABLE Sach(
	SoCabiet char(10) primary key,
	MaTS char(10),
	Tinhtrang nvarchar(20),
	Tinhtrangmuon nvarchar(20),
	foreign key (MaTS) references TuaSach(MaTS)
)
go
CREATE TABLE Phieumuon (
	MaBD char(10),
	SoPhieu char(10) primary key,
	foreign key (MaBD) references Bandoc(MaBD)
) 
go
CREATE TABLE ChitietPM (
	SoPhieu char(10) ,
	SoCabiet char(10),
	Tinhtrang nvarchar(20),
	primary key(SoPhieu,SoCabiet),
	foreign key(SoPhieu) references Phieumuon(SoPhieu),
	foreign key(SoCabiet) references Sach(SoCabiet)
)
-- thủ tục--
/*
Cú pháp:

	CREATE PROC NAME_PROC
	{@ Prameter nếu có}
	AS
	BEGIN
		< code xử lý >
	END

nếu là câu truy vấn thì ko cần Begin và End
*/
------------------------------------- Thêm-sửa-xóa------------------------------------Bandoc
go
CREATE proc InsertBandoc
(@MaBD char(10),@HoTenBD nvarchar(50),@NgaySinh Date,@GT nchar(5),@Diachi nvarchar(50),@Email nchar(30),@NgayHetHanthe Date)
AS
begin
	insert into Bandoc(MaBD,HoTenBD,NgaySinh,GT,Diachi,Email,NgayHetHanthe)
	values(@MaBD,@HoTenBD,@NgaySinh,@GT,@Diachi,@Email,@NgayHetHanthe)
end
go

exec InsertBandoc 'bd10',N'Nguyễn Quang Trọng','1996-12-25','Nam',N'Hà Nội','trongpro@gmail.com', '2018/09/25'


select * from Bandoc;
go
CREATE proc UpdateBandoc
(@MaBD char(10),@HoTenBD nvarchar(50),@NgaySinh Date,@GT nchar(5),@Diachi nvarchar(50),@Email nchar(30),@NgayHetHanthe Date)
as
begin
	update Bandoc
	set HoTenBD = @HoTenBD,
		NgaySinh = @NgaySinh,
		GT = @GT,
		Diachi = @Diachi,
		Email = @Email,
		NgayHetHanthe = @NgayHetHanthe
	where MaBD = @MaBD
end
go
CREATE proc DeleteBandoc
@MaBD char(10)
as
begin
	delete from Bandoc
	where MaBD = @MaBD
end

 
------------------------------------- Thêm-sửa-xóa------------------------------------Tacgia

CREATE proc InsertTacgia
@MaTG char(10),@TenTG nvarchar(50),@Diachi nvarchar(50),@SDT int
AS
begin
	insert into Tacgia(MaTG,TenTG,Diachi,SDT)
	values(@MaTG,@TenTG,@Diachi,@SDT)
end
go
CREATE proc UpdateTacgia
@MaTG char(10),@TenTG nvarchar(50),@Diachi nvarchar(50),@SDT int
as
begin
	update Tacgia
	set TenTG = @TenTG,
		Diachi = @Diachi,
		SDT = @SDT
	where MaTG = @MaTG
end
go
CREATE proc DeleteTacgia
@MaTG char(10)
as
begin
	delete from Tacgia
	where MaTG = @MaTG
end

------------------------------------- Thêm-sửa-xóa------------------------------------NXB

CREATE proc InsertNXB
@MaNXB char(10),@TenNXB nvarchar(50),@SoBan int,@Diachi nvarchar(50), @SDT int
AS
begin
	insert into NXB(MaNXB,TenNXB,SoBan,Diachi,SDT)
	values(@MaNXB,@TenNXB,@SoBan,@Diachi,@SDT)
end
go
CREATE proc UpdateNXB
@MaNXB char(10),@TenNXB nvarchar(50),@SoBan int,@Diachi nvarchar(50), @SDT int
as
begin
	update NXB
	set TenNXB = @TenNXB,
		SoBan = @SoBan,
		Diachi = @Diachi,
		SDT = @SDT
	where MaNXB = @MaNXB
end
go
CREATE proc DeleteNXB
@MaNXB char(10)
as
begin
	delete from NXB
	where MaNXB = @MaNXB
end

------------------------------------- Thêm-sửa-xóa------------------------------------THeloai

CREATE proc InsertTheloai
@MaTL char(10),@TenTL nvarchar(30)
as
begin
	insert into Theloai(MaTL,TenTL)
	values (@MaTL,@TenTL)
end
go

CREATE proc UpdateTheloai
@MaTL char(10), @TenTL nvarchar(30)
as
begin
	update Theloai
	set TenTL = @TenTL
	where MaTL = @MaTL
end
go
CREATE proc DeleteTheloai
@MaTL char(10)
as
begin
	delete from Theloai
	where MaTL = @MaTL
end
go
------------------------------------- Thêm-sửa-xóa------------------------------------Tựa sách

CREATE proc InsertTuasach
@MaTS char(10),@TenTS nvarchar(30),@MaTL char(10),@MaNXB char(10),@Sotrang int,@NamXB date,@GiaBan int
as
begin
	insert into TuaSach(MaTS,TenTS,MaTL,MaNXB,Sotrang,NamXB,GiaBan)
	values (@MaTS,@TenTS,@MaTL,@MaNXB,@Sotrang,@NamXB,@GiaBan)
end
go
CREATE proc UpdateTuasach
@MaTS char(10),@TenTS nvarchar(30),@MaTL char(10),@MaTG char(10),@MaNXB char(10),@Sotrang int,@NamXB date,@GiaBan int
as
begin
	update TuaSach
	set TenTS = @TenTS,
		MaTL = @MaTL,
		MaNXB = @MaNXB,
		Sotrang = @Sotrang,
		NamXB = @NamXB,
		GiaBan = @GiaBan
	where MaTS = @MaTS
end
go
CREATE proc DeleteTuasach
@MaTS char(10)
as
begin
	delete from TuaSach
	where MaTS = @MaTS
end

------------------------------------- Thêm-sửa-xóa------------------------------------Sangtac

CREATE proc InsertSangtac
@MaTS char(10),@MaTG char(10),@SoBan int
as
begin
	insert into Sangtac(MaTS,MaTG,SoBan)
	values(@MaTS,@MaTG,@SoBan)
end
go
CREATE proc UpdateSangtac
@MaTS char(10),@MaTG char(10),@SoBan int
as
begin
	update Sangtac
	set SoBan = @SoBan
	where MaTG = @MaTG and MaTS = @MaTS
end
go
CREATE proc DeleteSangtac
@MaTS char(10),@MaTG char(10)
as
begin
	delete from Sangtac
	where MaTG = @MaTG and MaTS = @MaTS
end

------------------------------------- Thêm-sửa-xóa------------------------------------Sach

CREATE proc InsertSach
@SoCabiet char(10),@MaTS char(10),@Tinhtrang nvarchar(20),@Tinhtrangmuon nvarchar(20)
as
begin
	insert into Sach(SoCabiet,MaTS,Tinhtrang,Tinhtrangmuon)
	values (@SoCabiet,@MaTS,@Tinhtrang,@Tinhtrangmuon)
end
go
CREATE proc UpdateSach
@SoCabiet char(10),@MaTS char(10),@Tinhtrang nvarchar(20),@Tinhtrangmuon nvarchar(20)
as
begin
	update Sach
	set MaTS = @MaTS,
		Tinhtrang = @Tinhtrang,
		Tinhtrangmuon = @Tinhtrangmuon
	where SoCabiet = @SoCabiet
end
go
CREATE proc DeleteSach
@SoCabiet char(10)
as
begin
	delete from Sach
	where SoCabiet = @SoCabiet
end

------------------------------------- Thêm-sửa-xóa------------------------------------Phieumuon
go
create proc InsertPhieumuon
(@MaBD nvarchar(10),@SoPhieu nvarchar(10))
as
begin
	insert into Phieumuon(MaBD,SoPhieu)
	values (@MaBD,@SoPhieu)
end 


execute InsertPhieuMuon 'bd01','01'

select * from Phieumuon

go
CREATE proc UpdatePhieumuon
@MaBD char(10),@SoPhieu char(10)
as
begin
	update Phieumuon
	set MaBD = @MaBD
	where SoPhieu = @SoPhieu
end
go
CREATE proc DeletePhieumuon
@SoPhieu char(10)
as
begin
	delete from Phieumuon
	where SoPhieu = @SoPhieu
end
exec DeletePhieumuon '34'


------------------------------------- Thêm-sửa-xóa------------------------------------ChitietPhieumuon

CREATE proc InsertCTPM
@SoPhieu char(10) ,@SoCabiet char(10),@Tinhtrang nvarchar(20)
as
begin
	insert into ChitietPM(SoPhieu,SoCabiet,Tinhtrang)
	values (@SoPhieu,@SoCabiet,@Tinhtrang)
end
go
CREATE proc UpdateCTPM
@SoPhieu char(10) ,@SoCabiet char(10),@Tinhtrang nvarchar(20)
as
begin
	update ChitietPM
	set Tinhtrang = @Tinhtrang
	where SoPhieu = @SoPhieu and SoCabiet = @SoCabiet
end
go
CREATE proc DeleteCTPM
@SoPhieu char(10) ,@SoCabiet char(10)
as
begin
	delete from ChitietPM
	where SoPhieu = @SoPhieu and SoCabiet = @SoCabiet
end















