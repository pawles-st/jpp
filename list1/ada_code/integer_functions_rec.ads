package Integer_Functions_Rec is
	type Diophantine_Solution is record 
		a, b, c : Integer;
	end record;
	Function Factorial(n : Integer) return Integer;
	Function GCD(x : Integer; y : Integer) return Integer;
	Function Solve_Dio(x : Integer; y : Integer) return Diophantine_Solution;
end Integer_Functions_Rec;
