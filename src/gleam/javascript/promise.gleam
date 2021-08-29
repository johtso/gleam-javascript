// TODO: docs
// TODO: labels
pub external type Promise(value)

pub external fn resolve(value) -> Promise(value) =
  "../../ffi.js" "resolve"

pub external fn then(Promise(a), fn(a) -> Promise(b)) -> Promise(b) =
  "../../ffi.js" "then"

pub external fn map(Promise(a), fn(a) -> b) -> Promise(b) =
  "../../ffi.js" "map_promise"

pub fn tap(promise: Promise(a), callback: fn(a) -> b) -> Promise(a) {
  promise
  |> map(fn(a) {
    callback(a)
    a
  })
}

pub fn map_try(
  promise: Promise(Result(a, e)),
  callback: fn(a) -> Result(b, e),
) -> Promise(Result(b, e)) {
  promise
  |> map(fn(result) {
    case result {
      Ok(a) -> callback(a)
      Error(e) -> Error(e)
    }
  })
}