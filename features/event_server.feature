Feature: Specdown::EventServer

  The Specdown::EventServer receives events and triggers callbacks.

  For example, to send an event to the EventServer, simply give the event a name, then pass any number of arguments after that:

      Specdown::EventServer.event "test passed"

  You can also register callbacks for events using the `register` method:
      
      Specdown::EventServer.register "test passed" do
        print "."
      end

  
  Scenario: Submitting an event triggers all registered callbacks for that event
      
    Given a USA population of zero:
      """
        @usa_population   = 0
      """
    And a world population of 10:
      """
        @world_population = 10
      """
    And I register callbacks to increment both whenever someone is born:
      """
        Specdown::EventServer.register("birth") {|num_births| @usa_population += num_births   }
        Specdown::EventServer.register("birth") {|num_births| @world_population += num_births }
      """
    When I create a "birth" event:
      """
        Specdown::EventServer.event "birth", 3
      """
    Then both the USA population and the World population should increase:
      """
        @usa_population.should == 3
        @world_population.should == 13
      """
