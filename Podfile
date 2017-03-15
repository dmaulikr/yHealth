platform :ios, '9.0'

def shared_pods
	pod 'Alamofire', '~>4.4'
	pod 'JTMaterialTransition', :git => 'https://github.com/jonathantribouharet/JTMaterialTransition.git'
end

target 'geia' do
  use_frameworks!

  # Pods for geia
	shared_pods

  target 'geiaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'geiaUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
