SELECT sale_customer_id, customer_first_name,
	   sale_seller_id , seller_first_name,
	   sale_product_id, product_name
FROM mock_data
order by sale_customer_id, sale_seller_id, sale_product_id;
--- сделал вывод, что айдишники - рандом