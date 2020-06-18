#include "vectors.h"
#include <cstdlib>
#include <random>
#include <cmath>
#include <fstream>
#include <iostream>
#include <string>
#include <iomanip>

using namespace std;

double dot_product(Vector a, Vector b) {
  return (a.x*b.x + a.y*b.y + a.z*b.z);
}

Vector cross_product(Vector a, Vector b) {
  Vector r;
  r.x = a.y*b.z - a.z*b.y;
  r.y = a.z*b.x - a.x*b.z;
  r.z = a.x*b.y - a.y*b.x;
  return r;
}

Vector vector_sub(Vector a, Vector b) {
  Vector r;
  r.x = a.x - b.x;
  r.y = a.y - b.y;
  r.z = a.z - b.z;
  return r;
}

Vector vector_add(Vector a, Vector b) {
  Vector r;
  r.x = a.x + b.x;
  r.y = a.y + b.y;
  r.z = a.z + b.z;
  return r;
}

Vector vector_scale(Vector a, double x) {
  Vector r;
  r.x = a.x*x;
  r.y = a.y*x;
  r.z = a.z*x;
  return r;
}

Vector vector_norm(Vector a) {
  Vector r;
  double length = sqrt(a.x*a.x + a.y*a.y + a.z*a.z);
  r.x = a.x / length;
  r.y = a.y / length;
  r.z = a.z / length;
  return r;
}

double veclength(Vector a) {
  return sqrt(a.x*a.x + a.y*a.y + a.z*a.z);
}

double random_num(double dev) {
   std::random_device r;
   std::knuth_b mt_gen(r());
   std::normal_distribution<double> dist(0, dev);
   double accel = dist(mt_gen);
   return accel;
}

int random_coin() {
  std::random_device r;
  std::mt19937 mt_gen(r());
  std::bernoulli_distribution dist(0.5);
  int coin = dist(mt_gen);
  return coin;
}

double test_init(double dev, int num2) {
   std::random_device r;
   std::mt19937 mt_gen(r());
   std::normal_distribution<double> dist(0, dev);
   int i;
   double accel;
   for(i=0;i<=num2;i++) {
      accel= dist(mt_gen);
   }
   std::ofstream fout("seed.dat");
   fout << mt_gen;
   fout.close();
   std::ofstream fout2("dist.dat");
   fout2 << dist;
   fout2.close();
   return accel;
}

double test_init2(double dev, int num2) {
   std::random_device r;
   std::mt19937 mt_gen(r());
   std::normal_distribution<double> dist(0, dev);
   double accel= dist(mt_gen);
   std::string seedname = "Seed" + std::to_string(num2) + ".bin";
   std::ofstream fout(seedname.c_str(), std::ofstream::binary);
   fout << mt_gen;
   fout.close();
   std::string distname = "Dist" + std::to_string(num2) + ".bin";
   std::ofstream fout2(distname.c_str(), std::ofstream::binary);
   fout2 << dist;
   fout2.close();
   return accel;
}

double test_last2(double dev, int num2) {
   std::mt19937 mt_gen;
   std::normal_distribution<double> dist(0, dev);
   std::string seedname = "Seed" + std::to_string(num2) + ".bin";
   std::ifstream fin(seedname.c_str(), std::ifstream::binary);
   fin >> mt_gen;
   fin.close();
   std::string distname = "Dist" + std::to_string(num2) + ".bin";
   std::ifstream fin2(distname.c_str(), std::ifstream::binary);
   fin2 >> dist;
   fin2.close();
   double accel = dist(mt_gen);
   std::ofstream fout2(distname.c_str(), std::ofstream::binary);
   fout2 << dist;
   fout2.close();
   return accel;
}

double test_cont(double dev, int num2) {
   std::mt19937 mt_gen;
   std::normal_distribution<double> dist(0, dev);
   std::ifstream fin("seed.dat");
   fin >> mt_gen;
   fin.close();
   std::ifstream fin2("dist.dat");
   fin2 >> dist;
   fin2.close();
   int i;
   double accel;
   //double accel = dist(mt_gen);
   for (i=0;i<=num2;i++) {
      accel = dist(mt_gen);
   }
   return accel;
}

