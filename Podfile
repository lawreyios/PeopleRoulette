platform :ios, '11.0'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
    pod 'ObjectMapper'
end

target 'PeopleRoulette' do
  use_frameworks!

  pod 'RealmSwift'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'ObjectMapper'
  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'ObjectMapper+Realm'
  pod 'ObjectMapperAdditions/Realm'

  target 'PeopleRouletteTests' do
      testing_pods
  end

end
