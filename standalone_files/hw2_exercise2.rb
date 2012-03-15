a=[:a,:b]
b= [4,5]

a.map{|l| b.map{|m| [l,m]}}.flatten(1)#.each { |elt| puts elt.inspect }

class CartesianProduct
  include Enumerable
  # your code here
  
  def initialize(set1,set2)
    @lst=set1.map{|l| set2.map{|m| [l,m]}}.flatten(1)
  end
  def each
    @lst.each do |e|
      yield e
    end
  end
end

c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]
p '**'
c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# (nothing printed since Cartesian product
# of anything with an empty collection is empty)