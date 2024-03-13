build:
    neat -j ntt.nt

test:
    neat -j --unittest --no-main ntt.nt -o test
    ./test
    rm -f ./test

clean:
    rm -f ./ntt ./.obj
