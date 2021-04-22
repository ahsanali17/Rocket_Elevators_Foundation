require 'excon'

module VoicesHelper
  def verify_audio_file(profile_id, file_name)
    file = File.open("public/uploads/voice/#{file_name}")
    endpoint =
      "https://westus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles#{
        profile_id
      }/verify"

    begin
      connection =
        Excon.new(endpoint, debug_request: true, debug_response: true)
      connection.request(
        # interval is in seconds, this will block the client so leaving the limit and interval low
        method: 'POST',
        idempotent: true,
        expects: [200, 201],
        retry_limit: 2,
        retry_interval: 0.5,
        body: file,
        headers: {
          'Content-Type' => 'audio/wave',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        instrumentor: ActiveSupport::Notifications
      ) # ActiveSupport::Notifications is for logging of requests and responses
    rescue Excon::Error => e
      puts "Error: #{e}"
    end
  end

  def createProfileId
    response =
      Excon.post(
        'https://westus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles',
        headers: {
          'Content-Type' => 'application/json',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: JSON.generate("locale": 'en-us')
      )

    return response.body
  rescue Excon::Error => e
    puts "Error: #{e}"
  end

  def enroll_profile(file_name, profile_id)
    file = File.open("public/uploads/voice/#{file_name}")
    endpoint =
      "https://westus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles#{
        profile_id
      }/enrollments"

    begin
      response =
        Excon.post(
          endpoint,
          debug_request: true,
          debug_response: true,
          headers: {
            'Content-Type' => 'audio/wave',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
          },
          body: file,
          instrumentor: ActiveSupport::Notifications
        )
      return response.body
    rescue Excon::Error => e
      puts "Error: #{e}"
    end
  end

  def getProfiles
    response =
      Excon.get(
        'https://westus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles',
        headers: {
          'Content-Type' => 'application/json',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: JSON.generate("locale": 'en-us')
      )
    parsed = JSON.parse(response.body)
    return parsed['profiles']
  rescue Excon::Error => e
    puts "Error: #{e}"
  end
end
