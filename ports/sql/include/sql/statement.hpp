#pragma once
#include <sql/binder.hpp>
#include <sql/exception.hpp>
#include <sql/iterator.hpp>
#include <sql/types.hpp>
#include <utility>

extern "C" {

struct sqlite3_stmt;

}  // extern "C"

namespace sql {

using statement_handle = std::unique_ptr<sqlite3_stmt, int (*)(sqlite3_stmt*)>;

class statement {
public:
  statement() noexcept;
  statement(statement&& other) = default;
  statement& operator=(statement&& other) = default;
  virtual ~statement() = default;

  bool step();
  void reset() noexcept;

  void bind(std::size_t index, null = nullptr);
  void bind(std::size_t index, integer value);
  void bind(std::size_t index, real value);
  void bind(std::size_t index, text value, bool copy = true);
  void bind(std::size_t index, blob value, bool copy = true);

  template <typename T>
  void bind(std::size_t index, T&& value) {
    sql::column column(*this, index);
    traits<std::decay_t<T>>::set(column, std::forward<T>(value));
  }

  statement& operator()() {
    reset();
    step();
    return *this;
  }

  template <typename... T>
  statement& operator()(T&&... values) {
    reset();
    binder<statement> binder(*this);
    binder.bind(std::forward<T>(values)...);
    step();
    return *this;
  }

  iterator<statement> begin() {
    return iterator<statement>(data_ ? this : nullptr);
  }

  static iterator<statement> end() noexcept {
    return iterator<statement>();
  }

  std::size_t column_count() const noexcept;
  std::string_view column_name(std::size_t index) const noexcept;
  std::string_view column_type(std::size_t index) const noexcept;
  std::string_view column_table(std::size_t index) const noexcept;
  std::string_view column_origin(std::size_t index) const noexcept;

  sql::type type(std::size_t index) const noexcept;

  template <typename T>
  T get(std::size_t index) const {
    const sql::column column(*this, index);
    return traits<T>::get(column);
  }

  template <typename T>
  T get(std::string_view name) const {
    for (std::size_t i = 0, count = column_count(); i < count; i++) {
      if (name.compare(column_name(i)) == 0) {
        return get<T>(i);
      }
    }
    throw exception("invalid column name: " + std::string(name));
  }

  statement_handle& handle() noexcept {
    return handle_;
  }

  std::string_view query() const;

  operator bool() const noexcept {
    return handle_ && data_ ? true : false;
  }

private:
  statement_handle handle_;
  bool data_ = false;
};

template <>
null statement::get<null>(std::size_t index) const;

template <>
integer statement::get<integer>(std::size_t index) const;

template <>
real statement::get<real>(std::size_t index) const;

template <>
text statement::get<text>(std::size_t index) const;

template <>
blob statement::get<blob>(std::size_t index) const;

}  // namespace sql
