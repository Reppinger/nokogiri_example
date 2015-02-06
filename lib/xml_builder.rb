require 'nokogiri'
puts 'Starting with examples taken from http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder'

puts '===Basic example==='
builder = Nokogiri::XML::Builder.new do
  root {
    products {
      widget {
        id_ "10"
        name "Awesome widget"
      }
    }
  }
end
puts builder.to_xml

puts '===Add encoding to xml tag==='
builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do
  root {
    products {
      widget {
        id_ "10"
        name "Awesome widget"
      }
    }
  }
end
puts builder.to_xml

puts '===Adding an attribute to a node==='
builder = Nokogiri::XML::Builder.new do
  root {
    products {
      widget(category:'stuff') {
        id_ "10"
        name "Awesome widget"
      }
    }
  }
end
puts builder.to_xml

puts '===Adding an undefined namespace to a node==='
#This will generate an error because the namespace has not been defined
begin
builder = Nokogiri::XML::Builder.new do
  root {
    products { |products|
      products['foo'].widget(category:'stuff') {
        id_ "10"
        name "Awesome widget"
      }
    }
  }
end
rescue Exception => e
  puts e
end

puts '===Adding a properly defined namespace to a node==='
builder = Nokogiri::XML::Builder.new do
  root('xmlns:foo' => 'bar') {
    products { |products|
      products['foo'].widget(category:'stuff') {
        id_ "10"
        name "Awesome widget"
      }
    }
  }
end
puts builder.to_xml
