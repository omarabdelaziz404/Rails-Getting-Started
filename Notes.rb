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
    - add a presence validation to the Product model 
    - to ensure that all products must have a name
    # app/models/product.rb
    class Product < ApplicationRecord
        validates :name, presence: true
    end
    > reload! #manually refresh the console
    > product.errors
    > product.errors.full_messages

8. A Request Journey Through Rails:
    - Routes = rules written in a Ruby DSL.
    - Controllers = Ruby classes.
    - Controller public methods = actions.
    - views = templates.

10. Controllers & Actions:
    $ bin/rails generate controller Products index --skip-routes # This command generates files for our controller
10.1. Making Requests:
    # config/routes.rb
    Rails.application.routes.draw do
        root "products#index" # We tell Rails the root route should render the Products index action
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

13. Rich Text Fields with Action Text:
    $ bin/rails action_text:install
    $ bundle install
    $ bin/rails db:migrate

16.1. Basic Inventory Tracking:
    $ bin/rails generate migration AddInventoryCountToProducts inventory_count:integer
    # db/migrate/<timestamp>_add_inventory_count_to_products.rb
    add_column :products, :inventory_count, :integer, default: 0
    $ bin/rails db:migrate

16.2. Adding Subscribers to Products
    $ bin/rails generate model Subscriber product:belongs_to email
    # product:belongs_to >> subscribers and products have a one-to-many relationship
    $ bin/rails db:migrate

16.3. In Stock Email Notifications:
    $ bin/rails g mailer Product in_stock # generates ProductMailer class + two email templates in our views folder(HTML - TEXT)

17.1. Propshaft:
    1. What is an Asset Pipeline?
    - The Rails Asset Pipeline is a library designed for organizing, caching, and serving static assets, such as JavaScript, CSS, and image files. 
    - It streamlines and optimizes the management of these assets to enhance the performance and maintainability of the application.
    - The Rails Asset Pipeline is managed by Propshaft. 
    
    2. Propshaft Features:
        2.1. Asset Load Order:
        manage file loading order manually by explicitly including files in the correct sequence within your HTML or layout files. 
        This ensures proper dependency handling without automated tools, relying instead on careful organization and inclusion.
        strategies for managing dependencies:
        1. Manually include assets in the correct order
        2. Use Modules in JavaScript (ES6)
        3. Combine Files when necessary
        4. Bundle your JavaScript or CSS using a bundler

        2.2. Asset Organization:
        - Propshaft stores assets in the app/assets directory, including folders like images, javascripts, and stylesheets.
        - It manages these files during the precompilation process.
        - Additional asset paths can be added by updating config.assets.paths in config/initializers/assets.rb.
        - Propshaft serves all assets from the configured paths.
        - During precompilation, assets are copied to the public/assets directory for production use.
        - Assets are referenced using helpers such as asset_path, image_tag, and javascript_include_tag.
        - After running assets:precompile, logical paths are automatically replaced with fingerprinted paths using the .manifest.json file.
        - Certain directories can be excluded from this process.

        2.3. Fingerprinting:
        - A technique that makes the name of a file dependent on its content.
        - Fingerprinting appends a digest (unique hash) to filenames, e.g. styles.css → styles-a1b2c3.css, ensuring browsers always fetch updated versions.
        2.3.1. Asset Digesting:
        - All assets from configured paths are copied to public/assets.
        - Fingerprinting renames files based on content to force browsers to load new versions when assets change.
        2.3.2. Manifest Files:
        - .manifest.json file is automatically generated during the asset precompilation process.
        - file maps original asset filenames to their fingerprinted versions.
        2.3.3. Digested Assets in Views:
        - Use Rails helpers to reference CSS, JS, and images.
        - Propshaft automatically replaces file names with fingerprinted ones for cache-busting
        - Turbo can auto-reload assets when updated.
        - CSS URLs and nested image paths are handled automatically.
        2.3.4. Digested Assets in JavaScript:
        - In JavaScript, you need to manually trigger the asset transformation using the RAILS_ASSET_URL macro.
        2.3.5. Bypassing the Digest Step:
        - To avoid re-digesting files that reference each other (e.g. JS + source maps), you can pre-digest manually.
        2.3.6. Excluding Directories from Digestion:
        - You can exclude folders from digestion by setting: config.assets.excluded_paths = [Rails.root.join("app/assets/stylesheets")]

    3.2. Development:
        3.2.1 No caching:
        - Rails skips asset caching in development.
        - Always serves the latest version of files (CSS, JS, images).
        - No need for versioning or cache clearing.
        3.2.2 Automatic reloading:
        - Propshaft automatically detects changes to assets.
        - Updates appear after a simple browser reload — no server restart needed.
        - Propshaft serves the newest compiled files.
        - Run both with ./bin/dev.
        3.2.3 File watchers for better performance:
        - Propshaft checks for asset updates before every request.
        - Reduces overhead and improves performance during development.

    3.3.2. Precompiling Assets:
        $ RAILS_ENV=production rails assets:precompile
        $ RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 rails assets:precompile

    4. Sprockets to Propshaft:
        4.1.1 Transpilation:
        - is the process of converting code from one language or syntax to another, like turning TypeScript into JavaScript. 
        - but modern CSS and JS features make it less necessary today.
        4.1.2 Bundling:
        - merges multiple files into one to reduce HTTP requests, which helped when browsers could only load a few files at a time (HTTP/1.1). 
        - With HTTP/2, browsers can fetch multiple files in parallel, so bundling is less critical.
        4.1.3 Compression: 
        - reduces the file size (like Gzip) to speed up delivery. 
        - While still useful, CDNs now often handle compression automatically, so manual compression isn’t always needed.

        4.3. Migration Steps:
        $ bundle remove sprockets
        $ bundle remove sprockets-rails
        $ bundle remove sass-rails