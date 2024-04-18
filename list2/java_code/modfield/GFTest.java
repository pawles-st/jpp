public class GFTest {
	public static void main(String[] args) {
		GF a = new GF(p);
		GF b = new GF(p, 5);
		GF c = new GF(p, 11);
		GF d = new GF(p, 11);

		assert a.getValue() == 0;

		assert(a.compareTo(b) == -1);
		assert(b.compareTo(a) == 1);
		assert(b.compareTo(c) != 1);
		assert(c.compareTo(d) != 1);
		assert(c.compareTo(d) == 0);
		assert(a.compareTo(b) != 0);

		assert((a.add(b)).compareTo(new GF(p, 5)) == 0);
		assert((c.sub(b)).compareTo(new GF(p, 6)) == 0);
		assert((a.mul(b)).compareTo(new GF(p, 0)) == 0);
		assert((b.mul(b.inverse())).compareTo(new GF(p, 1)) == 0);
		assert(((new GF(p, 1)).div(d)).compareTo(d.inverse()) == 0);
	
		assert(a.getCharacteristic() == p);
	}

	static final long p = 1234577;
}
