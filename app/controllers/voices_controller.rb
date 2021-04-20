require 'excon'

class VoicesController < ApplicationController
  include VoicesHelper

  def index
    @files =
      Dir['public/uploads/voice/*.wav'].select { |f| File.file? f }.map do |f|
        File.basename f
      end
    @profiles = ProfileId.all
  end

  def speech_transcription; end

  def enroll_new_profile
    file_name = params[:file_name]
    profile_id = params[:profile_id]
    enrolled_profile = enroll_profile(file_name, profile_id)
    p = ProfileId.new
    p.profile_id = profile_id
    p.user_name = "#{file_name} - #{current_user.custom_label_method}"
    p.save!
    respond_to { |r| r.json { render json: enrolled_profile } }
  end

  def create_profile_id
    new_profile = createProfileId
    respond_to { |r| r.json { render json: new_profile } }
  end

  def verify_audio
    file_name = params[:file_name]
    profile_id = params[:profile_id]
    response = verify_audio_file(profile_id, file_name)
    respond_to { |r| r.json { render json: response.body } }
  end

  def upload_audio
    uploaded_file = params[:file]
    FileUtils.mkdir_p 'public/uploads/voice'
    File.open(
      Rails.root.join(
        'public',
        'uploads',
        'voice',
        uploaded_file.original_filename
      ),
      'wb'
    ) { |file| file.write(uploaded_file.read) }
  end
end
