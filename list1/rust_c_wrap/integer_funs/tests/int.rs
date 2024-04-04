use integer_funs::*;

#[test]
fn test_factorial() {
    let fact_values = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800];
    for i in 0..(fact_values.len()) {
        unsafe {
            assert_eq!(factorial(i as u32), fact_values[i]);
        }
    }
}

#[test]
fn test_gcd() {
    let gcd_values = [4, 136, 19072];
    let x_values = [76, 1438472, 33261568];
    let y_values = [44, 82626392, 20082816];
    for i in 0..(gcd_values.len()) {
        unsafe {
            assert_eq!(gcd(x_values[i], y_values[i]), gcd_values[i]);
        }
    }
}

#[test]
fn test_dio() {
    let dio_values = [DiophantineSolution{a: -4, b: 7, c: 4}, DiophantineSolution{a: 4, b: 7, c: -4}, DiophantineSolution{a: 4, b: 7, c: 4}, DiophantineSolution{a: -4, b: 7, c: -4}, DiophantineSolution{a: -23608, b: 411, c: 136}, DiophantineSolution{a: -32, b: 53, c: 19072}];
    let x_values = [76, 76, -76, -76, 1438472, 33261568];
    let y_values = [44, -44, 44, -44, 82626392, 20082816];
    for i in 0..(dio_values.len()) {
        unsafe {
            let solution = solve_dio(x_values[i], y_values[i]);
            assert_eq!(solution.a, dio_values[i].a);
            assert_eq!(solution.b, dio_values[i].b);
            assert_eq!(solution.c, dio_values[i].c);
        }
    }
}
