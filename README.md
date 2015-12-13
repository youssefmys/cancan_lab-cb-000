# Cancan does rock paper scissors

## Objectives

We're going to learn how to integrate [CanCan] into a Rails application. Our authorization model for this example will be a message board for secret notes.

[CanCan]: https://github.com/ryanb/cancan

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

Create a `Note` model. `Note`s have `content`, and an `owner`.

Create a `Viewer` model. `viewers` is a join between `notes` and and `users`. An entry in the `Viewer`s table means that `user` can view that `note`.

The relationship between `Note` and `User`s is `has_and_belongs_to_many through: viewer`.

Ensure all model tests pass.

Some views have been created for you. You should now be able to see your app at work.