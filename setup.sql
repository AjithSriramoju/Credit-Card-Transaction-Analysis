-- =====================================================
-- Credit Card Transaction Analysis
-- Database Setup
-- =====================================================

CREATE TABLE credit_card_transactions (
    trans_date_trans_time TIMESTAMP,
    cc_num BIGINT,
    merchant TEXT,
    category TEXT,
    amt DOUBLE PRECISION,
    first TEXT,
    last TEXT,
    gender TEXT,
    street TEXT,
    city TEXT,
    state TEXT,
    zip INTEGER,
    lat DOUBLE PRECISION,
    long DOUBLE PRECISION,
    city_pop BIGINT,
    job TEXT,
    dob DATE,
    trans_num TEXT,
    unix_time BIGINT,
    merch_lat DOUBLE PRECISION,
    merch_long DOUBLE PRECISION,
    is_fraud INTEGER,
    merch_zipcode DOUBLE PRECISION,
    year INTEGER,
    month INTEGER,
    month_name TEXT,
    day INTEGER,
    day_name TEXT,
    hour INTEGER
);

