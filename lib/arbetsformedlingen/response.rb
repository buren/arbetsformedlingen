module Arbetsformedlingen
  class Response
    attr_reader :code, :messages, :boby, :request_boby

    def initialize(httparty_response, request_boby)
      @code = httparty_response.code
      @body = httparty_response.body
      @request_body = request_body
      @valid = @code == 202
      @messages = build_messages(httparty_response.to_a)
    end

    def valid?
      @valid
    end

    private

    def build_messages(messages)
      messages.map do |message|
        # HTTParty returns an array if there is only one key-value pair in the response
        # so we need to check for it here and normalize
        if message.is_a?(Array)
          { message: message.last, error_code: nil }
        else
          error_code = message['ErrorCode']
          @valid = false if error_code

          { message: message['Message'], error_code: error_code }
        end
      end
    end
  end
end
