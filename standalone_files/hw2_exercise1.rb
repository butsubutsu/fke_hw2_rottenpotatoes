#part a

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
  def method_missing(method_id,*arguments)
    myKey=nil
    if method_id.to_s=~/in/i
      myKey = arguments[0].to_s  
    else
      myKey=method_id.to_s
    end
    singular_currency = myKey.to_s.gsub( /s$/, '')

    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
     super
    end
  end
  
end
#p 5.euros
#p 5.euros.in(:rupees)
#.in(:rupees)
#p 6.46 * 0.019





class String
  def palindrome?
    self.gsub(/\W/,'').downcase==self.gsub(/\W/,'').reverse.downcase
  end
end
#p "foorfoof".palindrome?



module Enumerable    
      #class_eval "def palindrome?;p'***';p self==self.reverse; end"#ok, hash error
      class_eval "def palindrome?;enu=self.reverse_each;self.map{|l| l==enu.next}.reduce(:&); end"#ok, hash error
end
p ['a',12,12,'A'].palindrome?
#myh= {:a=>2,:b=>0,:a=>32}#.reverse_each{|l|l}
#enu=myh.reverse_each
#p myh.map{|l| p l; l==enu.next}.reduce(:&)
#p myh.palindrome?

p "foorfoof".palindrome?