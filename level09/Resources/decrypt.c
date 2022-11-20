#include <unistd.h>
#include <string.h>

int     main(int argc, char **argv) {
    int i = 0;
    while (i < strlen(argv[1])) {
        char c = argv[1][i] - i;
        write(1, &c, 1);
        i++;
    }
    return (0);
}
