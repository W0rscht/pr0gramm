require 'rest-client'

class Pr0gramm

  class Pr0gramm::Item

    attr_reader :id, :promoted, :up, :down, :created, :image, :thumb, :fullsize, :source, :flags, :user, :mark

    def initialize(item)

      @id       = item['id']
      @promoted = item['promoted']
      @up       = item['up']
      @down     = item['down']
      @created  = item['created']
      @image    = item['image']
      @thumb    = item['thumb']
      @fullsize = item['fullsize']
      @source   = item['source']
      @flags    = item['flags']
      @user     = item['user']
      @mark     = item['mark']
    end
  end

  class Pr0gramm::User

    @mark_mapping = {
      '0' => 'Schwuchtel',
      '1' => 'Neuschwuchtel',
      '2' => 'Altschwuchtel',
      '3' => 'Admin',
      '4' => 'Gesperrt',
      '5' => 'Moderator',
      '6' => 'Fliesentischbesitzer',
      '7' => 'Lebende Legende',
      '8' => 'pr0wichtler',
      '9' => 'Edler Spender',
    }

    attr_reader :id, :name, :registered, :score, :mark, :admin, :banned, :comments,

    def initialize(name)


      # http://pr0gramm.com/api/profile/info?name=GermanLeviathan

      # @id =
      # @name =
      # @registered =
      # @score =
      # @mark =
      # @admin =
      # @banned =
    end
  end

  attr_accessor :filter
  attr_reader :items

  def initialize(options = {})

    options = {
      url:      'pr0gramm.com',
      protocol: 'https',
      filter:   [:sfw],
      promoted: true,
    }.merge(options)

    @promoted = options[:promoted] # 'beliebt'
    @filter   = options[:filter]
    @base_url = "#{options[:protocol]}://#{options[:url]}/"

    @last_filter = []

    update
  end

  def update(options = {})

    options = {
      promoted: @promoted,
      filter:   @filter,
    }.merge(options)

    if !@items || ( @last_filter && @last_filter.uniq.sort != @filter.uniq.sort )
      @items = []
    end

    @last_filter = options[:filter]

    flags  = 0
    flags += 1 if @last_filter.include?(:sfw)
    flags += 2 if @last_filter.include?(:nsfw)
    flags += 4 if @last_filter.include?(:nsfl)

    parameter = {
      flags: flags
    }
    if options[:promoted]
      parameter[:promoted] = options[:promoted]
    end
    if options[:older]
      parameter[:older] = options[:older]
    end
    response = RestClient.get "#{@base_url}api/items/get", {
      accept: :json,
      params: parameter
    }


puts @items.inspect
puts response.to_str

    result = JSON.parse response.to_str


    new_items = []
    result['items'].each { |item|

      known = false
      @items.each { |known_item|

        next if known_item['id'] != item['id']
        known = true
        break
      }

      next if known

      new_items.push(item)
    }
    @items += new_items

puts @items.inspect
  end
end

pr0 = Pr0gramm.new

#pr0.update
items = pr0.items
pr0.update({
  older: items[-1]['promoted'],
  filter: [:sfw, :nsfw, :nsfl]
})



