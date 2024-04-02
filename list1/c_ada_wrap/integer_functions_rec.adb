package body Integer_Functions_Rec is
	Function Factorial(n : Integer) return Integer is
	begin
		if n = 0 then
			return 1;
		else
			return n * Factorial(n - 1);
		end if;
	end;

	Function GCD(x : Integer; y : Integer) return Integer is
	begin
		if y = 0 then
			return x;
		else
			return GCD(y, x rem y);
		end if;
	end;

	Function Solve_Dio(x : Integer; y : Integer) return Diophantine_Solution is
		q, r : Integer;
		prev : Diophantine_Solution;
	begin
		if y = 0 then
			return (1, 0, x);
		else
			q := x / y;
			r := x rem y;
			prev := Solve_Dio(y, r);
			return (prev.b, prev.a - q * prev.b, prev.c);
		end if;
	end;
end Integer_Functions_Rec;
