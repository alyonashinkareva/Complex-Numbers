#include "../include/Expression.h"
#include "catch2/catch_test_macros.hpp"
#include <cmath>

TEST_CASE("ComplexTest") {
  SECTION("Constructor") {
    const Complex cmplx0;
    REQUIRE(cmplx0.real() == 0);
    REQUIRE(cmplx0.imag() == 0);
    REQUIRE_FALSE(cmplx0.real() + cmplx0.imag() > 0);

    const Complex cmplx1(123, -123);
    REQUIRE(cmplx1.real() == 123);
    REQUIRE(cmplx1.imag() == -123);
    REQUIRE_FALSE(cmplx1.real() + cmplx1.imag() > 0);

    const Complex cmplx2(0.00000001, -0.00000000001);
    REQUIRE(cmplx2.real() == 0.00000001);
    REQUIRE(cmplx2.imag() == -0.00000000001);
    REQUIRE_FALSE(cmplx2.real() + cmplx2.imag() > 1);
  }

  SECTION("Abs") {
    const Complex cmplx0(1, 1);
    REQUIRE(cmplx0.abs() == std::sqrt(2));

    const Complex cmplx1(10, -10);
    REQUIRE(cmplx1.abs() == std::sqrt(200));

    const Complex cmplx2(-123, -123);
    REQUIRE(cmplx2.abs() == 173.9482681718906910026077130777928);

    const Complex cmplx3;
    REQUIRE_FALSE(cmplx3.abs() > 0);
  }

  SECTION("Str") {
    const Complex cmplx0(1, 1);
    REQUIRE(cmplx0.str() == "(1,1)");
    const Complex cmplx1(0, 0);
    REQUIRE(cmplx1.str() == "(0,0)");
    const Complex cmplx2(123);
    REQUIRE(cmplx2.str() == "(123,0)");
    const Complex cmplx3(0, -123);
    REQUIRE(cmplx3.str() == "(0,-123)");
  }

  SECTION("Print") {
    std::ostringstream s0;
    const Complex cmplx0(1, 1);
    s0 << cmplx0;
    REQUIRE(s0.str() == "(1,1)");
    const Complex cmplx1(0, 0);
    std::ostringstream s1;
    s1 << cmplx1;
    REQUIRE(s1.str() == "(0,0)");
    const Complex cmplx2(123);
    std::ostringstream s2;
    s2 << cmplx2;
    REQUIRE(s2.str() == "(123,0)");
    const Complex cmplx3(0, -123);
    std::ostringstream s3;
    s3 << cmplx3;
    REQUIRE(s3.str() == "(0,-123)");
  }
}

TEST_CASE("ExpressionTest") {
  SECTION("Constant") {
    REQUIRE(Const({0, 0}).eval() == Complex(0, 0));
    REQUIRE(Const({123, 4}).eval() == Complex(123, 4));
    REQUIRE_FALSE(Const({-123, -4}).eval() == Complex(123, 4));

    Const cnst({1, -1});
    REQUIRE(cnst.eval() == Complex(1, -1));
    REQUIRE(cnst.eval({{"x", {1, 1}}}) == Complex(1, -1));
    REQUIRE_FALSE(cnst.eval() == Complex(1, 1));
  }

  SECTION("Variable") {
    REQUIRE(Variable("x").eval({{"x", {123, -123}}}) == Complex(123, -123));
    std::map<std::string, Complex> map_{
        {"x", {1, 1}}, {"y", {0, -1}}, {"z", {123, -123}}, {"t", {0.01, 0.9}}};
    REQUIRE(Variable("y").eval(map_) == Complex(0, -1));
    REQUIRE_FALSE(Variable("z").eval(map_) == Variable("t").eval(map_));
  }

  SECTION("Negate") {
    const Complex cmplx(3, -123);
    REQUIRE((-cmplx).real() == -3);
    REQUIRE((-cmplx).imag() == 123);
    REQUIRE(0 - cmplx == -cmplx);
    REQUIRE(-(-cmplx) == cmplx);
  }

  SECTION("Conjugate") {
    const Complex cmplx(3, -123);
    REQUIRE((~cmplx).real() == 3);
    REQUIRE((~cmplx).imag() == 123);
    REQUIRE(~(~cmplx) == cmplx);
  }

  SECTION("Add") {
    Complex first(12, -12);
    const Complex second(4, -4);

    REQUIRE(first + Complex() == first);
    REQUIRE(first + Complex(1, -1) == Complex(13, -13));
    REQUIRE(first + second == Complex(16, -16));
    REQUIRE((first += second) == Complex(16, -16));
    const Complex first_old = first;
    REQUIRE_FALSE((first += second) == first_old);
  }

  SECTION("Subtract") {
    Complex first(12, -12);
    const Complex second(4, -4);

    REQUIRE(first - Complex() == first);
    REQUIRE(first - Complex(1, -1) == Complex(11, -11));
    REQUIRE(first - second == Complex(8, -8));
    REQUIRE((first -= second) == Complex(8, -8));
    const Complex first_old = first;
    REQUIRE_FALSE((first -= second) == first_old);
  }

  SECTION("Multiply") {
    REQUIRE(Complex() * 1 == 0);
    Complex first(12, -12);
    const Complex second(4, -4);
    const Complex third(-123, 123);

    REQUIRE(first * 0 == 0);
    REQUIRE(0 * first == 0);
    REQUIRE(first * 1 == first);
    REQUIRE(1 * first == first);
    REQUIRE(first * second == Complex(0, -96));
    REQUIRE(first * (second * third) == Complex(11808, 11808));
    REQUIRE(first * second * third == Complex(11808, 11808));
    REQUIRE(first * (second * third) == (first * second) * third);
    REQUIRE((first *= second) == Complex(0, -96));
    const Complex first_old = first;
    REQUIRE_FALSE((first *= second) == first_old);
  }

  SECTION("Divide") {
    REQUIRE(Complex() / 1 == 0);
    Complex first(12, -12);
    const Complex second(4, -4);
    const Complex third(-123, 123);

    REQUIRE(first / 1 == first);
    REQUIRE(0 / first == 0);
    REQUIRE(first / second == Complex(3, 0));
    REQUIRE(first * (second / third) ==
            Complex(-0.3902439024390244, 0.3902439024390244));
    REQUIRE(first * second / third ==
            Complex(-0.3902439024390244, 0.3902439024390244));
    REQUIRE(first / (second * third) == (first / second) / third);
    REQUIRE((first /= second) == Complex(3, 0));
    const Complex first_old = first;
    REQUIRE_FALSE((first /= second) == first_old);

    // division by zero

    Complex cmplx(3, 123);
    REQUIRE((cmplx / 0).real() != std::numeric_limits<double>::infinity());
    REQUIRE(std::isnan((cmplx / 0).real()));
    REQUIRE((cmplx / 0).imag() != std::numeric_limits<double>::infinity());
    REQUIRE(std::isnan((cmplx / 0).imag()));
  }
}