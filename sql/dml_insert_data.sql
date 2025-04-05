INSERT INTO
    d_country (name)
SELECT DISTINCT
    country
FROM (
        SELECT customer_country AS country
        FROM mock_data
        UNION
        SELECT store_country AS country
        FROM mock_data
        UNION
        SELECT supplier_country AS country
        FROM mock_data
    ) AS combined_countries
WHERE
    country IS NOT NULL
    AND LENGTH(country) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_city (name)
SELECT DISTINCT
    city
FROM (
        SELECT store_city AS city
        FROM mock_data
        UNION
        SELECT supplier_city AS city
        FROM mock_data
    ) AS combined_cities
WHERE
    city IS NOT NULL
    AND LENGTH(city) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_state (name)
SELECT DISTINCT
    store_state
FROM mock_data
WHERE
    store_state IS NOT NULL
    AND LENGTH(store_state) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_pet_type (name)
SELECT DISTINCT
    customer_pet_type
FROM mock_data
WHERE
    customer_pet_type IS NOT NULL
    AND LENGTH(customer_pet_type) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_breed (name)
SELECT DISTINCT
    customer_pet_breed
FROM mock_data
WHERE
    customer_pet_breed IS NOT NULL
    AND LENGTH(customer_pet_breed) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_pet_category (name)
SELECT DISTINCT
    pet_category
FROM mock_data
WHERE
    pet_category IS NOT NULL
    AND LENGTH(pet_category) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_product_category (name)
SELECT DISTINCT
    product_category
FROM mock_data
WHERE
    product_category IS NOT NULL
    AND LENGTH(product_category) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_color (name)
SELECT DISTINCT
    product_color
FROM mock_data
WHERE
    product_color IS NOT NULL
    AND LENGTH(product_color) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_brand (name)
SELECT DISTINCT
    product_brand
FROM mock_data
WHERE
    product_brand IS NOT NULL
    AND LENGTH(product_brand) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_material (name)
SELECT DISTINCT
    product_material
FROM mock_data
WHERE
    product_material IS NOT NULL
    AND LENGTH(product_material) > 0 ON CONFLICT (name) DO NOTHING;

INSERT INTO
    d_month (name)
VALUES ('January'),
    ('February'),
    ('March'),
    ('April'),
    ('May'),
    ('June'),
    ('July'),
    ('August'),
    ('September'),
    ('October'),
    ('November'),
    ('December');

INSERT INTO
    d_day (name)
VALUES ('Monday'),
    ('Tuesday'),
    ('Wednesday'),
    ('Thursday'),
    ('Friday'),
    ('Saturday'),
    ('Sunday');

INSERT INTO
    d_customer (
        first_name,
        last_name,
        age,
        email,
        country_id,
        postal_code
    )
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    (
        SELECT id
        FROM d_country
        WHERE
            name = customer_country
    ),
    customer_postal_code
FROM mock_data;

INSERT INTO
    d_customer_pet (
        name,
        customer_id,
        type_id,
        breed_id
    )
SELECT DISTINCT
    customer_pet_name,
    (
        SELECT id
        FROM d_customer
        WHERE
            email = customer_email
            AND first_name = customer_first_name
            AND last_name = customer_last_name
            AND age = customer_age
    ),
    (
        SELECT id
        FROM d_pet_type
        WHERE
            name = customer_pet_type
    ),
    (
        SELECT id
        FROM d_breed
        WHERE
            name = customer_pet_breed
    )
FROM mock_data;

INSERT INTO
    d_seller (
        first_name,
        last_name,
        email,
        country_id,
        postal_code
    )
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    (
        SELECT id
        FROM d_country
        WHERE
            name = seller_country
    ),
    seller_postal_code
FROM mock_data;

INSERT INTO
    d_time (
        date,
        year,
        quarter,
        month_id,
        day_id
    )
SELECT DISTINCT
    TO_DATE (sale_date, 'MM/DD/YYYY') AS date,
    EXTRACT(
        YEAR
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) AS year,
    EXTRACT(
        QUARTER
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) AS quarter,
    EXTRACT(
        MONTH
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) AS month_id,
    EXTRACT(
        DOW
        FROM TO_DATE (sale_date, 'MM/DD/YYYY')
    ) + 1 AS day_id
FROM mock_data
WHERE
    sale_date IS NOT NULL
UNION
SELECT DISTINCT
    TO_DATE (
        product_release_date,
        'MM/DD/YYYY'
    ) AS date,
    EXTRACT(
        YEAR
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) AS year,
    EXTRACT(
        QUARTER
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) AS quarter,
    EXTRACT(
        MONTH
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) AS month_id,
    EXTRACT(
        DOW
        FROM TO_DATE (
                product_release_date, 'MM/DD/YYYY'
            )
    ) + 1 AS day_id