double bern_init(int num, int num2) {
   std::mt19937 mt_gen(num);
   std::bernoulli_distribution dist(0.5);
   int i;
   double coin;
   for(i=0;i<=num2;i++) {
      coin = dist(mt_gen);
   }
   std::ofstream fout("seed.dat");
   fout << mt_gen;
   fout.close();
   std::ofstream fout2("dist.dat");
   fout2 << dist;
   fout2.close();
   return coin;
}

double bern_cont(int num, int num2) {
   std::mt19937 mt_gen;
   std::bernoulli_distribution dist(0.5);
   std::ifstream fin("seed.dat");
   fin >> mt_gen;
   fin.close();
   std::ifstream fin2("dist.dat");
   fin2 >> dist;
   fin2.close();
   int i;
   double coin;
   //double accel = dist(mt_gen);
   for (i=0;i<=num2;i++) {
      coin = dist(mt_gen);
   }
   return coin;
}

void writeto(double energy) {
   std::ofstream energyout("potential.dat");
   energyout << std::fixed << std::setprecision(4) << energy;
   energyout.close();
}

double readin() {
   std::ifstream energyin("potential.dat");
   double energy;
   energyin >> std::fixed >> std::setprecision(10) >> energy;
   energyin.close();
   return energy;
}

double test_last(double dev, int num2) {
   std::mt19937 mt_gen;
   std::normal_distribution<double> dist(0, dev);
   std::ifstream fin("seed.dat");
   fin >> mt_gen;
   fin.close();
   std::ifstream fin2("dist.dat");
   fin2 >> dist; 
   fin2.close();
   int i;
   double accel;
   //double accel = dist(mt_gen);
   for (i=0;i<=num2;i++) {
      accel = dist(mt_gen);
   }
   std::ofstream fout2("dist.dat");
   fout2 << dist;
   fout2.close();
   return accel;
}

double bern_last(int num, int num2) {
   std::mt19937 mt_gen;
   std::bernoulli_distribution dist(0.5);
   std::ifstream fin("seed.dat");
   fin >> mt_gen;
   fin.close();
   std::ifstream fin2("dist.dat");
   fin2 >> dist;
   fin2.close();
   int i;
   double coin;
   //double accel = dist(mt_gen);
   for (i=0;i<=num2;i++) {
      coin = dist(mt_gen);
   }
   std::ofstream fout("seed.dat");
   fout << mt_gen;
   fout.close();
   std::ofstream fout2("dist.dat");
   fout2 << dist;
   fout2.close();
   return coin;
}

Vector calc_force(Vector a, Vector b, Vector c, double accel) {
  Vector r1 = vector_sub(b, a);
  Vector r2 = vector_sub(c, b);
  Vector r3 = vector_sub(c, a);
  Vector n1 = vector_norm(r1);
  Vector n2 = vector_norm(r2);
  double dt1 = dot_product(n1, n2);
  double angle = acos(dt1);
  double PI = 2.0*asin(1.0);
  double scale1 = 1+(veclength(r2)*sin(angle-0.5*PI)/veclength(r1));
  Vector r4 = vector_scale(r1, scale1);
  Vector r5 = vector_sub(r3, r4);
  double thetarad = 0.5*PI;
  double scale2 = cos(thetarad);
  Vector s1 = vector_scale(r5, scale2);
  double scale3 = sin(thetarad);
  Vector s2 = cross_product(r1, r5);
  Vector s3 = vector_scale(s2, scale3);
  double scale4 = dot_product(r1, r5);
  Vector s4 = vector_scale(r1, scale4);
  double scale5 = 1-cos(thetarad);
  Vector s5 = vector_scale(s4, scale5);
  Vector s6 = vector_add(s1, s3);
  Vector s7 = vector_add(s6, s5);
  Vector s8 = vector_norm(s7);
  Vector s9 = vector_scale(s8, accel);
  return s9;
}

