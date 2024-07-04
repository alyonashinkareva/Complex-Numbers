//
// Created by Alyona Shinkareva on 07.06.2023.
//
#include "../include/complex.h"
#include <cmath>
#include <sstream>

Complex::Complex(double real, double imag)
    : cmplx_real(real), cmplx_imag(imag){};

double Complex::real() const { return cmplx_real; }

double Complex::imag() const { return cmplx_imag; }

double Complex::abs() const {
  return std::sqrt(cmplx_real * cmplx_real + cmplx_imag * cmplx_imag);
}

std::string Complex::str() const {
  std::ostringstream ss_;
  ss_ << *this;
  return ss_.str();
}

Complex operator+(const Complex &first_cmplx, const Complex &second_cmplx) {
  return {first_cmplx.cmplx_real + second_cmplx.cmplx_real,
          first_cmplx.cmplx_imag + second_cmplx.cmplx_imag};
}

Complex &operator+=(Complex &first_cmplx, const Complex &second_cmplx) {
  return (first_cmplx = first_cmplx + second_cmplx);
}

Complex operator-(const Complex &first_cmplx, const Complex &second_cmplx) {
  return {first_cmplx.cmplx_real - second_cmplx.cmplx_real,
          first_cmplx.cmplx_imag - second_cmplx.cmplx_imag};
}

Complex &operator-=(Complex &first_cmplx, const Complex &second_cmplx) {
  return (first_cmplx = first_cmplx - second_cmplx);
}

Complex operator*(const Complex &first_cmplx, const Complex &second_cmplx) {
  return {first_cmplx.cmplx_real * second_cmplx.cmplx_real -
              first_cmplx.cmplx_imag * second_cmplx.cmplx_imag,
          first_cmplx.cmplx_real * second_cmplx.cmplx_imag +
              first_cmplx.cmplx_imag * second_cmplx.cmplx_real};
}

Complex &operator*=(Complex &first_cmplx, const Complex &second_cmplx) {
  return (first_cmplx = first_cmplx * second_cmplx);
}

Complex operator/(const Complex &first_cmplx, const Complex &second_cmplx) {
  return {((first_cmplx.cmplx_real * second_cmplx.cmplx_real +
            first_cmplx.cmplx_imag * second_cmplx.cmplx_imag) /
           (second_cmplx.cmplx_real * second_cmplx.cmplx_real +
            second_cmplx.cmplx_imag * second_cmplx.cmplx_imag)),
          ((first_cmplx.cmplx_imag * second_cmplx.cmplx_real -
            first_cmplx.cmplx_real * second_cmplx.cmplx_imag) /
           (second_cmplx.cmplx_real * second_cmplx.cmplx_real +
            second_cmplx.cmplx_imag * second_cmplx.cmplx_imag))};
}

Complex &operator/=(Complex &first_cmplx, const Complex &second_cmplx) {
  return (first_cmplx = first_cmplx / second_cmplx);
}

Complex operator-(const Complex &cmplx) {
  return {-cmplx.cmplx_real, -cmplx.cmplx_imag};
}

Complex operator~(const Complex &cmplx) {
  return {cmplx.cmplx_real, -cmplx.cmplx_imag};
}

bool operator==(const Complex &first_cmplx, const Complex &second_cmplx) {
  return ((first_cmplx.cmplx_real == second_cmplx.cmplx_real) &&
          (first_cmplx.cmplx_imag == second_cmplx.cmplx_imag));
}

bool operator!=(const Complex &first_cmplx, const Complex &second_cmplx) {
  return !(first_cmplx == second_cmplx);
}

std::ostream &operator<<(std::ostream &out, const Complex &cmplx) {
  out << "(" << cmplx.cmplx_real << "," << cmplx.cmplx_imag << ")";
  return out;
}