FROM mock_data
WHERE
    product_release_date IS NOT NULL
UNION
SELECT DISTINCT
    TO_DATE (
        product_expiry_date,
        'MM/DD/YYYY'
    ) AS date,
    EXTRACT(
        YEAR
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) AS year,
    EXTRACT(
        QUARTER
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) AS quarter,
    EXTRACT(
        MONTH
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) AS month_id,
    EXTRACT(
        DOW
        FROM TO_DATE (
                product_expiry_date, 'MM/DD/YYYY'
            )
    ) + 1 AS day_id
FROM mock_data
WHERE
    product_expiry_date IS NOT NULL ON CONFLICT (date) DO NOTHING;

INSERT INTO
    d_product (
        name,
        category_id,
        price,
        quantity,
        weight,
        color_id,
        size,
        brand_id,
        material_id,
        description,
        rating,
        reviews,
        release_date_id,
        expiry_date_id
    )
SELECT DISTINCT
    product_name,
    (
        SELECT id
        FROM d_product_category
        WHERE
            name = product_category
    ),
    product_price,
    product_quantity,
    product_weight,
    (
        SELECT id
        FROM d_color
        WHERE
            name = product_color
    ),
    product_size,
    (
        SELECT id
        FROM d_brand
        WHERE
            name = product_brand
    ),
    (
        SELECT id
        FROM d_material
        WHERE
            name = product_material
    ),
    product_description,
    product_rating,
    product_reviews,
    (
        SELECT id
        FROM d_time
        WHERE
            date = TO_DATE (
                product_release_date,
                'MM/DD/YYYY'
            )
    ),
    (
        SELECT id
        FROM d_time
        WHERE
            date = TO_DATE (
                product_expiry_date,
                'MM/DD/YYYY'
            )
    )
FROM mock_data;

INSERT INTO f_sales (
        date_id,
        customer_id,
        seller_id,
        product_id,
        quantity,
        total_price
    )
SELECT DISTINCT (
        SELECT id
        FROM d_time
        WHERE date = TO_DATE(sale_date, 'MM/DD/YYYY')
    ),
    (
        SELECT id
        FROM d_customer
        WHERE email = customer_email
            AND first_name = customer_first_name
            AND last_name = customer_last_name
            AND age = customer_age
        LIMIT 1
    ), (
        SELECT id
        FROM d_seller
        WHERE email = seller_email
            AND first_name = seller_first_name
            AND last_name = seller_last_name
    ),
    (
        SELECT id
        FROM d_product
        WHERE name = product_name
            AND price = ROUND(product_price::numeric, 2)
            AND quantity = product_quantity
            AND weight = ROUND(product_weight::numeric, 2)
            AND size = product_size
            AND color_id = (
                SELECT id
                FROM d_color
                WHERE name = product_color
            )
            AND brand_id = (
                SELECT id
                FROM d_brand
                WHERE name = product_brand
            )
            AND material_id = (
                SELECT id
                FROM d_material
                WHERE name = product_material
            )
            AND description = product_description
            AND rating = ROUND(product_rating::numeric, 1)
            AND reviews = product_reviews
            AND release_date_id = (
                SELECT id
                FROM d_time
                WHERE date = TO_DATE(product_release_date, 'MM/DD/YYYY')
            )
            AND expiry_date_id = (
                SELECT id
                FROM d_time
                WHERE date = TO_DATE(product_expiry_date, 'MM/DD/YYYY')
            )
    ),
    sale_quantity,
    sale_total_price
FROM mock_data;

INSERT INTO
    d_store (
        name,
        location,
        city_id,
        state_id,
        country_id,
        phone,
        email
    )
SELECT DISTINCT
    store_name,
    store_location,
    (
        SELECT id
        FROM d_city
        WHERE
            name = store_city
    ),
    (
        SELECT id
        FROM d_state
        WHERE
            name = store_state
    ),
    (
        SELECT id
        FROM d_country
        WHERE
            name = store_country
    ),
    store_phone,
    store_email
FROM mock_data;

INSERT INTO
    d_supplier (
        name,
        contact,
        email,
        phone,
        address,
        city_id,
        country_id
    )
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    (
        SELECT id
        FROM d_city
        WHERE
            name = supplier_city
    ),
    (
        SELECT id
        FROM d_country
        WHERE
            name = supplier_country
    )
FROM mock_data;