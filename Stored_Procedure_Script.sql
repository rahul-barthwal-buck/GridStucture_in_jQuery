/*Author name: Rahul Barthwal*/
/*Objective: Stored Procedure Creation*/
/*Stored procedures: */
/* 1. [sp_Update_ProductDetails]*/
/*2. [sp_Delete_ProductDetails]*/
/*3. [sp_Get_ProductDetails]*/


USE [GridStructure]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_ProductDetails]    Script Date: 12/30/2021 6:59:22 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[sp_Update_ProductDetails]
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_ProductDetails]    Script Date: 12/30/2021 6:59:22 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[sp_Get_ProductDetails]
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_ProductDetails]    Script Date: 12/30/2021 6:59:22 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[sp_Delete_ProductDetails]
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_ProductDetails]    Script Date: 12/30/2021 6:59:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE

 PROC [dbo].[sp_Delete_ProductDetails] @ProductId INT AS
BEGIN
    BEGIN TRY
			DELETE FROM ProductDetails WHERE Product_Id = @ProductId
	END TRY
	BEGIN CATCH
		DECLARE @ErrorNumber INT = ERROR_NUMBER()
		DECLARE @ErrorLine INT = ERROR_LINE()
		DECLARE @ErrorMessage NVARCHAR(50) = ERROR_MESSAGE()
		DECLARE @ErrorProcedure NVARCHAR(50) = ERROR_PROCEDURE()
 
		RAISERROR ('Error Details: ErrorNumber: %d, ErrorLine: %d, ErrorMessage: %s, ErrorProcedure: %s',16,1,@Errornumber,@ErrorLine,@ErrorMessage,@ErrorProcedure)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_ProductDetails]    Script Date: 12/30/2021 6:59:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Author name: Rahul Barthwal*/
/*Objective: Creation of Stored Procedure for Getting Details of Products by applying some conditions*/
CREATE

 PROC [dbo].[sp_Get_ProductDetails] @PageSize INT, @NextOrPrevious INT, @SortBy NVARCHAR(20) = NULL AS
BEGIN
    BEGIN TRY
			DECLARE @SortByAscProductName NVARCHAR(20)
			DECLARE @SortByDescProductName NVARCHAR(20)
			DECLARE @SortByAscQuantityperUnit NVARCHAR(20)
			DECLARE @SortByDescQuantityperUnit NVARCHAR(20)
			DECLARE @SortByAscUnitPrice NVARCHAR(20)
			DECLARE @SortByDescUnitPrice NVARCHAR(20)

			SET @SortByAscProductName = 'SortByAscProductName'
			SET @SortByDescProductName = 'SortByDescProductName'
			SET @SortByAscQuantityperUnit = 'SortByAscQuantityperUnit'
			SET @SortByDescQuantityperUnit = 'SortByDescQuantityperUnit'
			SET @SortByAscUnitPrice = 'SortByAscUnitPrice'
			SET @SortByDescUnitPrice = 'SortByDescUnitPrice'

            IF( @SortBy = @SortByAscProductName)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Name ASC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
            ELSE
            IF( @SortBy = @SortByDescProductName)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Name DESC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
            ELSE
            IF( @SortBy = @SortByAscQuantityperUnit)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Quantity_Per_Unit ASC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
            ELSE
            IF( @SortBy = @SortByDescQuantityperUnit)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Quantity_Per_Unit DESC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
            ELSE
            IF( @SortBy = @SortByAscUnitPrice)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Unit_Price ASC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
            ELSE
            IF( @SortBy = @SortByDescUnitPrice)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Unit_Price DESC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
            ELSE IF(@SortBy IS NULL)
            BEGIN
                SELECT
                         Product_Id
                       , Name
                       , Quantity_Per_Unit
                       , Unit_Price
                       , Units_In_Stock
                FROM
                         ProductDetails
                ORDER BY
                         Product_Id ASC OFFSET (@PageSize*@NextOrPrevious) ROWS
                FETCH NEXT (@PageSize) ROWS ONLY
            END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorNumber INT = ERROR_NUMBER()
		DECLARE @ErrorLine INT = ERROR_LINE()
		DECLARE @ErrorMessage NVARCHAR(50) = ERROR_MESSAGE()
		DECLARE @ErrorProcedure NVARCHAR(50) = ERROR_PROCEDURE()
 
		RAISERROR ('Error Details: ErrorNumber: %d, ErrorLine: %d, ErrorMessage: %s, ErrorProcedure: %s',16,1,@Errornumber,@ErrorLine,@ErrorMessage,@ErrorProcedure)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_ProductDetails]    Script Date: 12/30/2021 6:59:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE

 PROC [dbo].[sp_Update_ProductDetails] @ProductId INT, @ProductName NVARCHAR(30), @QuantityPerUnit INT,@UnitPrice DECIMAL(12,2), @UnitsInStock INT  AS
BEGIN
    BEGIN TRY
			UPDATE ProductDetails SET Name=@ProductName,Quantity_Per_Unit=@QuantityPerUnit,Unit_Price=@UnitPrice, Units_In_Stock=@UnitsInStock WHERE Product_Id=@ProductId
	END TRY
	BEGIN CATCH
		DECLARE @ErrorNumber INT = ERROR_NUMBER()
		DECLARE @ErrorLine INT = ERROR_LINE()
		DECLARE @ErrorMessage NVARCHAR(50) = ERROR_MESSAGE()
		DECLARE @ErrorProcedure NVARCHAR(50) = ERROR_PROCEDURE()
 
		RAISERROR ('Error Details: ErrorNumber: %d, ErrorLine: %d, ErrorMessage: %s, ErrorProcedure: %s',16,1,@Errornumber,@ErrorLine,@ErrorMessage,@ErrorProcedure)
	END CATCH
END
GO

