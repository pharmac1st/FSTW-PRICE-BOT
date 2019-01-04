def bot_id()
  id = File.readlines("nativefile.txt")
  return id[0]
end

def match(user_input)
  lines = File.readlines("prices.txt")
  user_array = []
  title_array = []
  titlee = []
  bulk = []
  positive = []
  user_input.each_char do |chr|
    user_array << chr
  end
  lines.each do |line|
    title = line.split(":")[0]
    title_array << title
  end
  title_array.each do |title_|
    title_.each_char do |chr|
      titlee << chr
    end
    bulk << titlee
    titlee = []
  end
  temp = []
  auto = []
  bulk.each do |item|
    user_array.each.with_index do |chr,index|
      if user_array[index] == item[index]
        temp << "true"
      else
        temp << "false"
      end
      end
      if temp.count("false") < 3
        auto << item.join
      else
        temp = []
      end
    end
    return auto
  end


def search_item(query)
title = ""
file = File.readlines("prices.txt")
file.each do |element|
  title = element.split(":")[0]
  if title == query
    return element
    end
  end
  return "#{match(title)}?"
end


def search_price(query)
  file = File.readlines("prices.txt")
  file.each do |element|
  price = element.split(":")[1]
  if element.include? query
    return element
    end
  end
end


def catergorise(title)
  list = []
  File.readlines("prices.txt").each do |line|
    if line.include? title
      list << line
    end
  end
  f_title = list[0].split(":")[0]
  f_content = list[0].split(":")
  print f_content
  format = nil
  if list.length == 0
    return match(title)
  else
  return list
  end
end



#dict = key:value
def generate()
  hash = {}
  alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  alphabet.each_char do |letter|
    hash[letter] = []
  end
  return hash
end

def create()
  hash = generate()
  lines = File.readlines("prices.txt")
  lines.each do |line|
    first_letter = line[0]
    hash[first_letter] << line
  end
  return hash
end



def convert(convert)
  alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  if convert.is_a? String
    alphabet.each_char.with_index do |chr,index|
      if chr == convert
        return index
      end
    end
  end
end



def message_cache(message_id)
  File.open("cache.txt","a") {|file| file.puts "#{message_id}"}
end


def get_cache()
  array = []
  File.readlines("cache.txt").each do |id|
    array << id
  end
  return array
end

def currency_hash()
  hash = {}
  chash = {}
  carray = []
  titles = []
  contents = []
  lines = File.readlines("currency.txt")
  lines.each do |line|
    x = line.split(":")[0]
    titles << x
  end
  lines.each do |line|
    x = line.split(":")[1]
    content = x.split(",")
    contents << content
  end
  contents.each do |op|
    op.each do |item|
      nameval = item.split("=")
      name = nameval[0]
      chash[name] = nameval[1].to_f
    end
    carray << chash
    chash = {}
  end
  titles.each_index do |index|
    hash[titles[index]] = carray[index]
  end
  return hash
  end


def currency(price,type)
  hash = currency_hash()
  bulk = []
  raw = []
  hash[type].each do |each|
    multiplier = each[1]
    each[1] = price * multiplier
    each[1] = each[1].round(2)
    bulk << each
  end
    bulk.each do |item|
      raw << "#{item[1]}"
    end
    special = "ShadowShard:#{price}/Obsidian:#{raw[2]}/Malachite:#{raw[3]}"
  end
