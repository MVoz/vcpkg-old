#pragma once
#include <sql/types.hpp>
#include <ice/uuid.h>

namespace sql {

template <>
struct traits<ice::uuid> {
  static void set(sql::column& column, const ice::uuid& value) {
    column.set(value.str());
  }
  static ice::uuid get(const sql::column& column) {
    return ice::uuid(column.get<text>());
  }
};

}  // namespace sql
