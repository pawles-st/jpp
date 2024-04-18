public class GF implements Comparable<GF> {

	public GF(final long p) {
		if (p > 0) {
			this.p = p;
			this.value = 0;
		} else {
			throw new InvalidFieldCharacteristicException("Characteristic has to be positive");
		}
	}

	public GF(final long p, final long value) {
		if (p > 0) {
			this.p = p;
			this.value = value % p;
		} else {
			throw new InvalidFieldCharacteristicException("Characteristic has to be positive");
		}
	}

	/// --- COMPARABLE IMPLEMENTATION

	@Override
	public int compareTo(final GF rhs) {
		if (rhs != null) {
			if (this.getCharacteristic() == rhs.getCharacteristic()) {
				return Long.compare(this.getValue(), rhs.getValue());
			}
			throw new InvalidFieldCharacteristicException("Characteristics of the provided GF objects differ");
		} else {
			throw new IllegalArgumentException("Rhs cannot be null");
		}
	}

	/// --- ARITHMETIC METHODS

	public GF add(final GF rhs) {
		if (rhs != null) {
			return new GF(this.p, this.value + rhs.value);
		} else {
			throw new IllegalArgumentException("Rhs cannot be null");
		}
	}

	public GF sub(final GF rhs) {
		if (rhs != null) {
			return new GF(this.p, this.value - rhs.value);
		} else {
			throw new IllegalArgumentException("Rhs cannot be null");
		}
	}

	public GF mul(final GF rhs) {
		if (rhs != null) {
			return new GF(this.p, this.value * rhs.value);
		} else {
			throw new IllegalArgumentException("Rhs cannot be null");
		}
	}

	public GF div(final GF rhs) {
		if (rhs != null) {
			return this.mul(rhs.inverse());
		} else {
			throw new IllegalArgumentException("Rhs cannot be null");
		}
	}

	public GF inverse() {
		if (this.value != 0) {
			DiophantineSolution solution = GF.solve_dio(p, this.value);
			return new GF(this.p, solution.b);
		} else {
			throw new DivideByZeroException("Cannot invert a zero element");
		}
	}

	/// --- SETTERS/GETTERS ---

	public long getValue() {
		return this.value;
	}
	
	public void setValue(final long value) {
		this.value = value;
	}

	/// --- OTHER METHODS ---
	
	public long getCharacteristic() {
		return p;
	}

	/// --- PRIVATE FIELDS ---

	private long value;
	private long p;

	/// --- HELPER METHODS ---

	static DiophantineSolution solve_dio(final long x, final long y) {
		if (y == 0) {
			return new DiophantineSolution(1L, 0L, x);
		} else {
			long r = x % y;
			long q = x / y;
			DiophantineSolution prev = solve_dio(y, r);
			return new DiophantineSolution(prev.b, prev.a - q  * prev.b, prev.c);
		}
	}


}

class DiophantineSolution {
	public DiophantineSolution(final long a, final long b, final long c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}

	public long a;
	public long b;
	public long c;
}

