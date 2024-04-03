

install-mac:
	brew install mdbook

serve:
	mdbook serve --open

watch:
	mdbook watch

clean:
	rm -rf ./build

build:
	mdbook build --dest-dir=build


build-ci:
	mkdir bin
	curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.37/mdbook-v0.4.37-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=bin
	bin/mdbook build


