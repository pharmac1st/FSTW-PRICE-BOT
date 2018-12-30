require "discordrb"
require_relative "price_manipulation.rb"
require_relative "price_listing"
require_relative "upload.rb"
require "open-uri"

bot = Discordrb::Bot.new token: 'NTI0MDI0MDAzNjIzMzg3MTU3.Dwhwyw.jvu3fKqRB4qcCnngegj7iUScu5E'

bot.message(start_with: '!addelement') do |event|
  newelement = event.message.content.split(" ")
  tester = newelement[1].split(":")
  if tester.length != 2
    event.respond "Invalid element, please seperate using `name:price`"
  else
    add_element(tester[0],tester[1])
    event.respond "Successfully added item `#{tester[0]}` with price `#{tester[1]}`."
  end
end

bot.message(start_with: '!delelement') do |event|
  delelement = event.message.content.split(" ")[1]
  if check_element(delelement) == true
    delete_element(delelement)
    event.respond "Successfully deleted item: `#{delelement}`"
  else
    event.respond "No such item: `#{delelement}`"
  end
end

bot.message(start_with: '!editelement') do |event|
  contents = event.message.content.split(" ")[1]
  item = contents.split(":")[0]
  newprice = contents.split(":")[1]
  if check_element(item) == true
    change_item_price(item,newprice)
    event.respond "Successfully changed nil -> #{newprice}"
  else
    event.respond "No such item: `#{item}`"
  end
end

bot.message(contains: '!upload help') do |event|
  event.respond "To upload a file, drag the file onto discord and add the comment !upload"
end

bot.message(start_with: '!upload') do |event|
  link = event.message.attachments
  url = link[0].url
  name = link[0].filename
  download_file(url)
  process()
  event.respond "Successfully uploaded #{name}"
end


bot.run
