module ApiExceptions 
  class ApiExceptionError < RuntimeError; end

  class BadRequest < ApiExceptionError; end
end
