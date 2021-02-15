Terminal:

rails console sandbox mode:
rails c --sandbox
reload console: reload!

Generators:

rails g controller restaurants index create

Migrations:
add_column
change_column
rename_column
remove_column
add_reference

Validations:
class Restaurant < ApplicationRecord
    validates :name, presence: true
    validates :rating, presence: true, inclusion: { in: 1..5 }
    validates :address, presence: true
  end

  class Review < ApplicationRecord
    belongs_to :restaurant
    validates :content, presence: true, length: { minimum: 40, message: "content is waaaay too short" }
  end
  

-----------------Example Controller:-----------------

class GardensController < ApplicationController
  before_action :set_garden, only: [:show, :edit, :update, :destroy]

  # GET /gardens
  def index
    @gardens = Garden.all
  end

  # GET /gardens/1
  def show
    @plant = Plant.new
  end

  # GET /gardens/new
  def new
    @garden = Garden.new
  end

  # GET /gardens/1/edit
  def edit
  end

  # POST /gardens
  def create
    @garden = Garden.new(garden_params)

    if @garden.save
      redirect_to @garden, notice: 'Garden was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /gardens/1
  def update
    if @garden.update(garden_params)
      redirect_to @garden, notice: 'Garden was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /gardens/1
  def destroy
    @garden.destroy
    redirect_to gardens_url, notice: 'Garden was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden
      @garden = Garden.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def garden_params
      params.require(:garden).permit(:name, :banner_url)
    end
end


-----------------Routes:-----------------
  Rails.application.routes.draw do
    get "restaurants/index"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    #Create, Read, Update, Delete
    #verb "path", to: "controller#action"
    #read all restaurants
    get "/restaurants", to: "restaurants#index"
    #read one restaurant
    get "restaurants/:id", to: "restaurants#show"
    #create a restaurant
    get "restaurants/new", to: "restaurants#new"
    post "restaurants", to: "restaurants#create"
    #update a restaurant
    get "restaurants/:id/edit", to: "restaurants#edit"
    patch "restaurants/:id", to: "restaurants#update"
    #delete a restaurant
    delete "restaurants/:id", to: "restautants#destroy"
  
or

resources :restaurants, only: [:show, :create] (only can be replaced by "except")

end


----------  Nested Routes -----------

we only need nested routes if we need the id in the URL
Rails.application.routes.draw do
  resources :restaurants do
    #collection
    # /restaurants/...
    collection do
      get :top
    end
    
    #member
    # /restaurants/:id/chef
    member do
      get :chef
    end

    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: :destroy
 
end



Seeds with Faker
100.times do
    Restaurant.create(
      name: Faker::Restaurant.name,
      rating: rand(1..5),
      address: Faker::Address.street_address,
    )
  end
  
  

Forms

<%= form_for @restaurant do |f| %>
    <%= f.label :name, "Name" %>
    <%= f.text_field :name%>
    <%= f.label :address, "Address" %>
    <%= f.text_field :address %>
    <%= f.label :rating, "Rating" %>
    <%= f.number_field :rating, min: 1, max: 5%>
    <%= f.submit "Add"%>
  <% end %>

  <%= simple_form_for @review do |f| %>
  <%= f.input :content %>
  <%= f.submit, class: "btn btn-primary" %>
<% end %>


  https://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_for

same as:

  <form action="/restaurants" method="post">
    <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
    <label for="name">Name</label>
    <input type="text" name="restaurant[name]">
    <label for="address">Address</label>
    <input type="text" name="restaurant[address]">
    <label for="rating">Rating</label>
    <input type="number" name="restaurant[rating]">
    <button type="submit">Add</button>
  </form>
  
Links

link_to "create new restaurant", new_restaurant_path
<%= link_to  "Delete", restaurant_path(@restaurant), method: :delete %>
<%= link_to  "Edit", edit_restaurant_path(@restaurant) %>
<%= link_to restaurant.name, restaurant_path(restaurant)  %>
<%= link_to  "Delete", restaurant_path(@restaurant), method: :delete, data: {confirm: "Sure?"} %>
also works as block with do - end


Before Action

before_action :find_restaurant, only: [:show, :edit, :update, :destroy]

Render Partials

<%= render 'form' %>
<%= render 'form', restaurant: @restaurant %>

Simple Form

add to gemfile: gem "simple_form"
rails g simple_form:install --bootstrap

<%= simple_form_for [@restaurant, @review] do |f| %>
  <%= f.input :content %>
  <%= f.submit class: "btn btn-primary" %>
<% end %>


Use Bootstrap CSS

rename application.css to scss
add: @import "bootstrap/scss/bootstrap"
add to application.html:

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


use scaffold
comment jbuilder in gemfile
rails g scaffold restaurants address:string and so one..


Model Relationships
belongs_to :restaurant
has_many :reviews, dependent: destroy

Model error messages
  new_review.errors.messages


  ----------SCSS------------

  // Defining a variable
$gray: #F4F4F4;
$spacer: 8px;

body {
  background: $gray; // Using this variable
}

.btn {
  padding: $spacer ($spacer * 3);
}

