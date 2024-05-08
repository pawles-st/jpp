use std::ops::{Add, Sub, Mul, Div, AddAssign, SubAssign, MulAssign, DivAssign};
use std::fmt;

#[derive(Debug)]
pub enum GFError {
    DivideByZero,
}

type ModType = u64;

struct DiophantineSolution {
    a: i64,
    b: i64,
    c: ModType,
}

#[derive(PartialEq, Eq, PartialOrd, Ord, Clone, Copy, Debug)]
pub struct GF<const P: ModType> {
    value: ModType,
}

impl<const P: ModType> GF<P> {
    pub fn new() -> Self {
        return GF::<P>{value: 0};
    }

    pub fn from_i64(v: i64) -> Self {
        return GF::<P>{value: GF::<P>::modulo(v)};
    }

    pub fn to_i64(&self) -> i64 {
        return self.value as i64;
    }
    
    pub fn from_u64(v: u64) -> Self {
        return GF::<P>{value: v % P};
    }

    pub fn to_u64(&self) -> u64 {
        return self.value;
    }

    pub fn get_characteristic(&self) -> ModType {
        return P;
    }
    
    pub fn get_value(&self) -> ModType {
        return self.value;
    }

    fn modulo(v: i64) -> ModType {
        println!("{}", v % (P as i64));
        println!("{}", P);
        println!("---");
        return (((v % (P as i64)) + P as i64) as ModType) % P;
    }
}
impl<const P: ModType> fmt::Display for GF::<P> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.value)
    }
}

impl<const P: ModType> Add for GF::<P> {
    type Output = GF::<P>;

    fn add(self, rhs: Self) -> GF::<P> {
        return GF::from_u64(self.value + rhs.value);
    }
}

impl<const P: ModType> Sub for GF::<P> {
    type Output = GF::<P>;

    fn sub(self, rhs: Self) -> GF::<P> {
        return GF::from_i64(self.value as i64 - rhs.value as i64);
    }
}

impl<const P: ModType> Mul for GF::<P> {
    type Output = GF::<P>;

    fn mul(self, rhs: Self) -> GF::<P> {
        return GF::from_u64(self.value * rhs.value);
    }
}

impl<const P: ModType> Div for GF::<P> {
    type Output = Result<GF::<P>, GFError>;

    fn div(self, rhs: Self) -> Result<GF::<P>, GFError> {
        let rhs_inv = rhs.inverse()?;
        return Ok(GF::from_u64(self.value * rhs_inv.value));
    }
}

impl<const P: ModType> Add<u64> for GF::<P> {
    type Output = GF::<P>;

    fn add(self, rhs: u64) -> GF::<P> {
        return GF::from_u64(self.value + rhs);
    }
}

impl<const P: ModType> Sub<u64> for GF::<P> {
    type Output = GF::<P>;

    fn sub(self, rhs: u64) -> GF::<P> {
        return GF::from_i64(self.value as i64 - rhs as i64);
    }
}

impl<const P: ModType> Mul<u64> for GF::<P> {
    type Output = GF::<P>;

    fn mul(self, rhs: u64) -> GF::<P> {
        return GF::from_u64(self.value * rhs);
    }
}

impl<const P: ModType> Div<u64> for GF::<P> {
    type Output = Result<GF::<P>, GFError>;

    fn div(self, rhs: u64) -> Result<GF::<P>, GFError> {
        return Ok(self * GF::<P>::from_u64(rhs).inverse()?);
    }
}

impl<const P: ModType> GF<P> {
    pub fn inverse(self) -> Result<Self, GFError> {
        if self.value != 0 {
            let solution = GF::<P>::solve_dio(P, self.value);
            return Ok(GF::from_i64(solution.b));
        } else {
            return Err(GFError::DivideByZero);
        }
    }

    fn solve_dio(x: ModType, y: ModType) -> DiophantineSolution {
        if y == 0 {
            return DiophantineSolution{a: 1, b: 0, c: x};
        } else {
            let r = x % y;
            let q = x / y;
            let prev = GF::<P>::solve_dio(y, r);
            return DiophantineSolution{a: prev.b, b: prev.a - (q as i64) * prev.b, c: prev.c};
        }
    }
}

impl<const P: ModType> AddAssign for GF::<P> {
    fn add_assign(&mut self, rhs: Self) {
        *self = *self + rhs;
    }
}

impl<const P: ModType> SubAssign for GF::<P> {
    fn sub_assign(&mut self, rhs: Self) {
        *self = *self - rhs;
    }
}

impl<const P: ModType> MulAssign for GF::<P> {
    fn mul_assign(&mut self, rhs: Self) {
        *self = *self * rhs;
    }
}

impl<const P: ModType> DivAssign for GF::<P> {
    fn div_assign(&mut self, rhs: Self) {
        *self = (*self / rhs).unwrap();
    }
}

impl<const P: ModType> AddAssign<u64> for GF::<P> {
    fn add_assign(&mut self, rhs: u64) {
        *self = *self + rhs;
    }
}

impl<const P: ModType> SubAssign<u64> for GF::<P> {
    fn sub_assign(&mut self, rhs: u64) {
        *self = *self - rhs;
    }
}

impl<const P: ModType> MulAssign<u64> for GF::<P> {
    fn mul_assign(&mut self, rhs: u64) {
        *self = *self * rhs;
    }
}

impl<const P: ModType> DivAssign<u64> for GF::<P> {
    fn div_assign(&mut self, rhs: u64) {
        *self = (*self / rhs).unwrap();
    }
}

