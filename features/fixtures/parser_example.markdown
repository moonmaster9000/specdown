# Specdown Example

This is an example specdown file.

## Child Node

This section is a child node. It contains some ruby code: 
    
```ruby
"simple code".should_not be(nil)
```

### First Leaf

This section has a failure simulation:
    
```ruby
raise "specdown error simulation!"
```

## Last Leaf

This section is a leaf node. It contains some ruby code:

```ruby
1.should satisfy(&:odd?)
```
