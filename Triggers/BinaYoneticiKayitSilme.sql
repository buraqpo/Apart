USE [AYS]
GO
/****** Object:  Trigger [dbo].[YoneticiBinaKayitSilmee]    Script Date: 4.05.2017 07:06:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Kadir KANMAZ>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[YoneticiBinaKayitSilmee] ON [dbo].[tbl_Binalar]
FOR DELETE
   AS 
BEGIN
	DECLARE @binaID int
	SELECT @binaID=bina_id from deleted
	DELETE FROM tbl_YoneticiBina where tbl_YoneticiBina.bina_id=@binaID

END
