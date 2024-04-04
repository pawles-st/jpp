#[derive(Debug)]
#[repr(C)]
pub struct DiophantineSolution{
    pub a: i32,
    pub b: i32,
    pub c: i32,
}

extern "C" {
    pub fn factorial(n: u32) -> u64;
    pub fn gcd(x: u32, y: u32) -> u32;
    pub fn solve_dio(x: i32, y: i32) -> DiophantineSolution;
}
