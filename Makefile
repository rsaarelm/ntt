# Update both of these when moving to new Neat version.
NEAT_VER := v0.7.1
NEAT_SHA256 := f2556a715b62f28caad33b91256b9c84d6e85cfb92b00bdb3c5be471ca9d14ee

NEAT_PKG := neat-$(NEAT_VER)-gcc.tar.xz
NEAT_URL := https://github.com/Neat-Lang/neat/releases/download/$(NEAT_VER)/$(NEAT_PKG)

NEAT_SETUP := neat-$(NEAT_VER)-gcc/build.sh
NEAT := ./neat-$(NEAT_VER)-gcc/neat

ntt: $(NEAT) ntt.nt
	$(NEAT) -j ntt.nt

test: $(NEAT) ntt.nt
	$(NEAT) -j --no-main ntt.nt -o test --unittest
	./test
	# See if the test still works in different TZs
	TZ=Asia/Tokyo ./test
	TZ=Europe/London ./test
	rm ./test

$(NEAT): $(NEAT_PKG)
	tar xf $(NEAT_PKG)
	cd neat-$(NEAT_VER)-gcc; ./build.sh

$(NEAT_PKG):
	curl -OL --output-dir /tmp/ $(NEAT_URL)
	echo "$(NEAT_SHA256) /tmp/$(NEAT_PKG)" | sha256sum -c
	mv /tmp/$(NEAT_PKG) .

clean:
	rm -rf ./ntt ./.obj ./test

realclean: clean
	rm -rf $(NEAT_PKG) neat-$(NEAT_VER)-gcc