NESTING

.banner {
  background: red;

  h1 {
    font-size: 50px;
  }
}

CHAINING

a {
  color: grey;

  &:hover {
    color: black;
  }
}

Partials
// _home.scss
body {
  font-family: Helvetica;
}
// application.scss
@import "home";

-------FRONTEND SETUP---------
yarn add bootstrap

/* app/assets/stylesheets/application.scss 
@import "bootstrap/scss/bootstrap"; /* picks it up in node_modules! */

# Gemfile
gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'simple_form'

bundle install
rails generate simple_form:install --bootstrap

LE WAGON STYLESHEETS

rm -rf app/assets/stylesheets
curl -L https://github.com/lewagon/rails-stylesheets/archive/master.zip > stylesheets.zip
unzip stylesheets.zip -d app/assets && rm -f stylesheets.zip && rm -f app/assets/rails-stylesheets-master/README.md
mv app/assets/rails-stylesheets-master app/assets/stylesheets


STYLESHEET ARCHITECTURE

.
├── components
│   ├── _index.scss               # Main components stylesheet
│   ├── _alert.scss
│   └── _navbar.scss
├── config
│   ├── _bootstrap_variables.scss # Bootstrap variables override
│   ├── _colors.scss              # Colors variables 🎨
│   └── _fonts.scss               # Fonts variables ✍️
├── pages
│   ├── _index.scss               # Main pages stylesheet
│   └── _home.scss
└── application.scss              # Main stylesheet - Open it!

ADDING A NEW COMPONENT
touch app/assets/stylesheets/components/_card.scss
You can use one of these cards



Then import this component in components/_index.scss:

/* app/assets/stylesheets/components/_index.scss */

@import "card";

USE IMAGES

<%= image_tag "logo.png", alt: "Le Wagon", width: 200 %>

Images in CSS:

<div class="logo"></div>
/* app/assets/stylesheets/_logo.scss */

.logo {
  background-image: asset-url('logo.png');
  background-size: cover;
  height: 100px;
  width: 250px;
}
/* app/assets/stylesheets/_index.scss */
@import "logo";


-------_ADD JAVASCRIPT------
webpacker:

webpack is in head and loads javascript and css in head and stays always the same. Only body gets rerendered. Problem: functions only get run once. Solution: eventlistener "turbolinks:load". Any imported js functions should be placed inside the callback function so they run every time the body gets rerendered.

<!-- app/views/layouts/application.html.erb -->
<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>

# In the terminal:
# if you haven't done it already
yarn add bootstrap

# and the dependencies
yarn add popper.js jquery

// config/webpack/environment.js
const { environment } = require('@rails/webpacker')

// Bootstrap 4 has a dependency over jQuery & Popper.js:
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
// app/javascript/packs/application.js
import 'bootstrap';

Implement function in separate files. export them
import function in the pack and use it.

