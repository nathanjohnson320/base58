Base58
======
Elm lib for base58 encoding/decoding

## Examples
```
  Base58.decode "Qmd4STeBJPJyDw9KhaDYfFd91W2cDkW6CFkzEF8gveVfXg"
  |> Result.map BigInt.toString
  |> Expect.equal (Ok "537374223645606396327404992513981989153791146196994939352589708590914230509284699")

```

```
  BigInt.fromInt 0
  |> Base58.encode
  |> Expect.equal "1"
```