#pragma once
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <variant>
#include <cstddef>
#include <cstdint>

namespace sql {

enum class code {
  ok = 0,
  error = 1,
  internal = 2,
  perm = 3,
  abort = 4,
  busy = 5,
  locked = 6,
  nomem = 7,
  readonly = 8,
  interrupt = 9,
  ioerr = 10,
  corrupt = 11,
  notfound = 12,
  full = 13,
  cantopen = 14,
  protocol = 15,
  empty = 16,
  schema = 17,
  toobig = 18,
  constraint = 19,
  mismatch = 20,
  misuse = 21,
  nolfs = 22,
  auth = 23,
  format = 24,
  range = 25,
  notadb = 26,
  notice = 27,
  warning = 28,
  row = 100,
  done = 101,
};

enum class type { null, integer, real, text, blob };

using null = std::nullptr_t;
using integer = std::int64_t;
using real = double;
using text = std::string_view;
using blob = std::basic_string_view<unsigned char>;
using value = std::variant<null, integer, real, text, blob>;

template <typename T>
struct is_native_type {
  // clang-format off
  static constexpr bool value =
    std::is_same_v<T, null> ||
    std::is_same_v<T, integer> ||
    std::is_same_v<T, real> ||
    std::is_same_v<T, text> ||
    std::is_same_v<T, blob> ||
    std::is_same_v<T, value>;
  // clang-format on
};

template <typename T>
constexpr bool is_native_type_v = is_native_type<T>::value;

template <typename Statement>
class basic_column {
public:
  explicit basic_column(const Statement& statement, std::size_t index) noexcept :
    statement_(const_cast<Statement*>(&statement)), index_(index) {
  }

  basic_column(basic_column&& other) = delete;
  basic_column(const basic_column& other) = delete;
  basic_column& operator=(basic_column&& other) = delete;
  basic_column& operator=(const basic_column& other) = delete;

  operator bool() const {
    return type() != sql::type::null;
  }

  std::size_t index() const noexcept {
    return index_;
  }

  sql::type type() const noexcept {
    return statement_->type(index_);
  }

  template <typename T>
  T get() const {
    return statement_->template get<T>(index_);
  }

  template <typename... T>
  void set(T&&... values) {
    statement_->bind(index_, std::forward<T>(values)...);
  }

private:
  Statement* statement_;
  std::size_t index_ = 0;
};

class statement;

using column = basic_column<statement>;

template <typename T>
struct traits {
  template <typename U = T>
  static std::enable_if_t<std::is_integral_v<U>, void> set(sql::column& column, U value) {
    column.set(static_cast<integer>(value));
  }

  template <typename U = T>
  static std::enable_if_t<std::is_floating_point_v<U>, void> set(sql::column& column, U value) {
    column.set(static_cast<real>(value));
  }

  template <typename U = T>
  static std::enable_if_t<std::is_integral_v<U>, U> get(const sql::column& column) {
    return static_cast<U>(column.get<integer>());
  }

  template <typename U = T>
  static std::enable_if_t<std::is_floating_point_v<U>, U> get(const sql::column& column) {
    return static_cast<U>(column.get<real>());
  }
};

template <>
struct traits<bool> {
  static void set(sql::column& column, bool value) {
    column.set(value ? 1LL : 0LL);
  }
  static bool get(const sql::column& column) {
    return column.get<integer>() ? true : false;
  }
};

template <>
struct traits<std::string> {
  static void set(sql::column& column, std::string&& value) {
    column.set(text(value), true);
  }
  static void set(sql::column& column, const std::string& value) {
    column.set(text(value), false);
  }
  static std::string get(const sql::column& column) {
    return std::string(column.get<text>());
  }
};

template <typename T>
struct traits<std::optional<T>> {
  static void set(sql::column& column, const std::optional<T>& value) {
    if (value) {
      column.set(value.value());
    } else {
      column.set();
    }
  }
  static std::optional<T> get(const sql::column& column) {
    if (column) {
      return column.template get<T>();
    }
    return {};
  }
};

}  // namespace sql
