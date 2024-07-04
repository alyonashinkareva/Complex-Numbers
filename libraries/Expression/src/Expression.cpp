//
// Created by Alyona Shinkareva on 07.06.2023.
//
#include "../include/Expression.h"

Complex Const::eval(const std::map<std::string, Complex> &values) const {
  return cmplx;
}

std::string Const::toString() const {
  return "(" + std::to_string(cmplx.real()) + "," +
         std::to_string(cmplx.imag()) + ")";
}

std::unique_ptr<Expression> Const::clone() const {
  return std::make_unique<Const>(*this);
}

Complex Variable::eval(const std::map<std::string, Complex> &values) const {
  return values.at(v);
}

std::string Variable::toString() const { return v; }

std::unique_ptr<Expression> Variable::clone() const {
  return std::make_unique<Variable>(*this);
}

Complex
UnaryOperation::eval(const std::map<std::string, Complex> &values) const {
  return evaluate(expression->eval(values));
}

std::string UnaryOperation::toString() const {
  return get_op() + "(" + expression->toString() + ")";
}

Complex Negate::evaluate(const Complex &cmplx) const { return -cmplx; }

std::string Negate::get_op() const { return "-"; }

std::unique_ptr<Expression> Negate::clone() const {
  return std::make_unique<Negate>(*expression);
}

Complex Conjugate::evaluate(const Complex &cmplx) const {
  return {cmplx.real(), -cmplx.imag()};
}

std::string Conjugate::get_op() const { return "~"; }

std::unique_ptr<Expression> Conjugate::clone() const {
  return std::make_unique<Conjugate>(*expression);
}

Complex
BinaryOperation::eval(const std::map<std::string, Complex> &values) const {
  return evaluate(first_expression->eval(values),
                  second_expression->eval(values));
}

std::string BinaryOperation::toString() const {
  return "(" + first_expression->toString() + get_op() +
         second_expression->toString() + ")";
}

Complex Add::evaluate(const Complex &first_cmplx,
                      const Complex &second_cmplx) const {
  return first_cmplx + second_cmplx;
}

std::string Add::get_op() const { return "+"; }

std::unique_ptr<Expression> Add::clone() const {
  return std::make_unique<Add>(*first_expression, *second_expression);
}

Complex Subtract::evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const {
  return first_cmplx - second_cmplx;
}

std::string Subtract::get_op() const { return "-"; }

std::unique_ptr<Expression> Subtract::clone() const {
  return std::make_unique<Subtract>(*first_expression, *second_expression);
  ;
}

Complex Multiply::evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const {
  return first_cmplx * second_cmplx;
}

std::string Multiply::get_op() const { return "*"; }

std::unique_ptr<Expression> Multiply::clone() const {
  return std::make_unique<Multiply>(*first_expression, *second_expression);
  ;
}

Complex Divide::evaluate(const Complex &first_cmplx,
                         const Complex &second_cmplx) const {
  return first_cmplx / second_cmplx;
}

std::string Divide::get_op() const { return "/"; }

std::unique_ptr<Expression> Divide::clone() const {
  return std::make_unique<Divide>(*first_expression, *second_expression);
  ;
}

Add operator+(const Expression &first_expression,
              const Expression &second_expression) {
  return Add(first_expression, second_expression);
}

Subtract operator-(const Expression &first_expression,
                   const Expression &second_expression) {
  return Subtract(first_expression, second_expression);
}

Multiply operator*(const Expression &first_expression,
                   const Expression &second_expression) {
  return Multiply(first_expression, second_expression);
}

Divide operator/(const Expression &first_expression,
                 const Expression &second_expression) {
  return Divide(first_expression, second_expression);
}

Negate operator-(const Expression &first_expression) {
  return Negate(first_expression);
}