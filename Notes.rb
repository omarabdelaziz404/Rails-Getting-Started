1. Creating a New Rails App:
    $ rails new projectName
    $ cd projectName

2. creating database:
    $ bin/rails db:create
    $ bin/rails server #runs server

3. Creating a Database Model:
    $ bin/rails generate model Product name:string
    $ bin/rails db:migrate

4. Rails Console:
    $ bin/rails console
    > Product.column_names
4.1. Creating Records
    > product = Product.new(name: "T-Shirt")
    > product.save
    > Product.create(name: "Pants") #new + save in one line
    > product //print product
4.2. Querying Records
    > Product.all
    > Product.where(name: "Pants")
    > Product.order(name: :asc) #sort records by name in ascending alphabetical order
    > Product.find(1)
4.5. Updating Records
    > product = Product.find(1)
    > product.update(name: "Shoes")

    > product = Product.find(1)
    > product.name = "T-Shirt"
    > product.save
4.6. Deleting Records
    > product.destroy
4.7. Validations
    add a presence validation to the Product model 
    to ensure that all products must have a name
    # app/models/product.rb
    class Product < ApplicationRecord
        validates :name, presence: true
    end
    > reload! #manually refresh the console
    > product.errors
    > product.errors.full_messages

8. A Request Journey Through Rails:
    Routes = rules written in a Ruby DSL.
    Controllers = Ruby classes.
    Controller public methods = actions.
    views = templates.

10. Controllers & Actions:
    $ bin/rails generate controller Products index --skip-routes 
    #This command generates files for our controller
10.1. Making Requests:
    # config/routes.rb
    Rails.application.routes.draw do
        root "products#index" #we tell Rails the root route should render the Products index action
    end
10.2. Instance Variables  
    # app/controllers/products_controller.rb
    def show
        @product = Product.find(params[:id])
    end

11. Adding Authentication:
    $ bin/rails generate authentication
    $ bin/rails db:migrate
    $ bin/rails console
    > User.create! email_address: "you@example.org", password: "s3cr3t", password_confirmation: "s3cr3t"

11.1. Adding Log Out:
    # app/views/layouts/application.html.erb 
    <body>
        <nav>
        <%= link_to "Home", root_path %>
        <%= button_to "Log out", session_path, method: :delete if authenticated? %>
        </nav>

        <main>
        <%= yield %>
        </main>
    </body>
    
11.3. Showing Links for Authenticated Users Only:
    # app/views/products/index.html.erb
    <%= link_to "New product", new_product_path if authenticated? %>
    <%= link_to "Login", new_session_path unless authenticated? %>
