module Adhoq
  module AuthorizationMethods
    extend ActiveSupport::Concern

    included do |controller|
      controller.before_filter Authorizer.new

      helper_method :adhoq_current_user
      hide_action   :adhoq_current_user
    end

    class Authorizer
      def before(controller)
        return true if authorization.call(controller)

        if failure = Adhoq.config.authorization_failure_action
          failure.call(controller)
        else
          controller.send(:render, text: 'No such file or directory', status: :not_found)
        end
      end

      private

      def authorization
        @authorization ||= Adhoq.config.callablize(:authorization)
      end
    end

    def adhoq_current_user
      @_adhoq_current_user_proc ||= Adhoq.config.callablize(:current_user)

      @_adhoq_current_user_proc.call(self)
    end
  end
end
