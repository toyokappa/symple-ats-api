# frozen_string_literal: true

class LowerCamelTransformer < Blueprinter::Transformer
  def transform(hash, _object, _options)
    hash.transform_keys! {|key| key.to_s.camelize(:lower).to_sym }
  end
end

Blueprinter.configure do |config|
  config.sort_fields_by = :definition
  config.default_transformers = [LowerCamelTransformer]
end
