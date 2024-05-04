#include <stdio.h>

#define MAX_SZ 14
int wordConvert(char*);

int main(void) {
  wordConvert("zero");
  wordConvert("fifteen");
  wordConvert("ninety");
  wordConvert("nineteen");
  
  return 0;
}

int wordConvert(char* word){
  //digit arrays for output
    int single_digits[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
 
  int second_digits[] = { 0, 10, 11, 12, 13, 14, 15, 
 16,17,18, 19 };
  
  int tens[] = {20, 30, 40, 50, 60,  70, 80, 
 90};

  int largeNums[] = { 100, 1000 };
//word arrays for input
  char* single_digits_place[] = { "zero", "one", "two",   "three", "four", "five", "six", "seven", "eight", "nine"};
 
  char* second_digits_place[] = { "empty", "ten", "eleven",  "twelve", "thirteen",  "fourteen", "fifteen", 
 "sixteen","seventeen", "eighteen", "nineteen"};
  
  char* multiples_ten[] = {"twenty","thirty", "forty", "fifty", "sixty",  "seventy", "eighty", "ninety"};

  char* large[] = { "hundred", "thousand" };

  int x = 0;
  int i,a;

  
  for(i = 0; i < MAX_SZ ; i++) {
      //0-9
       if(word == single_digits_place[i]){
            printf("%d\n", single_digits[i]);
         }
        //10-19
       if(word == second_digits_place[i]){
            printf("%d\n", second_digits[i]);
         }
       //20,30,40...90
       if(word == multiples_ten[i]){
            printf("%d\n", tens[i]);
         }  
    }
    
  
  return 0;
}