DIRECTORY = "prices.txt"
require "open-uri"

def add_element(item,price)
  File.open("prices.txt","a") {|file| file.puts "#{item}:#{price}"}
end

def change_item_price(item,newprice)
  index = 0
  file = File.readlines("prices.txt")
  puts file
  file.each do |line|
    if line.include? item
      index = file.index line
    end
  end
  element = file[index].split(":")
  element[1] = newprice
  newelement = "#{element[0]}:#{element[1]}\n"
  file[index] = newelement
  File.write("prices.txt",file.join)
end

def check_element(item_)
  item_list = []
  file = File.readlines("prices.txt")
  file.each do |element|
    item = element.split(":")[0]
    item_list << item
  end
  puts item_list
  if item_list.include? item_
    return true
  end
end


def delete_element(item)
  index = 0
  file = File.readlines("prices.txt")
  file.each do |line|
    if line.include? item
      index = file.index(line)
    end
  end
  file[index] = nil
  File.write(DIRECTORY,file.join)
end
