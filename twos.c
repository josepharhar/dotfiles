#include <stdio.h>

int betterPow(int base, int exponent) {
    if (exponent == 0) {
        return 1;
    }
    return base * betterPow(base, exponent - 1);
}

void main() {
    printf("powers of two!\n");
    
    int user;
    int answer;
    int exponent = 0;

    do {
        printf("2^%d: ", exponent);
        scanf(" %d", &user);
        answer = betterPow(2, exponent);
        exponent++;
    } while (user == answer);

    printf("you lose! answer was %d\n", answer);
}
