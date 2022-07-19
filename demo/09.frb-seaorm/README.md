# Create SQLite database file

https://github.com/SeaQL/sea-orm/discussions/283

 create the sqlite sqlite database file if it does not exist.

```rust
let connection = Database::connect("/Users/me/.myapp/data.db?mode=rwc").await?;
```

just appending the appropriate permission flags to the end of the path to the database file in the Database::connect call. 

Just make sure the path to wherever you are creating the file exists beforehand (or create it using std::fs)

