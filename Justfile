build:
    neat -j ntt.nt

test:
    neat -j --unittest --no-main ntt.nt -o test
    ./test

clean:
    rm -f ./ntt ./.obj ./test
