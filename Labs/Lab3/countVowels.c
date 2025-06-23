#include <stdio.h>
#include <string.h>

int main() 
{
  char input[] = "This is a sample, examine this sentence for vowels!!!";

  int length = strlen(input);

  int i = 0;
  int count = 0;

  while (i < length)
  {
    if (input[i] == 'a')
    {
      count += 1;
    }
    if (input[i] == 'e')
    {
      count += 1;
    }
    if (input[i] == 'i')
    {
      count += 1;
    }
    if (input[i] == 'o')
    {
      count += 1;
    }
    if (input[i] == 'u')
    {
      count += 1;
    }
    i++;
  }

  printf("%d\n", count);
}
