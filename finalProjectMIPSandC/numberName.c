#include <stdio.h>
int strlength(char* arr);
void numberName(char* num);

int main(void) {
  char num[6];
  fgets(num, 7, stdin);
  int length = strlength(num);
  numberName(num);
  return 0;
}


int strlength(char *arr) {
    int count= 0;
    while (*arr != '\0' && *arr != '\n') 
    {
        count++;
        arr++;
    }
    return count;
}


void numberName(char* num) {
  int len = strlength(num);
  //Arrays holding number names
  char* single_digits_place[] = { "zero", "one", "two",   "three", "four", "five", "six", "seven", "eight", "nine"};
 
  char* second_digits_place[] = { "empty", "ten", "eleven",  "twelve", "thirteen",  "fourteen", "fifteen", 
 "sixteen","seventeen", "eighteen", "nineteen" };
  
  char* multiples_ten[] = { "empty", "empty", "twenty","thirty", "forty", "fifty", "sixty",  "seventy", "eighty", 
 "ninety"};

  char* large[] = { "hundred", "thousand" };
 
  // If user enters nothing
  if (len == 0) {
    printf("%s", "No number entered\n");
    return; 
  }
  // If user enters a number larger than 9999
  if (len > 4) {
    printf("%s", "Please enter a number between 0-9999\n");
    return;
  }
  
  /* For single digit number */
  if (len == 1) {
    printf("%s\n", single_digits_place[*num - '0']);
    return;
  }
 
  while (*num != '\0' && *num != '\n') {
    if (len >= 3) {
      if (*num - '0' != 0) {
        printf("%s ", single_digits_place[*num - '0']);
        printf("%s ",large[len - 3]); 
      }
      --len; 
    } else {
      /* Numbers from 10-19 */
      if (*num == '1') {
        int sum = *num - '0' + *(num + 1) - '0';
        printf("%s\n", second_digits_place[sum]);
         return;
      }
      /* twenty is not working */
      else if (*num == '2' && *(num + 1) == '0') {
        printf("twenty\n");
        return;
      } else {
        /* Numbers from 21-99 */
        int place = *num - '0';
        printf("%s ", place ? multiples_ten[place] : "");
        ++num;
        if (*num != '0'){
            printf("%s ", single_digits_place[*num - '0']);
          }
      }
    }
  ++num;
  }
}