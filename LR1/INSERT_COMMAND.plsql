CREATE OR REPLACE FUNCTION generate_insert_command(input_id IN NUMBER, input_val IN NUMBER DEFAULT NULL)
RETURN VARCHAR2 IS
    insert_command VARCHAR2(400);
    existing_id NUMBER;
BEGIN
    if input_id is Null or input_id <=0 then
        DBMS_OUTPUT.PUT_LINE('ID should be a positive value');
        RETURN 'ID should be a positive value';
    end if;
    BEGIN
        SELECT id into existing_id
        FROM MyTable
        WHERE id = input_id;
        DBMS_OUTPUT.PUT_LINE('ID already exists');
        RETURN 'ID already exists';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            insert_command := 'INSERT INTO MyTable(id, val) VALUES('||input_id||','|| input_val || ');';
            DBMS_OUTPUT.PUT_LINE(insert_command);
            RETURN insert_command;
    END;

END generate_insert_command;
/

select generate_insert_command(-5, 52) from dual;
select generate_insert_command(25, 52) from dual;
select generate_insert_command(25052, 52) from dual;
select generate_insert_command(NULL, 52) from dual;