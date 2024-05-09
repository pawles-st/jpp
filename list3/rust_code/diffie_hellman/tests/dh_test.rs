use diffie_hellman::*;
use diffie_hellman::modfield::*;

const P: u64 = 1234567891;

#[test]
fn test_encrypt_decrypt() {
    let dhs = DHSetup::<GF<P>>::new();

    println!("generator: {}", dhs.get_generator());

    let mut alice = User::<GF<P>>::new(&dhs);
    let mut bob = User::<GF<P>>::new(&dhs);

    alice.set_key(bob.get_public_key());
    bob.set_key(alice.get_public_key());

    let message = GF::<P>::from_u64(28);
    let encrypted = alice.encrypt(message).unwrap();
    let decrypted = bob.decrypt(encrypted).unwrap();
    assert_eq!(message, decrypted);

    for i in 0..P {
        let m = GF::<P>::from_u64(i);
        assert_eq!(m, bob.decrypt(alice.encrypt(m).unwrap()).unwrap());
        if i % 1000000 == 0 {
            println!("{}%", 100 * i / P);
        }
    }
}
