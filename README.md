# PlainService

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'plain_service'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plain_service

## Why?

To keep your controller and model thin.

## Usage

Example (simple password change service):

1. Define your service: 
  
  ```ruby
  # app/services/user_service/change_password
  
  module UserService
    class ChangePassword
      attribute :user  
      attribute :password  
      attribute :password_confirmation
        
      validates :password, presence: true, confirmation: true
      
      def process
        user.password = password
        user.save
      end
    end
  end
  ```
2. Use it in your controller:

  ```ruby
  def change_password
    change_password = UserService::ChangePassword.new(params)
    change_password.user = current_user
    
    # you can also call UserService::ChangePassword.perform(params) as shortcut
    
    if change_password.perform
      render #good response
    else
      render #bad response, see change_password.error to get standard rails Errors object
    end
  end
  ```

Advantages of such approach: 
1. Simple and readable controller code. All action-related logic will be in service object.
2. Validations that are related with specific action also hidden in service to keep model clean and easy to use.
3. Easy to test. No callback hell, just plain ruby object.
  
# Passing errors from model to service

Sometimes you want to have some specific model errors in service object. For example you are saving model with uniqueness validation on some field. Then you can do the following:

```ruby
def process
 if user.save
   true
 else
   pass_errors_from user
   false
 end
end

# usage
service.perform
service.errors # => will include all errors from user object 
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
