-- signup for teacher-student

DELIMITER //

DROP PROCEDURE IF EXISTS signup_user //

CREATE PROCEDURE signup_user (
	IN input_username VARCHAR(100),
    IN input_password VARCHAR(100) ,
    IN input_first_name VARCHAR(100),
    IN input_last_name VARCHAR(100),
    IN input_birth_date date,
    IN input_phone_number VARCHAR(30) ,
    IN input_role VARCHAR(1) ,
    IN is_lm TINYINT(1)
)
BEGIN
	DECLARE username_check INT;
    DECLARE check_phone VARCHAR(100); 
    DECLARE username_check_lm INT;
    
    SELECT COUNT(*) INTO username_check
    FROM School_User su
    WHERE su.username_su = input_username;
    
    IF username_check > 0 THEN 
		SELECT 'This username already exists. Please choose a different one.' AS Message; 
    
    ELSE 
    
		SELECT COUNT(*) INTO check_phone
		FROM School_Unit su
		WHERE su.phone_number = input_phone_number;
                
        IF check_phone = 0 THEN
			SELECT 'The phone number you have provided does not belong to any School Unit on the database. Please provide a valid phone number.' AS Message;
		
        ELSE 
			IF is_lm = 1 THEN 
				INSERT INTO Library_Manager (username_libm, password, approved) VALUES (input_username, input_password, 'pending');
				INSERT INTO School_User (username_su, password, first_name, last_name, birth_date, role, phone_number, is_lm, approved) VALUES (input_username, input_password, input_first_name, input_last_name, input_birth_date, input_role, input_phone_number, 1, 'pending');
			ELSE 
				INSERT INTO School_User (username_su, password, first_name, last_name, birth_date, role, phone_number, is_lm, approved) VALUES (input_username, input_password, input_first_name, input_last_name, input_birth_date, input_role, input_phone_number, 0, 'pending');
		
			END IF;
		END IF;
	END IF;
    
    END //
    
DELIMITER ;
    
-- CALL signup_user('godinternal', '8QvDwYh3F!kSPS3b', 'John', 'Stefanopoulos', '1974-04-22', '148-108-2401', 'T', 1);