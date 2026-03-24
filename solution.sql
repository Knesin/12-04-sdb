USE sakila;

-- 1
SELECT
    st.first_name,
    st.Last_name,
    ci.city,
    COUNT(c.store_id) AS count_user
FROM
    customer c
    INNER JOIN store s ON c.store_id = s.store_id
    INNER JOIN address a ON a.address_id = s.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN staff st ON s.store_id = st.store_id
GROUP BY
    st.first_name,
    st.Last_name,
    c.store_id,
    ci.city
HAVING
    count_user > 300;

-- 2
SELECT
    COUNT(*)
FROM
    film
WHERE
    length > (
        SELECT
            AVG(length)
        FROM
            film
    );

-- 3
SELECT
    DATE_FORMAT(payment_date, '%M - %Y') AS MONTH,
    SUM(amount) AS sum,
    COUNT(rental_id) AS count_rental
FROM
    payment
GROUP BY
    DATE_FORMAT(payment_date, '%M - %Y')
ORDER BY
    sum DESC
LIMIT
    1;

-- 4
SELECT
    s.first_name,
    s.last_name,
    CASE
        WHEN COUNT(r.rental_id) > 8000 THEN 'Да'
        ELSE 'Нет'
    END AS 'Премия'
FROM
    staff s
    JOIN rental r ON s.staff_id = r.staff_id
GROUP BY
    s.staff_id;

-- 5
SELECT
    f.title
FROM
    film f
    INNER JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE
    r.inventory_id IS NULL