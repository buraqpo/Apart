USE [AYS]
GO
/****** Object:  StoredProcedure [dbo].[spFaturaGiderEkle]    Script Date: 11.05.2017 03:01:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[spFaturaGiderEkle](@aboneNo varchar(50),@faturaDonemi nvarchar(50),@tutar float)
as
begin

	INSERT INTO [dbo].[tbl_FaturaGiderTablosu]
           ([fatura_abone_no]
           ,[fatura_tutari]
           ,fatura_donemi)
     VALUES
           (@aboneNo,@tutar,@faturaDonemi)
end


