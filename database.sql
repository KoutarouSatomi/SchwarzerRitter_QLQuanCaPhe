USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 15/03/2023 6:27:39 CH ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SATOMI\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SATOMI\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCafe', N'ON'
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE = OFF
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1]
(
 @strInput NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN 
 IF @strInput IS NULL RETURN @strInput
 IF @strInput = '' RETURN @strInput
 DECLARE @RT NVARCHAR(4000)
 DECLARE @SIGN_CHARS NCHAR(136)
 DECLARE @UNSIGN_CHARS NCHAR (136)
 SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế
 ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý
 ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ
 ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'
 +NCHAR(272)+ NCHAR(208)
 SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee
 iiiiiooooooooooooooouuuuuuuuuuyyyyy
 AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII
 OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 DECLARE @COUNTER int
 DECLARE @COUNTER1 int
 SET @COUNTER = 1
 WHILE (@COUNTER <=LEN(@strInput))
 BEGIN 
 SET @COUNTER1 = 1
 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
 BEGIN
 IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1))
 = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
 BEGIN 
 IF @COUNTER=1
 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
 + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
 ELSE
 SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1)
 +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
 + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
 BREAK
 END
 SET @COUNTER1 = @COUNTER1 +1
 END
 SET @COUNTER = @COUNTER +1
 END
 SET @strInput = replace(@strInput,' ','-')
 RETURN @strInput
END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tableName] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'ddd', N'aaaa', N'2251022057731868917119086224872421513662', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'Kouta', N'Satom', N'2251022057731868917119086224872421513662', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'Nanami', N'Nanami', N'2251022057731868917119086224872421513662', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1025, CAST(N'2023-03-10' AS Date), CAST(N'2023-03-10' AS Date), 1, 1, 20, 61600)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1026, CAST(N'2023-03-10' AS Date), CAST(N'2023-03-10' AS Date), 2, 1, 20, 37600)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1027, CAST(N'2023-03-10' AS Date), CAST(N'2023-03-10' AS Date), 3, 1, 0, 51000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1028, CAST(N'2023-03-10' AS Date), CAST(N'2023-03-12' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1029, CAST(N'2023-03-10' AS Date), CAST(N'2023-03-10' AS Date), 2, 1, 50, 87500)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1030, CAST(N'2023-03-12' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 90000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1031, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1032, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1033, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1034, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1035, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1036, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1037, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1038, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 90000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1039, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1040, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1041, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1042, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1043, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1044, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1045, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1046, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1047, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1048, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1049, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1050, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1051, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1052, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1053, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1054, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1055, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1056, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 2, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1057, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 2, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1058, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 2, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1059, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 1, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1060, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 7, 1, 0, 45000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1061, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-15' AS Date), 7, 1, 0, 45000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1038, 1025, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1039, 1025, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1040, 1025, 6, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1041, 1026, 6, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1042, 1026, 3, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1043, 1027, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1044, 1027, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1045, 1029, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1046, 1029, 4, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1052, 1030, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1053, 1031, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1054, 1032, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1055, 1033, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1056, 1034, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1057, 1035, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1058, 1036, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1059, 1037, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1060, 1038, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1061, 1039, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1062, 1040, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1063, 1041, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1064, 1042, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1065, 1043, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1066, 1044, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1067, 1045, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1068, 1046, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1069, 1047, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1070, 1048, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1071, 1049, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1072, 1050, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1073, 1051, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1074, 1052, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1075, 1053, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1076, 1054, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1077, 1055, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1078, 1056, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1079, 1057, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1080, 1058, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1081, 1059, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1082, 1060, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1083, 1061, 1, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Trà sữa trân châu đường đen', 1, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Purple Latte', 2, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Trà hoa cúc mật ong', 3, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Warrior', 4, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Trà xanh xoài', 5, 44000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Nước suối Lavie', 6, 6000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Creme Brulee', 7, 55000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Trân châu đường đen', 8, 15000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Trà sữa')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Cà phê')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Trà')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Nước ngọt')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Trà trái cây')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Nước suối')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (7, N'Bánh')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (8, N'topping')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1004, N'Đồ ăn vặt')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (1, N'Bàn 0', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (2, N'Bàn 1', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (3, N'Bàn 2', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (4, N'Bàn 3', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (5, N'Bàn 4', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (6, N'Bàn 5', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (7, N'Bàn 6', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (8, N'Bàn 7', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (9, N'Bàn 8', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [tableName], [status]) VALUES (1008, N'Bàn 9', N'Bàn trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Ritter') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Password]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [tableName]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@username nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin
	select t.tableName as [Tên bàn], b.totalPrice as [Tổng tiền], DateCheckIn as [Ngày tạo], DateCheckOut as [Ngày thanh toán] , discount as [Giảm giá] 
	from dbo.Bill as b, dbo.TableFood as t 
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
as
begin
	declare @pageRows int = 10
	declare @selectRows int = @pageRows
	declare @excepRows int  = (@page - 1) * @pageRows


	;With BillShow AS ( select b.id, t.tableName as [Tên bàn], b.totalPrice as [Tổng tiền], DateCheckIn as [Ngày tạo], DateCheckOut as [Ngày thanh toán] , discount as [Giảm giá] 
	from dbo.Bill as b, dbo.TableFood as t 
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable)

	select TOP (@selectRows) * from BillShow where BillShow.id NOT IN (select top (@excepRows) id from BillShow)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListCattegory]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListCattegory]
