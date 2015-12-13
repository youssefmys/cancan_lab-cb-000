# Cancan secret notes

## Objectives

We're going to learn how to integrate [CanCan] into a Rails application. Our authorization model for this example will be a message board for secret notes.

## Introduction

CanCan lets you define actions that a `User` `can` or `cannot` do to another model object. For example,

    class Ability
      include CanCan::Ability

      def initialize(user)
        if user.admin?
	  can :manage, Post
        end
	can :write, post: { owner_id: user.id }
	can :read, Post
      end
    end

This `Ability` class says that admins can `:manage` (do anything to) `Post`s, and everyone else can `:write` to `Post`s they own.

In this lab, we're going to learn about CanCan authorization by making message board for secret notes.

## Instructions

First, create a `User` model and migration. `User`s have `name`s and that's it.

We could give our users passwords quite easily with `has_secure_password`. And, for a message board of secrets but that would actually make it a lot more annoying to develop this app! For now, we'll just have usernames, and we'll let you sign in as someone else with a different clearance level on the main screen. This will make it easy to switch between accounts and test our authorization sceme.

Create a `Note` model. `Note`s have `content`, and a `user`, their creator.

Create a `Viewer` model. `viewers` is a join between `notes` and and `users`. An entry in the `Viewer`s table means that `user` can view that `note`. 

Hint: There are a few ways to set up the relationship between `Note`s and `User`s. Here's what I did and what the tests expect:

    # user.rb
    has_many :viewers
    has_many :readable, through: :viewers, source: :note

    # note.rb
    has_many :viewers
    has_many :readers, through: :viewers, source: :user

Your `Note` model will need `visible_to` and `visible_to=` methods, which take a comma-separated list of user names, and turns that list into the `Note`'s `viewers` relation. There are tests for this; ensure they pass.

Create controllers. We'll need a `SessionsController`, a `UsersController`, and a `NotesController`. `UsersController` just needs a `create` route. `NotesController` should have the full CRUD suite.

Some views have been created for you. You should now be able to see your app at work.

Now add [`cancan`][CanCan] to your Gemfile. `bundle`, then you can generate a skeleton `Ability` model with `rails g cancan:ability`. Write rules in the `Ability` model. If you need help on composing rules, [the documentation here][defining_abilities] is good.

The rules are a little bit tricky because you have to look through an association to figure out if a user can read a note. You'll want to use a block condition, like this:

    can :read, Note do |note|
      # TODO
    end

If your ActiveRecord relationships have been set up right, this should be fine.

Now, go through the remaining tests and ensure they pass. To pass the controller tests, make calls to `authorize!` or `load_and_authorize_resource` in your `NotesController`.

[CanCan]: https://github.com/ryanb/cancan
[defining_abilities]: https://github.com/ryanb/cancan/wiki/defining-abilities
