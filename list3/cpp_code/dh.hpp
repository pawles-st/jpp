#ifndef DIFFIE_HELLMAN
#define DIFFIE_HELLMAN

#include <random>
#include <vector>
#include <stdexcept>

using mod_type = unsigned long;

template<class T>
class DHSetup {
	public:
		DHSetup() {
			mod_type q = T::getCharacteristic() - 1;
			std::vector<mod_type> prime_divisors = DHSetup::findPrimeDivisors(q);
			T g;
			do {
				g = getRandom(2, T::getCharacteristic() - 1);
			} while (!DHSetup::isGenerator(g, prime_divisors));
			this->generator = g;
		}

		T getGenerator() const {
			return this->generator;
		}

		static T power(T a, mod_type b) {
			T result = T(1);
			while (b > 0) {
				if (b % 2 == 1) {
					result *= a;
				}
				a *= a;
				b /= 2;
			}
			return result;
		}

		T getRandom(mod_type low, mod_type high) const {
			std::uniform_int_distribution<mod_type> dist(low, high);
			return dist(DHSetup::rd);
		}
	private:
		T generator;
		static std::random_device rd;
		static std::mt19937 mt;
		std::uniform_int_distribution<mod_type> dist;

		static std::vector<mod_type> findPrimeDivisors(mod_type q) {
			std::vector<mod_type> divisors;
			for (mod_type x = 2; q > 1; ++x) {
				if (q % x == 0) {
					divisors.push_back(x);
					do {
						q /= x;
					} while (q % x == 0);
				}
			}
			return divisors;
		}

		static bool isGenerator(const T g, const std::vector<mod_type>& divisors) {
			for (mod_type p : divisors) {
				if (DHSetup::power(g, (T::getCharacteristic() - 1) / p) == T(1)) {
					return false;
				}
			}
			return true;
		}
};

template<class T>
std::random_device DHSetup<T>::rd;

template<class T>
std::mt19937 DHSetup<T>::mt(rd());

template<class T>
class User {
	public:
		User(const DHSetup<T>& dhs) : dhsetup(dhs) {
			this->secret = dhs.getRandom(2, T::getCharacteristic() - 2);
		}
		
		T getPublicKey() {
			return DHSetup<T>::power(this->dhsetup.getGenerator(), this->secret);
		}

		void setKey(T a) {
			this->key = DHSetup<T>::power(a, secret);
			isKeySet = true;
		}

		T encrypt(T m) {
			if (!isKeySet) {
				throw std::runtime_error("Encryption key has not been set");
			} else {
				return m * key;
			}
		}

		T decrypt(T c) {
			if (!isKeySet) {
				throw std::runtime_error("Encryption key has not been set");
			} else {
				return c / key;
			}
		}
	private:
		const DHSetup<T>& dhsetup;
		T secret;
		T key;
		bool isKeySet;
};

#endif
