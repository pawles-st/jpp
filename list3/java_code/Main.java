import java.lang.reflect.Constructor;

public class Main {
    public static void main(String[] args) {
	Constructor<GF> constructor;
	try {
		constructor = GF.class.getConstructor(long.class, long.class);
	} catch (Exception e) {
		System.out.println(e);
		return;
	}
        DHSetup<GF> dhs = new DHSetup<>(1234567891, constructor);

        System.out.println("generator: " + dhs.getGenerator().getValue());

        User<GF> alice = new User<>(dhs);
        User<GF> bob = new User<>(dhs);

        alice.setKey(bob.getPublicKey());
//    bob.setKey(alice.getPublicKey() + GF<P>(1));
        bob.setKey(alice.getPublicKey());

        GF message = new GF(1234567891, 113L);
        long test = message.getValue();
        GF encryptedMessage = alice.encrypt(message);
        System.out.println("alice encrypted " + message.getValue() + ", bob decrypted " + bob.decrypt(encryptedMessage).getValue());

        for (int i = 0; i < 1234567891; i++) {
            GF m = new GF(1234567891, i);
            if (m.compareTo(bob.decrypt(alice.encrypt(m))) != 0) {
                System.out.println("ALERT");
            }
            if (i % 1000000 == 0) {
//                std::cout << 100 * double(((double)i / (double)P)) << "% ";
                System.out.println(100 * (((double)i / (double)1234567891)) + "% ");
            }
        }
    }
}
