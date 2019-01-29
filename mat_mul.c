#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int idx(int x, int y, int dim);
void mat_mul(int* A, int* B, int* C, int n);

int main(int argc, char** argv) {
  int n = 0;
  char c;
  opterr = 0;


  while ((c = getopt (argc, argv, "n:")) != -1) {
    switch (c){
      case 'n':
        n = atoi(optarg);
        break;
      default:
        printf("Argument Needed\n -n <dimension>\n");
        return -1;
    }
  }

  /* Allocate Arrays */
  int* A = (int*)malloc(sizeof(int)*n*n);
  int* B = (int*)malloc(sizeof(int)*n*n);
  int* C = (int*)malloc(sizeof(int)*n*n);

  printf("Begin Mat Mul %i x %i\n", n, n);
  mat_mul(A, B, C, n);
  printf("End Mat Mul %i x %i\n", n, n);

  return 0;
}

int idx(int y, int x, int dim) {
  return y*dim + x;
}

void mat_mul(int* A, int* B, int* C, int n) {
  for (int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      C[idx(i, j, n)] = 0;
      for(int k = 0; k < n; k++) {
        C[idx(i, j, n)] += A[idx(i, k, n)]*B[idx(k, j, n)];
      }
    }
  }
}
