---------3.create select and find function---

create Or Replace function checkSales(productId varchar)
Returns varchar as $$
DECLARE 
	salesStatus varchar;
	sumOfSales float;
	
	BEGIN
		select sum(sales) into sumOfSales from sales where product_id = productId;
		if sumOfSales > 500 THEN salesStatus := 'sales is good ';
		ELSE salesStatus := 'sales is not good ';
		END if;
		RETURN salesStatus;
	END;
	
$$ LANGUAGE Plpgsql
	
select sum(sales) , product_id from sales group by product_id


select checksales('OFF-PA-10003656')

select sum(sales) , product_id, checksales(product_id) from sales group by product_id
