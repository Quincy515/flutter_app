#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_platform(int64_t port_);

void wire_rust_release_mode(int64_t port_);

void wire_greet(int64_t port_);

void wire_square(int64_t port_, uint32_t n);

void wire_connect(int64_t port_, struct wire_uint_8_list *path);

void wire_save_person(int64_t port_, struct wire_uint_8_list *name, int32_t *age);

void wire_list_persons(int64_t port_);

int32_t *new_box_autoadd_i32_0(int32_t value);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_platform);
    dummy_var ^= ((int64_t) (void*) wire_rust_release_mode);
    dummy_var ^= ((int64_t) (void*) wire_greet);
    dummy_var ^= ((int64_t) (void*) wire_square);
    dummy_var ^= ((int64_t) (void*) wire_connect);
    dummy_var ^= ((int64_t) (void*) wire_save_person);
    dummy_var ^= ((int64_t) (void*) wire_list_persons);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_i32_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}