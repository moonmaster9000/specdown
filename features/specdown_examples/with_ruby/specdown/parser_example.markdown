# Specdown Example

This is an example specdown file.

## Child Node

This section is a child node. It contains some ruby code: 
    
    "simple code".should_not be(nil)

### First Leaf

This section has a failure simulation:
    
    raise "specdown error simulation!"

## Last Leaf

This section is a leaf node. It contains some ruby code:
    
    1.should satisfy(&:odd?)

