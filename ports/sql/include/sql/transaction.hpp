#pragma once
#include <sql/database.hpp>
#include <sql/lock.hpp>
#include <exception>

namespace sql {

class transaction {
public:
  transaction(database& db) : lock_(db) {
    lock_.db().begin();
  }

  ~transaction() noexcept(false) {
    if (std::uncaught_exceptions()) {
      try {
        lock_.db().rollback();
      }
      catch (...) {
      }
    } else {
      lock_.db().commit();
    }
  }

private:
  lock lock_;
};

}  // namespace sql
