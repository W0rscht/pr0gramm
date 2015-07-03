# local testing workaround
$LOAD_PATH.unshift File.dirname(__FILE__) +'/lib/'

require 'pr0gramm'

pr0 = Pr0gramm.new({ username: 'RubyPr0gramm', password: 'RubyPr0gramm' })

requester = pr0.requester

puts requester.session.inspect

result = requester.get('/user/info')

puts result.inspect

#puts result.inspect

# #pr0.update
# items = pr0.items
# pr0.update({
#   older: items[-1]['promoted'],
#   filter: [:sfw, :nsfw, :nsfl]
# })

# class Pr0gramm

#   def update(options = {})

#     options = {
#       promoted: @promoted,
#       filter:   @filter,
#     }.merge(options)

#     if !@items || ( @last_filter && @last_filter.uniq.sort != @filter.uniq.sort )
#       @items = []
#     end

#     @last_filter = options[:filter]

#     flags  = 0
#     flags += 1 if @last_filter.include?(:sfw)
#     flags += 2 if @last_filter.include?(:nsfw)
#     flags += 4 if @last_filter.include?(:nsfl)

#     parameter = {
#       flags: flags
#     }
#     if options[:promoted]
#       parameter[:promoted] = options[:promoted]
#     end
#     if options[:older]
#       parameter[:older] = options[:older]
#     end
#     response = RestClient.get "#{@base_url}api/items/get", {
#       accept: :json,
#       params: parameter
#     }


# puts @items.inspect
# puts response.to_str

#     result = JSON.parse response.to_str


#     new_items = []
#     result['items'].each { |item|

#       known = false
#       @items.each { |known_item|

#         next if known_item['id'] != item['id']
#         known = true
#         break
#       }

#       next if known

#       new_items.push(item)
#     }
#     @items += new_items

# puts @items.inspect
#   end
# end





