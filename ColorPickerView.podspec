#
# Be sure to run `pod lib lint ColorPickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ColorPickerView"
  s.version          = "0.1.0"
  s.summary          = "You can easily create a color picker with an original image."

  s.description      = <<-DESC
You can easily create a color picker with an original image on interface builder.
                       DESC

  s.homepage         = "https://github.com/malt03/ColorPickerView"
  s.license          = 'MIT'
  s.author           = { "Koji Murata" => "malt.koji@gmail.com" }
  s.source           = { :git => "https://github.com/malt03/ColorPickerView.git", :tag => s.version.to_s }

  s.xcconfig         = { 'CLANG_MODULES_AUTOLINK' => 'YES' }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ColorPickerView' => ['Pod/Assets/*.png']
  }

  s.dependency 'ImageColorPicker'
end
