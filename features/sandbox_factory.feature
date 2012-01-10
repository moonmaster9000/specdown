Feature: Specdown::SandboxFactory

  All of your tests run in a sandbox - a protected object namespace, configurable via a simple API.
  
  For example, let's imagine we've written an assertion library called `SimpleAssert`:

      module SimpleAssert
        def simple_assert(&block) 
          raise "failed!" if block.call == false
        end
      end

  We can configure Specdown to include our library in the sandbox via the `Specdown::SandboxFactory.decorate` API:
      
      Specdown::SandboxFactory.decorate do |sandbox|
        sandbox.extend SimpleAssert
      end

  Now all sandboxes will respond to the `simple_assert` method. We could even make this configurable:

      Specdown::SandboxFactory.decorate do |sandbox|
        if Specdown::Config.expectations == :simple_assert
          sandbox.extend SimpleAssert
        end
      end

  Now you could add `Specdown::Config.expectations = :simple_assert` to your `specdown/support/env.rb` to use your own SimpleAssert library in your tests.

  
  Scenario: decorate sandbox with module 
    
    Given the following module:
      """
        module SimpleAssert
          def simple_assert(&block) 
            raise "failed!" if block.call == false
          end
        end
      """

    When I decorate the sandbox with it:
      """
        Specdown::SandboxFactory.decorate do |sandbox|
          sandbox.extend SimpleAssert
        end
      """
    
    Then all sandboxes should include my module methods:
      """
        proc { 
          Specdown::SandboxFactory.generate.instance_eval do
            simple_assert { 1 == 1 }
          end
        }.should_not raise_exception
      """
