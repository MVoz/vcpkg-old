#pragma once
#include <sql/database.hpp>
#include <mutex>

namespace sql {

class lock {
public:
  lock(database& db) : db_(db), lock_(db.mutex()) {
  }

  database& db() noexcept {
    return db_;
  }

private:
  database& db_;
  std::lock_guard<std::recursive_mutex> lock_;
};

}  // namespace sql
