def search_item(query)
file = File.readlines("prices.txt")
file.each do |element|
  title = element.split(":")[0]
  if title == query
    return element
    end
  end
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

def page_length()
  file = File.readlines("prices.txt")
  totlength = file.length
  booklength = []
  while totlength > 4
    totlength = totlength - 4
    booklength << 4
  end
  booklength << totlength
  return booklength
end

def page()
  file = File.readlines("prices.txt")
  book = []
  booklength = page_length()
  page = []
  pagenum = 1
  booklength.each do |num|
    num.times do |i|
      page << file[i]
      file.delete(file[i])
    end
    book << page
    page = []
  end
  return book
end

print page

def list(page)

end
