# RSpec: Subjects (implicit & explicit): The Star of Your Specs

Welcome to Lesson 10! If you’ve ever found yourself typing the same object over and over in your specs, it’s time to meet RSpec’s `subject`. This feature lets you define the “star” of your tests—making your specs cleaner, more focused, and sometimes even a little magical. We’ll cover implicit and explicit subjects, one-liner syntax, and the mysterious `described_class`.

---

## What is subject?

The `subject` is the main object your specs are about. It’s like the lead actor in your test’s story. By defining a subject, you can refer to it with a simple keyword, making your specs easier to read and write.

## Implicit subject: The Default Star

If you don’t define a subject, RSpec creates one for you based on the class you’re describing.

```ruby
# /spec/recipe_spec.rb
RSpec.describe Recipe do
  it "is a Recipe" do
    expect(subject).to be_a(Recipe)
  end
end
```

**Output:**

```shell
Recipe
  is a Recipe

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

Here, `subject` is a new instance of `Recipe`.

## Explicit subject: Naming Your Star

You can define your own subject for more control or clarity.

```ruby
# /spec/recipe_spec.rb
RSpec.describe Recipe do
  subject(:salad) { Recipe.new("Salad") }

  it "has a name" do
    expect(salad.name).to eq("Salad")
  end
end
```

**Output:**

```shell
Recipe
  has a name

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

You can use any name you like for the subject (e.g., `subject(:admin) { ... }`).

## One-liner Syntax: Super Concise

If your test is just checking the subject, you can use a one-liner:

```ruby
# /spec/recipe_spec.rb
RSpec.describe Recipe do
  subject { Recipe.new("Soup") }

  it { is_expected.to be_a(Recipe) }
end
```

**Output:**

```shell
Recipe
  is expected to be a kind of Recipe

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

---

## Cautions and Best Practices

- **Multiple subjects:** Defining more than one `subject` block in the same example group can lead to confusion. If you need more than one, use custom names (e.g., `subject(:admin)`, `subject(:guest)`), and be explicit about which one you use in each test.
- **let vs subject:** Use `subject` for the main object under test, especially when you want to use one-liner syntax or focus the spec on a single "star." Use `let` for supporting objects, attributes, or collaborators. Both are lazily evaluated, but `subject` is for the primary focus.
- **Lazy evaluation:** `subject` (and `let`) are not instantiated until referenced in an example. For example:

```ruby

subject { puts "Building subject!"; Recipe.new("Bread") }

it "doesn't build subject until needed" do
  # No output yet
  expect(true).to be true
end

it "builds subject when referenced" do
  expect(subject).to be_a(Recipe) # Triggers the puts
end
```

- **One-liner vs full example:** One-liner syntax (`it { is_expected.to ... }`) is great for simple, focused assertions. For more complex tests (multiple expectations, setup, or custom error messages), use a full `it` block.

---

## described_class: The Mysterious Helper

`described_class` is a special RSpec helper that always refers to the class you’re describing. It’s great for DRYing up your specs.

```ruby
# /spec/recipe_spec.rb
RSpec.describe Recipe do
  subject { described_class.new("Cake") }

  it "is a Recipe" do
    expect(subject).to be_a(Recipe)
  end
end
```

## When to Use subject

- Use `subject` when you’re testing the same object in multiple examples.
- Use explicit subjects for clarity, especially when you have more than one object in your tests.
- Use one-liner syntax for simple, focused specs.
- Don’t overuse it—sometimes a good old variable or let is clearer!

## Getting Hands-On

Ready to practice? Here’s how to get started:

1. **Fork and clone this repo to your own GitHub account.**
2. **Install dependencies:**

    ```zsh
    bundle install
    ```

3. **Run the specs:**

    ```zsh
    bin/rspec
    ```

4. **Explore the code:**

   - All lesson code uses the Recipe and Ingredient domain (see `lib/` and `spec/`).
   - Review the examples for implicit/explicit subject, subject!, custom subject, and more in `spec/recipe_spec.rb`.

5. **Implement the pending specs:**

     - Open `spec/recipe_spec.rb` and look for specs marked as `pending`.
     - Implement the real methods in the recipe class (`lib/recipe.rb`) as needed so the pending specs pass.

6. **Re-run the specs** to verify your changes!

**Challenge:** Try writing your own spec using a custom-named subject or one-liner syntax for a new Recipe feature (e.g., "Recipe#calories" or "Ingredient#allergen?").

---

## Resources

- [RSpec: subject and described_class](https://relishapp.com/rspec/rspec-core/v/3-10/docs/subject/subject)
- [Better Specs: subject](https://www.betterspecs.org/#subject)
- [Ruby Guides: RSpec subject](https://www.rubyguides.com/2018/07/rspec/)

*Next: You’ll learn how to reuse test logic with shared examples and shared context!*
