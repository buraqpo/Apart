USE [AYS]
GO
/****** Object:  StoredProcedure [dbo].[spFaturaGelirKaydet]    Script Date: 11.05.2017 03:00:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Burak Portakal
-- Create date: 23/04/2017
-- Description:	Gelir kaydetme işlemi. @gelirAdi ="Elektrik,su,doğalgaz,kira", @daireKapiNo = müşterinin kaldığı dairenin kapı nosu
-- @binaAdi= "Lale1,Lale2"
-- =============================================
ALTER PROCEDURE [dbo].[spFaturaGelirKaydet](@aboneNo nvarchar(50),@gelirTutari float
,@gelirTarihi Datetime,@daireKapiNo int,@binaAdi nvarchar(50),@gelirKayitEdenYoneticiId int,@faturaDonemi nvarchar(50),
 @sonuc int output)
AS
BEGIN
declare @daireNo int
declare @odenmesiGerekenFatura float
declare @odenenFatura float
set @daireNo=(select tbl_Daireler.daire_no 
					 from tbl_Daireler
					 where tbl_Daireler.daire_kapi_no=@daireKapiNo 
					 and tbl_Daireler.bina_id=
							(select bina_id 
							from tbl_Binalar 
							where bina_adi=@binaAdi))
declare @ortaklar int = (select Count(tbl_OrtakFatura.id) from tbl_OrtakFatura where tbl_OrtakFatura.fatura_abone_no='25223')
set @odenmesiGerekenFatura=CASE WHEN @ortaklar=2 Then (select tbl_FaturaGiderTablosu.fatura_tutari/2 from tbl_FaturaGiderTablosu where tbl_FaturaGiderTablosu.fatura_abone_no='25223'
 and tbl_FaturaGiderTablosu.fatura_donemi='2017/3') else (select tbl_FaturaGiderTablosu.fatura_tutari from tbl_FaturaGiderTablosu where tbl_FaturaGiderTablosu.fatura_abone_no='25223'
 and tbl_FaturaGiderTablosu.fatura_donemi='2017/3') end
set @odenenFatura =(select tbl_FaturaGiderTablosu.fatura_odenen_tutar from tbl_FaturaGiderTablosu where tbl_FaturaGiderTablosu.fatura_abone_no=@aboneNo and tbl_FaturaGiderTablosu.fatura_donemi=@faturaDonemi)
if(@odenmesiGerekenFatura=@odenenFatura)
 begin
 set @sonuc = 0
 return
end
INSERT INTO [dbo].[tbl_FaturaGelir]
           ([fatura_abone_no]
           ,[fatura_odenen_tutar]
           ,[daire_no]
           ,[fatura_donemi]
           ,[fatura_odeme_tarihi]
           ,[gelir_kaydeden_yonetici_id])
     VALUES
          (@aboneNo,@gelirTutari,@daireNo,@faturaDonemi,@gelirTarihi,@gelirKayitEdenYoneticiId)


UPDATE [dbo].[tbl_FaturaGiderTablosu]
   SET fatura_durumu = CASE WHEN Round( @odenmesiGerekenFatura,0)=Round(@gelirTutari+@odenenFatura,0) THEN 1 ELSE 0 END,
	   fatura_odenen_tutar = @gelirTutari+@odenenFatura
 WHERE tbl_FaturaGiderTablosu.fatura_abone_no=@aboneNo and tbl_FaturaGiderTablosu.fatura_donemi=@faturaDonemi  

set @sonuc = 1
return
end

