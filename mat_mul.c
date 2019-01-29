#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int idx(int x, int y, int dim);
void mat_mul(int* A, int* B, int* C, int n);
void mat_mul_tile(int* A, int* B, int* C, int n, int m);

int main(int argc, char** argv) {
  int n = 0;
  int t = 0;
  int m = 0;
  char c;
  opterr = 0;


  while ((c = getopt (argc, argv, "n:tm:")) != -1) {
    switch (c){
      case 'n':
        n = atoi(optarg);
        break;
      case 't':
        t = 1;
        break;
      case 'm':
        m = atoi(optarg);
        break;
      default:
        printf("Argument Needed\n -n <dimension> -t <enable_tiling> -m <tile_size>\n");
        return -1;
    }
  }

  if(t == 1) {
    if((n % m) != 0) {
      printf("Matrix size must be a multiple of tile size\n");
      return -1;
    }
  }

  /* Allocate Arrays */
  int* A = (int*)malloc(sizeof(int)*n*n);
  int* B = (int*)malloc(sizeof(int)*n*n);
  int* C = (int*)malloc(sizeof(int)*n*n);

  if(t) {
    printf("Begin Mat Mul: %i x %i Tile: %i x %i\n", n, n, m, m);
    mat_mul_tile(A, B, C, n, m);
    printf("End Mat Mul: %i x %i Tile: %i x %i\n", n, n, m, m);
  }
  else {
    printf("Begin Mat Mul %i x %i\n", n, n);
    mat_mul(A, B, C, n);
    printf("End Mat Mul %i x %i\n", n, n);
  }

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

void mat_mul_tile(int* A, int* B, int* C, int n, int m) {
  for (int i = 0; i < n; i+=m) {
    for(int j = 0; j < n; j+=m) {
      for(int a = 0; a < m; a++) {
        for(int b = 0; b < m; b++) {
          C[idx(i+a, j+b, n)] = 0;
          for(int k = 0; k < n; k++) {
            C[idx(i+a, j+b, n)] += A[idx(i+a, k, n)]*B[idx(k, j+b, n)];
          }
        }
      }
    }
  }
}
