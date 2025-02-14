CREATE OR REPLACE FUNCTION TOTAL_ANNUAL_AWARD(monthly_payment IN DECIMAL, annual_premium IN NUMBER) RETURN DECIMAL IS
    total_award DECIMAL;
BEGIN
    IF monthly_payment is null OR monthly_payment < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Montly payment should be positive');
    END IF;
    IF annual_premium IS NULL OR annual_premium < 0 OR annual_premium <> TRUNC(annual_premium) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Annual premium must be a positive integer');
    END IF;
    total_award := (1 + annual_premium / 100) * monthly_payment * 12;
    RETURN total_award;

END TOTAL_ANNUAL_AWARD;
/

SELECT TOTAL_ANNUAL_AWARD(-1, -1) FROM dual;
SELECT TOTAL_ANNUAL_AWARD(5, 20) FROM dual;
SELECT TOTAL_ANNUAL_AWARD(50, 20.5) FROM dual;
SELECT TOTAL_ANNUAL_AWARD(null, null) FROM dual;