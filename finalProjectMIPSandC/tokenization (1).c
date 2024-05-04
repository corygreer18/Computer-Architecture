#include <stdio.h>
#define MAX_SZ 101
void tokenization(char str[MAX_SZ]);

int main(void) {
  //declare the variable for the program
  int i;
  char str[101];
  fgets(str, MAX_SZ, stdin);
    tokenization(str);
  return 0;
}

void tokenization(char str[MAX_SZ]){
  int i;
// create a loop that will check if the values are not 0
  for(i = 0; str[i] != 0; i++){
// the if checks if the values in the string are between 
//A and Z and a and z
    if(str[0] >= 'A' && str[0] <= 'Z' || str[0] >= 'a' && str[0] <= 'z'){
//this will then print the letter and say if it is a string 
      printf("%c", str[i]);
      printf("\n");
      printf("STRING");
      break;
    
    }
      //this will check if the first is a number
    else if (str[0] >= '0' && str[0] <= '9'){
      printf("%c", str[i]);
      printf("\n");
      printf("NUMBER");
      break;    
    }
  }
}