class LeadsController < ApplicationController
    
    
    def sendGrid_email_sender
        require 'sendgrid-ruby'
        # include SendGrid
        from = SendGrid::Email.new(email: 'ahsantime1@gmail.com')
        to = SendGrid::Email.new(email: 'ahsantime1@gmail.com')
        subject = 'Sending with SendGrid is Fun'
        content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
        mail = SendGrid::Mail.new(from, subject, to, content)
        sg = SendGrid::API.new(api_key:'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')
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        puts response.status_code
        puts response.body
        puts response.headers

    end

    # POST /quotes or /quotes.json
    def create
        
        @lead = Lead.new(lead_params)
        
     #===================================================================================================
     # DECLARING VARIABLES  
     #===================================================================================================
        attachment = params["attachment"]
        #@lead.file_name = attachment
     
     #===================================================================================================
     # SAVER  
     #===================================================================================================
        @lead.save

     #===================================================================================================
     # PRINTS PARAMS INTO TERMINAL WINDOW
     #===================================================================================================
        puts "===========START================"
        puts params
        puts "=============END================"

     #===================================================================================================
     # FORM SUBMISSION & FILE ATTACHMENT LOGIC (converts into binary code, submission alert, redirecting, rendering, errors) 
     #===================================================================================================
        if attachment != nil
            @lead.attachment = attachment.read
            @lead.file_name = attachment.original_filename
        end  
        
        if @lead.save!
            # Redirect back
            redirect_back fallback_location: root_path, notice: "Your Request was successfully created and sent!"
            
            # Sender
            sendGrid_email_sender()
        end    
    end    
     #===================================================================================================
     # DEFINING @lead = Lead.new(lead_params) BELOW:
     #===================================================================================================

     # Only allow a list of trusted parameters through.
    def lead_params
        params.required(:leads).permit!
    end
end