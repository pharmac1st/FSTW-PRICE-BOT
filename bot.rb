require "discordrb"
require_relative "price_manipulation.rb"
require_relative "price_listing"
require_relative "upload.rb"
require "open-uri"

#Shadow-shard:Obsidian:Malachite 1:1:5

bot = Discordrb::Bot.new token: bot_id()


bot.message(contains: '.add') do |event|
  content = event.message.content.split(" ")[1].split(":")
  title = content[0]
  price_array = content[1].split(",")
  message = add_element(title,price_array)
  if message == false
    event.respond "❌ Error, please try again."
  end
  event.respond "✅ item: `#{message}` has been added successfully."
  first_letter = title[0]
  hash = create()
  cache = get_cache()
  first_letter = title[0]
  items = message.split("*")[1]
  items = items.split(",").join("\n")
  index = convert first_letter
  id = cache[index]
  id = id.to_i
  holder = bot.channel(529984730968621057).load_message(id)
  if holder = "-"
    bot.channel(529984730968621057).load_message(id).edit("#{title}\n#{items}")
  else
    bot.channel(529984730968621057).load_message(id).("#{holder.content}\n#{title}\n#{items}")
  end
end



bot.message(contains: '.help add') do |event|
  event.respond "`.add <item_name>:<82_price>,<106_price>,<130_price>` prices require to be in ShadowShard as per the server."
end

bot.message(contains: '.delelement') do |event|
  delelement = event.message.content.split(" ")[1]
  if check_element(delelement) == true
    delete_element(delelement)
    event.respond "Successfully deleted item: `#{delelement}`"
  else
    event.respond "No such item: `#{delelement}`"
  end
end

bot.message(contains: '.editelement') do |event|
  contents = event.message.content.split(" ")[1]
  item = contents.split(":")[0]
  newprice = contents.split(":")[1]
  if check_element(item) == true
    change_item_price(item,newprice)
    event.respond "Successfully changed #{search_price(item)} -> #{newprice}"
  else
    event.respond "No such item: `#{item}`"
  end
end

bot.message(contains: '.upload help') do |event|
  event.respond "To upload a file, drag the file onto discord and add the comment `!upload`."
end

bot.message(contains: '.upload') do |event|
  link = event.message.attachments
  url = link[0].url
  name = link[0].filename
  download_file(url)
  process()
  event.respond "Successfully uploaded #{name}"
end

bot.message(contains: '$') do |event| # i did this at 5am with no sleep excuse the spelling
  title = event.message.content.split("$")[1]
   catagory = catergorise(title)
   message = "```#{title}:\n#{catagory.join}```"
   event.respond message
 end

bot.message(contains: '.reset') do |event|
  event.respond "Manually overiding... (This will take up to 20 seconds due to Discord's rate-limiting.)"
  File.write("cache.txt","")
  list = "A-B-C-D-E-F-G-H-I-J-K-L-M-N-O-P-Q-R-S-T-U-V-W-X-Y-Z-".split("")
  bot.channel(529984730968621057).prune(100)
  list.each do |msg|
      message = bot.send_message(529984730968621057,msg)
      id = message.id
      if msg == "-"
        message_cache(id)
    end
  end
end


bot.message(contains: '.clear') do |event|
  event.channel.prune 100
  File.write("cache.txt","")
end



bot.run
