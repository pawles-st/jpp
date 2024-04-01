with Ada.Text_IO; use Ada.Text_IO;
with Integer_Functions_Iter; use Integer_Functions_Iter;

procedure Main is
	type Int_Array is array (Integer range <>) of Integer;
	type Dio_Array is array (Integer range <>) of Diophantine_Solution;
begin
	declare 
		FACT_TEST_LEN : constant Integer := 10;
		fact_values : constant Int_Array (0 .. FACT_TEST_LEN) := (1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800);
		fact_result : Integer;
	begin
		for i in 0 .. FACT_TEST_LEN loop
			fact_result := Factorial(i);
			if fact_result /= fact_values(i) then
				Put_Line("Error: in Factorial test number" & Integer'Image(i) & " - got" & Integer'Image(fact_result) & " but expected" & Integer'Image(fact_values(i)));
			end if;
--			pragma Assert(Check => Factorial(i) = fact_values(i));
		end loop;
	end;

	declare
		GCD_TEST_LEN : constant Integer := 2;
		gcd_values : constant Int_Array (0 .. GCD_TEST_LEN) := (4, 136, 19072);
		x_values : constant Int_Array (0 .. GCD_TEST_LEN) := (76, 1438472, 33261568);
		y_values : constant Int_Array (0 .. GCD_TEST_LEN) := (44, 82626392, 20082816);
		gcd_result : Integer;
	begin
		for i in 0 .. GCD_TEST_LEN loop
			gcd_result := GCD(x_values(i), y_values(i));
			if gcd_result /= gcd_values(i) then
				Put_Line("Error: in GCD test number" & Integer'Image(i) & " - got" & Integer'Image(gcd_result) & " but expected" & Integer'Image(gcd_values(i)));
			end if;
		end loop;
	end;
	
	declare
		DIO_TEST_LEN : constant Integer := 5;
		--dio_values: constant array (0 .. DIO_TEST_LEN) of Diophantine_Solution := ((a => -4, b => 7, c => 4), (a => , b => 1, c => 1));
		dio_values : constant Dio_Array (0 .. DIO_TEST_LEN) := ((-4, 7, 4), (4, 7, -4), (4, 7, 4), (-4, 7, -4), (-23608, 411, 136), (-32, 53, 19072));
		x_values : constant Int_Array (0 .. DIO_TEST_LEN) := (76, 76, -76, -76, 1438472, 33261568);
		y_values : constant Int_Array (0 .. DIO_TEST_LEN) := (44, -44, 44, -44, 82626392, 20082816);
		dio_result : Diophantine_Solution;
	begin
		for i in 0 .. DIO_TEST_LEN loop
			dio_result := Solve_Dio(x_values(i), y_values(i));
			if dio_result /= dio_values(i) then
				Put_Line("Error: in GCD test number" & Integer'Image(i) & " - got (" & Integer'Image(dio_result.a) & Integer'Image(dio_result.b) & Integer'Image(dio_result.c) & ") but expected (" & Integer'Image(dio_values(i).a) & Integer'Image(dio_values(i).b) & Integer'Image(dio_values(i).c) & ")");
			end if;
		end loop;
	end;

end Main;
