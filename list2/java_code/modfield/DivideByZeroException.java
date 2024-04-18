package modfield;

import java.io.NotSerializableException;

@SuppressWarnings("serial")
public class DivideByZeroException extends RuntimeException {
	public DivideByZeroException(final String errorMessage) {
		super(errorMessage);
	}

	public void writeObject() throws NotSerializableException {
		throw new NotSerializableException("");
	}
}
