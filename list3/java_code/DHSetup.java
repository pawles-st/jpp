import java.util.ArrayList;
import java.util.Random;
import java.lang.reflect.Constructor;

public class DHSetup <T extends ModField & Comparable<T>> {
	public DHSetup(long p, Constructor<T> constructor) {
		this.constructor = constructor;
		this.p = p;

		long q = p - 1;
		ArrayList<Long> primeDivisors = this.findPrimeDivisors(q);

		Random rng = new Random();
		T g;
		do {
			try {
				g = this.constructor.newInstance(p, rng.nextLong(p - 3) + 2);
				System.out.println(g.getValue());
			} catch (Exception e) {
				System.out.println("Cannot make instance of type T");
				return;
			}
		} while (!this.isGenerator(g, primeDivisors));
		this.generator = g;
	}

	@SuppressWarnings("unchecked")
	public T power(T a, long b) {
		T pow;
		T result;
		try {
			pow = this.constructor.newInstance(this.p, a.getValue());
			result = this.constructor.newInstance(this.p, 1L);
		} catch (Exception e) {
			System.out.println("Cannot raise to the power");
			return a;
		}

		while (b > 0) {
			if (b % 2 == 1) {
				result = (T) result.mul(a);
			}
			a = (T) a.mul(a);
			b /= 2;
		}
		return result;
	}

	public T getGenerator() {
		return this.generator;
	}

	public long getCharacteristic() {
		return p;
	}

	private Constructor<T> constructor;
	private T generator;
	private long p;

	private ArrayList<Long> findPrimeDivisors(long q) {
		ArrayList<Long> divisors = new ArrayList<Long>();
		for (long x = 2; q > 1; ++x) {
			if (q % x == 0) {
				divisors.add(x);
				do {
					q /= x;
				} while (q % x == 0);
			}
		}
		return divisors;
	}

	private boolean isGenerator(final T g, final ArrayList<Long> divisors) {
		System.out.println(divisors);
		for (long q : divisors) {
			try {
				if (this.power(g, (this.p - 1) / q).compareTo(this.constructor.newInstance(this.p, 1L)) == 0) {
					System.out.println("hello");
					return false;
				}
			} catch (Exception e) {
				return false;
			}
		}
		return true;
	}
}
