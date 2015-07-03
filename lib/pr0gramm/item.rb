class Pr0gramm

  class Item

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
