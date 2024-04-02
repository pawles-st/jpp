package Integer_Functions_Rec is
	type Diophantine_Solution is record
		a, b, c : Integer;
	end record;
	Function Factorial(n : Integer) return Integer;
	Function GCD(x : Integer; y : Integer) return Integer;
	Function Solve_Dio(x : Integer; y : Integer) return Diophantine_Solution;

	pragma Import(C, Factorial, "factorial");
	pragma Import(C, GCD, "gcd");
	pragma Import(C, Solve_Dio, "solve_dio");
end Integer_Functions_Rec;
