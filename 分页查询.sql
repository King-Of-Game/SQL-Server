
GO
DECLARE @TopNum INT
DECLARE @PageNum INT 
SET @TopNum = 5
SET @PageNum = 2


--效率高的方法一：
IF @PageNum = 1
	BEGIN
		SELECT TOP (@TopNum) * FROM T_DelyOrderNew ORDER BY F_Id
	END
ELSE
	BEGIN
		SELECT TOP (@TopNum) * 
		FROM T_DelyOrderNew 
		WHERE F_Id > (SELECT max(F_Id) FROM ( SELECT TOP (@TopNum * (@PageNum - 1) ) F_Id FROM T_DelyOrderNew ORDER BY F_Id) a1)
		ORDER BY F_Id
	END	


--效率高的方法二：
GO
DECLARE @TopNum INT
DECLARE @PageNum INT 
SET @TopNum = 5
SET @PageNum = 1

SELECT  *
FROM    ( SELECT    ROW_NUMBER() OVER ( ORDER BY F_Id ) rownumber ,
                    *
          FROM      T_DelyOrderNew
        ) a1
WHERE   rownumber BETWEEN ( (@PageNum - 1) * @TopNum + 1 ) AND (@TopNum * @PageNum)






--SQL语句效率测试
go
declare @begin_date datetime
declare @end_date datetime
select @begin_date = getdate()

--****************放入测试的语句****************--
SELECT TOP 100 * FROM T_DelyOrderNew ORDER BY F_Id
--****************放入测试的语句****************--

select @end_date = getdate()
select datediff(ms,@begin_date,@end_date) as '毫秒'





--测试开始
go
declare @begin_date datetime
declare @end_date datetime
select @begin_date = getdate()

--****************放入测试的语句****************--
DECLARE @TopNum INT
DECLARE @PageNum INT 
SET @TopNum = 1000
SET @PageNum = 3


--效率高的方法一：
IF @PageNum = 1
	BEGIN
		SELECT TOP (@TopNum) * FROM T_DelyOrderNew ORDER BY F_Id
	END
ELSE
	BEGIN
		SELECT TOP (@TopNum) * 
		FROM T_DelyOrderNew 
		WHERE F_Id > (SELECT max(F_Id) FROM ( SELECT TOP (@TopNum * (@PageNum - 1) ) F_Id FROM T_DelyOrderNew ORDER BY F_Id) a1)
		ORDER BY F_Id
	END	

--****************放入测试的语句****************--

select @end_date = getdate()
select datediff(ms,@begin_date,@end_date) as '毫秒'