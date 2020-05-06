#pragma once
#include <iterator>

namespace sql {

template <typename Statement>
class iterator {
public:
  using reference = Statement&;
  using value_type = Statement;

  using iterator_category = std::input_iterator_tag;

  explicit iterator() noexcept = default;
  explicit iterator(Statement* statement) noexcept : value_(statement) {
  }

  iterator& operator++() {
    if (value_ && !value_->step()) {
      value_ = nullptr;
    }
    return *this;
  }

  bool operator==(const iterator& other) const noexcept {
    return value_ == other.value_;
  }

  bool operator!=(const iterator& other) const noexcept {
    return value_ != other.value_;
  }

  reference operator*() noexcept {
    return *value_;
  }

private:
  value_type* value_ = nullptr;
};

}  // namespace sql
