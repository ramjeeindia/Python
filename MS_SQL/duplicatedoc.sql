                        --- NEW VALIDATION UNDER OBSERVATION
IF @object_type = '1250000001' And (@transaction_type = 'A' or @transaction_type = 'U')
 BEGIN
	DECLARE @Item AS VARCHAR (100)
	DECLARE @PRDNO as NVARCHAR (100)
	DECLARE @WTQQty as NVARCHAR (100)
	IF (@object_type = '1250000001')
	 BEGIN
	   SELECT  @Item = ItemCode,@PRDNO = U_OWOR_Doc,@WTQQty=t0.Quantity FROM WTQ1 T0 WHERE T0.DocEntry = @list_of_cols_Val_tab_del
	  BEGIN
	    IF (@PRDNO IS NOT NULL)
	     BEGIN
	     IF 1!= (SELECT COUNT (WTQ1.ItemCode) FROM WTQ1 WHERE WTQ1.U_OWOR_Doc = @PRDNO and WTQ1.ItemCode=@Item and WTQ1.Quantity=@WTQQty )
	     BEGIN
	       SELECT @error = 401
	       SELECT @error_message = 'Item code quantity ALREADY transfered FOR THIS order.'
	      END
	   END
	 END
  END
END