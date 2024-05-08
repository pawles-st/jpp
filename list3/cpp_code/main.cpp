#include <iostream>
#include <cassert>

#include "dh.hpp"
#include "mod_field.hpp"

#define P 1234567891

int main() {

    DHSetup<GF<P>> dhs;

    std::cout << "generator: " << dhs.getGenerator() << "\n";

    User<GF<P>> alice(dhs);
    User<GF<P>> bob(dhs);

    alice.setKey(bob.getPublicKey());
//    bob.setKey(alice.getPublicKey() + GF<P>(1));
    bob.setKey(alice.getPublicKey());

    auto message = GF<P>(28);
    auto encryptedMessage = alice.encrypt(message);
    std::cout << "alice encrypted " << message << ", bob decrypted " << bob.decrypt(encryptedMessage) << "\n";

    for (int i = 0; i < P; i++) {
        auto m = GF<P>(i);
        assert(m == bob.decrypt(alice.encrypt(m)));
        if (i % 1000000 == 0) {
            std::cout << 100 * double(((double)i / (double)P)) << "% ";
        }
    }

//    for (int i = 0; i < P; i++) {
//        auto m = GF<P>(i);
//        if(m == bob.decrypt(alice.encrypt(m))) {
//            std::cout << "i: " << i << ", m: " << m << ", alice.encrypt(m): " << alice.encrypt(m) << "\n";
//        }
//        if (i % 10000000 == 0) {
//            std::cout << 100 * double(((double)i / (double)P)) << "% ";
//        }
//    }

    return 0;
}

