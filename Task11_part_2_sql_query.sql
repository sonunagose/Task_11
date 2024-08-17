-------2.create function on your own data-------

select * from cricketers

---1) check customer Country---
	
Create or Replace Function customer_country(get_country varchar)
Returns Varchar as $$
Declare 
      getcustomer_country varchar;
Begin
   select first_name into getcustomer_country from cricketers where  country = get_country;
   Case
	   when get_country in ('Hamel', 'Norway') Then getcustomer_country := 'Customer lives in Norway';
       When get_country in ('Allissa', 'Indonesia') Then getcustomer_country := 'Customer lives in  Indonesia';
       Else getcustomer_country := 'Any other country';
   End Case;
   Return getcustomer_country; 
End 
$$ Language plpgsql;

select first_name, customer_country(country) from cricketers

---2) Check Gender---

Create or Replace Function customer_gender(get_gender varchar)
Returns Varchar as $$
Declare 
      getcustomer_gender varchar;
Begin
   select last_name into getcustomer_gender from cricketers where  gender = get_gender;
   Case
	   when get_gender in ('Petchell', 'Female') Then getcustomer_gender := 'Customer is female';
       When get_gender in ('Hallowes', 'Male') Then getcustomer_gender := 'Customer is male';
       Else getcustomer_gender := 'no gender';
   End Case;
   Return getcustomer_gender; 
End 
$$ Language plpgsql;

select last_name, customer_gender(gender) from cricketers
