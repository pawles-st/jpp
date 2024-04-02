use std::mem;

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
        let mut result = n;
        let mut k = n - 1;
        while k > 1 {
            result *= k;
            k -= 1;
        }
        return result;
    }
}

pub fn gcd(mut x: u64, mut y: u64) -> u64 {
    if x < y {
        mem::swap(&mut x, &mut y);
    }
    while y != 0 {
        let r = x % y;
        x = y;
        y = r;
    }
    return x;
}

pub fn solve_dio(mut x: i64, mut y: i64) -> DiophantineSolution {
    let mut s1 = 1;
    let mut s2 = 0;
    let mut t1 = 0;
    let mut t2 = 1;
    while y != 0 {
        let q = x / y;
        let r = x % y;
        let new_s = s1 - q * s2;
        let new_t = t1 - q * t2;
        s1 = s2;
        s2 = new_s;
        t1 = t2;
        t2 = new_t;
        x = y;
        y = r;
    }
    return DiophantineSolution{a: s1, b: t1, c: x};
}
