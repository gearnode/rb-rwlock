# Copyright (c) 2020 Bryan Frimin <bryan@frimin.fr>.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

require("thread")

module RbRWLock

  def self.new_rwlock
    RWLock.new
  end

  class RWLock
    def initialize
      @num_readers_active = 0
      @num_writers_waiting = 0
      @writer_active = false
      @mut = Mutex.new
      @cond = ConditionVariable.new
    end

    # Aquire read lock.
    #
    # @author Gearnode <bryan@frimin.fr>
    # @since 1.0.0
    #
    # @param the code to execute protected by the lock
    #
    # @return [void]
    def with_read_lock
      @mut.synchronize do
        while @num_writers_waiting > 0 || @writer_active
          @cond.wait(@mut)
        end
        @num_readers_active += 1
      end

      yield

    ensure
      @mut.synchronize do
        @num_readers_active -= 1
        if @num_readers_active == 0
          @cond.broadcast
        end
      end
    end

    # Aquire write lock.
    #
    # @author Gearnode <bryan@frimin.fr>
    # @since 1.0.0
    #
    # @param the code to execute protected by the lock
    #
    # @return [void]
    def with_write_lock
      @mut.synchronize do
        @num_writers_waiting += 1
        while @num_readers_active > 0 || @writer_active
          @cond.wait(@mut)
        end

        @num_writers_waiting -= 1
        @writer_active = true
      end

      yield
    ensure
      @mut.synchronize do
        @writer_active = false
        @cond.broadcast
      end
    end
  end
end
