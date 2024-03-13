build:
    neat ntt.nt

test:
    neat --unittest --no-main ntt.nt
    ./ntt

clean:
    rm -f ./ntt ./.obj
