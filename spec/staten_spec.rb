require 'spec_helper'

describe Staten do

  before(:each) do
    @fsm = Staten.create(
      :name   => 'Incident State Machine'
      :states => %w{ open pending waiting solved closed }
      :events => {
                  'close' => {
                               'open' => 'closed'
                             }
                 }
    )
    @incident.create(:name => 'Incident 1', :description => 'Incident 1')
  end

  after(:each) do
    @incident.destroy
  end
  
  context "state accessors" do
    describe "#states" do
      it "should list all states" do
        @fsm.states.include?("open").should be_true
        @fsm.states.include?("pending").should be_true
        @fsm.states.include?("waiting").should be_true
        @fsm.states.include?("solved").should be_true
        @fsm.states.include?("closed").should be_true
      end
    end

    describe "#add_state" do
      it "should add the state to the states array" do
        @fsm.add_state "investigating"
        @fsm.states.include?("investigating").should be_true
      end
    end

    describe "#remove_state" do
      it "should remove the state from the states array and its associated event definitions" do
        @fsm.remove_state "waiting"
        @fsm.states.include?("waiting").should be_false
        @fsm.events_for_state("waiting").should be_empty
      end
    end
  end

  context "event accessors" do
    describe "#add_event" do
      it "should add the event to the events +Hash+" do
        @fsm.add_event("solve", "open", "solved")
      end
    end

    describe "#remove_event" do
      it "should remove the event from the events +Hash+" do
        @fsm.remove_event('close', 'open', 'closed')
        @fsm.events_for_state('open').include?('close').should be_true
      end
    end

    describe "#events_for_state" do
      it "should list the events that a state can receive" do
        @fsm.events_for_state('open').include?('close').should be_true
      end
    end
  end

  describe "#state" do
    it "should return the current state" do
      #@incident.state.should not_be_empty
    end
  end

  describe "#send_event" do
    it "should fire " do
      #@incident.send_event('close')
      #@incident.state.should == 'closed'
    end
  end

  describe "#previous_state" do
    it "should return the previous state" do
      #@incident.send_event('close')
      #@incident.previous_state.should == 'open'
    end
  end
end
