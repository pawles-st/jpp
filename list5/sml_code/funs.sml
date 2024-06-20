fun binomial n k =
  if k = 0 orelse k = n then 1
  else binomial (n - 1) k + binomial (n - 1) (k - 1);

local
  fun pascal_row 0 = [1]
    | pascal_row n = let
      val prevrow = pascal_row (n - 1)
      fun compute_element i =
        if i = 0 orelse i = n then 1
        else List.nth(prevrow, i - 1) + List.nth(prevrow, i)
    in
      List.tabulate(n + 1, compute_element)
    end
in
  fun binomial2 n k =
    List.nth(pascal_row n, k)
end;

local
  fun merge ([], right) = right
    | merge (left, []) = left
    | merge (l::left, r::right) =
      if l <= r then l :: merge(left, r::right)
      else r :: merge(l::left, right)
in
  fun mergesort [] = []
    | mergesort [x] = [x]
    | mergesort lst = let
        val mid = length lst div 2
        val (left, right) = (List.take(lst, mid), List.drop(lst, mid))
      in
        merge(mergesort left, mergesort right)
      end
end;

fun de a 0 = (1, 0, a)
  | de a b = let
      val q = a div b
      val r = a mod b
      val (x, y, d) = de b r
    in
      (y, x - q * y, d)
    end;

local
  fun factor(k, p, primes) =
    if k = 1 then rev primes
    else if k mod p = 0 then factor(k div p, p, p::primes)
    else factor(k, p + 1, primes)
in
  fun prime_factors n = factor(n, 2, [])
end;

fun totient n = let
    fun gcd a 0 = a
      | gcd a b = gcd b (a mod b)
    fun is_coprime k = if gcd n k = 1 then 1 else 0
  in
    List.foldl (fn (k, acc) => acc + (is_coprime k)) 0 (List.tabulate(n, fn x => x + 1))
  end;

fun totient2 n = let
  val primes = prime_factors n
  fun power a 0 = 1
    | power a b = a * power a (b - 1)
  fun totient_factor p k = (p - 1) * (power p (k - 1))
  fun distinct [] = []
  | distinct (x::xs) = x :: distinct (List.filter (fn y => y <> x) xs);
in
  List.foldl (fn (p, acc) => acc * totient_factor p (length (List.filter (fn x => x = p) primes))) 1 (distinct primes)
end;

fun primes n = let
  fun sieve [] = []
    | sieve (n::lst) = n :: sieve (List.filter (fn x => x mod n <> 0) lst)
in
  sieve (List.tabulate(n - 1, fn x => x + 2))
end;


binomial 7 3;
binomial2 7 3;
mergesort [9, 8, 7, 6, 5, 4, 3, 2, 1];
de 27 15;
prime_factors 123;
totient 123;
totient2 123;
primes 123;