void calc_force3(double *v, double a1, double a2, double a3, double b1, double b2, double b3, double c1, double c2, double c3, double accel) {
  // vector r1 //
  double r1x = b1 - a1;
  double r1y = b2 - a2;
  double r1z = b3 - a3;
  // vector r2 //
  double r2x = c1 - b1;
  double r2y = c2 - b2;
  double r2z = c3 - b3;
  // vector r3 //
  double r3x = c1 - a1;
  double r3y = c2 - a2;
  double r3z = c3 - a3;
  // vector n1 //
  double length_r1 = sqrt(r1x*r1x + r1y*r1y + r1z*r1z);
  double n1x = r1x / length_r1;
  double n1y = r1y / length_r1;
  double n1z = r1z / length_r1;
  // vector n2 //
  double length_r2 = sqrt(r2x*r2x + r2y*r2y + r2z*r2z);
  double n2x = r2x / length_r2;
  double n2y = r2y / length_r2;
  double n2z = r2z / length_r2;
  // dot_product n1 and n2 //
  double dt1 = n1x*n2x + n1y*n2y + n1z*n2z;
  double angle = acos(dt1);
  double PI = 2.0*asin(1.0);
  double scale1 = 1+(length_r2*sin(angle-0.5*PI)/length_r1);
  // vector r4 //
  double r4x = r1x*scale1;
  double r4y = r1y*scale1;
  double r4z = r1z*scale1;
  // vector r5 //
  double r5x = r3x-r4x;
  double r5y = r3y-r4y;
  double r5z = r3z-r4z;
  double thetarad = 0.5*PI;
  double scale2 = cos(thetarad);
  // vector s1 //
  double s1x = r5x*scale2;
  double s1y = r5y*scale2;
  double s1z = r5z*scale2;
  double scale3 = sin(thetarad);
  // vector s2 as a cross product of r1 and r5 //
  double s2x = r1y*r5z-r1z*r5y;
  double s2y = r1z*r5x-r1x*r5z;
  double s2z = r1x*r5y-r1y*r5x;
  // vector s3 //
  double s3x = s2x*scale3;
  double s3y = s2y*scale3;
  double s3z = s2z*scale3;
  // dot_product r1 and r5 //
  double scale4 = r1x*r5x + r1y*r5y + r1z*r5z;
  // vector s4 //
  double s4x = r1x*scale4;
  double s4y = r1y*scale4;
  double s4z = r1z*scale4;
  double scale5 = 1-cos(thetarad);
  // vector s5 //
  double s5x = s4x*scale5;
  double s5y = s4y*scale5;
  double s5z = s4z*scale5;
  // vector s6 //
  double s6x = s1x+s3x;
  double s6y = s1y+s3y;
  double s6z = s1z+s3z;
  // vector s7 //
  double s7x = s5x+s6x;
  double s7y = s5y+s6y;
  double s7z = s5z+s6z;
  // vector s8 //
  double length_s7 = sqrt(s7x*s7x + s7y*s7y + s7z*s7z);
  double s8x = s7x / length_s7;
  double s8y = s7y / length_s7;
  double s8z = s7z / length_s7;
  // vector s9 //
  double s9x = s8x*accel;
  double s9y = s8y*accel;
  double s9z = s8z*accel;
  // setting doubles //
  v[0] = s9x;
  v[1] = s9y;
  v[2] = s9z;
}

