USE [HHSQLDB]
GO

/****** Object:  StoredProcedure [dbo].[Mailer_Compare_Fuzzy]    Script Date: 03/05/2012 18:03:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Joseph Rounds
-- Create date: 2-29-2012
-- Description:	Stored Proc to Get results for compare mailer database
-- =============================================
CREATE PROCEDURE [dbo].[Mailer_Compare_Fuzzy]
	-- Add the parameters for the stored procedure here
  @Sort_type  int,
  @Sort_value nvarchar(30), 
    @Sort_value2 int 
  

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--No filter by Compaign
   if @Sort_Type=0
   Begin
   with Mailer as (

select  * from openquery (MAILERDB, 'select mca.campaignid, mca.campaign_name,mca.campaign_tollfree_number,  trim(mc.customer_lastname) lastname, trim(mc.customer_street1) street1, trim(mc.customer_street2) street2 ,mc.customer_zipcode zip
 from mailer.customer_info  mc join campaign mca on mc.campaignid=mca.campaignid'
 --'group by mc.Customer_lastname, mc.Customer_street1,mc.customer_street2,mc.customer_zipcode,mca.campaign_name')
 )
)

select  Mailer.campaign_name,mailer.campaign_tollfree_number, COUNT(*) Customer_Count from Mailer, HHSQLDB.dbo.tbl_Account_Member as member where
SOUNDEX(member.Last_Name)=SOUNDEX(Mailer.lastname) and SOUNDEX(member.Address_1)=SOUNDEX(Mailer.street1) and SOUNDEX(member.Address_2)=SOUNDEX(Mailer.street2) 
and member.Zip=Mailer.zip group by campaign_name,mailer.campaign_tollfree_number
End
-- By Compaign with sort filter
else if @Sort_type=1
   begin
      with Mailer as (

select  * from openquery (MAILERDB, 'select mca.campaignid, mca.campaign_name,mca.campaign_tollfree_number,  trim(mc.customer_lastname) lastname, trim(mc.customer_street1) street1, trim(mc.customer_street2) street2 ,mc.customer_zipcode zip
 from mailer.customer_info  mc join campaign mca on mc.campaignid=mca.campaignid'
 --'group by mc.Customer_lastname, mc.Customer_street1,mc.customer_street2,mc.customer_zipcode,mca.campaign_name')
 )
)

select  Mailer.campaign_name,mailer.campaign_tollfree_number ,mailer.campaign_tollfree_number, COUNT(*) Customer_Count from Mailer, HHSQLDB.dbo.tbl_Account_Member as member where
SOUNDEX(member.Last_Name)=SOUNDEX(Mailer.lastname) and SOUNDEX(member.Address_1)=SOUNDEX(Mailer.street1) and SOUNDEX(member.Address_2)=SOUNDEX(Mailer.street2) 
and member.Zip=Mailer.zip and campaignid=@Sort_value2 group by campaign_name,mailer.campaign_tollfree_number
end
--Sort By mailing list
else if @Sort_type=2
Begin
 with Mailer as (

select  * from openquery (MAILERDB, 'select mca.campaign_tollfree_number, mca.campaignid, mma. mailinglistID,campaign_name ,  trim(mc.customer_lastname) lastname, trim(mc.customer_street1) street1, trim(mc.customer_street2) street2 ,mc.customer_zipcode zip
 from mailer.customer_info  mc join  mailinglist mma on mc. mailinglistID =mma. mailinglistID join campaign mca on mc.campaignid=mca.campaignid '
 --'group by mc.Customer_lastname, mc.Customer_street1,mc.customer_street2,mc.customer_zipcode,mca.campaign_name')
 )
)

select  Mailer. mailinglistID,campaign_name ,mailer.campaign_tollfree_number, COUNT(*) Customer_Count from Mailer, HHSQLDB.dbo.tbl_Account_Member as member where
SOUNDEX(member.Last_Name)=SOUNDEX(Mailer.lastname) and SOUNDEX(member.Address_1)=SOUNDEX(Mailer.street1) and SOUNDEX(member.Address_2)=SOUNDEX(Mailer.street2) 
and member.Zip=Mailer.zip  group by  mailinglistID ,campaign_name,mailer.campaign_tollfree_number
End
--Sort by Mailing List filter by Campaign
Else if @Sort_type=3
Begin
 with Mailer as (

select  * from openquery (MAILERDB, 'select mca.campaign_tollfree_number, mca.campaignid, mma. mailinglistID,campaign_name ,  trim(mc.customer_lastname) lastname, trim(mc.customer_street1) street1, trim(mc.customer_street2) street2 ,mc.customer_zipcode zip
 from mailer.customer_info  mc join  mailinglist mma on mc. mailinglistID =mma. mailinglistID join campaign mca on mc.campaignid=mca.campaignid '
 --'group by mc.Customer_lastname, mc.Customer_street1,mc.customer_street2,mc.customer_zipcode,mca.campaign_name')
 )
)

select  Mailer. mailinglistID,campaign_name ,mailer.campaign_tollfree_number, COUNT(*) Customer_Count from Mailer, HHSQLDB.dbo.tbl_Account_Member as member where
SOUNDEX(member.Last_Name)=SOUNDEX(Mailer.lastname) and SOUNDEX(member.Address_1)=SOUNDEX(Mailer.street1) and SOUNDEX(member.Address_2)=SOUNDEX(Mailer.street2) 
and member.Zip=Mailer.zip and campaignid=@Sort_value2  group by  mailinglistID ,campaign_name,mailer.campaign_tollfree_number
End
--Sort by Mailing List filter by Malinglist ID
Else if @Sort_type=4
begin
 with Mailer as (

select  * from openquery (MAILERDB, 'select mca.campaign_tollfree_number, mca.campaignid, mma. mailinglistID,campaign_name ,  trim(mc.customer_lastname) lastname, trim(mc.customer_street1) street1, trim(mc.customer_street2) street2 ,mc.customer_zipcode zip
 from mailer.customer_info  mc join  mailinglist mma on mc. mailinglistID =mma. mailinglistID join campaign mca on mc.campaignid=mca.campaignid '
 --'group by mc.Customer_lastname, mc.Customer_street1,mc.customer_street2,mc.customer_zipcode,mca.campaign_name')
 )
)

select  Mailer. mailinglistID,campaign_name ,mailer.campaign_tollfree_number, COUNT(*) Customer_Count from Mailer, HHSQLDB.dbo.tbl_Account_Member as member where
SOUNDEX(member.Last_Name)=SOUNDEX(Mailer.lastname) and SOUNDEX(member.Address_1)=SOUNDEX(Mailer.street1) and SOUNDEX(member.Address_2)=SOUNDEX(Mailer.street2) 
and member.Zip=Mailer.zip and mailinglistID=@Sort_value  group by  mailinglistID ,campaign_name,mailer.campaign_tollfree_number
End


END

GO

