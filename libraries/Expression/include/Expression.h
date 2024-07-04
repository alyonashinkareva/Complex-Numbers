//
// Created by Alyona Shinkareva on 07.06.2023.
//
#include "complex.h"
#include <map>
#include <memory>
#include <sstream>

struct Expression {
public:
  virtual ~Expression() = default;
  virtual Complex
  eval(std::map<std::string, Complex> const &values = {}) const = 0;
  virtual std::unique_ptr<Expression> clone() const = 0;
  virtual std::string toString() const = 0;
  friend std::ostream &operator<<(std::ostream &out,
                                  const Expression &expression) {
    return out << expression.toString();
  }

private:
};

struct Const : public Expression {
private:
  const Complex cmplx;

public:
  Const(const Complex cmplx) : cmplx(cmplx){};
  std::unique_ptr<Expression> clone() const override;
  Complex
  eval(std::map<std::string, Complex> const &values = {}) const override;
  std::string toString() const override;
};

struct Variable : public Expression {
private:
  const std::string v;

public:
  Variable(const std::string v) : v(v){};
  std::unique_ptr<Expression> clone() const override;
  Complex
  eval(std::map<std::string, Complex> const &values = {}) const override;
  std::string toString() const override;
};

struct UnaryOperation : public Expression {
protected:
  std::unique_ptr<Expression> expression;
  virtual std::string get_op() const = 0;
  virtual Complex evaluate(const Complex &cmplx) const = 0;

public:
  UnaryOperation(const Expression &other) : expression(other.clone()){};
  Complex
  eval(std::map<std::string, Complex> const &values = {}) const override;
  std::string toString() const override;
};

struct Negate : public UnaryOperation {
private:
  virtual std::string get_op() const override;
  virtual Complex evaluate(const Complex &cmplx) const override;

public:
  Negate(const Expression &expression) : UnaryOperation(expression){};
  std::unique_ptr<Expression> clone() const override;
};

struct Conjugate : public UnaryOperation {
private:
  virtual std::string get_op() const override;
  virtual Complex evaluate(const Complex &cmplx) const override;

public:
  Conjugate(const Expression &expression) : UnaryOperation(expression){};
  std::unique_ptr<Expression> clone() const override;
};

struct BinaryOperation : public Expression {
protected:
  std::unique_ptr<Expression> first_expression;
  std::unique_ptr<Expression> second_expression;
  virtual std::string get_op() const = 0;
  virtual Complex evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const = 0;

public:
  BinaryOperation(const Expression &first_expression,
                  const Expression &second_expression)
      : first_expression(first_expression.clone()),
        second_expression(second_expression.clone()){};
  Complex
  eval(std::map<std::string, Complex> const &values = {}) const override;
  std::string toString() const override;
};

struct Add : public BinaryOperation {
private:
  virtual std::string get_op() const override;
  virtual Complex evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const override;

public:
  Add(const Expression &first_expression, const Expression &second_expression)
      : BinaryOperation(first_expression, second_expression){};
  std::unique_ptr<Expression> clone() const override;
};

struct Subtract : BinaryOperation {
private:
  virtual std::string get_op() const override;
  virtual Complex evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const override;

public:
  Subtract(const Expression &first_expression,
           const Expression &second_expression)
      : BinaryOperation(first_expression, second_expression){};
  std::unique_ptr<Expression> clone() const override;
};

struct Divide : BinaryOperation {
private:
  virtual std::string get_op() const override;
  virtual Complex evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const override;

public:
  Divide(const Expression &first_expression,
         const Expression &second_expression)
      : BinaryOperation(first_expression, second_expression){};
  std::unique_ptr<Expression>clone() const override;
};

struct Multiply : BinaryOperation {
private:
  virtual std::string get_op() const override;
  virtual Complex evaluate(const Complex &first_cmplx,
                           const Complex &second_cmplx) const override;

public:
  Multiply(const Expression &first_expression,
           const Expression &second_expression)
      : BinaryOperation(first_expression, second_expression){};
  std::unique_ptr<Expression> clone() const override;
};

Add operator+(const Expression &first_expression,
              const Expression &second_expression);
Subtract operator-(const Expression &first_expression,
                   const Expression &second_expression);
Multiply operator*(const Expression &first_expression,
                   const Expression &second_expression);
Divide operator/(const Expression &first_expression,
                 const Expression &second_expression);
Negate operator-(const Expression &first_expression);