#include <iostream>
#include <cstdlib>
#include <malloc.h>
#include <string.h>
#include <algorithm>
#include <sstream>

using namespace std;

void bigmul_8(long num1, long num2, int x[]);
void printArray(int x[], int n);

string bigmul_recur(string num1, string num2);
void adjLength(string &str, int n);
string addZero(string str, int n);
void removeZero(string &str);
int stringToInt(string str);
string intToString(int value);
string add(string x, string y);
string sub(string &x, string &y);

#include "source.cpp"
