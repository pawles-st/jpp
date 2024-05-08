import java.util.Random;

public class User<T extends ModField & Comparable<T>> {
	public User(DHSetup<T> dhsetup) {
		this.dhsetup = dhsetup;
		this.secret = new Random().nextLong(dhsetup.getCharacteristic() - 4) + 2;
	}

	public T getPublicKey() {
		return this.dhsetup.power(this.dhsetup.getGenerator(), this.secret);
	}

	public void setKey(T a) {
		this.key = this.dhsetup.power(a, this.secret);
		this.isKeySet = true;
	}

	@SuppressWarnings("unchecked")
	public T encrypt(T m) {
		if (!this.isKeySet) {
			throw new RuntimeException("Key has not been set");
		} else {
			return (T) m.mul(this.key);
		}
	}
	
	@SuppressWarnings("unchecked")
	public T decrypt(T c) {
		if (!this.isKeySet) {
			throw new RuntimeException("Key has not been set");
		} else {
			return (T) c.div(this.key);
		}
	}

	private DHSetup<T> dhsetup;
	private long secret;
	private T key;
	private boolean isKeySet = false;
}
