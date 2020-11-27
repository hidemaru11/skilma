require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :validation_helpers

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
 
    { 
      large:  magick.resize_to_limit!(800, 800),
      medium: magick.resize_to_limit!(500, 500),
      small:  magick.resize_to_limit!(300, 300),
    }
  end

  Attacher.validate do
    validate_max_size 5 * 1024 * 1024, message: '5MBを超える画像はアップロードできません。'
    validate_mime_type_inclusion %w(image/jpeg image/png)
  end
end