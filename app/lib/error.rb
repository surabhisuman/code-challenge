class Error < StandardError
  attr_reader :message, :trace

  def initialize(message: "Request can't be fulfilled currently.")
    @message = message
    @backtrace = caller
  end

  class InvalidZipCodeError < Error
  end
end