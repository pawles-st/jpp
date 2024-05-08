use modfield::*;

const P: u64 = 1234577;

#[test]
fn test_order() {
    let a = GF::<P>::new();
    let b = GF::<P>::from_u64(5);
    let c = GF::<P>::from_u64(11);
    let d = GF::<P>::from_u64(11);

    assert!(a < b);
    assert!(b > a);
    assert!(b <= c);
    assert!(c <= d);
    assert!(c == d);
    assert!(a != b);
}

#[test]
fn test_arithmetic() {
    let a = GF::<P>::new();
    let b = GF::<P>::from_u64(5);
    let c = GF::<P>::from_u64(11);
    let d = GF::<P>::from_u64(11);

    assert_eq!(a + b, GF::<P>::from_u64(5));
    assert_eq!(c - b, GF::<P>::from_u64(6));
    assert_eq!(a * b, GF::<P>::from_u64(0));
    assert_eq!(b * b.inverse().unwrap(), GF::<P>::from_u64(1));
    assert_eq!((GF::<P>::from_u64(1) / d).unwrap(), d.inverse().unwrap());
}

#[test]
fn test_assignment() {
    let mut a = GF::<P>::new();

    a = GF::<P>::from_u64(1);
    a -= 5;
    assert_eq!(a, GF::<P>::from_u64(1234573));
    a -= 1;
    assert_eq!(a, GF::<P>::from_u64(1234572));
    a *= 2;
    assert_eq!(a, GF::<P>::from_u64(1234567));
    a /= 2;
    assert_eq!(a, GF::<P>::from_u64(1234572));
}

#[test]
fn test_other() {
    let a = GF::<P>::new();
    assert_eq!(a.get_characteristic(), P);
    assert_eq!(a.get_value(), 0);
}

