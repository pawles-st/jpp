#[derive(Debug)]
#[repr(C)]
pub struct DiophantineSolution{
    pub a: i32,
    pub b: i32,
    pub c: i32,
}

#[no_mangle]
pub extern "C" fn factorial(n: u32) -> u64 {
    if n == 0 {
        return 1;
    } else {
        return n as u64 * factorial(n - 1);
    }
}

#[no_mangle]
pub extern "C" fn gcd(x: u32, y: u32) -> u32 {
    if y == 0 {
        return x;
    } else {
        return gcd(y, x % y);
    }
}

#[no_mangle]
pub extern "C" fn solve_dio(x: i32, y: i32) -> DiophantineSolution {
    if y == 0 {
        return DiophantineSolution{a: 1, b: 0, c: x};
    } else {
        let q = x / y;
        let r = x % y;
        let prev = solve_dio(y, r);
        return DiophantineSolution{a: prev.b, b: prev.a - q * prev.b, c: prev.c};
    }
}
