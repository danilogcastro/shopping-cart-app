module CookieSigner
  def sign_cookie(name, value)
    key_generator = ActiveSupport::KeyGenerator.new(Rails.application.secret_key_base, iterations: 1000)
    secret = key_generator.generate_key('signed cookie')

    verifier = ActiveSupport::MessageVerifier.new(secret, digest: "SHA1")

    "#{name}=#{verifier.generate(value)}"
  end
end

RSpec.configure do |config|
  config.include CookieSigner, type: :request
end