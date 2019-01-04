require_relative "price_manipulation"

def download_file(link)
  File.open('dl_file.txt', "wb") do |file|
    file.write open(link).read
  end
end

def sanatize()
  pass = []
  fail = []
  File.readlines("dl_file.txt").each do |line|
    line = line.chomp
    if dupe_check(line) == true
      puts "#{line} failed"
      fail << line
    else
      puts "#{line} passed"
      pass << line
    end
  end
  if fail.length == 0
    return 0,pass,fail
  end
  if fail.length > 0
    return 1,fail,pass
  end
end

def file_read(file_directory)
  newfile = File.readlines(file_directory)
  File.open("prices.txt","a") do |file|
    newfile.each do |newelement|
      file.puts newelement
    end
  end
end

def file_wipe()
  File.write("dl_file.txt",nil)
end

def process()
  file_read("dl_file.txt")
  sleep 1
  file_wipe()
end
