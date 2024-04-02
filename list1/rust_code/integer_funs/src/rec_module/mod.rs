#[derive(Debug)]
pub struct DiophantineSolution{
    pub a: i64,
    pub b: i64,
    pub c: i64,
}

pub fn factorial(n: u64) -> u64 {
    if n == 0 {
        return 1;
    } else {
        return n * factorial(n - 1);
    }
}

pub fn gcd(x: u64, y: u64) -> u64 {
    if y == 0 {
        return x;
    } else {
        return gcd(y, x % y);
    }
}

pub fn solve_dio(x: i64, y: i64) -> DiophantineSolution {
    if y == 0 {
        return DiophantineSolution{a: 1, b: 0, c: x};
    } else {
        let q = x / y;
        let r = x % y;
        let prev = solve_dio(y, r);
        return DiophantineSolution{a: prev.b, b: prev.a - q * prev.b, c: prev.c};
    }
}
