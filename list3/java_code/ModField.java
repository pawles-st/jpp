public interface ModField {
	ModField add(final ModField rhs);
	ModField sub(final ModField rhs);
	ModField mul(final ModField rhs);
	ModField div(final ModField rhs);
	ModField inverse();
	long getValue();
	void setValue(final long value);
}
