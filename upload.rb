def download_file(link)
  File.open('dl_file.txt', "wb") do |file|
    file.write open(link).read
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
