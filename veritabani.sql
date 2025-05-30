USE [ogrenciBilgiSistemiDB]
GO
/****** Object:  Table [dbo].[Bolumler]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bolumler](
	[bolumID] [int] IDENTITY(1,1) NOT NULL,
	[bolumIsmi] [varchar](100) NOT NULL,
	[bolumBaskaniID] [varchar](100) NOT NULL,
	[bolumKodu] [varchar](2) NOT NULL,
	[fakulteID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[bolumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DersKayit]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DersKayit](
	[dersKayitID] [int] IDENTITY(1,1) NOT NULL,
	[ogrenciID] [int] NOT NULL,
	[dersID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[dersKayitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dersler]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dersler](
	[dersID] [int] IDENTITY(1,1) NOT NULL,
	[dersAdi] [varchar](100) NOT NULL,
	[bolumID] [int] NOT NULL,
	[kredi] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[dersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DersProgrami]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DersProgrami](
	[programID] [int] IDENTITY(1,1) NOT NULL,
	[dersID] [int] NOT NULL,
	[ogretimGorevlisiID] [int] NOT NULL,
	[gun] [varchar](10) NOT NULL,
	[baslangicSaati] [time](7) NOT NULL,
	[bitisSaati] [time](7) NOT NULL,
	[sinif] [nvarchar](20) NULL,
	[aciklama] [nvarchar](255) NULL,
	[donemID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[programID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Donemler]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donemler](
	[donemID] [int] IDENTITY(1,1) NOT NULL,
	[akademikYil] [nvarchar](9) NOT NULL,
	[yariyil] [tinyint] NOT NULL,
	[donemAdi]  AS (([akademikYil]+' ')+case [yariyil] when (1) then 'Güz' when (2) then 'Bahar'  end) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[donemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fakulteler]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fakulteler](
	[fakulteID] [int] NOT NULL,
	[fakulteKodu] [char](2) NOT NULL,
	[fakulteIsim] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fakulteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notlar]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notlar](
	[notID] [int] IDENTITY(1,1) NOT NULL,
	[ogrenciID] [int] NULL,
	[dersID] [int] NULL,
	[vize] [decimal](5, 2) NULL,
	[final] [decimal](5, 2) NULL,
	[butunleme] [decimal](5, 2) NULL,
	[ortalama]  AS (case when [vize] IS NULL OR [final] IS NULL then NULL else [vize]*(0.4)+[final]*(0.6) end),
	[harfNotu]  AS (case when [vize] IS NULL OR [final] IS NULL then NULL when ([vize]*(0.4)+[final]*(0.6))>=(90) then 'AA' when ([vize]*(0.4)+[final]*(0.6))>=(85) then 'BA' when ([vize]*(0.4)+[final]*(0.6))>=(80) then 'BB' when ([vize]*(0.4)+[final]*(0.6))>=(75) then 'CB' when ([vize]*(0.4)+[final]*(0.6))>=(70) then 'CC' when ([vize]*(0.4)+[final]*(0.6))>=(65) then 'DC' when ([vize]*(0.4)+[final]*(0.6))>=(60) then 'DD' when ([vize]*(0.4)+[final]*(0.6))>=(50) then 'FD' else 'FF' end),
	[gecmeDurumu]  AS (case when [vize] IS NULL OR [final] IS NULL then NULL when ([vize]*(0.4)+[final]*(0.6))>=(60) then (1) else (0) end),
	[donemID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[notID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ogrenciler]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ogrenciler](
	[ogrenciID] [int] IDENTITY(1,1) NOT NULL,
	[isim] [varchar](50) NOT NULL,
	[soyIsim] [varchar](50) NOT NULL,
	[email] [varchar](100) NULL,
	[dogumTarihi] [date] NOT NULL,
	[cinsiyet] [varchar](50) NOT NULL,
	[bolumID] [int] NULL,
	[kayitTarihi] [date] NULL,
	[ogrenciNo] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ogrenciID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OgretimGorevlileri]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OgretimGorevlileri](
	[ogretimGrID] [int] IDENTITY(1,1) NOT NULL,
	[isim] [varchar](50) NOT NULL,
	[soyIsim] [varchar](50) NOT NULL,
	[bolumID] [int] NOT NULL,
	[email] [varchar](100) NULL,
 CONSTRAINT [PK_OgretimGrID] PRIMARY KEY CLUSTERED 
(
	[ogretimGrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yoklama]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yoklama](
	[yoklamaID] [int] IDENTITY(1,1) NOT NULL,
	[ogrenciID] [int] NOT NULL,
	[dersID] [int] NOT NULL,
	[tarih] [date] NOT NULL,
	[durum] [bit] NOT NULL,
	[aciklama] [nvarchar](255) NULL,
	[donemID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[yoklamaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YoklamaDetay]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YoklamaDetay](
	[oturumID] [int] NOT NULL,
	[ogrenciID] [int] NOT NULL,
	[durum] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[oturumID] ASC,
	[ogrenciID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YoklamaOturumlari]    Script Date: 5/28/2025 5:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YoklamaOturumlari](
	[oturumID] [int] IDENTITY(1,1) NOT NULL,
	[dersID] [int] NULL,
	[tarih] [date] NOT NULL,
	[baslangicSaati] [time](7) NULL,
	[bitisSaati] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[oturumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Bolumler__ED09FADAACB07A17]    Script Date: 5/28/2025 5:39:36 PM ******/
