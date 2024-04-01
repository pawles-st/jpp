package body Integer_Functions_Iter is
	Function Factorial(n : Integer) return Integer is
		result : Integer;
	begin
		if n = 0 then
			return 1;
		else
			result := n;
			for k in reverse 2 .. (n - 1) loop
				result := result * k;
			end loop;
			return result;
		end if;
	end;

	Function GCD(x : Integer; y : Integer) return Integer is
		u, v, r : Integer;
	begin
		u := x;
		v := y;
		if u < v then
			r := u;
			u := v;
			v := r;
		end if;
		while v /= 0 loop
			r := u rem v;
			u := v;
			v := r;
		end loop;
		return u;
	end;

	Function Solve_Dio(x : Integer; y : Integer) return Diophantine_Solution is
		u, v, s1, s2, new_s, t1, t2, new_t, q, r : Integer;
	begin
		u := x;
		v := y;
		s1 := 1;
		s2 := 0;
		t1 := 0;
		t2 := 1;
		while v /= 0 loop
			q := u / v;
			r := u rem v;
			new_s := s1 - q * s2;
			new_t := t1 - q * t2;
			s1 := s2;
			s2 := new_s;
			t1 := t2;
			t2 := new_t;
			u := v;
			v := r;
		end loop;
		return (s1, t1, u);
	end;
end Integer_Functions_Iter;
