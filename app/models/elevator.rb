class Elevator < ApplicationRecord
    belongs_to :column

    before_update :notify_slack, on: :update

    private
        def notify_slack
            notify = self.status_changed?
            if notify 
                notifier = Slack::Notifier.new ENV["SLACK_API"]
                notifier.ping "The Elevator '#{self.id}' with Serial Number '#{self.serial_number}' changed status from '#{self.status_was}' to '#{self.status}'."
            end
        end

end
