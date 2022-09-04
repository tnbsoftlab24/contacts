module Payments
  module PaymentsHelper
    def show_due
      current_account.contractor? && controller.class == Payments::PaymentsController
    end

    def payments_filter_statuses
      if current_account.contractor?
        if controller_name == 'invoices'
          ::Payments::Invoice.statuses
        else
          ::Payments::Payout.statuses
        end
      else
        ::Payments::Invoice.statuses.each_with_object({}) do |(k, v), hash|
          hash[k.humanize] = v
        end
      end
    end

    def payments_filter_types
      if current_account.client?
        [['Invoice', ::Payments::Invoice.name], ['Subscription fee', ::Payments::SubscriptionFee.name]]
      else
        if controller_name == 'invoices'
          [['Invoice', ::Payments::Invoice.name]]
        else
          [['Payout', ::Payments::Payout.name]]
        end
      end
    end
  end
end