// app/javascript/components/navbar.js
const initUpdateNavbarOnScroll = () => {

  const navbar = document.querySelector('.navbar-lewagon');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-lewagon-white');
      } else {
        navbar.classList.remove('navbar-lewagon-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
// app/javascript/packs/application.js
import { initUpdateNavbarOnScroll } from '../components/navbar';

document.addEventListener('turbolinks:load', () => {
  // Call your JS functions here
  initUpdateNavbarOnScroll();
});

----JS HOT REFRESH----

run webpack-dev-server in separate terminal window. It will listen for changes in JS.

-------SETUP WITH POSTGRESQL---------

rails new blog --database=postgresql


-----------HEROKU----------
heroku login
heroku create $YOUR_APP_NAME --region eu
git push heroku master

heroku run <command>         # Syntax
heroku run rails db:migrate  # Run pending migrations in prod
heroku run rails c           # Run the production console

Useful commands

heroku open         # open in your browser
heroku logs --tail  # show the app logs and keep listening

heroku
Usage: heroku COMMAND [--app APP] [command-specific-options]
Primary help topics, type "heroku help TOPIC" for more details:
  addons     # manage addon resources
  apps       # manage apps (create, destroy)
  auth       # authentication (login, logout)
  config     # manage app config vars
  domains    # manage custom domains
  logs       # display logs for an app
  ps         # manage dynos (dynos, workers)
  releases   # manage app releases
  run        # run one-off commands (console, rake)
  sharing    # manage collaborators on an app


  ----DOTENV----
  # Gemfile
gem 'dotenv-rails', groups: [:development, :test]
bundle install
touch .env
echo '.env*' >> .gitignore
git status # .env should not be there, we don't want to push it to Github.
git add .
git commit -m "Add dotenv - Protect my secret data in .env file"

-------_CLOUDINARY-------

# Gemfile
gem 'cloudinary', '~> 1.16.0'

# .env
CLOUDINARY_URL=cloudinary://298522699261255:Qa1ZfO4syfbOC-***********************8
Let’s upload two pictures
curl https://c1.staticflickr.com/3/2889/33773377295_3614b9db80_b.jpg > san_francisco.jpg
curl https://pbs.twimg.com/media/DC1Xyz3XoAAv7zB.jpg > boris_retreat_2017.jpg
# rails c
Cloudinary::Uploader.upload("san_francisco.jpg")
Cloudinary::Uploader.upload("boris_retreat_2017.jpg")


<%= cl_image_tag("THE_IMAGE_ID_FROM_LIBRARY",
      width: 400, height: 300, crop: :fill) %>

<!-- for face detection -->
<%= cl_image_tag("IMAGE_WITH_FACE_ID",
      width: 150, height: 150, crop: :thumb, gravity: :face) %>
Crop modes:
scale, fit, fill, limit, pad, crop.

You even have thumb with Face detection



---------ACTIVE STORAGE-----------

rails active_storage:install
rails db:migrate

creates migration for two tables

add to storage.yml:name => 

cloudinary:
  service: Cloudinary

....

change development environment to 
  config.active_storage.service = :cloudinary

Model
  class Article < ApplicationRecord
    has_one_attached :photo
  end


  <%= form_with(model: article, local: true) do |form| %>
    <% if article.errors.any? %>
      <div id="error_explanation">
        <h2><%= pluralize(article.errors.count, "error") %> prohibited this article from being saved:</h2>
        <ul>
          <% article.errors.full_messages.each do |message| %>
            <li><%= message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>
    <div class="field">
      <%= form.label :title %>
      <%= form.text_field :title %>
    </div>
    <div class="field">
      <%= form.label :body %>
      <%= form.text_area :body %>
    </div>
    <%= form.file_field :photo %>
    <div class="actions">
      <%= form.submit %>
    </div>
  <% end %>


check if foto attached
@article.photo.attached? #=> true/false
@article.photo.purge #=> Destroy the photo
  

use as background image with cl_image_path:

<div class="card-category" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('<%= cl_image_path @article.photo.key, height: 300, width: 400, crop: :fill %>')">
  Cool article
</div>



Multiple photos:name => 
class Article < ApplicationRecord
  has_many_attached :photos
end
View & Controller
<!-- app/views/articles/_form.html.erb -->
<%= simple_form_for(article) do |f| %>
  <!-- [...] -->
  <%= f.input :photos, as: :file, input_html: { multiple: true } %>
  <!-- [...] -->
<% end %>
# app/controllers/articles_controller.rb
def article_params
  params.require(:article).permit(:title, :body, photos: [])
end
<!-- app/views/articles/show.html.erb -->
<% @article.photos.each do |photo| %>
  <%= cl_image_tag photo.key, height: 300, width: 400, crop: :fill %>
<% end %>



----------AUTHENTICATION---------------


gem "devise"
bundle install
rails generate devise:install
config devise in initializers/devise.rb

rails g devise:views

then create user model
rails g devise User

user_signed_in?
# => true / false

<%= current_user %>
<%= current_user.email %>
# => User instance / nil


Application controller:
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end

skip for specific pages

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def about
  end
end


add more fields to signup forms:


class ApplicationController < ActionController::Base
  # [...]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end



-----PARTIALS-----

CSS: components
views: shared

----ALERTS--------

<!-- app/views/layouts/application.html.erb -->
<%= render 'shared/flashes' %>
<!-- app/views/shared/_flashes.html.erb -->
<% if notice %>
  <div class="alert alert-info alert-dismissible" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <%= notice %>
  </div>
<% end %>
<% if alert %>
  <div class="alert alert-warning alert-dismissible" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <%= alert %>
  </div>
<% end %>



----PUNDIT----

gem "pundit"
rails g pundit:install

creates application policy in app/policies/
all actions return a boolean

Appication Controller:

class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    include Pundit
  
    # Pundit: white-list approach.
    after_action :verify_authorized, except: :index, unless: :skip_pundit?
    after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  
    # Uncomment when you *really understand* Pundit!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(root_path)
    end
  
    private
  
    def skip_pundit?
      devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end
  end
  

  rails g pundit:policy restaurant

  class RestaurantPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def new?
      true
    end

  end
  

check if user is owner of a restaurant:

current_user == record.user (record and user come from pundit!)


redirect if not authorized:
application controller

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

def user_not_authorized
  flash[:alert] = "You are not authorized to perform this action."
  redirect_to(request.referrer || root_path)
end


index action:

all restaurants have to be authorized
@restaurants = policy_scope(Restaurant)

p0licy:    scope.all is like Restaurant.all
specify with : scope.where(user: user)

special cases: order results

@restaurants = policy_scope(Restaurant).order(created_at: :desc)



conditional rendering with pundit

we call the policy on the restaurant instance

<% if policy(restaurant).edit? %>
    <td><%= link_to 'Edit', edit_restaurant_path(restaurant) %></td>
  <% end %>
  <% if policy(restaurant).destroy? %>
    <td><%= link_to 'Destroy', restaurant, method: :delete, data: { confirm: 'Are you sure?' } %></td>
  <% end %>

without having an instance

<% if policy(Restaurant).new? %>
    <%= link_to 'New Restaurant', new_restaurant_path %>
  <% end %>

----------GEOCODING-------------

add gem "geocoder"
bundle install
rails generate geocoder:config
