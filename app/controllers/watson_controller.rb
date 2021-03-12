require "json"
require "ibm_watson"
require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson


class WatsonController < ActionController::Base
    skip_before_action :verify_authenticity_token

  
    def speak
  
        authenticator = Authenticators::IamAuthenticator.new(
            apikey: ENV["TEXT_TO_SPEECH_APIKEY"]
        )
        text_to_speech = TextToSpeechV1.new(
            authenticator: authenticator
        )
        text_to_speech.service_url = "https://api.us-south.text-to-speech.watson.cloud.ibm.com/instances/b0629bf8-7de7-4d25-831f-39083fe5af36"
            
        message = "Greetings user #{current_user.id}"

        response = text_to_speech.synthesize(
            text: message,
            accept: "audio/wav",
            voice: "en-GB_KateV3Voice"
        ).result

        File.open("#{Rails.root}/public/hello_world.wav", "wb") do |audio_file|
                        audio_file.write(response)
        end 
           
    end
end

