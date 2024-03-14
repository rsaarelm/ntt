build:
    neat -j ntt.nt

test:
    neat -j --no-main ntt.nt -o test --unittest
    ./test

clean:
    rm -rf ./ntt ./.obj ./test
