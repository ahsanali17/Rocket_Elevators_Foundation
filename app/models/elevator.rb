class Elevator < ApplicationRecord
    belongs_to :column
    before_save :twilio_txt

    #if the elevator status change to Intervention, you'll receive a text message
    def twilio_txt
        notify = self.status_changed?
        if notify 
            if self.status == "Intervention" or self.status == "intervention" then
                account_sid = ENV['TWILIO_ACCOUNT_SID']
                auth_token = ENV['TWILIO_AUTH_TOKEN']
                #phone_to = self.column.battery.building.technical_contact_phone_for_the_building
                @client = Twilio::REST::Client.new(account_sid, auth_token)    
                
                message = @client.messages.create(
                    body: "Hello Mr/Mrs #{self.column.battery.building.full_name_of_the_technical_contact_for_the_building}. The Elevator ID: #{self.id}, with Serial Number: #{self.serial_number} requires maintenance, the elevators status has been changed to: #{self.status}",
                    # Cristiane numbers:
                    # from: '+16106869129',
                    # to: '+14184469990'
                    # Kaelen numbers:
                    from: '+12248582267',
                    to: '+13062407737'
                ) 
            end           
        end        
    end

    before_update :notify_slack, on: :update

    private
        def notify_slack
            notify = self.status_changed?
            if notify 
                notifier = Slack::Notifier.new ENV["SLACK_API"]
                notifier.ping "The Elevator: #{self.id} with Serial Number: #{self.serial_number} changed status from *'#{self.status_was}'* to *'#{self.status}'*."
            end
        end

end