void calc_force4(double *v, double a1, double a2, double a3, double b1, double b2, double b3, double c1, double c2, double c3, double dev) {
  // random accel // 
  std::random_device r;
  std::mt19937 mt_gen(r());
  std::normal_distribution<double> dist(0, dev);
  double accel = dist(mt_gen);
  // vector r1 //
  double r1x = b1 - a1;
  double r1y = b2 - a2;
  double r1z = b3 - a3;
  // vector r2 //
  double r2x = c1 - b1;
  double r2y = c2 - b2;
  double r2z = c3 - b3;
  // vector r3 //
  double r3x = c1 - a1;
  double r3y = c2 - a2;
  double r3z = c3 - a3;
  // vector n1 //
  double length_r1 = sqrt(r1x*r1x + r1y*r1y + r1z*r1z);
  double n1x = r1x / length_r1;
  double n1y = r1y / length_r1;
  double n1z = r1z / length_r1;
  // vector n2 //
  double length_r2 = sqrt(r2x*r2x + r2y*r2y + r2z*r2z);
  double n2x = r2x / length_r2;
  double n2y = r2y / length_r2;
  double n2z = r2z / length_r2;
  // dot_product n1 and n2 //
  double dt1 = n1x*n2x + n1y*n2y + n1z*n2z;
  double angle = acos(dt1);
  double PI = 2.0*asin(1.0);
  double scale1 = 1+(length_r2*sin(angle-0.5*PI)/length_r1);
  // vector r4 //
  double r4x = r1x*scale1;
  double r4y = r1y*scale1;
  double r4z = r1z*scale1;
  // vector r5 //
  double r5x = r3x-r4x;
  double r5y = r3y-r4y;
  double r5z = r3z-r4z;
  double thetarad = 0.5*PI;
  double scale2 = cos(thetarad);
  // vector s1 //
  double s1x = r5x*scale2;
  double s1y = r5y*scale2;
  double s1z = r5z*scale2;
  double scale3 = sin(thetarad);
  // vector s2 as a cross product of r1 and r5 //
  double s2x = r1y*r5z-r1z*r5y;
  double s2y = r1z*r5x-r1x*r5z;
  double s2z = r1x*r5y-r1y*r5x;
  // vector s3 //
  double s3x = s2x*scale3;
  double s3y = s2y*scale3;
  double s3z = s2z*scale3;
  // dot_product r1 and r5 //
  double scale4 = r1x*r5x + r1y*r5y + r1z*r5z;
  // vector s4 //
  double s4x = r1x*scale4;
  double s4y = r1y*scale4;
  double s4z = r1z*scale4;
  double scale5 = 1-cos(thetarad);
  // vector s5 //
  double s5x = s4x*scale5;
  double s5y = s4y*scale5;
  double s5z = s4z*scale5;
  // vector s6 //
  double s6x = s1x+s3x;
  double s6y = s1y+s3y;
  double s6z = s1z+s3z;
  // vector s7 //
  double s7x = s5x+s6x;
  double s7y = s5y+s6y;
  double s7z = s5z+s6z;
  // vector s8 //
  double length_s7 = sqrt(s7x*s7x + s7y*s7y + s7z*s7z);
  double s8x = s7x / length_s7;
  double s8y = s7y / length_s7;
  double s8z = s7z / length_s7;
  // vector s9 //
  double s9x = s8x*accel;
  double s9y = s8y*accel;
  double s9z = s8z*accel;
  // setting doubles //
  v[0] = s9x;
  v[1] = s9y;
  v[2] = s9z;
}

Vector calc_force_bern(Vector a, Vector b, Vector c, double coin, double accel) {
  Vector r1 = vector_sub(b, a);
  Vector r2 = vector_sub(c, b);
  Vector r3 = vector_sub(c, a);
  Vector n1 = vector_norm(r1);
  Vector n2 = vector_norm(r2);
  double dt1 = dot_product(n1, n2);
  double angle = acos(dt1);
  double PI = 2.0*asin(1.0);
  double scale1 = 1+(veclength(r2)*sin(angle-0.5*PI)/veclength(r1));
  Vector r4 = vector_scale(r1, scale1);
  Vector r5 = vector_sub(r3, r4);
  double thetarad;
  if (coin==0) thetarad = 0.5*PI;
  if (coin==1) thetarad = -0.5*PI;
  double scale2 = cos(thetarad);
  Vector s1 = vector_scale(r5, scale2);
  double scale3 = sin(thetarad);
  Vector s2 = cross_product(r1, r5);
  Vector s3 = vector_scale(s2, scale3);
  double scale4 = dot_product(r1, r5);
  Vector s4 = vector_scale(r1, scale4);
  double scale5 = 1-cos(thetarad);
  Vector s5 = vector_scale(s4, scale5);
  Vector s6 = vector_add(s1, s3);
  Vector s7 = vector_add(s6, s5);
  Vector s8 = vector_norm(s7);
  Vector s9 = vector_scale(s8, accel);
  return s9;
}
