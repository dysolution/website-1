# This cancels a payment within Stripe, and makes a record
# within our database.
module Donations
  class Subscription
    class Cancel
      include Mandate

      initialize_with :subscription

      def call
        begin
          Stripe::Subscription.delete(subscription.stripe_id)
        rescue Stripe::InvalidRequestError
          data = Stripe::Subscription.retrieve(subscription.stripe_id)

          # Raise if we failed to cancel an active subscription
          raise if data.status == 'active'
        end

        subscription.update!(active: false)

        # Update based on whether there is another different active subscription
        user = subscription.user
        user.update!(active_donation_subscription: user.donation_subscriptions.active.exists?)
      end
    end
  end
end
