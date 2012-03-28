# SprayPaint

This is the simplest possible implementation for tagging for
ActiveRecord. It does not do any of the fancy things that most of the
other tagging libraries (`acts-as-taggable-on`,
`acts_as_taggable_on_seroids`) do. It doesn't use any real stuff either.

It make this assumption: You want some records to have a `#tags`
attribute.

It's also more ruby friendly. Including modules is better than calling a
method to dynamically include another module then define methods. This
way, you can override and call `super`. What a thought right?

## Using

Using is simple:

```
$ bundle exec rake db:migrate SCOPE=spray_paint
```

```ruby
class DJ
  include SprayPaint::Tags
end

markus = DJ.new :name => "Markus Schulz"
markus.tags = %w(progressive melodic dark)
markus.save

armin = DJ.new :name => 'Armin van Buuren'
armin.tags = 'noob'
armin.save

# you can also set tags like this:

dj.tags << %w(style1 style2)
dj.tags = 'one-style'

# Finding tagged objects
# The 'tagged' scope works like a set. Find all the records
# who's tags contain these tags.

DJ.tagged('melodic', 'progressive')
```

That's all folks. It does nothing else.
