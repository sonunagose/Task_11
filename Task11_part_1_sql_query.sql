-------1.create 5 function on ecom---

select product_id, sum(sales) from sales group by product_id

select product_id, sales,
    case
       When sales < 100 Then 'Better Selling'
       When sales between 50 and 1000 Then  'Good Selling'
       When sales between 1000 and 1500 Then 'Best selling'
     Else  'Not good selling'
    End 
from sales

---1) Check sales----

create or replace function get_checkSales(sales int)
RETURNS varchar AS $$
DECLARE
	   product_sales_status varchar;
BEGIN
	case 
			When sales < 100 Then product_sales_status := 'Better Selling'; 
            When sales between 50 and 1000 Then product_sales_status:= 'Good Selling';
            When sales between 1000 and 1500 Then product_sales_status:= 'Best selling';
            Else product_sales_status:= 'Not good selling';
	END CASE;
	RETURN product_sales_status;
END 
$$ LANGUAGE plpgsql;

select get_checkSales(20)

select product_id, sales, get_checkSales(sales::int) from sales

---2) Check customer Age----

select * from customer

Create or Replace Function category_customer(cust_age int)
Returns varchar as $$
Declare 
      customer_age varchar;
BEGIN
    Case 
	 When cust_age < 25 Then customer_age := 'Younger age customer';
     When cust_age between 25 And 30 Then customer_age := 'Middle age customer';
     When cust_age between 35 and 50 Then customer_age := 'Senior age customer';
     Else customer_age := 'super senior age customer';
    End Case;
     Return customer_age;
END
$$ Language plpgsql;

select customer_name, age, category_customer(age) from customer 

---3) Check Profit---

create or replace function checkProfit(prof int)
RETURNS varchar AS $$
DECLARE
	profit_status varchar;
BEGIN
	case 
			When prof > 0  THEN  profit_status := 'min profit' ;
			When prof > 20  THEN profit_status := 'good profit';
			When prof > 50  THEN profit_status := 'best profit';
			When prof > 80  THEN profit_status := 'great profit';
			Else profit_status := 'no  profit';
	END CASE;
	RETURN profit_status;
END
$$ LANGUAGE plpgsql;

select checkProfit(0)

select profit , checkProfit(profit::int) from sales

---4) check customer states---

select * from customer
	
Create or Replace Function customer_state(get_state varchar)
Returns Varchar as $$
Declare 
      getcustomerState varchar;
Begin
   select customer_name into getcustomerState from customer where  state = get_state;
   Case
	   when get_state in ('Darren Powers', 'Indiana') Then getcustomerState := 'Customer lives in Darren Powers or Indiana';
       When get_state in ('Kunst Miller', 'California') Then getcustomerState := 'Customer lives in Kunst Miller or California';
       Else getcustomerState := 'Any other state';
   End Case;
   Return getcustomerState; 
End 
$$ Language plpgsql;

select customer_name, customer_state(state) from customer

---5) check total sales per product---

Create or Replace Function get_total(productId varchar)
Returns varchar as $$
Declare 
     SumOfSales float;
     sumOfQuantity float ;
Begin 
  select sum(sales) as "sumofsales", sum(quantity) as "sumofquantity" into sumOfSales, sumOfQuantity from sales 
  where product_id = productId;
   
   Return SumOfSales;
End
$$ Language plpgsql

select product_id, sales, get_total(product_id) from sales







