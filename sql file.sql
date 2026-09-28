

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'banking_customers'
ORDER BY ordinal_position;
SELECT *
FROM banking_customers
LIMIT 10;
SELECT COUNT(*)
FROM banking_customers;
SELECT *
FROM banking_customers
LIMIT 10;
ALTER TABLE public.banking_customers
ADD COLUMN IF NOT EXISTS exited integer;