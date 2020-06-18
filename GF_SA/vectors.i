%module vectors
%{
#include <fstream>
#include <iostream>
#include <string>
#include "vectors.h"
#include "math.h"
#include "stdlib.h"
%}

/* Some functions that manipulate Vectors by value */
%inline %{
extern double dot_product(Vector a, Vector b);
extern Vector vector_add(Vector a, Vector b);
extern Vector vector_sub(Vector a, Vector b);
extern Vector vector_scale(Vector a, double x);
extern Vector cross_product(Vector a, Vector b);
extern Vector vector_norm(Vector a);
extern double veclength(Vector a);
extern Vector calc_force(Vector a, Vector b, Vector c, double accel);
extern Vector calc_force_bern(Vector a, Vector b, Vector c, double coin, double accel);
extern void delete_vector(Vector *v);
extern double random_num(double dev);
extern int random_coin();
extern double test_init(double dev, int num2);
extern double test_init2(double dev, int num2);
extern double test_cont(double dev, int num2);
extern double test_last(double dev, int num2);
extern double test_last2(double dev, int num2);
extern double bern_init(int num, int num2);
extern double bern_cont(int num, int num2);
extern double bern_last(int num, int num2);
extern void writeto(double energy);
extern double readin();
extern void calc_force3(double *v, double a1, double a2, double a3, double b1, double b2, double b3, double c1, double c2, double c3, double accel);
extern void calc_force4(double *v, double a1, double a2, double a3, double b1, double b2, double b3, double c1, double c2, double c3, double dev);
%}

/* Some helper functions for our interface */
%inline %{

Vector *new_Vector(double x, double y, double z) {
   Vector *v = (Vector *) malloc(sizeof(Vector));
   v->x = x;
   v->y = y;
   v->z = z;
   return v;
}

double get_vector(Vector v, int index) {
   double r[3];
   if (index == 0) r[index] = v.x;
   if (index == 1) r[index] = v.y;
   if (index == 2) r[index] = v.z;
   return r[index];
}

void delete_vector(Vector *a) {
   free(a);

}

double *new_double(int size) {
   return (double *) malloc(size*sizeof(double));
}

double get_double(double *a, int index) {
        return a[index];
}

void set_double(double *a, int index, double val) {
        a[index] = val;
}

void delete_double(double *a) {
        free(a);
}

%}
