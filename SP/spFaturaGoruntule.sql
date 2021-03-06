USE [AYS]
GO
/****** Object:  StoredProcedure [dbo].[spFaturaGoruntule]    Script Date: 11.05.2017 03:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[spFaturaGoruntule]
as
begin
SELECT 
		tbl_FaturaAboneNo.fatura_abone_no as 'Abone No',
		tbl_Musteriler.musteri_adi as 'Adı',
		tbl_Musteriler.musteri_soyadi as 'Soyadı',
		tbl_Daireler.daire_kapi_no 'Daire Kapı No',
		tbl_Binalar.bina_adi 'Apart Adı',
		tbl_FaturaGiderTablosu.fatura_tutari as 'Fatura Tutarı',
		tbl_FaturaGiderTablosu.fatura_donemi as 'Fatura Donemi',
		--tbl_FaturaGiderTablosu.fatura_odenen_tutar as 'Ödenen Tutar',
		tbl_FaturaGiderTablosu.fatura_durumu as 'Fatura Durumu'
		--tbl_Musteriler.musteri_adi
FROM 
		tbl_FaturaGiderTablosu Inner Join
		tbl_FaturaAboneNo ON tbl_FaturaAboneNo.fatura_abone_no=tbl_FaturaGiderTablosu.fatura_abone_no Inner Join
		tbl_OrtakFatura ON tbl_FaturaAboneNo.fatura_abone_no =tbl_OrtakFatura.fatura_abone_no Inner join
		tbl_Musteriler ON tbl_OrtakFatura.daire_no = tbl_Musteriler.daire_no Inner Join
		tbl_Daireler ON tbl_Musteriler.daire_no=tbl_Daireler.daire_no Inner Join
		tbl_Binalar ON tbl_Binalar.bina_id =tbl_FaturaAboneNo.bina_id
WHERE 
		tbl_Musteriler.musteri_yetki=1 and tbl_Musteriler.musteri_durumu=1
		
end

