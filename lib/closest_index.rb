#
# closest_index - find the closest index
#
# Copyright 2009 Daniel Nelson.  All rights reserved.
#
# This is free software with ABSOLUTELY NO WARRANTY, released under
# the terms of the Ruby license
#
# Example:
#
#  % irb -r ./closest_index.rb
#  >> [1, 2, 3, 4, 5, 6, 7].closest_index(3.7)
#  => 3

module ClosestIndex
  VERSION = '0.1'
end

class Array
  # Array elements must be sorted in ascending order
  # Returns the index of the nearest match
  def closest_index(value, lower_bound=0, upper_bound=(self.length - 1))
    return nil if self.length == 0
    middle_bound = (lower_bound + upper_bound) / 2
    
    return lower_bound if value <= self[lower_bound]
    return upper_bound if value >= self[upper_bound]
    
    if value < self[middle_bound]
      if middle_bound == lower_bound + 1
        return middle_bound if self[middle_bound] - value <= value - self[lower_bound]
        return lower_bound
      end
      return closest_index(value, lower_bound, middle_bound) 
    end
    
    if upper_bound == middle_bound + 1
      return upper_bound if self[upper_bound] - value <= value - self[middle_bound]
      return middle_bound
    end
    closest_index(value, middle_bound, upper_bound)
  end
end
