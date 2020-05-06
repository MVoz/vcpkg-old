#pragma once
#include <sql/database.hpp>
#include <sql/exception.hpp>
#include <sql/statement.hpp>
#include <exception>
#include <sstream>

namespace sql {

class stream {
public:
  stream(database& db, std::string_view query) : db_(&db) {
    oss_ << query;
  }

  stream(stream&& other) : db_(std::exchange(other.db_, nullptr)), oss_(std::move(other.oss_)) {
  }

  stream& operator=(stream&& other) {
    db_ = std::exchange(other.db_, nullptr);
    oss_ = std::move(other.oss_);
    return *this;
  }

  ~stream() noexcept(false) {
    if (db_ && !std::uncaught_exceptions()) {
      (*db_)(oss_.str());
    }
  }

  operator statement() {
    if (auto db = std::exchange(db_, nullptr)) {
      return db->prepare(oss_.str());
    }
    throw exception("statement error: invalid handle", oss_.str());
  }

  template <typename T>
  stream& operator<<(T&& v) {
    oss_ << '\n' << std::forward<T>(v);
    return *this;
  }

private:
  database* db_ = nullptr;
  std::ostringstream oss_;
};

inline stream operator<<(database& db, std::string_view query) {
  return stream(db, query);
}

}  // namespace sql
