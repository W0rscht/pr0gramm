# pr0gramm

A Ruby interface to the pr0gramm.com API.

## Installation

The pr0gramm.com API client can be installed using Rubygems or Bundler.

### Rubygems

```sh
gem install pr0gramm
```

### Bundler

Add it to your Gemfile

    gem "pr0gramm"

and follow normal [Bundler](http://gembundler.com/) installation and execution procedures.

## Usage

```ruby
pr0 = Pr0gramm.new(username: 'RubyPr0gramm', password: 'RubyPr0gramm')
pr0 = Pr0gramm.new()
```

### User Profile

```ruby
profile = pr0.profile
profile = pr0.profile('cha0s')
```

### Upload

```ruby
id = pr0.upload('/9gag/meme.jpeg', :sfw, ['lol', 'rofl', 'xD', 'da mal ...', 'b100'])
```

### Private Messaging

```ruby
pr0.private_message('W0rscht', 'Hi W0rscht, thanks for coding me :)')
```

```ruby
messages = pr0.inbox # or pr0.inbox(:all)
messages = pr0.inbox(:unread)
messages = pr0.inbox(:messages)

messages.first.reply('pssst')
```

### Item Handling

```ruby
items = pr0.items # or pr0.items(promoted: true, tags: [:nsfw])

items = pr0.items(promoted: false)

items = pr0.items(flags: [:sfw, :nsfw])

items = pr0.items(tags: 'Rüdiger')


items = pr0.items(following: true)
items = pr0.following
```

```ruby

items = pr0.items(tags: 'Rüdiger')

items.each { |item|

  image = item.image

  item.save_image
  item.save_image('/tmp/')
  item.save_image('/tmp/Ruediger.jpg')

  thumb = item.thumb

  item.save_thumb
  item.save_thumb('/tmp/')
  item.save_thumb('/tmp/Ruediger_t.jpg')

  fullsize = item.fullsize

  item.save_fullsize
  item.save_fullsize('/tmp/')
  item.save_fullsize('/tmp/Ruediger_t.jpg')


  item.up
  item.down
  item.fav
  item.unfav

  item.vote(1)
  item.vote(-1)
  item.vote(2)
  item.vote(1)


  item.comment('Schöner Fogel')


  item.tag(['Rüdiger', 'Kackvogel'])
}
```

#### Item Information (Tags and Comments)

```ruby
item_info = pr0.item_info(879293)

comments = item_info[:comments]

tags = item_info[:tags]
tag  = tags.first
tag.up
tag.down
tag.vote(1)
tag.vote(-1)
```

### Account Settings

```ruby
user = pr0.user

pr0.request_email_change('cha0s@pr0gramm.com')

pr0.invite('harterhund@web.de')


pr0.settings_site(likes_are_public: false, user_status: 'Edler Spender') # user_status: 'Schwuchtel' / 'Neuschwuchtel'
```

### Flags

```ruby
digit = Pr0gramm::Flags.digit( [:sfw] )
digit = Pr0gramm::Flags.digit( [:nsfw] )
digit = Pr0gramm::Flags.digit( [:sfw, :nsfw] )
digit = Pr0gramm::Flags.digit( [:nsfl] )
digit = Pr0gramm::Flags.digit( [:sfw, :nsfl] )
digit = Pr0gramm::Flags.digit( [:nsfw, :nsfl] )
digit = Pr0gramm::Flags.digit( [:sfw, :nsfw, :nsfl] )


array = Pr0gramm::Flags.array(1)
array = Pr0gramm::Flags.array(2)
array = Pr0gramm::Flags.array(3)
array = Pr0gramm::Flags.array(4)
array = Pr0gramm::Flags.array(5)
array = Pr0gramm::Flags.array(6)
array = Pr0gramm::Flags.array(7)


symbol = Pr0gramm::Flags.symbol(1)
symbol = Pr0gramm::Flags.symbol(2)
symbol = Pr0gramm::Flags.symbol(4)
```

### Marker

```ruby
digit = Pr0gramm::Mark.digit( 'Schwuchtel' )
digit = Pr0gramm::Mark.digit( 'Neuschwuchtel' )
digit = Pr0gramm::Mark.digit( 'Altschwuchtel' )
digit = Pr0gramm::Mark.digit( 'Admin' )
digit = Pr0gramm::Mark.digit( 'Gesperrt' )
digit = Pr0gramm::Mark.digit( 'Moderator' )
digit = Pr0gramm::Mark.digit( 'Fliesentischbesitzer' )
digit = Pr0gramm::Mark.digit( 'Lebende Legende' )
digit = Pr0gramm::Mark.digit( 'pr0wichtler' )
digit = Pr0gramm::Mark.digit( 'Edler Spender' )

string = Pr0gramm::Mark.string( 0 )
string = Pr0gramm::Mark.string( 1 )
string = Pr0gramm::Mark.string( 2 )
string = Pr0gramm::Mark.string( 3 )
string = Pr0gramm::Mark.string( 4 )
string = Pr0gramm::Mark.string( 5 )
string = Pr0gramm::Mark.string( 6 )
string = Pr0gramm::Mark.string( 7 )
string = Pr0gramm::Mark.string( 8 )
string = Pr0gramm::Mark.string( 9 )
```

## Tests

To run the tests export the following two variables:

```bash
export PR0_USERNAME='...'
export PR0_PASSWORD='...'
```

After that run tests via rake:

```
rake test
```

Attentiont: Some tests will fail caused by usage of special API test user.

## TODO

- documentation
- moar tests
- Proper session handling
- "pp" cookie?!
- Make use of REST::Clients cookie_jar method
- Refactoring of Item handling / searches
- Refactoring of Item Information handling (Tags / Comments)
- Refactoring of Comment handling in inbox result