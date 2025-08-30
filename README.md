# RSpec: Subjects (implicit & explicit): The Star of Your Specs

Welcome to Lesson 10! If you’ve ever found yourself typing the same object over and over in your specs, it’s time to meet RSpec’s `subject`. This feature lets you define the “star” of your tests—making your specs cleaner, more focused, and sometimes even a little magical. We’ll cover implicit and explicit subjects, one-liner syntax, and the mysterious `described_class`.

---

## What is subject?

The `subject` is the main object your specs are about. It’s like the lead actor in your test’s story. By defining a subject, you can refer to it with a simple keyword, making your specs easier to read and write.

## Implicit subject: The Default Star

If you don’t define a subject, RSpec creates one for you based on the class you’re describing.

```ruby
# /spec/calculator_spec.rb
RSpec.describe Calculator do
  it "is a Calculator" do
    expect(subject).to be_a(Calculator)
  end
end
```

**Output:**

```shell
Calculator
  is a Calculator

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

Here, `subject` is a new instance of `Calculator`.

## Explicit subject: Naming Your Star

You can define your own subject for more control or clarity.

```ruby
# /spec/user_spec.rb
RSpec.describe User do
  subject(:user) { User.new(name: "Alice") }

  it "has a name" do
    expect(user.name).to eq("Alice")
  end
end
```

**Output:**

```shell
User
  has a name

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

You can use any name you like for the subject (e.g., `subject(:admin) { ... }`).

## One-liner Syntax: Super Concise

If your test is just checking the subject, you can use a one-liner:

```ruby
# /spec/calculator_spec.rb
RSpec.describe Calculator do
  subject { Calculator.new }

  it { is_expected.to be_a(Calculator) }
end
```

**Output:**

```shell
Calculator
  is expected to be a kind of Calculator

Finished in 0.01 seconds (files took 0.1 seconds to load)
1 example, 0 failures
```

---

## Cautions and Best Practices

- **Multiple subjects:** Defining more than one `subject` block in the same example group can lead to confusion. If you need more than one, use custom names (e.g., `subject(:admin)`, `subject(:guest)`), and be explicit about which one you use in each test.
- **let vs subject:** Use `subject` for the main object under test, especially when you want to use one-liner syntax or focus the spec on a single "star." Use `let` for supporting objects, attributes, or collaborators. Both are lazily evaluated, but `subject` is for the primary focus.
- **Lazy evaluation:** `subject` (and `let`) are not instantiated until referenced in an example. For example:

```ruby
subject { puts "Building subject!"; User.new }

it "doesn't build subject until needed" do
  # No output yet
  expect(true).to be true
end

it "builds subject when referenced" do
  expect(subject).to be_a(User) # Triggers the puts
end
```

- **One-liner vs full example:** One-liner syntax (`it { is_expected.to ... }`) is great for simple, focused assertions. For more complex tests (multiple expectations, setup, or custom error messages), use a full `it` block.

---

## described_class: The Mysterious Helper

`described_class` is a special RSpec helper that always refers to the class you’re describing. It’s great for DRYing up your specs.

```ruby
# /spec/widget_spec.rb
RSpec.describe Widget do
  subject { described_class.new }

  it "is a Widget" do
    expect(subject).to be_a(Widget)
  end
end
```

## When to Use subject

- Use `subject` when you’re testing the same object in multiple examples.
- Use explicit subjects for clarity, especially when you have more than one object in your tests.
- Use one-liner syntax for simple, focused specs.
- Don’t overuse it—sometimes a good old variable or let is clearer!

## Practice Prompts

1. Refactor a spec to use `subject` instead of repeating the same object.
2. Try using `subject(:admin)` to define a custom-named subject. How does it change your tests?
3. Write a one-liner spec using `is_expected.to`.
4. Use `described_class` in a spec. What are the benefits?

---

## Resources

- [RSpec: subject and described_class](https://relishapp.com/rspec/rspec-core/v/3-10/docs/subject/subject)
- [Better Specs: subject](https://www.betterspecs.org/#subject)
- [Ruby Guides: RSpec subject](https://www.rubyguides.com/2018/07/rspec/)

*Next: You’ll learn how to reuse test logic with shared examples and shared context!*
