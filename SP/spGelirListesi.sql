USE [AYS]
GO
/****** Object:  StoredProcedure [dbo].[spFaturaGelirListesi]    Script Date: 11.05.2017 03:01:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[spFaturaGelirListesi]
as
begin
SELECT        tbl_Binalar.bina_adi as 'Apart Adı',
 tbl_Daireler.daire_kapi_no as 'Daire Kapı No',
 tbl_Musteriler.musteri_adi as 'Adı',
 tbl_Musteriler.musteri_soyadi as 'Soyadı',
 tbl_FaturaGelir.fatura_odenen_tutar as 'Ödenen Tutar',
 tbl_FaturaGelir.fatura_donemi as 'Fatura Dönemi',
 tbl_FaturaGelir.fatura_odeme_tarihi as 'Ödeme Tarihi'
 
FROM            tbl_FaturaGelir INNER JOIN
                         tbl_Daireler ON tbl_FaturaGelir.daire_no=tbl_Daireler.daire_no INNER JOIN
                         tbl_Musteriler ON tbl_FaturaGelir.daire_no = tbl_Musteriler.daire_no INNER JOIN
                         tbl_Binalar ON tbl_Binalar.bina_id = tbl_Daireler.bina_id
end

