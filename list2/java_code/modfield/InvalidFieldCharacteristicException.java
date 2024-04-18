package modfield;

import java.io.NotSerializableException;

@SuppressWarnings("serial")
public class InvalidFieldCharacteristicException extends Exception {
	public InvalidFieldCharacteristicException(final String errorMessage) {
		super(errorMessage);
	}

	public void writeObject() throws NotSerializableException {
		throw new NotSerializableException("");
	}
}
