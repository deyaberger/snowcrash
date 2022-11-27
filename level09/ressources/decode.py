
import sys

if __name__=="__main__":
    if (len(sys.argv) == 2) :
        with open(sys.argv[1], "r") as f:
            my_str = f.read().split(" ")[:-2]
            for i, c in enumerate(my_str):
                print(chr(int(c, 16) - i), end="")