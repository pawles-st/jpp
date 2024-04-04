fn main() {
    cc::Build::new()
        .file("src/rec_module.c")
        .compile("rec_module");
}
