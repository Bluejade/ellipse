#
# ellipse methods
#
# Copyright 2009 Daniel Nelson.  All rights reserved.
#
# This is free software with ABSOLUTELY NO WARRANTY, released under
# the terms of the Ruby license
#

require 'closest_index'

class Ellipse
  VERSION = '0.1'
  
  attr_reader :a, :b
  def initialize(a, b)
    @a = a.to_f
    @b = b.to_f
  end

  def circumference
    @circumference ||= compute_circumference
  end

  # arc_length is length from x=a, y=0 to 
  def angle_from_arc(arc_length)
    index = cumulative_distances.closest_index(arc_length)
    @cumulative_distance_angles[index]
  end

  # theta is in radians
  # returns [x, y]
  def coords_from_angle(theta)
    cos_theta = Math.cos(theta)
    sin_theta = Math.sin(theta)
    radius = @a * @b / Math.sqrt(@b * @b * cos_theta * cos_theta + @a * @a * sin_theta * sin_theta)
    [radius * cos_theta, radius * sin_theta]
  end  

  private
  
  def cumulative_distances
    @cumulative_distances ||= compute_cumulative_distances
  end

  def compute_circumference
    # From "a better approximation" of the circumference of an ellipse
    # at http://en.wikipedia.org/wiki/Ellipse (based on Ramanujan's?)
    a_b_block = 3 * ((@a - @b) / (@a + @b))**2
    Math::PI * (@a + @b) * (1 + a_b_block / (10 + Math.sqrt(4 - a_b_block)))
  end

  def compute_cumulative_distances
    cumulative_distances = [0.0]
    
    # 180 gives for every 1 degree, 360 for every half degree
    segments = 360
    delta_theta = Math::PI / segments

    previous_x = @a
    previous_y = 0
    segments.times do |i|
      x, y = coords_from_angle(delta_theta * (i + 1))
      distance = Math.sqrt((y - previous_y)**2 + (x - previous_x)**2)
      cumulative_distances << cumulative_distances.last + distance
      previous_x = x
      previous_y = y
    end
    segments.times do |i|
      cumulative_distances << cumulative_distances[i + 1] + cumulative_distances[segments]
    end
    
    @cumulative_distance_angles = []
    (segments * 4 + 1).times do |i|
      @cumulative_distance_angles << delta_theta * i
    end
    
    cumulative_distances
  end
end