ALTER TABLE [dbo].[Bolumler] ADD UNIQUE NONCLUSTERED 
(
	[bolumKodu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Fakultel__BD8ABE59C09261F0]    Script Date: 5/28/2025 5:39:36 PM ******/
ALTER TABLE [dbo].[Fakulteler] ADD UNIQUE NONCLUSTERED 
(
	[fakulteKodu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Ogrencil__91C96A52D6EA2A74]    Script Date: 5/28/2025 5:39:36 PM ******/
ALTER TABLE [dbo].[Ogrenciler] ADD UNIQUE NONCLUSTERED 
(
	[ogrenciNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ogrenciler] ADD  DEFAULT (getdate()) FOR [kayitTarihi]
GO
ALTER TABLE [dbo].[Bolumler]  WITH CHECK ADD FOREIGN KEY([fakulteID])
REFERENCES [dbo].[Fakulteler] ([fakulteID])
GO
ALTER TABLE [dbo].[DersKayit]  WITH CHECK ADD  CONSTRAINT [FK_DersKayit_Ders] FOREIGN KEY([dersID])
REFERENCES [dbo].[Dersler] ([dersID])
GO
ALTER TABLE [dbo].[DersKayit] CHECK CONSTRAINT [FK_DersKayit_Ders]
GO
ALTER TABLE [dbo].[DersKayit]  WITH CHECK ADD  CONSTRAINT [FK_DersKayit_Ogrenci] FOREIGN KEY([ogrenciID])
REFERENCES [dbo].[Ogrenciler] ([ogrenciID])
GO
ALTER TABLE [dbo].[DersKayit] CHECK CONSTRAINT [FK_DersKayit_Ogrenci]
GO
ALTER TABLE [dbo].[Dersler]  WITH CHECK ADD FOREIGN KEY([bolumID])
REFERENCES [dbo].[Bolumler] ([bolumID])
GO
ALTER TABLE [dbo].[DersProgrami]  WITH CHECK ADD FOREIGN KEY([dersID])
REFERENCES [dbo].[Dersler] ([dersID])
GO
ALTER TABLE [dbo].[DersProgrami]  WITH CHECK ADD FOREIGN KEY([donemID])
REFERENCES [dbo].[Donemler] ([donemID])
GO
ALTER TABLE [dbo].[DersProgrami]  WITH CHECK ADD FOREIGN KEY([ogretimGorevlisiID])
REFERENCES [dbo].[OgretimGorevlileri] ([ogretimGrID])
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD FOREIGN KEY([dersID])
REFERENCES [dbo].[Dersler] ([dersID])
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD FOREIGN KEY([donemID])
REFERENCES [dbo].[Donemler] ([donemID])
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD FOREIGN KEY([ogrenciID])
REFERENCES [dbo].[Ogrenciler] ([ogrenciID])
GO
ALTER TABLE [dbo].[Ogrenciler]  WITH CHECK ADD  CONSTRAINT [FK_Ogrenciler_Bolumler] FOREIGN KEY([bolumID])
REFERENCES [dbo].[Bolumler] ([bolumID])
GO
ALTER TABLE [dbo].[Ogrenciler] CHECK CONSTRAINT [FK_Ogrenciler_Bolumler]
GO
ALTER TABLE [dbo].[OgretimGorevlileri]  WITH CHECK ADD FOREIGN KEY([bolumID])
REFERENCES [dbo].[Bolumler] ([bolumID])
GO
ALTER TABLE [dbo].[Yoklama]  WITH CHECK ADD FOREIGN KEY([dersID])
REFERENCES [dbo].[Dersler] ([dersID])
GO
ALTER TABLE [dbo].[Yoklama]  WITH CHECK ADD FOREIGN KEY([donemID])
REFERENCES [dbo].[Donemler] ([donemID])
GO
ALTER TABLE [dbo].[Yoklama]  WITH CHECK ADD FOREIGN KEY([ogrenciID])
REFERENCES [dbo].[Ogrenciler] ([ogrenciID])
GO
ALTER TABLE [dbo].[YoklamaDetay]  WITH CHECK ADD FOREIGN KEY([ogrenciID])
REFERENCES [dbo].[Ogrenciler] ([ogrenciID])
GO
ALTER TABLE [dbo].[YoklamaDetay]  WITH CHECK ADD FOREIGN KEY([oturumID])
REFERENCES [dbo].[YoklamaOturumlari] ([oturumID])
GO
ALTER TABLE [dbo].[YoklamaOturumlari]  WITH CHECK ADD FOREIGN KEY([dersID])
REFERENCES [dbo].[Dersler] ([dersID])
GO
ALTER TABLE [dbo].[Donemler]  WITH CHECK ADD CHECK  (([yariyil]=(2) OR [yariyil]=(1)))
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD CHECK  (([butunleme]<=(100) AND [butunleme]>=(0)))
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD CHECK  (([final]<=(100) AND [final]>=(0)))
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD CHECK  (([vize]<=(100) AND [vize]>=(0)))
GO
ALTER TABLE [dbo].[Ogrenciler]  WITH CHECK ADD CHECK  (([cinsiyet]='Kadin' OR [cinsiyet]='Erkek'))
GO
