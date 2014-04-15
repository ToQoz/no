# NO

Support creating null object in Ruby. NO::NullObject basically bahaves as nil.

1. NO::NullObject basically delegates to nil.
2. if nil doesn't respond to a method, NO::NullObject returns nil.

If you want to customize, inherit NO::NullObject

## Installation

Add this line to your application's Gemfile:

```
gem 'no'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install no
```

## Usage

### Simple

```
def write(out = NO::NullObject.new, body)
  out.write body
end
```

### Custom

```
class User
  class Annonymous < NO::NullObject
    def name
      'annonymous'
    end
  end

  ANNONYMOUS = Annonymous.new

  attr_reader :name

  def initialize name
    @name = name
  end
end

class UserRepository
  class << self
    def users
      [User.new('Foo'), User.new('Bar'), User.new('Baz')]
    end

    def find id
      users[id] || User::ANNONYMOUS
    end
  end
end

UserRepository.find(3) #=> 'annonymous'
```

## Spec

```

NO::NullObject
  can expand by inheritance
  to_a
    should eq []
  to_c
    should eq (0+0i)
  to_f
    should eq 0.0
  to_h
    should eq {}
  to_i
    should eq 0
  to_r
    should eq (0/1)
  to_s
    should eq ""
  rationalize
    should eq (0/1)
  #&
    NO::NullObject & object
      should be false
  #^
    NO::NullObject ^ nil
      should eq false
    NO::NullObject ^ false
      should eq false
    NO::NullObject ^ NO::NullObject
      should eq false
    NO::NullObject ^ object(that is not nil, false or NO::NullObject)
      should eq true
  #|
    NO::NullObject | nil
      should eq false
    NO::NullObject | false
      should eq false
    NO::NullObject | NO::NullObject
      should eq false
    NO::NullObject | object(that is not nil, false or NO::NullObject)
      should eq true
  #==
    NO::NullObject == nil
      should be true
    NO::NullObject == NO::NullObject (Same instance)
      should be true
    NO::NullObject == NO::NullObject (Different instance)
      should be false
  #!
    should be true
  #nil?
    should be true
  methods that nil don't have
    should return nil
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/no/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
