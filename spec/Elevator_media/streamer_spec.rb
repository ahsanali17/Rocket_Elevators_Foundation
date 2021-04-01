require 'streamer' 
# require './spec/Elevator_media/streamer_spec.rb' 

RSpec.describe ElevatorMedia::Streamer do 
    describe ".getContent" do
        context "information about covid-19 in Canada" do                                                                            
            it "will return a string" do                                                                        
                # streamer = ElevatorMedia::Streamer.new
                # expect(streamer.getContent).to eq "okay"  
                expect(ElevatorMedia::Streamer.getContent("Canada")).to be_an_instance_of(String)
            end 
            it "will return output as html" do
                expect(ElevatorMedia::Streamer.getContent("Canada")).to start_with("<div>")
            end
            # it "will return info about another country like Turkey" do 
            #     expect(ElevatorMedia::Streamer.getContent("Turkey")).to eq("<div>Turkey</div>")
            # end

        end                                                                                                               
    end
end  