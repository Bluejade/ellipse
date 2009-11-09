$LOAD_PATH << File.join(File.dirname(__FILE__),".." ,"lib" )
require 'spec'
require 'ellipse'

describe Ellipse do
  describe '#circumference' do
    it 'should be close to the circumference of a circle when major and minor axis are equal' do
      ellipse = Ellipse.new(7, 7)
      ellipse.circumference.should be_close(2 * Math::PI * 7, 0.05)
    end
  end
  
  describe '#angle_from_arc(arc_length)' do
    it 'should be close to 0 when arc_length is 0' do
      ellipse = Ellipse.new(7, 9)
      ellipse.angle_from_arc(0).should be_close(0, 0.01)
    end
    it 'should be close to Pi when arc_length is half the circumference' do
      ellipse = Ellipse.new(7, 9)
      ellipse.angle_from_arc(ellipse.circumference * 0.5).should be_close(Math::PI, 0.01)
    end
    it 'should be close to 2 * Pi when arc_length is equal to the circumference' do
      ellipse = Ellipse.new(7, 9)
      ellipse.angle_from_arc(ellipse.circumference).should be_close(0, 0.01)
    end
  end
  
  describe '#angle_from_arc(arc_length, -Pi / 2)' do
    it 'should be close to 0 when arc_length is 0' do
      ellipse = Ellipse.new(7, 9)
      ellipse.angle_from_arc(0, -1 * Math::PI / 2).should be_close(3 * Math::PI / 2, 0.01)
    end
    it 'should be close to Pi when arc_length is half the circumference' do
      ellipse = Ellipse.new(7, 9)
      ellipse.angle_from_arc(ellipse.circumference * 0.5, -1 * Math::PI / 2).should be_close(Math::PI / 2, 0.01)
    end
    it 'should be close to 2 * Pi when arc_length is equal to the circumference' do
      ellipse = Ellipse.new(7, 9)
      ellipse.angle_from_arc(ellipse.circumference, -1 * Math::PI / 2).should be_close(3 * Math::PI / 2, 0.01)
    end
  end

  describe '#coords_from_angle(theta)' do
    it 'should be close to [a, 0] when theta is 0' do
      ellipse = Ellipse.new(9, 7)
      x, y = ellipse.coords_from_angle(0)
      x.should be_close(9, 0.01)
      y.should be_close(0, 0.01)
    end
    it 'should be close to [0, b] when theta is Pi / 2' do
      ellipse = Ellipse.new(9, 7)
      x, y = ellipse.coords_from_angle(Math::PI * 0.5)
      x.should be_close(0, 0.01)
      y.should be_close(7, 0.01)
    end
    it 'should be close to [-a, 0] when theta is Pi' do
      ellipse = Ellipse.new(9, 7)
      x, y = ellipse.coords_from_angle(Math::PI)
      x.should be_close(-9, 0.01)
      y.should be_close(0, 0.01)
    end
    it 'should be close to [0, -b] when theta is 3 * Pi / 2' do
      ellipse = Ellipse.new(9, 7)
      x, y = ellipse.coords_from_angle(3 * Math::PI * 0.5)
      x.should be_close(0, 0.01)
      y.should be_close(-7, 0.01)
    end
    it 'should be close to [a, 0] when theta is 2 * Pi' do
      ellipse = Ellipse.new(9, 7)
      x, y = ellipse.coords_from_angle(2 * Math::PI)
      x.should be_close(9, 0.01)
      y.should be_close(0, 0.01)
    end
    it 'should be close to [0, -b] when theta is -1 * Pi / 2' do
      ellipse = Ellipse.new(9, 7)
      x, y = ellipse.coords_from_angle(-1 * Math::PI * 0.5)
      x.should be_close(0, 0.01)
      y.should be_close(-7, 0.01)
    end
  end
end

