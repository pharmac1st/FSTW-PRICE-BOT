DIRECTORY = "prices.txt"
require "open-uri"
LEVELS = 82,106,130


def dupe_check(string) #ONLY TO BE USED FOR FILES!
  File.readlines("prices.txt").each do |line|
    if line == "#{string}\n"
      return true
    end
  end
  return false
end

def add_element(title,price_array)
  currency_array = []
  price_array.each.with_index do |price,index|
    num = price.split("x")[0].to_i
    type = price.split("x")[1]
    curr = currency(num,type)
    currency_array << curr
end
  element_array = []
  LEVELS.each.with_index do |level,index|
    element_array << "#{title} #{level}:#{currency_array[index]}"
  end
  message = "#{title}*#{element_array.join(",")}"
  File.open("prices.txt","a") do |file|
    file.puts "#{title}*#{element_array.join(",")}"
  end
  return message
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
    name = item.split(" ")[0]
    item_list << name
  end
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
