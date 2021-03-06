USE [AYS]
GO
/****** Object:  StoredProcedure [dbo].[spFaturaOrtakDaire]    Script Date: 11.05.2017 03:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[spFaturaOrtakDaire](@aboneNo nvarchar(50))
as
begin
declare @faturaId int= (select tbl_FaturaAboneNo.fatura_turu_id from tbl_FaturaAboneNo where tbl_FaturaAboneNo.fatura_abone_no=@aboneNo)
	SELECT       tbl_Daireler.daire_kapi_no as 'Daire Kapı No',
				 tbl_Daireler.daire_no as 'Daire No'

FROM            tbl_OrtakFatura INNER JOIN
                         tbl_Daireler ON tbl_OrtakFatura.daire_no = tbl_Daireler.daire_no INNER JOIN
						 tbl_FaturaAboneNo ON tbl_OrtakFatura.fatura_abone_no=tbl_FaturaAboneNo.fatura_abone_no
WHERE
				tbl_OrtakFatura.fatura_abone_no=@aboneNo and tbl_FaturaAboneNo.fatura_turu_id=@faturaId
end

