public class GF implements Comparable<GF> {

	public GF(final long p) {
		if (p > 0) {
			this.p = p;
			this.value = 0;
		} else {
			throw
		}
	}

	public GF(final long p, final long value) {
		if (p > 0) {
			this.p = p;
			this.value = mod(value);
		} else {
			throw
		}
	}

	/// --- COMPARABLE IMPLEMENTATION

	@Override
	public int compareTo(final GF rhs) {
		if (this.getCharacteristic() == rhs.getCharacteristic) {
			return Long.compare(this.getValue(), rhs.getValue());
		}
		throw
	}

	/// --- ARITHMETIC METHODS

	public GF add(GF rhs) {}

	/// --- SETTERS/GETTERS ---

	public long getValue() {
		return this.value;
	}
	
	public long setValue(final long value) {
		this.value = value;
	}

	/// --- OTHER METHODS ---
	
	public getCharacteristic() {
		return p;
	}

	/// --- PRIVATE FIELDS ---

	private long value;
	private long p;

	/// --- HELPER METHODS ---
}


