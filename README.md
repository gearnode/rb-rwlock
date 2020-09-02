# Introduction
`RbRWLock` is simple pure Ruby implementation of the read write lock mutex.

# Motivation
The standard Ruby library come with very basic concurrency tool, in many case
I need read write lock instead of mutex. This implementation is a very basic
implementation which is perfect for intensive read usage to increase
performance.

# Usage

```ruby
require("rb-rwlock")

lock = RbRWLock.new_rwlock
counter = 0

lock.with_read_lock do
    puts counter
end

lock.with_write_lock do
    counter += 1
end

lock.with_read_lock do
    puts counter
end
```

# Documentation
You can also use the [yard](https://yardoc.org) documentation tool to read
code documentation, for example:

    yard doc

# Contact
If you find a bug or have any question, feel free to open a Github issue or to
contact me [by email](mailto:bryan@frimin.fr).

Please note that I do not currently review or accept any contribution.

# License
Released under the ISC license.

Copyright (c) 2020 Bryan Frimin <bryan@frimin.fr>.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
