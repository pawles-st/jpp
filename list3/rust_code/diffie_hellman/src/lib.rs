use rand::distributions::{Distribution, Uniform};
use crate::modfield::{ModField, ModType};

pub mod modfield;

pub struct DHSetup<T: ModField<T>> {
    generator: T,
}

impl<T: ModField<T>> DHSetup<T> {
    pub fn new() -> Self {
        let q = T::get_characteristic() - 1;
        let prime_divisors = Self::find_prime_divisors(q);
        
        let mut g;
        let between = Uniform::from(2..T::get_characteristic());
        let mut rng = rand::thread_rng();
        loop {
            g = T::from_u64(between.sample(&mut rng));
            if Self::is_generator(g, &prime_divisors) {
                break;
            }
        }
        return Self{generator: g};
    }

    pub fn power(mut a: T, mut b: ModType) -> T {
        let mut result = T::from_u64(1);
        while b > 0 {
            if b % 2 == 1 {
                result = result * a;
            }
            a = a * a;
            b /= 2;
        }
        return result;
    }

    pub fn get_generator(&self) -> T {
        return self.generator;
    }

    fn find_prime_divisors(mut q: ModType) -> Vec<ModType> {
        let mut divisors = Vec::new();
        let mut x = 2;
        while q > 1 {
            if q % x == 0 {
                divisors.push(x);
                while q % x == 0 {
                    q /= x;
                }
            }
            x += 1;
        }
        return divisors;
    }

    fn is_generator(g: T, divisors: &Vec<ModType>) -> bool {
        for p in divisors {
            if Self::power(g, (T::get_characteristic() - 1) / p) == T::from_u64(1) {
                return false;
            }
        }
        return true;
    }
}

pub struct User<'a, T: ModField<T>> {
    dhsetup: &'a DHSetup<T>,
    secret: u64,
    key: T,
    is_key_set: bool,
}

#[derive(Debug)]
pub enum DHError {
    KeyNotSet,
}

impl<'a, T: ModField<T>> User<'a, T> {
    pub fn new(dhs: &'a DHSetup::<T>) -> Self {
        let between = Uniform::from(2..(T::get_characteristic() - 1));
        let mut rng = rand::thread_rng();
        let random_secret = between.sample(&mut rng);
        return Self{dhsetup: dhs, secret: random_secret, key: T::from_u64(0), is_key_set: false};
    }

    pub fn get_public_key(&self) -> T {
        return DHSetup::power(self.dhsetup.get_generator(), self.secret);
    }

    pub fn set_key(&mut self, a: T) {
        self.key = DHSetup::power(a, self.secret);
        self.is_key_set = true;
    }

    pub fn encrypt(&self, m: T) -> Result<T, DHError> {
        if !self.is_key_set {
            return Err(DHError::KeyNotSet);
        } else {
            return Ok(m * self.key)
        }
    }

    pub fn decrypt(&self, c: T) -> Result<T, DHError> {
        if !self.is_key_set {
            return Err(DHError::KeyNotSet);
        } else {
            return Ok((c / self.key).unwrap());
        }
    }
}
