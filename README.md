Cards
=====

Add controllers and manage them as a stack of cards.

The default layout and interaction behaviour is like Passbook.


How to use
==========

Check out the Examples in the project.

Here is a simple sample of how you add two controllers to the card controller.'



    - (BOOL)application:(UIApplication *)application 
            didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
      // create an array of controllers
      NSArray *cards = @[[[FirstViewController alloc] init], [[SecondViewController alloc] init]];
      // craete card contoller with array of controllers
      JTCardsViewController *controller = [[JTCardsViewController alloc] initWithCards:cards];
      
      self.window.rootViewController = controller;
      return YES;
    }