as
begin
	select * from dbo.FoodCategory
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListFood]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListFood]
as
begin
	select id, Name, idCategory,price from dbo.Food
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
as
begin
	select COUNT(*)
	from dbo.Bill as b, dbo.TableFood as t 
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBill]
 @idTable INT
 as
 begin
	INSERT Bill
			(
				DateCheckIn,
				DateCheckOut,
				idTable,
				status,
				discount
			)
	VALUES  (
				GETDATE(),
				NULL,
				@idTable,
				0,
				0
			)
 end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE proc [dbo].[USP_InsertBillInfo]
 @idBill int,
 @idFood int,
 @count int
 AS
 BEGIN
	declare @isExistBillInfo int --khỏi tại 1 biến tến như bên => dùng để ktra có tồn tại hay ko
	declare @countFood INT = 1; --tạo 1 cái biến tên như bên để lưu giá trị số lượng của food

	select @isExistBillInfo = id, @countFood = count --chọn 2 cái bên 
	from	dbo.BillInfo  -- từ bảng BillInfo
	WHERE idBill = @idBill AND idFood = @idFood -- với điều kiện này

	if(@isExistBillInfo > 0) --neus như có tồn tại cái bill rồi
	BEGIN
		DECLARE @newCount INT = @countFood + @count --khởi tạo 1 biến số lượng mới để lưu số lượng khi cộng dồn
		IF(@newCount > 0) -- nếu mà biến số lượng dương (tứng là có trường hợp trừ bớt phần đã gọi đi
															--(tức là trượng hợp mà cout nhập vào là âm)
			--nếu nó không âm thì cập nhật lại số lượng món đó
			--cộng thêm vào count 
			UPDATE dbo.BillInfo SET count = @countFood + @count WHERE idFood = @idFood
		ELSE-- ngược lại nếu nó âm
			--thì mình xóa luôn cái món đó OK????
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		insert dbo.BillInfo
			(
				idBill,
				idFood,
				count
			)
		values  (
					@idBill,
					@idFood,
					@count
				)
	END
 END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@username nvarchar(100),
@password nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username AND Password = @password
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_SwitchTable]
@idTable1 int , @idTable2 int --bởi vì table có thể null còn billInfo thì ko nên ta sẽ truyền vào Proc 2 idTable
as
begin
	--Khỏi tạo 2 id Bill 
	--một số lưu ý nhỏ , mà thật ra có 1 lưu ý thôi
	-- ở đây hỏi ngược 1 tí @idFirstBill là cái id của bill cũ, còn @idSecondBill là của bill mới 
	--làm hơi ngược tí xiu
	declare @idFirstBil int 
	declare @idSecondBill int

	declare @isFirstTableEmpty int = 1
	declare @isSecondTableEmpty int = 1

	--cho @idSencondBill có giá trị bằng cái id bill hiện tại với điều kiện idTable hiện tại bằng @idTable 2(là cái table dag được ta chọn)
	--và nó phải là 1 cái bill chưa thanh toán
	select @idSecondBill = id from dbo.Bill where idTable = @idTable2 and status = 0
	--tương tự với cái trên nhưng lần này là id bill của cái bàn mà ta muốn chuyển tới
	select @idFirstBil = id from dbo.Bill where idTable = @idTable1 and status = 0


	--trong trường hợp nếu như 1 trong 2 cái bàn đó chưa có bill thì sao? thì cái idBill bị null
	--ta sẽ tiến hành tạo cái bill cho nó
	--trường hợp @idFirtBill bị Null
	if(@idFirstBil IS NULL)
	begin
		insert into dbo.Bill 
					(
						DateCheckIn,
						DateCheckOut,
						idTable,
						status
					)
				values(
						GETDATE(),
						NULL,
						@idTable1,
						0
					  )
		
		select @idFirstBil = MAX(id) from Bill where idTable = @idTable1 and status = 0
		
		
	end

	select @isFirstTableEmpty = COUNT(*) FROM dbo.BillInfo where idBill = @idFirstBil

	---trường hợp với idSecondBill
	if(@idSecondBill IS NULL)
	begin
		insert into dbo.Bill 
					(
						DateCheckIn,
						DateCheckOut,
						idTable,
						status
					)
				values(
						GETDATE(),
						NULL,
						@idTable2,
						0
					  )
		select @idSecondBill = MAX(id) from Bill where idTable = @idTable2 and status = 0
		
	end

	select @isSecondTableEmpty = COUNT(*) from dbo.BillInfo where idBill = @idSecondBill 

	--sau đó ta sẽ tiến hành lấy ra nhưng thằng id có điều kiện idBill = @idSecondBill
	-- cái IDBillInfoTable ở đây sẽ là một cái table tạm tao ra để lưu hết id của billInfo trong bàn hiện tại
	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo where idBill = @idSecondBill
	--sau đó thì ta sẽ thay đổi giá trị của bill của bản đổi và cần đổi với nhau
	update dbo.BillInfo set idBill = @idSecondBill where idBill = @idFirstBil
	--rồi lấy dữ liệu từ cái IDBIllInfoTable chuyển qua cái bàn ta muốn đổi
	update dbo.BillInfo set idBill = @idFirstBil where id in (select * from IDBillInfoTable)
	--cuối cùng là bỏ cái IDBillInfoTable đi
	DROP TABLE IDBillInfoTable
	--nôm na thì nó như cái thuật toán đổi vị trí trong code thui
	--một lưu ý nhỏ khí sử dụng điệu kiện so sánh với null thì sử dụng "IS" nhớ nha

	if(@isFirstTableEmpty = 0)
		update dbo.TableFood set status = N'Bàn trống' where id = @idTable2

	if(@isSecondTableEmpty = 0)
		update dbo.TableFood set status = N'Bàn trống' where id = @idTable1
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 15/03/2023 6:27:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100),
@password NVARCHAR(100),@newPassword NVARCHAR(100)
as
begin
	declare @isRightPass int = 0

	select @isRightPass = COUNT(*) from dbo.Account where UserName = @userName and Password =@password

	if(@isRightPass >= 1)
	Begin
		IF(@newPassword = NULL or @newPassword ='')
		begin
			 update dbo.Account set DisplayName = @displayName where UserName = @userName
		end
		else
			update dbo.Account SET  DisplayName = @displayName, Password =@newPassword where UserName = @userName
	end
end
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO
