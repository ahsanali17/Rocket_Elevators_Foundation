require 'streamer' 

RSpec.describe ElevatorMedia::Streamer, "#" do 
    
    context "with no strikes or spares" do                                                                            
        it "sums the pin count for each roll" do                                                                        
            streamer = ElevatorMedia::Streamer.new
            expect(streamer.getContent).to eq "okay"                                                                               
        end                                                                                                             
    end                                                                                                               
end  