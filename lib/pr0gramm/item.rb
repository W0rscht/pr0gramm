class Pr0gramm

  class Item

    attr_reader :id, :promoted, :up, :down, :created, :image,
                :thumb, :fullsize, :source, :flags, :user, :mark

    def initialize(item_data)

      @id       = item_data['id']
      @promoted = item_data['promoted']
      @up       = item_data['up']
      @down     = item_data['down']
      @created  = Time.at( item_data['user']['registered'] ).to_datetime
      @image    = item_data['image']
      @thumb    = item_data['thumb']
      @fullsize = item_data['fullsize']
      @source   = item_data['source']
      @flags    = item_data['flags']
      @user     = item_data['user']
      @mark     = item_data['mark']
    end
  end
end
