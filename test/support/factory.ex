defmodule BetTipper.Factory do
  use ExMachina.Ecto, repo: BetTipper.Repo

  alias BetTipper.Schemas.Bet
  alias BetTipper.Schemas.User

  def user_factory do
    %User{
      email: Faker.Internet.email()
    }
  end

  def bet_factory do
    %Bet{
      bet_amount_cents: Faker.random_between(10, 100) * 100,
      bet_type: :shareable,
      patron: build(:user)
    }
  end

  # def article_factory do
  #   title = sequence(:title, &"Use ExMachina! (Part #{&1})")
  #   # derived attribute
  #   slug = MyApp.Article.title_to_slug(title)
  #   %MyApp.Article{
  #     title: title,
  #     slug: slug,
  #     # associations are inserted when you call `insert`
  #     author: build(:user),
  #   }
  # end

  # # derived factory
  # def featured_article_factory do
  #   struct!(
  #     article_factory(),
  #     %{
  #       featured: true,
  #     }
  #   )
  # end

  # def comment_factory do
  #   %MyApp.Comment{
  #     text: "It's great!",
  #     article: build(:article),
  #   }
  # end
end
