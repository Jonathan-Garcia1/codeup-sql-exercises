SELECT * 
FROM telco_normalized.customer_details
LEFT JOIN customer_churn ON customer_details.customer_id = customer_churn.customer_id
LEFT JOIN customer_contracts ON customer_details.customer_id = customer_contracts.customer_id
LEFT JOIN contract_types ON customer_contracts.contract_type_id = contract_types.contract_type_id
LEFT JOIN customer_payments ON customer_details.customer_id = customer_payments.customer_id
LEFT JOIN payment_types ON customer_payments.payment_type_id = payment_types.payment_type_id
LEFT JOIN customer_signups ON customer_details.customer_id = customer_signups.customer_id
LEFT JOIN customer_subscriptions ON customer_details.customer_id = customer_subscriptions.customer_id
LEFT JOIN internet_service_types ON customer_subscriptions.internet_service_type_id = internet_service_types.internet_service_type_id;
