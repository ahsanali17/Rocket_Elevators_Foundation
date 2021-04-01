require 'streamer' 
RSpec.describe ElevatorMedia::Streamer do 
    describe ".getContent" do
        context "information about covid-19 in , Quebec" do                                                                            
            it "will return a string" do                                                                        
                expect(ElevatorMedia::Streamer.getContent("Quebec")).to be_an_instance_of(String)
            end 
            it "will return output as html" do
                expect(ElevatorMedia::Streamer.getContent("Quebec")).to start_with("<div>")
            end
        end                                                                                                               
    end
end  