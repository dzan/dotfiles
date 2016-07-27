#! /bin/bash

for i in $(eval echo {0..$1}); do
    printf "\x1b[38;5;${i}mcolour${i}\n"
done
