class InterventionsController < ApplicationController
  # POST /quotes or /quotes.json
  def create
    #===================================================================================================
    # DECLARING VARIABLES  
    #===================================================================================================
    @interventions = Intervention.new(intervention_params)
    @interventions.battery = params["battery"]
    @interventions.building = params["building"]
    @interventions.column = params["column"]
    @interventions.customer = params["customer"]
    @interventions.elevator = params["elevator"]
    @interventions.employee = params["employee"]

    #===================================================================================================
    # SAVE AND REDIRECT
    #===================================================================================================
    @interventions.save

    if @interventions.save!
      # Redirect back to page
      redirect_back fallback_location: root_path, notice: "Intervention sucessfull"
    end 
    #===================================================================================================
    # PRINTS PARAMS INTO TERMINAL WINDOW
    #===================================================================================================
    puts "===========START================"
    puts params
    puts "=============END================"
  end    


  # Only allow a list of trusted parameters through.
  def intervention_params
    #===================================================================================================
    # CAPTURES DATA FROM SUBMITTED FORMS
    #===================================================================================================
    params.fetch(:interventions, {})
  end
end
