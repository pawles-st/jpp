import Data.List (nub)

binomial :: Integer -> Integer -> Integer
binomial n k | k == 0 = 1
             | k == n = 1
             | otherwise = binomial (n - 1) k + binomial (n - 1) (k - 1)

binomial2 :: Integer -> Integer -> Integer
binomial2 n k = (pascal_triangle !! fromIntegral(n) !! fromIntegral(k))
  where pascal_triangle = [[pascal i j | j <- [0..i]] | i <- [0..]]
        pascal _ 0 = 1
        pascal x y | x == y = 1
                   | otherwise = pascal_triangle !! (x - 1) !! (y - 1) + pascal_triangle !! (x - 1) !! y

mergesort :: Ord a => [a] -> [a]
mergesort [] = []
mergesort [x] = [x]
mergesort lst = merge (mergesort left) (mergesort right)
  where (left, right) = splitAt (length lst `div` 2) lst
        merge [] r = r
        merge l [] = l
        merge (l:ltail) (r:rtail) | l <= r = l : merge ltail (r:rtail)
                                  | otherwise = r : merge (l:ltail) rtail

de :: Integral a => a -> a -> (a, a, a)
de a 0 = (1, 0, a)
de a b =
  let (q, r) = a `quotRem` b
      (x, y, z) = de b r
  in (y, x - q * y, z)

prime_factors :: Integer -> [Integer]
prime_factors n = factor n 2
  where factor 1 _ = []
        factor n p | n `mod` p == 0 = p : factor (n `div` p) p
                   | otherwise = factor n (p + 1)

totient :: Integer -> Integer
totient n = fromIntegral $ length [x | x <- [1..n], gcd n x == 1]

totient2 :: Integer -> Integer
totient2 n = product [product $ subtract_one $ [x | x <- factors, x == p] | p <- unique_factors]
  where factors = prime_factors n
        unique_factors = nub factors
        subtract_one [] = []
        subtract_one (hd:tl) = (hd - 1):tl

primes :: Integer -> [Integer]
primes n = sieve [2..n]
  where sieve (p:lst) = p : sieve [x | x <- lst, x `mod` p /= 0]
        sieve [] = []

main :: IO ()
main = do {
    putStrLn $ show (binomial 7 3);
    putStrLn $ show (binomial2 7 3);
    putStrLn $ show (mergesort [9,8..1]);
    putStrLn $ show (de 27 15);
    putStrLn $ show (prime_factors 123);
    putStrLn $ show (totient 123);
    putStrLn $ show (totient2 123);
    putStrLn $ show (primes 123);
}
