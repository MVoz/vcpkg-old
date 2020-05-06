#pragma once
#include <utility>
#include <cstddef>

namespace sql {

template <typename Statement>
class binder {
public:
  binder(Statement& statement, std::size_t index = 0) noexcept : statement_(statement), index_(index) {
  }

  template <typename T>
  void bind(T&& value) {
    statement_.bind(index_++, std::forward<T>(value));
  }

  template <typename T, typename... Args>
  void bind(T&& value, Args&&... args) {
    statement_.bind(index_++, std::forward<T>(value));
    bind(std::forward<Args>(args)...);
  }

private:
  Statement& statement_;
  std::size_t index_ = 0;
};

}  // namespace sql
