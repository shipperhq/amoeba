u1 = User.create(:name => "Robert Johnson", :email => "bob@crossroads.com")
u2 = User.create(:name => "Miles Davis", :email => "miles@kindofblue.com")

t = Topic.create(:title => "Ponies", :description => "Lets talk about my ponies.")

# First Post {{{
p1 = t.posts.create(:author => u1, :title => "My little pony", :contents => "Lorum ipsum dolor rainbow bright. I like dogs, dogs are awesome.")
f1 = p1.create_post_config(:is_visible => true, :is_open => false, :password => 'abcdefg123')
a1 = p1.create_account(:title => "Foo")
h1 = p1.account.create_history(:some_stuff => "Bar")
c1 = p1.comments.create(:contents => "I love it!")
c1.ratings.create(:num_stars => 5)
c1.ratings.create(:num_stars => 5)
c1.ratings.create(:num_stars => 4)
c1.ratings.create(:num_stars => 3)
c1.ratings.create(:num_stars => 5)
c1.ratings.create(:num_stars => 5)

c2 = p1.comments.create(:contents => "I hate it!")
c2.ratings.create(:num_stars => 3)
c2.ratings.create(:num_stars => 1)
c2.ratings.create(:num_stars => 4)
c2.ratings.create(:num_stars => 1)
c2.ratings.create(:num_stars => 1)
c2.ratings.create(:num_stars => 2)

c3 = p1.comments.create(:contents => "kthxbbq!!11!!!1!eleven!!")
c3.ratings.create(:num_stars => 0)
c3.ratings.create(:num_stars => 0)
c3.ratings.create(:num_stars => 1)
c3.ratings.create(:num_stars => 2)
c3.ratings.create(:num_stars => 1)
c3.ratings.create(:num_stars => 0)

t1 = Tag.create(:value => "funny")
t2 = Tag.create(:value => "wtf")
t3 = Tag.create(:value => "cats")

p1.tags << t1
p1.tags << t2
p1.tags << t3
p1.save

c1 = Category.create(:title => "Umbrellas", :description => "Clown fart")
c2 = Category.create(:title => "Widgets", :description => "Humpty dumpty")
c3 = Category.create(:title => "Wombats", :description => "Slushy mushy")

Supercat.create(:post => p1, :category => c1, :ramblings => "zomg")
Supercat.create(:post => p1, :category => c2, :ramblings => "why")
Supercat.create(:post => p1, :category => c3, :ramblings => "ohnoes")
# }}}