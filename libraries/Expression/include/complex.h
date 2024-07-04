//
// Created by Alyona Shinkareva on 07.06.2023.
//

#include <iosfwd>
#include <string>

struct Complex {
  Complex(double real = 0, double imag = 0);

public:
  double real() const;
  double imag() const;
  double abs() const;
  std::string str() const;

  friend Complex operator+(const Complex &first_cmplx,
                           const Complex &second_cmplx);
  friend Complex &operator+=(Complex &first_cmplx, const Complex &second_cmplx);

  friend Complex operator-(const Complex &first_cmplx,
                           const Complex &second_cmplx);
  friend Complex &operator-=(Complex &first_cmplx, const Complex &second_cmplx);

  friend Complex operator*(const Complex &first_cmplx,
                           const Complex &second_cmplx);
  friend Complex &operator*=(Complex &first_cmplx, const Complex &second_cmplx);

  friend Complex operator/(const Complex &first_cmplx,
                           const Complex &second_cmplx);
  friend Complex &operator/=(Complex &first_cmplx, const Complex &second_cmplx);

  friend Complex operator-(const Complex &cmplx);

  friend Complex operator~(const Complex &cmplx);

  friend bool operator==(const Complex &first_cmplx,
                         const Complex &second_cmplx);
  friend bool operator!=(const Complex &first_cmplx,
                         const Complex &second_cmplx);

  friend std::ostream &operator<<(std::ostream &, const Complex &);

private:
  double cmplx_real;
  double cmplx_imag;
};
